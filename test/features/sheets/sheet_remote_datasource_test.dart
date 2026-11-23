import 'package:factory_app/core/data/stock_ledger.dart';
import 'package:factory_app/features/frames/domain/entities/frame_entities.dart';
import 'package:factory_app/features/sheets/data/datasources/sheet_remote_datasource.dart';
import 'package:factory_app/features/sheets/domain/entities/sheet_entities.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

const _machine = 'Sheet Machine 3';

MachineCleaningReport _cleaning(String machine, DateTime d) =>
    MachineCleaningReport(
      date: d, machineNumber: machine, machineCondition: 5, groundCondition: 4,
      mouldCondition: 3, totalScore: 12, percentage: 80, createdBy: 'u1',
    );

SheetProductionLineItem _item({int qty = 10}) => SheetProductionLineItem(
  thickness: '9mm', density: '0.8', color: 'White', length: 10, width: 4,
  quantity: qty, sqft: 40, perPieceWeight: 5, totalWeight: 50,
  totalRunningFeet: 100, timeOfChange: DateTime(2026, 11, 10, 9),
  manualWeightPerSqft: null,
);

SheetProductionDetailsReport _production() => SheetProductionDetailsReport(
  date: DateTime(2026, 11, 10), machineNumber: _machine, shift: 'Day',
  lineItems: [_item()],
  totalQuantity: 10, totalWeight: 50, totalRunningFeet: 100, createdBy: 'u1',
  submittedAt: DateTime(2026, 11, 10, 18),
);

void main() {
  late FakeFirebaseFirestore db;
  late SheetRemoteDataSourceImpl ds;
  setUp(() {
    db = FakeFirebaseFirestore();
    ds = SheetRemoteDataSourceImpl(firestore: db);
  });

  test('cleaning reports: machine + inclusive date filters, newest first, delete', () async {
    await ds.submitMachineCleaningReport(_cleaning(_machine, DateTime(2026, 11, 1)));
    await ds.submitMachineCleaningReport(_cleaning(_machine, DateTime(2026, 11, 10)));
    await ds.submitMachineCleaningReport(_cleaning('Sheet Machine 4', DateTime(2026, 11, 10)));

    final all = await ds.getMachineCleaningReports();
    expect(all, hasLength(3));
    expect(all.first.date, DateTime(2026, 11, 10));

    final filtered = await ds.getMachineCleaningReports(
      machineNumber: _machine,
      startDate: DateTime(2026, 11, 5),
      endDate: DateTime(2026, 11, 10, 23, 59, 59),
    );
    expect(filtered.single.date, DateTime(2026, 11, 10));
    expect(filtered.single.mouldCondition, 3);
    expect(filtered.single.timestamp, isNotNull);

    await ds.deleteMachineCleaningReport(filtered.single.id!);
    expect(await ds.getMachineCleaningReports(), hasLength(2));
  });

  test('tools count and health reports round-trip', () async {
    await ds.submitToolsCountReport(ToolsCountReport(
      date: DateTime(2026, 11, 10), machineNumber: _machine,
      totalToolsGiven: 10, totalToolsAvailable: 8, percentageAvailable: 80,
      createdBy: 'u1',
    ));
    final tools = (await ds.getToolsCountReports(machineNumber: _machine)).single;
    expect(tools.totalToolsAvailable, 8);

    await ds.submitMachineHealthReport(MachineHealthReport(
      date: DateTime(2026, 11, 10), machineNumber: _machine, shift: 'Day',
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
    expect(r.entries.single.startTime, DateTime(2026, 11, 10, 8));
    expect(r.submittedAt, DateTime(2026, 11, 10, 18));
    expect(await ds.getPendingApprovals(), hasLength(1));
  });

  test('production details round-trip, lookup, stock in running feet, reverses on delete', () async {
    await ds.submitProductionDetailsReport(_production());
    final list = await ds.getProductionDetailsReports(machineNumber: _machine);
    final li = list.single.lineItems.single;
    expect(li.thickness, '9mm');
    expect(li.timeOfChange, DateTime(2026, 11, 10, 9));
    expect(li.manualWeightPerSqft, isNull);
    expect(list.single.totalRunningFeet, 100);

    final found = await ds.getProductionDetailsReport(
        _machine, DateTime(2026, 11, 10, 14), 'Day');
    expect(found!.id, list.single.id);
    expect(await ds.getProductionDetailsReport(_machine, DateTime(2026, 11, 11), 'Day'), isNull);

    var stock = await StockLedger.read(db, StockKind.sheet);
    expect(stock.totalProduced, 100);
    expect(stock.variants.single.produced, 10);

    await ds.deleteProductionDetailsReport(list.single.id!);
    stock = await StockLedger.read(db, StockKind.sheet);
    expect(stock.totalProduced, 0);
    expect(stock.variants.single.produced, 0);
  });

  test('packing report updates stock in running feet and reverses on delete', () async {
    await ds.submitShiftPackingReport(SheetShiftPackingReport(
      date: DateTime(2026, 11, 10), machineNumber: _machine, shift: 'Day',
      lineItems: [
        const SheetPackingLineItem(
          thickness: '9mm', density: '0.8', color: 'White', length: 10, width: 4,
          productionQuantity: 10, perPieceWeight: 5, runningFeetPerItem: 10,
          packed: 6, onlySanding: 0, sandingAndPacked: 0, rejectedQuality: 1,
        ),
      ],
      totalRejectedRunningFeet: 10, qualityAcceptancePercentage: 90,
      packingEfficiency: 60, createdBy: 'u1',
    ));
    var stock = await StockLedger.read(db, StockKind.sheet);
    expect(stock.totalPacked, 60);
    expect(stock.totalRejected, 10);
    expect([stock.variants.single.packed, stock.variants.single.rejected], [6, 1]);

    final frame = await StockLedger.read(db, StockKind.frame);
    expect([frame.totalPacked, frame.totalRejected, frame.variants], [0, 0, isEmpty]);

    final report = (await ds.getShiftPackingReports()).single;
    expect(report.lineItems.single.runningFeetPerItem, 10);
    await ds.deleteShiftPackingReport(report.id!);
    stock = await StockLedger.read(db, StockKind.sheet);
    expect([stock.totalPacked, stock.totalRejected], [0, 0]);
    expect([stock.variants.single.packed, stock.variants.single.rejected], [0, 0]);
  });

  test('customer rejection is filtered by originalProductionDate', () async {
    await ds.submitCustomerRejectionReport(SheetCustomerRejectionReport(
      originalProductionDate: DateTime(2026, 10, 1), machineNumber: _machine,
      shift: 'Day', rejectedItems: [_item(qty: 2)],
      totalRejectedRunningFeet: 20, createdBy: 'u1',
    ));
    final inRange = await ds.getCustomerRejectionReports(
        startDate: DateTime(2026, 9, 30), endDate: DateTime(2026, 10, 31));
    expect(inRange.single.rejectedItems.single.quantity, 2);
    expect(inRange.single.originalProductionDate, DateTime(2026, 10, 1));
    expect(await ds.getCustomerRejectionReports(startDate: DateTime(2026, 11, 1)), isEmpty);

    await ds.deleteCustomerRejectionReport(inRange.single.id!);
    expect(await ds.getCustomerRejectionReports(), isEmpty);
  });

  test('running feet report round-trips', () async {
    await ds.submitProductionRunningFeetReport(SheetProductionRunningFeetReport(
      date: DateTime(2026, 11, 10), machineNumber: _machine, shift: 'Day',
      productionRunningFeet: 100, maintenanceRunningFeet: 10,
      totalProductionRunningFeet: 110, targetRunningFeet: 120,
      efficiencyPercentage: 91.5, createdBy: 'u1',
    ));
    final r = (await ds.getProductionRunningFeetReports(machineNumber: _machine)).single;
    expect(r.totalProductionRunningFeet, 110);
    expect(r.efficiencyPercentage, 91.5);
    expect(r.timestamp, isNotNull);
    await ds.deleteProductionRunningFeetReport(r.id!);
    expect(await ds.getProductionRunningFeetReports(), isEmpty);
  });

  test('writing efficiency filters by operatorId', () async {
    for (final op in ['a', 'b']) {
      await ds.submitWritingEfficiency(ReportWritingEfficiencyRecord(
        date: DateTime(2026, 11, 10), machineNumber: _machine, shift: 'Day',
        shiftEndTime: DateTime(2026, 11, 10, 18), score: 4, operatorId: op,
      ));
    }
    final r = await ds.getReportWritingEfficiency(operatorId: 'a');
    expect(r.single.operatorId, 'a');
    expect(r.single.shiftEndTime, DateTime(2026, 11, 10, 18));
    expect(r.single.submittedAt, isNotNull); // defaults to now

    await ds.deleteWritingEfficiency(r.single.id!);
    expect(await ds.getReportWritingEfficiency(), hasLength(1));
  });
}
