import 'package:factory_app/core/data/stock_ledger.dart';
import 'package:factory_app/features/frames/data/datasources/frame_remote_datasource.dart';
import 'package:factory_app/features/frames/domain/entities/frame_entities.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

MachineCleaningReport _cleaning(String machine, DateTime d) => MachineCleaningReport(
  date: d, machineNumber: machine, machineCondition: 5, groundCondition: 4,
  mouldCondition: 3, totalScore: 12, percentage: 80, createdBy: 'u1',
);

FrameProductionDetailsReport _production({int qty = 10, double weight = 50}) =>
    FrameProductionDetailsReport(
      date: DateTime(2026, 11, 10), machineNumber: 'Frame Machine 1', shift: 'Day',
      lineItems: [
        FrameProductionLineItem(section: '3x2', density: '0.8', color: 'White',
            length: 10, quantity: qty, perPieceWeight: 5, totalWeight: weight),
      ],
      totalQuantity: qty, totalWeight: weight, createdBy: 'u1',
      submittedAt: DateTime(2026, 11, 10, 18),
    );

void main() {
  late FakeFirebaseFirestore db;
  late FrameRemoteDataSourceImpl ds;
  setUp(() {
    db = FakeFirebaseFirestore();
    ds = FrameRemoteDataSourceImpl(firestore: db);
  });

  test('cleaning reports: machine + inclusive date filters, newest first, delete', () async {
    await ds.submitMachineCleaningReport(_cleaning('Frame Machine 1', DateTime(2026, 11, 1)));
    await ds.submitMachineCleaningReport(_cleaning('Frame Machine 1', DateTime(2026, 11, 10)));
    await ds.submitMachineCleaningReport(_cleaning('Frame Machine 2', DateTime(2026, 11, 10)));

    final all = await ds.getMachineCleaningReports();
    expect(all, hasLength(3));
    expect(all.first.date, DateTime(2026, 11, 10));

    final filtered = await ds.getMachineCleaningReports(
      machineNumber: 'Frame Machine 1',
      startDate: DateTime(2026, 11, 5),
      endDate: DateTime(2026, 11, 10, 23, 59, 59),
    );
    expect(filtered.single.date, DateTime(2026, 11, 10));
    expect(filtered.single.percentage, 80);
    expect(filtered.single.timestamp, isNotNull);

    await ds.deleteMachineCleaningReport(filtered.single.id!);
    expect(await ds.getMachineCleaningReports(), hasLength(2));
  });

  test('health report embeds entries and round-trips times', () async {
    await ds.submitMachineHealthReport(MachineHealthReport(
      date: DateTime(2026, 11, 10), machineNumber: 'Frame Machine 1', shift: 'Day',
      entries: [
        FrameMaintenanceEntry(
          maintenanceItem: 'Oil', startTime: DateTime(2026, 11, 10, 8),
          endTime: DateTime(2026, 11, 10, 9), personDoingMaintenance: 'Ravi',
          description: 'routine', durationHours: 1,
        ),
      ],
      totalMaintenanceDurationHours: 1, createdBy: 'u1',
      submittedAt: DateTime(2026, 11, 10, 18),
    ));
    final r = (await ds.getMachineHealthReports()).single;
    expect(r.entries.single.maintenanceItem, 'Oil');
    expect(r.entries.single.startTime, DateTime(2026, 11, 10, 8));
    expect(r.submittedAt, DateTime(2026, 11, 10, 18));
    expect((await ds.getPendingApprovals()), hasLength(1));
  });

  test('production report round-trip, lookup by machine/date/shift, stock updates and reverses', () async {
    await ds.submitProductionDetailsReport(_production());
    final list = await ds.getProductionDetailsReports();
    expect(list.single.lineItems.single.section, '3x2');
    expect(list.single.totalWeight, 50);

    final found = await ds.getProductionDetailsReport(
        'Frame Machine 1', DateTime(2026, 11, 10, 14), 'Day');
    expect(found!.id, list.single.id);
    expect(await ds.getProductionDetailsReport('Frame Machine 1', DateTime(2026, 11, 11), 'Day'), isNull);

    var stock = await StockLedger.read(db, StockKind.frame);
    expect(stock.totalProduced, 50);
    expect(stock.variants.single.produced, 10);

    await ds.deleteProductionDetailsReport(list.single.id!);
    stock = await StockLedger.read(db, StockKind.frame);
    expect(stock.totalProduced, 0);
    expect(stock.variants.single.produced, 0);
  });

  test('packing report updates packed/rejected stock using per-piece weight and reverses on delete', () async {
    await ds.submitProductionDetailsReport(_production());
    await ds.submitShiftPackingReport(FrameShiftPackingReport(
      date: DateTime(2026, 11, 10), machineNumber: 'Frame Machine 1', shift: 'Day',
      lineItems: [
        FramePackingLineItem(section: '3x2', density: '0.8', color: 'White', length: 10,
            productionQuantity: 10, perPieceWeight: 5, packed: 6, rejectedQuality: 1),
      ],
      totalRejectedWeight: 5, qualityAcceptancePercentage: 90, packingEfficiency: 60,
      createdBy: 'u1',
    ));
    var stock = await StockLedger.read(db, StockKind.frame);
    expect(stock.totalPacked, 30); // 6 * 5
    expect(stock.totalRejected, 5); // 1 * 5
    expect([stock.variants.single.packed, stock.variants.single.rejected], [6, 1]);

    final id = (await ds.getShiftPackingReports()).single.id!;
    await ds.deleteShiftPackingReport(id);
    stock = await StockLedger.read(db, StockKind.frame);
    expect([stock.totalPacked, stock.totalRejected], [0, 0]);
  });

  test('writing efficiency filters by operatorId', () async {
    for (final op in ['a', 'b']) {
      await ds.submitWritingEfficiency(ReportWritingEfficiencyRecord(
        date: DateTime(2026, 11, 10), machineNumber: 'Frame Machine 1', shift: 'Day',
        shiftEndTime: DateTime(2026, 11, 10, 18), score: 4, operatorId: op,
      ));
    }
    final r = await ds.getReportWritingEfficiency(operatorId: 'a');
    expect(r.single.operatorId, 'a');
    expect(r.single.shiftEndTime, DateTime(2026, 11, 10, 18));
    expect(r.single.submittedAt, isNotNull); // defaults to now
  });

  test('customer rejection is filtered and ordered by originalProductionDate', () async {
    await ds.submitCustomerRejectionReport(FrameCustomerRejectionReport(
      originalProductionDate: DateTime(2026, 10, 1), rejectionDate: DateTime(2026, 11, 2),
      machineNumber: 'Frame Machine 1', shift: 'Day',
      rejectedItems: [
        FrameProductionLineItem(section: '3x2', density: '0.8', color: 'White',
            length: 10, quantity: 2, perPieceWeight: 5, totalWeight: 10),
      ],
      totalRejectedWeight: 10, createdBy: 'u1',
    ));
    final inRange = await ds.getCustomerRejectionReports(
        startDate: DateTime(2026, 9, 30), endDate: DateTime(2026, 10, 31));
    expect(inRange.single.rejectedItems.single.quantity, 2);
    expect(inRange.single.rejectionDate, DateTime(2026, 11, 2));
    expect(await ds.getCustomerRejectionReports(startDate: DateTime(2026, 11, 1)), isEmpty);
  });
}
