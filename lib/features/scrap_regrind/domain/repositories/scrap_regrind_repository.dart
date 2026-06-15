import '../entities/scrap_regrind_entities.dart';

abstract class ScrapRegrindRepository {
  // Machine Cleaning Report
  Future<void> submitCleaningReport(ScrapCleaningReport report);
  Future<List<ScrapCleaningReport>> getCleaningReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });

  // Tools Count Report
  Future<void> submitToolsCountReport(ScrapToolsCountReport report);
  Future<List<ScrapToolsCountReport>> getToolsCountReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });

  // Machine Health Report
  Future<void> submitMachineHealthReport(ScrapMachineHealthReport report);
  Future<List<ScrapMachineHealthReport>> getMachineHealthReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<ScrapMachineHealthReport?> getMachineHealthReport(
    String machineNumber,
    DateTime date,
    String shift,
  );

  // Production Details Report
  Future<void> submitProductionDetailsReport(
    ScrapProductionDetailsReport report,
  );
  Future<List<ScrapProductionDetailsReport>> getProductionDetailsReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<ScrapProductionDetailsReport?> getProductionDetailsReport(
    String machineNumber,
    DateTime date,
    String shift,
  );

  // Production Weight Report
  Future<void> submitProductionWeightReport(ScrapProductionWeightReport report);
  Future<List<ScrapProductionWeightReport>> getProductionWeightReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });

  // Report Writing Efficiency
  Future<List<ScrapReportWritingEfficiency>> getReportWritingEfficiency({
    String? operatorId,
    DateTime? startDate,
    DateTime? endDate,
  });

  // Scrap Quality Report
  Future<void> submitScrapQualityReport(ScrapQualityReport report);
  Future<List<ScrapQualityReport>> getScrapQualityReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });

  // Salary
  Future<ScrapSalaryWeightages> getSalaryWeightages();
  Future<ScrapSalaryCalculation> calculateSalary(
    String operatorId,
    int year,
    int month,
  );
  Future<void> saveSalaryCalculation(ScrapSalaryCalculation calculation);
  Future<ScrapSalaryCalculation?> getSavedCalculation(
    String operatorId,
    int year,
    int month,
  );

  // Monthly aggregates for salary variables
  Future<Map<String, double>> getMonthlyAggregates(
    String operatorId,
    int year,
    int month,
  );
}
