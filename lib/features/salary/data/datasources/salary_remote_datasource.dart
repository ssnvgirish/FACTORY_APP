import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/data/collections.dart';
import '../../../../core/data/firestore_support.dart';
import '../../domain/entities/salary_entities.dart';

abstract class SalaryRemoteDataSource {
  Future<SalaryWeightages> getWeightages();
  Future<Map<String, double>> getOperatorAggregates(
    String operatorId,
    int year,
    int month,
  );
  Future<double> getFixedSalary(String operatorId);
  Future<String> getOperatorName(String operatorId);
  Future<void> saveSalaryCalculation(SalaryCalculation calculation);
  Future<SalaryCalculation?> getSavedCalculation(
    String operatorId,
    int year,
    int month,
  );
  Future<List<SalaryCalculation>> getCalculationsForMonth(int year, int month);
}

class SalaryRemoteDataSourceImpl implements SalaryRemoteDataSource {
  SalaryRemoteDataSourceImpl({required FirebaseFirestore firestore})
    : _db = firestore,
      _reports = Reports(firestore);

  final FirebaseFirestore _db;
  final Reports _reports;

  Future<DocRow?> _user(String operatorId) =>
      _reports.findOne(Col.users, {'uid': operatorId});

  double _avg(Iterable<double> values) {
    final list = values.toList();
    return list.isEmpty ? 0 : list.reduce((x, y) => x + y) / list.length;
  }

  @override
  Future<SalaryWeightages> getWeightages() async {
    final snap = await _db
        .collection(Col.masterSalaryWeightages)
        .where('category', isEqualTo: 'frame_sheet')
        .get();
    final items = snap.docs.map(DocRow.fromSnapshot).toList();
    final d = AppConstants.defaultSalaryWeightages;
    if (items.isEmpty) {
      return SalaryWeightages(
        wA: d['wA']!, wB: d['wB']!, wC: d['wC']!,
        wD: d['wD']!, wE: d['wE']!, wF: d['wF']!,
      );
    }
    double val(String variable) =>
        items.where((w) => w.str('variable') == variable).firstOrNull?.real('percentage') ?? 0;
    double pick(String v) => val(v) > 0 ? val(v) : d[v]!;
    return SalaryWeightages(
      wA: pick('wA'), wB: pick('wB'), wC: pick('wC'),
      wD: pick('wD'), wE: pick('wE'), wF: pick('wF'),
    );
  }

  @override
  Future<Map<String, double>> getOperatorAggregates(
    String operatorId,
    int year,
    int month,
  ) async {
    final user = await _user(operatorId);
    if (user == null) {
      return {'a': 0, 'b': 0, 'c': 0, 'd': 0, 'e': 0, 'f': 0};
    }
    final isFrame = user.strings('assignedMachines').any((m) => m.startsWith('Frame'));
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 0, 23, 59, 59);

    Future<List<DocRow>> range(String collection) =>
        _reports.list(collection, startDate: start, endDate: end);

    final cleaning = await range(isFrame ? Col.frameCleaning : Col.sheetCleaning);
    final tools = await range(isFrame ? Col.frameToolsCount : Col.sheetToolsCount);
    final efficiency = await range(isFrame ? Col.frameProductionWeight : Col.sheetRunningFeet);
    final packing = await range(isFrame ? Col.frameShiftPacking : Col.sheetShiftPacking);
    final writing = await _reports.list(
      isFrame ? Col.frameWritingEfficiency : Col.sheetWritingEfficiency,
      equalsField: 'operatorId',
      equalsValue: operatorId,
      startDate: start,
      endDate: end,
    );

    final a = _avg(cleaning.map((r) => r.real('percentage')));
    final b = _avg(tools.map((r) => r.real('percentageAvailable')));
    final c = _avg(
      efficiency.where((r) => r.str('createdBy') == operatorId).map((r) => r.real('efficiencyPercentage')),
    );
    final d = _avg(packing.map((r) => r.real('qualityAcceptancePercentage')));
    final e = _avg(packing.map((r) => r.real('packingEfficiency')));
    final f = writing.isEmpty ? 0.0 : _avg(writing.map((r) => r.integer('score').toDouble())) / 5 * 100;
    return {'a': a, 'b': b, 'c': c, 'd': d, 'e': e, 'f': f};
  }

  @override
  Future<double> getFixedSalary(String operatorId) async =>
      (await _user(operatorId))?.real('fixedSalary') ?? 0;

  @override
  Future<String> getOperatorName(String operatorId) async =>
      (await _user(operatorId))?.str('name') ?? 'Unknown';

  @override
  Future<void> saveSalaryCalculation(SalaryCalculation calc) async {
    await _reports.add(Col.salaryCalculations, {
      'operatorId': calc.operatorId,
      'operatorName': calc.operatorName,
      'year': calc.year,
      'month': calc.month,
      'a': calc.a, 'b': calc.b, 'c': calc.c, 'd': calc.d, 'e': calc.e, 'f': calc.f,
      'wA': calc.wA, 'wB': calc.wB, 'wC': calc.wC, 'wD': calc.wD, 'wE': calc.wE, 'wF': calc.wF,
      'multiplier': calc.multiplier,
      'fixedSalary': calc.fixedSalary,
      'calculatedSalary': calc.calculatedSalary,
    });
  }

  SalaryCalculation _calc(DocRow s) => SalaryCalculation(
    id: s.id,
    operatorId: s.str('operatorId'),
    operatorName: s.str('operatorName'),
    year: s.integer('year'),
    month: s.integer('month'),
    a: s.real('a'), b: s.real('b'), c: s.real('c'),
    d: s.real('d'), e: s.real('e'), f: s.real('f'),
    wA: s.real('wA'), wB: s.real('wB'), wC: s.real('wC'),
    wD: s.real('wD'), wE: s.real('wE'), wF: s.real('wF'),
    multiplier: s.real('multiplier'),
    fixedSalary: s.real('fixedSalary'),
    calculatedSalary: s.real('calculatedSalary'),
  );

  @override
  Future<SalaryCalculation?> getSavedCalculation(
    String operatorId,
    int year,
    int month,
  ) async {
    final row = await _reports.findOne(Col.salaryCalculations, {
      'operatorId': operatorId,
      'year': year,
      'month': month,
    });
    return row == null ? null : _calc(row);
  }

  @override
  Future<List<SalaryCalculation>> getCalculationsForMonth(int year, int month) async {
    final snap = await _db
        .collection(Col.salaryCalculations)
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();
    final list = snap.docs.map((d) => _calc(DocRow.fromSnapshot(d))).toList()
      ..sort((x, y) => x.operatorName.compareTo(y.operatorName));
    return list;
  }
}
