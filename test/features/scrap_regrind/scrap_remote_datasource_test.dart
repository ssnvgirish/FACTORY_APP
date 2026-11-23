import 'package:factory_app/features/scrap_regrind/data/datasources/scrap_regrind_remote_datasource.dart';
import 'package:factory_app/features/scrap_regrind/domain/entities/scrap_regrind_entities.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

ScrapCleaningReport _cleaning(String machine, DateTime d, {double pct = 80}) =>
    ScrapCleaningReport(
      date: d,
      machineNumber: machine,
      machineCondition: 8,
      groundCondition: 8,
      totalScore: 16,
      percentage: pct,
      createdBy: 'u1',
    );

ScrapReportWritingEfficiency _writing(String machine, {int score = 4}) =>
    ScrapReportWritingEfficiency(
      date: DateTime(2026, 11, 10),
      machineNumber: machine,
      shift: 'Day',
      shiftEndTime: DateTime(2026, 11, 10, 18),
      score: score,
      operatorId: '+911',
    );

void main() {
  late FakeFirebaseFirestore db;
  late ScrapRegrindRemoteDataSourceImpl ds;
  setUp(() {
    db = FakeFirebaseFirestore();
    ds = ScrapRegrindRemoteDataSourceImpl(firestore: db);
  });

  test('cleaning reports: machine + inclusive date filters, newest first, delete', () async {
    await ds.submitCleaningReport(_cleaning('Crusher Machine 1', DateTime(2026, 11, 1)));
    await ds.submitCleaningReport(_cleaning('Crusher Machine 1', DateTime(2026, 11, 10)));
    await ds.submitCleaningReport(_cleaning('Crusher Machine 2', DateTime(2026, 11, 10)));

    final all = await ds.getCleaningReports();
    expect(all, hasLength(3));
    expect(all.first.date, DateTime(2026, 11, 10));

    final filtered = await ds.getCleaningReports(
      machineNumber: 'Crusher Machine 1',
      startDate: DateTime(2026, 11, 5),
      endDate: DateTime(2026, 11, 10, 23, 59, 59),
    );
    expect(filtered.single.date, DateTime(2026, 11, 10));
    expect(filtered.single.percentage, 80);
    expect(filtered.single.timestamp, isNotNull);

    await ds.deleteCleaningReport(filtered.single.id!);
    expect(await ds.getCleaningReports(), hasLength(2));
  });

  test('health report embeds entries; lookup by machine/date/shift', () async {
    await ds.submitMachineHealthReport(ScrapMachineHealthReport(
      date: DateTime(2026, 11, 10),
      machineNumber: 'Crusher Machine 1',
      shift: 'Day',
      entries: [
        ScrapMaintenanceEntry(
          maintenanceItem: 'Oil',
          startTime: DateTime(2026, 11, 10, 8),
          endTime: DateTime(2026, 11, 10, 9),
          personDoingMaintenance: 'Ravi',
          description: 'routine',
          durationHours: 1,
        ),
      ],
      totalMaintenanceDurationHours: 1,
      createdBy: 'u1',
      submittedAt: DateTime(2026, 11, 10, 18),
    ));

    final r = (await ds.getMachineHealthReports()).single;
    expect(r.entries.single.maintenanceItem, 'Oil');
    expect(r.entries.single.startTime, DateTime(2026, 11, 10, 8));
    expect(r.submittedAt, DateTime(2026, 11, 10, 18));

    final found = await ds.getMachineHealthReport(
        'Crusher Machine 1', DateTime(2026, 11, 10, 14), 'Day');
    expect(found, isNotNull);
    expect(found!.entries, hasLength(1));
    expect(
      await ds.getMachineHealthReport(
          'Crusher Machine 1', DateTime(2026, 11, 10), 'Night'),
      isNull,
    );
  });

  test('production details embeds lineItems; lookup by machine/date/shift', () async {
    await ds.submitProductionDetailsReport(ScrapProductionDetailsReport(
      date: DateTime(2026, 11, 10),
      machineNumber: 'Pulverizer 1',
      shift: 'Day',
      lineItems: const [
        ScrapProductionLineItem(
            product: 'PVC Powder', weightPerBag: 25, totalBags: 4, totalWeight: 100),
      ],
      totalProductionWeight: 100,
      createdBy: 'u1',
      submittedAt: DateTime(2026, 11, 10, 18),
    ));

    final list = await ds.getProductionDetailsReports();
    expect(list.single.lineItems.single.product, 'PVC Powder');
    expect(list.single.lineItems.single.weightPerBag, 25);
    expect(list.single.lineItems.single.totalBags, 4);
    expect(list.single.lineItems.single.totalWeight, 100);
    expect(list.single.totalProductionWeight, 100);

    final found = await ds.getProductionDetailsReport(
        'Pulverizer 1', DateTime(2026, 11, 10, 14), 'Day');
    expect(found?.lineItems, hasLength(1));
    expect(
      await ds.getProductionDetailsReport(
          'Pulverizer 1', DateTime(2026, 11, 10), 'Night'),
      isNull,
    );
  });

  test('writing efficiency filters machineNumber by the operatorId argument (legacy quirk)', () async {
    await ds.submitWritingEfficiency(_writing('Pulverizer 1'));
    await ds.submitWritingEfficiency(_writing('Pulverizer 2'));

    expect(await ds.getReportWritingEfficiency(), hasLength(2));
    final r = await ds.getReportWritingEfficiency(operatorId: 'Pulverizer 2');
    expect(r.single.machineNumber, 'Pulverizer 2');
    expect(r.single.submittedAt, isNotNull);
    // operatorId value itself is NOT what is filtered on.
    expect(await ds.getReportWritingEfficiency(operatorId: '+911'), isEmpty);
  });

  test('getMonthlyAggregates averages November values for the assigned machine', () async {
    await db.collection('users').add({
      'uid': '+911',
      'name': 'Anil',
      'fixedSalary': 12000,
      'assignedMachines': ['Crusher Machine 1'],
    });
    const m = 'Crusher Machine 1';
    final day = DateTime(2026, 11, 10);

    await ds.submitCleaningReport(_cleaning(m, day, pct: 80));
    await ds.submitCleaningReport(_cleaning(m, DateTime(2026, 10, 15), pct: 10));
    await ds.submitToolsCountReport(ScrapToolsCountReport(
      date: day, machineNumber: m, totalToolsGiven: 10,
      totalToolsAvailable: 6, percentageAvailable: 60, createdBy: 'u1',
    ));
    await ds.submitProductionWeightReport(ScrapProductionWeightReport(
      date: day, machineNumber: m, shift: 'Day', totalProductionWeight: 70,
      maintenanceWeight: 0, totalWeight: 70, targetWeight: 100,
      efficiencyPercentage: 70, createdBy: 'u1',
    ));
    await ds.submitWritingEfficiency(_writing(m, score: 4));
    await ds.submitScrapQualityReport(ScrapQualityReport(
      date: day, machineNumber: m, shift: 'Day', product: 'PVC',
      qualityRating: 5, createdBy: 'u1',
    ));

    final agg = await ds.getMonthlyAggregates('+911', 2026, 11);
    expect(agg['a'], 80);
    expect(agg['b'], 60);
    expect(agg['e'], 70);
    expect(agg['f'], closeTo(80, 1e-9)); // 4 / 5 * 100
    expect(agg['g'], closeTo(50, 1e-9)); // 5 / 10 * 100

    // Empty month -> zeros.
    final empty = await ds.getMonthlyAggregates('+911', 2026, 9);
    expect(empty, {'a': 0.0, 'b': 0.0, 'e': 0.0, 'f': 0.0, 'g': 0.0});

    expect(await ds.getFixedSalary('+911'), 12000);
    expect(await ds.getOperatorName('+911'), 'Anil');
    expect(await ds.getFixedSalary('nope'), 0.0);
    expect(await ds.getOperatorName('nope'), 'Unknown');
  });

  test('getSalaryWeightages: defaults when empty, scrap category values otherwise', () async {
    expect((await ds.getSalaryWeightages()).wA, 20);
    expect((await ds.getSalaryWeightages()).total, 100);

    await db.collection('master_salary_weightages').add(
        {'variable': 'wA', 'label': 'A', 'category': 'scrap', 'percentage': 30});
    await db.collection('master_salary_weightages').add(
        {'variable': 'wB', 'label': 'B', 'category': 'frame_sheet', 'percentage': 99});
    final w = await ds.getSalaryWeightages();
    expect(w.wA, 30);
    expect(w.wB, 0);
  });

  test('salary calculation save and lookup', () async {
    await ds.saveSalaryCalculation(const ScrapSalaryCalculation(
      operatorId: '+911', operatorName: 'Anil', year: 2026, month: 11,
      a: 80, b: 60, e: 70, f: 80, g: 50,
      wA: 20, wB: 15, wE: 25, wF: 15, wG: 25,
      multiplier: 0.7, fixedSalary: 12000, calculatedSalary: 8400,
    ));

    final c = await ds.getSavedCalculation('+911', 2026, 11);
    expect(c, isNotNull);
    expect(c!.id, isNotNull);
    expect(c.operatorName, 'Anil');
    expect(c.wG, 25);
    expect(c.calculatedSalary, 8400);
    expect(await ds.getSavedCalculation('+911', 2026, 10), isNull);
  });
}
