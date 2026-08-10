import '../entities/frame_entities.dart';

abstract class FrameRepository {
  // Machine Cleaning Report
  Future<void> submitMachineCleaningReport(MachineCleaningReport report);
  Future<List<MachineCleaningReport>> getMachineCleaningReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteMachineCleaningReport(String id);

  // Tools Count Report
  Future<void> submitToolsCountReport(ToolsCountReport report);
  Future<List<ToolsCountReport>> getToolsCountReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteToolsCountReport(String id);

  // Machine Health Report
  Future<void> submitMachineHealthReport(MachineHealthReport report);
  Future<List<MachineHealthReport>> getMachineHealthReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<List<MachineHealthReport>> getPendingApprovals();
  Future<void> deleteMachineHealthReport(String id);

  // Production Details Report
  Future<void> submitProductionDetailsReport(
    FrameProductionDetailsReport report,
  );
  Future<List<FrameProductionDetailsReport>> getProductionDetailsReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<FrameProductionDetailsReport?> getProductionDetailsReport(
    String machineNumber,
    DateTime date,
    String shift,
  );
  Future<void> deleteProductionDetailsReport(String id);

  // Production Weight Report
  Future<void> submitProductionWeightReport(FrameProductionWeightReport report);
  Future<List<FrameProductionWeightReport>> getProductionWeightReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteProductionWeightReport(String id);

  // Shift Packing Report
  Future<void> submitShiftPackingReport(FrameShiftPackingReport report);
  Future<List<FrameShiftPackingReport>> getShiftPackingReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteShiftPackingReport(String id);

  // Report Writing Efficiency
  Future<List<ReportWritingEfficiencyRecord>> getReportWritingEfficiency({
    String? operatorId,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteWritingEfficiency(String id);

  // Customer Rejection Report
  Future<void> submitCustomerRejectionReport(
    FrameCustomerRejectionReport report,
  );
  Future<List<FrameCustomerRejectionReport>> getCustomerRejectionReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteCustomerRejectionReport(String id);

  // Monthly aggregates
  Future<Map<String, double>> getMonthlyAggregates(
    String operatorId,
    int year,
    int month,
  );
}
