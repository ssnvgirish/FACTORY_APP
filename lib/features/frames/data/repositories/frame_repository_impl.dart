import '../../domain/entities/frame_entities.dart';
import '../../domain/repositories/frame_repository.dart';
import '../datasources/frame_remote_datasource.dart';

class FrameRepositoryImpl implements FrameRepository {
  final FrameRemoteDataSource remoteDataSource;

  FrameRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> submitMachineCleaningReport(MachineCleaningReport report) =>
      remoteDataSource.submitMachineCleaningReport(report);

  @override
  Future<List<MachineCleaningReport>> getMachineCleaningReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) => remoteDataSource.getMachineCleaningReports(
    machineNumber: machineNumber,
    startDate: startDate,
    endDate: endDate,
  );

  @override
  Future<void> submitToolsCountReport(ToolsCountReport report) =>
      remoteDataSource.submitToolsCountReport(report);

  @override
  Future<List<ToolsCountReport>> getToolsCountReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) => remoteDataSource.getToolsCountReports(
    machineNumber: machineNumber,
    startDate: startDate,
    endDate: endDate,
  );

  @override
  Future<void> submitMachineHealthReport(MachineHealthReport report) =>
      remoteDataSource.submitMachineHealthReport(report);

  @override
  Future<List<MachineHealthReport>> getMachineHealthReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) => remoteDataSource.getMachineHealthReports(
    machineNumber: machineNumber,
    startDate: startDate,
    endDate: endDate,
  );

  @override
  Future<List<MachineHealthReport>> getPendingApprovals() =>
      remoteDataSource.getPendingApprovals();

  @override
  Future<void> submitProductionDetailsReport(
    FrameProductionDetailsReport report,
  ) => remoteDataSource.submitProductionDetailsReport(report);

  @override
  Future<List<FrameProductionDetailsReport>> getProductionDetailsReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) => remoteDataSource.getProductionDetailsReports(
    machineNumber: machineNumber,
    startDate: startDate,
    endDate: endDate,
  );

  @override
  Future<FrameProductionDetailsReport?> getProductionDetailsReport(
    String machineNumber,
    DateTime date,
    String shift,
  ) => remoteDataSource.getProductionDetailsReport(machineNumber, date, shift);

  @override
  Future<void> submitProductionWeightReport(
    FrameProductionWeightReport report,
  ) => remoteDataSource.submitProductionWeightReport(report);

  @override
  Future<List<FrameProductionWeightReport>> getProductionWeightReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) => remoteDataSource.getProductionWeightReports(
    machineNumber: machineNumber,
    startDate: startDate,
    endDate: endDate,
  );

  @override
  Future<void> submitShiftPackingReport(FrameShiftPackingReport report) =>
      remoteDataSource.submitShiftPackingReport(report);

  @override
  Future<List<FrameShiftPackingReport>> getShiftPackingReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) => remoteDataSource.getShiftPackingReports(
    machineNumber: machineNumber,
    startDate: startDate,
    endDate: endDate,
  );

  @override
  Future<List<ReportWritingEfficiencyRecord>> getReportWritingEfficiency({
    String? operatorId,
    DateTime? startDate,
    DateTime? endDate,
  }) => remoteDataSource.getReportWritingEfficiency(
    operatorId: operatorId,
    startDate: startDate,
    endDate: endDate,
  );

  @override
  Future<void> submitCustomerRejectionReport(
    FrameCustomerRejectionReport report,
  ) => remoteDataSource.submitCustomerRejectionReport(report);

  @override
  Future<List<FrameCustomerRejectionReport>> getCustomerRejectionReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) => remoteDataSource.getCustomerRejectionReports(
    machineNumber: machineNumber,
    startDate: startDate,
    endDate: endDate,
  );

  @override
  Future<Map<String, double>> getMonthlyAggregates(
    String operatorId,
    int year,
    int month,
  ) async {
    // Calculate monthly averages for salary multiplier variables
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0, 23, 59, 59);

    // a - Machine Cleaning Report % average
    final cleaningReports = await getMachineCleaningReports(
      startDate: startDate,
      endDate: endDate,
    );
    final operatorCleaning = cleaningReports
        .where((r) => r.createdBy == operatorId)
        .toList();
    final a = operatorCleaning.isEmpty
        ? 0.0
        : operatorCleaning.map((r) => r.percentage).reduce((a, b) => a + b) /
              operatorCleaning.length;

    // b - Tools Count % average
    final toolsReports = await getToolsCountReports(
      startDate: startDate,
      endDate: endDate,
    );
    final operatorTools = toolsReports
        .where((r) => r.createdBy == operatorId)
        .toList();
    final b = operatorTools.isEmpty
        ? 0.0
        : operatorTools
                  .map((r) => r.percentageAvailable)
                  .reduce((a, b) => a + b) /
              operatorTools.length;

    // c - Production Efficiency % average
    final weightReports = await getProductionWeightReports(
      startDate: startDate,
      endDate: endDate,
    );
    final operatorWeight = weightReports
        .where((r) => r.createdBy == operatorId)
        .toList();
    final c = operatorWeight.isEmpty
        ? 0.0
        : operatorWeight
                  .map((r) => r.efficiencyPercentage)
                  .reduce((a, b) => a + b) /
              operatorWeight.length;

    // d - Quality Acceptance % average
    final packingReports = await getShiftPackingReports(
      startDate: startDate,
      endDate: endDate,
    );
    final operatorPacking = packingReports
        .where((r) => r.createdBy == operatorId)
        .toList();
    final d = operatorPacking.isEmpty
        ? 0.0
        : operatorPacking
                  .map((r) => r.qualityAcceptancePercentage)
                  .reduce((a, b) => a + b) /
              operatorPacking.length;

    // e - Packing Efficiency % average
    final e = operatorPacking.isEmpty
        ? 0.0
        : operatorPacking
                  .map((r) => r.packingEfficiency)
                  .reduce((a, b) => a + b) /
              operatorPacking.length;

    // f - Report Writing Efficiency average
    final rwReports = await getReportWritingEfficiency(
      operatorId: operatorId,
      startDate: startDate,
      endDate: endDate,
    );
    final f = rwReports.isEmpty
        ? 0.0
        : (rwReports.map((r) => r.score).reduce((a, b) => a + b) /
                  rwReports.length /
                  5) *
              100;

    return {'a': a, 'b': b, 'c': c, 'd': d, 'e': e, 'f': f};
  }
}
