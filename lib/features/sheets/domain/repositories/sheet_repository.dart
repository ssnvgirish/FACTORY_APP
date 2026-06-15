import '../../../frames/domain/entities/frame_entities.dart';
import '../entities/sheet_entities.dart';

abstract class SheetRepository {
  // Machine Cleaning (reuse frame entity with sheet machines)
  Future<void> submitMachineCleaningReport(MachineCleaningReport report);
  Future<List<MachineCleaningReport>> getMachineCleaningReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });

  // Tools Count
  Future<void> submitToolsCountReport(ToolsCountReport report);
  Future<List<ToolsCountReport>> getToolsCountReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });

  // Machine Health
  Future<void> submitMachineHealthReport(MachineHealthReport report);
  Future<List<MachineHealthReport>> getMachineHealthReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<List<MachineHealthReport>> getPendingApprovals();

  // Production Details (sheet-specific)
  Future<void> submitProductionDetailsReport(
    SheetProductionDetailsReport report,
  );
  Future<List<SheetProductionDetailsReport>> getProductionDetailsReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<SheetProductionDetailsReport?> getProductionDetailsReport(
    String machineNumber,
    DateTime date,
    String shift,
  );

  // Production Running Feet
  Future<void> submitProductionRunningFeetReport(
    SheetProductionRunningFeetReport report,
  );
  Future<List<SheetProductionRunningFeetReport>>
  getProductionRunningFeetReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });

  // Shift Packing
  Future<void> submitShiftPackingReport(SheetShiftPackingReport report);
  Future<List<SheetShiftPackingReport>> getShiftPackingReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });

  // Report Writing Efficiency
  Future<List<ReportWritingEfficiencyRecord>> getReportWritingEfficiency({
    String? operatorId,
    DateTime? startDate,
    DateTime? endDate,
  });

  // Customer Rejection
  Future<void> submitCustomerRejectionReport(
    SheetCustomerRejectionReport report,
  );
  Future<List<SheetCustomerRejectionReport>> getCustomerRejectionReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });

  // Monthly aggregates
  Future<Map<String, double>> getMonthlyAggregates(
    String operatorId,
    int year,
    int month,
  );
}
