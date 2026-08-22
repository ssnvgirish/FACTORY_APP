import '../../domain/entities/scrap_regrind_entities.dart';
import '../../domain/repositories/scrap_regrind_repository.dart';
import '../datasources/scrap_regrind_remote_datasource.dart';
import '../../../../core/utils/calculations.dart';

class ScrapRegrindRepositoryImpl implements ScrapRegrindRepository {
  final ScrapRegrindRemoteDataSource remoteDataSource;

  ScrapRegrindRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> submitCleaningReport(ScrapCleaningReport report) =>
      remoteDataSource.submitCleaningReport(report);

  @override
  Future<List<ScrapCleaningReport>> getCleaningReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) => remoteDataSource.getCleaningReports(
    machineNumber: machineNumber,
    startDate: startDate,
    endDate: endDate,
  );

  @override
  Future<void> deleteCleaningReport(String id) =>
      remoteDataSource.deleteCleaningReport(id);

  @override
  Future<void> submitToolsCountReport(ScrapToolsCountReport report) =>
      remoteDataSource.submitToolsCountReport(report);

  @override
  Future<List<ScrapToolsCountReport>> getToolsCountReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) => remoteDataSource.getToolsCountReports(
    machineNumber: machineNumber,
    startDate: startDate,
    endDate: endDate,
  );

  @override
  Future<void> deleteToolsCountReport(String id) =>
      remoteDataSource.deleteToolsCountReport(id);

  @override
  Future<void> submitMachineHealthReport(ScrapMachineHealthReport report) =>
      remoteDataSource.submitMachineHealthReport(report);

  @override
  Future<List<ScrapMachineHealthReport>> getMachineHealthReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) => remoteDataSource.getMachineHealthReports(
    machineNumber: machineNumber,
    startDate: startDate,
    endDate: endDate,
  );

  @override
  Future<ScrapMachineHealthReport?> getMachineHealthReport(
    String machineNumber,
    DateTime date,
    String shift,
  ) => remoteDataSource.getMachineHealthReport(machineNumber, date, shift);

  @override
  Future<void> deleteMachineHealthReport(String id) =>
      remoteDataSource.deleteMachineHealthReport(id);

  @override
  Future<void> submitProductionDetailsReport(
    ScrapProductionDetailsReport report,
  ) => remoteDataSource.submitProductionDetailsReport(report);

  @override
  Future<List<ScrapProductionDetailsReport>> getProductionDetailsReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) => remoteDataSource.getProductionDetailsReports(
    machineNumber: machineNumber,
    startDate: startDate,
    endDate: endDate,
  );

  @override
  Future<ScrapProductionDetailsReport?> getProductionDetailsReport(
    String machineNumber,
    DateTime date,
    String shift,
  ) => remoteDataSource.getProductionDetailsReport(machineNumber, date, shift);

  @override
  Future<void> deleteProductionDetailsReport(String id) =>
      remoteDataSource.deleteProductionDetailsReport(id);

  @override
  Future<void> submitProductionWeightReport(
    ScrapProductionWeightReport report,
  ) => remoteDataSource.submitProductionWeightReport(report);

  @override
  Future<List<ScrapProductionWeightReport>> getProductionWeightReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) => remoteDataSource.getProductionWeightReports(
    machineNumber: machineNumber,
    startDate: startDate,
    endDate: endDate,
  );

  @override
  Future<void> deleteProductionWeightReport(String id) =>
      remoteDataSource.deleteProductionWeightReport(id);

  @override
  Future<List<ScrapReportWritingEfficiency>> getReportWritingEfficiency({
    String? operatorId,
    DateTime? startDate,
    DateTime? endDate,
  }) => remoteDataSource.getReportWritingEfficiency(
    operatorId: operatorId,
    startDate: startDate,
    endDate: endDate,
  );

  @override
  Future<void> deleteWritingEfficiency(String id) =>
      remoteDataSource.deleteWritingEfficiency(id);

  @override
  Future<void> submitWritingEfficiency(ScrapReportWritingEfficiency record) =>
      remoteDataSource.submitWritingEfficiency(record);

  @override
  Future<void> submitScrapQualityReport(ScrapQualityReport report) =>
      remoteDataSource.submitScrapQualityReport(report);

  @override
  Future<List<ScrapQualityReport>> getScrapQualityReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) => remoteDataSource.getScrapQualityReports(
    machineNumber: machineNumber,
    startDate: startDate,
    endDate: endDate,
  );

  @override
  Future<void> deleteScrapQualityReport(String id) =>
      remoteDataSource.deleteScrapQualityReport(id);

  @override
  Future<ScrapSalaryWeightages> getSalaryWeightages() =>
      remoteDataSource.getSalaryWeightages();

  @override
  Future<ScrapSalaryCalculation> calculateSalary(
    String operatorId,
    int year,
    int month,
  ) async {
    final fixedSalary = await remoteDataSource.getFixedSalary(operatorId);
    final operatorName = await remoteDataSource.getOperatorName(operatorId);
    final aggregates = await remoteDataSource.getMonthlyAggregates(
      operatorId,
      year,
      month,
    );
    final weightages = await remoteDataSource.getSalaryWeightages();

    final a = aggregates['a'] ?? 0;
    final b = aggregates['b'] ?? 0;
    final e = aggregates['e'] ?? 0;
    final f = aggregates['f'] ?? 0;
    final g = aggregates['g'] ?? 0;

    final multiplier = Calculations.scrapTotalSalaryMultiplier(
      a: a,
      b: b,
      e: e,
      f: f,
      g: g,
      wA: weightages.wA,
      wB: weightages.wB,
      wE: weightages.wE,
      wF: weightages.wF,
      wG: weightages.wG,
    );

    final calculatedSalary = Calculations.monthlySalary(
      fixedSalary,
      multiplier,
    );

    return ScrapSalaryCalculation(
      operatorId: operatorId,
      operatorName: operatorName,
      year: year,
      month: month,
      a: a,
      b: b,
      e: e,
      f: f,
      g: g,
      wA: weightages.wA,
      wB: weightages.wB,
      wE: weightages.wE,
      wF: weightages.wF,
      wG: weightages.wG,
      multiplier: multiplier,
      fixedSalary: fixedSalary,
      calculatedSalary: calculatedSalary,
    );
  }

  @override
  Future<void> saveSalaryCalculation(ScrapSalaryCalculation calculation) =>
      remoteDataSource.saveSalaryCalculation(calculation);

  @override
  Future<ScrapSalaryCalculation?> getSavedCalculation(
    String operatorId,
    int year,
    int month,
  ) => remoteDataSource.getSavedCalculation(operatorId, year, month);

  @override
  Future<Map<String, double>> getMonthlyAggregates(
    String operatorId,
    int year,
    int month,
  ) => remoteDataSource.getMonthlyAggregates(operatorId, year, month);
}
