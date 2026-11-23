import 'package:factory_app/features/salary/data/datasources/salary_remote_datasource.dart';
import 'package:factory_app/features/salary/domain/entities/salary_entities.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore db;
  late SalaryRemoteDataSourceImpl ds;

  setUp(() async {
    db = FakeFirebaseFirestore();
    ds = SalaryRemoteDataSourceImpl(firestore: db);
    await db.doc('users/a1').set({
      'uid': '+911', 'name': 'Ravi', 'fixedSalary': 1500.0,
      'assignedMachines': ['Frame Machine 1'], 'roles': ['machine_operator'], 'isActive': true,
    });
    await db.doc('users/a2').set({
      'uid': '+912', 'name': 'Sita', 'fixedSalary': 0,
      'assignedMachines': ['Sheet Machine 3'], 'roles': ['machine_operator'], 'isActive': true,
    });
  });

  test('user lookups by legacy uid with fallbacks', () async {
    expect(await ds.getFixedSalary('+911'), 1500);
    expect(await ds.getOperatorName('+911'), 'Ravi');
    expect(await ds.getFixedSalary('nope'), 0);
    expect(await ds.getOperatorName('nope'), 'Unknown');
  });

  test('getWeightages falls back to defaults then reads master rows', () async {
    final defaults = await ds.getWeightages();
    expect(defaults.wA, greaterThan(0));
    await db.collection('master_salary_weightages').add(
        {'variable': 'wA', 'label': 'x', 'category': 'frame_sheet', 'percentage': 33.0});
    expect((await ds.getWeightages()).wA, 33);
  });

  test('frame operator aggregates average the month and ignore other months', () async {
    Future<void> add(String col, Map<String, dynamic> m) => db.collection(col).add(m);
    await add('frame_cleaning_reports', {'date': '2026-11-03', 'percentage': 80.0});
    await add('frame_cleaning_reports', {'date': '2026-11-20', 'percentage': 60.0});
    await add('frame_cleaning_reports', {'date': '2026-10-31', 'percentage': 0.0});
    await add('frame_tools_count_reports', {'date': '2026-11-03', 'percentageAvailable': 90.0});
    await add('frame_production_weight_reports',
        {'date': '2026-11-03', 'efficiencyPercentage': 70.0, 'createdBy': '+911'});
    await add('frame_production_weight_reports',
        {'date': '2026-11-04', 'efficiencyPercentage': 10.0, 'createdBy': '+999'});
    await add('frame_shift_packing_reports', {
      'date': '2026-11-05', 'qualityAcceptancePercentage': 95.0, 'packingEfficiency': 85.0});
    await add('frame_writing_efficiencies',
        {'date': '2026-11-05', 'operatorId': '+911', 'score': 4});

    final a = await ds.getOperatorAggregates('+911', 2026, 11);
    expect(a['a'], 70);
    expect(a['b'], 90);
    expect(a['c'], 70);
    expect(a['d'], 95);
    expect(a['e'], 85);
    expect(a['f'], 80); // 4/5*100
  });

  test('unknown operator returns zeros; sheet operators use sheet collections', () async {
    expect((await ds.getOperatorAggregates('nope', 2026, 11))['a'], 0);
    await db.collection('sheet_cleaning_reports').add({'date': '2026-11-03', 'percentage': 50.0});
    expect((await ds.getOperatorAggregates('+912', 2026, 11))['a'], 50);
  });

  test('save and read calculations; month list sorted by operator name', () async {
    SalaryCalculation calc(String id, String name) => SalaryCalculation(
      operatorId: id, operatorName: name, year: 2026, month: 11,
      a: 1, b: 2, c: 3, d: 4, e: 5, f: 6,
      wA: 10, wB: 10, wC: 10, wD: 10, wE: 10, wF: 10,
      multiplier: 1.1, fixedSalary: 100, calculatedSalary: 123,
    );
    await ds.saveSalaryCalculation(calc('+912', 'Sita'));
    await ds.saveSalaryCalculation(calc('+911', 'Ravi'));
    final saved = await ds.getSavedCalculation('+911', 2026, 11);
    expect(saved!.calculatedSalary, 123);
    expect(await ds.getSavedCalculation('+911', 2026, 10), isNull);
    final month = await ds.getCalculationsForMonth(2026, 11);
    expect(month.map((c) => c.operatorName), ['Ravi', 'Sita']);
  });
}
