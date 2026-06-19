import '../../../../core/constants/app_constants.dart';
import '../../../../generated/dataconnect/default.dart';
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
  final DefaultConnector connector;

  SalaryRemoteDataSourceImpl({required this.connector});

  @override
  Future<SalaryWeightages> getWeightages() async {
    final result = await connector.listMasterSalaryWeightages().execute();
    final items = result.data.masterSalaryWeightages.where(
      (w) => w.category == 'frame_sheet',
    );
    if (items.isEmpty) {
      final d = AppConstants.defaultSalaryWeightages;
      return SalaryWeightages(
        wA: d['wA']!,
        wB: d['wB']!,
        wC: d['wC']!,
        wD: d['wD']!,
        wE: d['wE']!,
        wF: d['wF']!,
      );
    }
    double _val(String variable) =>
        items.where((w) => w.variable == variable).firstOrNull?.percentage ?? 0;
    final d = AppConstants.defaultSalaryWeightages;
    return SalaryWeightages(
      wA: _val('wA') > 0 ? _val('wA') : d['wA']!,
      wB: _val('wB') > 0 ? _val('wB') : d['wB']!,
      wC: _val('wC') > 0 ? _val('wC') : d['wC']!,
      wD: _val('wD') > 0 ? _val('wD') : d['wD']!,
      wE: _val('wE') > 0 ? _val('wE') : d['wE']!,
      wF: _val('wF') > 0 ? _val('wF') : d['wF']!,
    );
  }

  @override
  Future<Map<String, double>> getOperatorAggregates(
    String operatorId,
    int year,
    int month,
  ) async {
    final allUsers = await connector.listAllUsers().execute();
    final userMatch = allUsers.data.users.where((u) => u.uid == operatorId);
    if (userMatch.isEmpty)
      return {'a': 0, 'b': 0, 'c': 0, 'd': 0, 'e': 0, 'f': 0};

    final machines = userMatch.first.assignedMachines;
    final isFrame = machines.any((m) => m.startsWith('Frame'));

    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0, 23, 59, 59);

    double a = 0, b = 0, c = 0, d = 0, e = 0, f = 0;

    if (isFrame) {
      // Cleaning
      final cleanResult = await connector
          .listFrameCleaningReports()
          .startDate(startDate)
          .endDate(endDate)
          .execute();
      final cleanPcts = cleanResult.data.frameCleaningReports
          .map((r) => r.percentage)
          .toList();
      a = cleanPcts.isEmpty
          ? 0
          : cleanPcts.reduce((x, y) => x + y) / cleanPcts.length;

      // Tools
      final toolsResult = await connector
          .listFrameToolsCountReports()
          .startDate(startDate)
          .endDate(endDate)
          .execute();
      final toolsPcts = toolsResult.data.frameToolsCountReports
          .map((r) => r.percentageAvailable)
          .toList();
      b = toolsPcts.isEmpty
          ? 0
          : toolsPcts.reduce((x, y) => x + y) / toolsPcts.length;

      // Production efficiency
      final effResult = await connector
          .listFrameProductionWeightReports()
          .startDate(startDate)
          .endDate(endDate)
          .execute();
      final effPcts = effResult.data.frameProductionWeightReports
          .where((r) => r.createdBy == operatorId)
          .map((r) => r.efficiencyPercentage)
          .toList();
      c = effPcts.isEmpty
          ? 0
          : effPcts.reduce((x, y) => x + y) / effPcts.length;

      // Packing quality + efficiency
      final packResult = await connector
          .listFrameShiftPackingReports()
          .startDate(startDate)
          .endDate(endDate)
          .execute();
      final qualPcts = packResult.data.frameShiftPackingReports
          .map((r) => r.qualityAcceptancePercentage)
          .toList();
      final packPcts = packResult.data.frameShiftPackingReports
          .map((r) => r.packingEfficiency)
          .toList();
      d = qualPcts.isEmpty
          ? 0
          : qualPcts.reduce((x, y) => x + y) / qualPcts.length;
      e = packPcts.isEmpty
          ? 0
          : packPcts.reduce((x, y) => x + y) / packPcts.length;

      // Writing efficiency
      final rwResult = await connector
          .listFrameWritingEfficiency()
          .operatorId(operatorId)
          .startDate(startDate)
          .endDate(endDate)
          .execute();
      final scores = rwResult.data.frameWritingEfficiencies
          .map((r) => r.score.toDouble())
          .toList();
      f = scores.isEmpty
          ? 0
          : (scores.reduce((x, y) => x + y) / scores.length / 5) * 100;
    } else {
      // Sheet: Cleaning
      final cleanResult = await connector
          .listSheetCleaningReports()
          .startDate(startDate)
          .endDate(endDate)
          .execute();
      final cleanPcts = cleanResult.data.sheetCleaningReports
          .map((r) => r.percentage)
          .toList();
      a = cleanPcts.isEmpty
          ? 0
          : cleanPcts.reduce((x, y) => x + y) / cleanPcts.length;

      // Tools
      final toolsResult = await connector
          .listSheetToolsCountReports()
          .startDate(startDate)
          .endDate(endDate)
          .execute();
      final toolsPcts = toolsResult.data.sheetToolsCountReports
          .map((r) => r.percentageAvailable)
          .toList();
      b = toolsPcts.isEmpty
          ? 0
          : toolsPcts.reduce((x, y) => x + y) / toolsPcts.length;

      // Production efficiency (running feet)
      final effResult = await connector
          .listSheetRunningFeetReports()
          .startDate(startDate)
          .endDate(endDate)
          .execute();
      final effPcts = effResult.data.sheetRunningFeetReports
          .where((r) => r.createdBy == operatorId)
          .map((r) => r.efficiencyPercentage)
          .toList();
      c = effPcts.isEmpty
          ? 0
          : effPcts.reduce((x, y) => x + y) / effPcts.length;

      // Packing quality + efficiency
      final packResult = await connector
          .listSheetShiftPackingReports()
          .startDate(startDate)
          .endDate(endDate)
          .execute();
      final qualPcts = packResult.data.sheetShiftPackingReports
          .map((r) => r.qualityAcceptancePercentage)
          .toList();
      final packPcts = packResult.data.sheetShiftPackingReports
          .map((r) => r.packingEfficiency)
          .toList();
      d = qualPcts.isEmpty
          ? 0
          : qualPcts.reduce((x, y) => x + y) / qualPcts.length;
      e = packPcts.isEmpty
          ? 0
          : packPcts.reduce((x, y) => x + y) / packPcts.length;

      // Writing efficiency
      final rwResult = await connector
          .listSheetWritingEfficiency()
          .operatorId(operatorId)
          .startDate(startDate)
          .endDate(endDate)
          .execute();
      final scores = rwResult.data.sheetWritingEfficiencies
          .map((r) => r.score.toDouble())
          .toList();
      f = scores.isEmpty
          ? 0
          : (scores.reduce((x, y) => x + y) / scores.length / 5) * 100;
    }

    return {'a': a, 'b': b, 'c': c, 'd': d, 'e': e, 'f': f};
  }

  @override
  Future<double> getFixedSalary(String operatorId) async {
    final result = await connector.listAllUsers().execute();
    final match = result.data.users.where((u) => u.uid == operatorId);
    return match.isEmpty ? 0 : match.first.fixedSalary;
  }

  @override
  Future<String> getOperatorName(String operatorId) async {
    final result = await connector.listAllUsers().execute();
    final match = result.data.users.where((u) => u.uid == operatorId);
    return match.isEmpty ? 'Unknown' : match.first.name;
  }

  @override
  Future<void> saveSalaryCalculation(SalaryCalculation calc) async {
    await connector
        .createSalaryCalculation(
          operatorId: calc.operatorId,
          operatorName: calc.operatorName,
          year: calc.year,
          month: calc.month,
          a: calc.a,
          b: calc.b,
          c: calc.c,
          d: calc.d,
          e: calc.e,
          f: calc.f,
          wA: calc.wA,
          wB: calc.wB,
          wC: calc.wC,
          wD: calc.wD,
          wE: calc.wE,
          wF: calc.wF,
          multiplier: calc.multiplier,
          fixedSalary: calc.fixedSalary,
          calculatedSalary: calc.calculatedSalary,
        )
        .execute();
  }

  @override
  Future<SalaryCalculation?> getSavedCalculation(
    String operatorId,
    int year,
    int month,
  ) async {
    final result = await connector
        .getSalaryCalculation(operatorId: operatorId, year: year, month: month)
        .execute();
    final calcs = result.data.salaryCalculations;
    if (calcs.isEmpty) return null;
    final s = calcs.first;
    return SalaryCalculation(
      id: s.id,
      operatorId: s.operatorId,
      operatorName: s.operatorName,
      year: s.year,
      month: s.month,
      a: s.a,
      b: s.b,
      c: s.c,
      d: s.d,
      e: s.e,
      f: s.f,
      wA: s.wA,
      wB: s.wB,
      wC: s.wC,
      wD: s.wD,
      wE: s.wE,
      wF: s.wF,
      multiplier: s.multiplier,
      fixedSalary: s.fixedSalary,
      calculatedSalary: s.calculatedSalary,
    );
  }

  @override
  Future<List<SalaryCalculation>> getCalculationsForMonth(
    int year,
    int month,
  ) async {
    final result = await connector
        .listAllSalaryCalculationsForMonth(year: year, month: month)
        .execute();
    return result.data.salaryCalculations
        .map(
          (s) => SalaryCalculation(
            id: s.id,
            operatorId: s.operatorId,
            operatorName: s.operatorName,
            year: s.year,
            month: s.month,
            a: s.a,
            b: s.b,
            c: s.c,
            d: s.d,
            e: s.e,
            f: s.f,
            wA: s.wA,
            wB: s.wB,
            wC: s.wC,
            wD: s.wD,
            wE: s.wE,
            wF: s.wF,
            multiplier: s.multiplier,
            fixedSalary: s.fixedSalary,
            calculatedSalary: s.calculatedSalary,
          ),
        )
        .toList();
  }
}
