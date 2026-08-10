import '../entities/scrap_regrind_entities.dart';

abstract class ScrapRegrindRepository {
  // Machine Cleaning Report
  Future<void> submitCleaningReport(ScrapCleaningReport report);
  Future<List<ScrapCleaningReport>> getCleaningReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteCleaningReport(String id);

  // Tools Count Report
  Future<void> submitToolsCountReport(ScrapToolsCountReport report);
  Future<List<ScrapToolsCountReport>> getToolsCountReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteToolsCountReport(String id);

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
  Future<void> deleteMachineHealthReport(String id);

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
  Future<void> deleteProductionDetailsReport(String id);

  // Production Weight Report
  Future<void> submitProductionWeightReport(ScrapProductionWeightReport report);
  Future<List<ScrapProductionWeightReport>> getProductionWeightReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteProductionWeightReport(String id);

  // Report Writing Efficiency
  Future<List<ScrapReportWritingEfficiency>> getReportWritingEfficiency({
    String? operatorId,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteWritingEfficiency(String id);

  // Scrap Quality Report
  Future<void> submitScrapQualityReport(ScrapQualityReport report);
  Future<List<ScrapQualityReport>> getScrapQualityReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteScrapQualityReport(String id);

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
