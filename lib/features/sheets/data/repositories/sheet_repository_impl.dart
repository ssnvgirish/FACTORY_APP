import '../../../frames/domain/entities/frame_entities.dart';
import '../../domain/entities/sheet_entities.dart';
import '../../domain/repositories/sheet_repository.dart';
import '../datasources/sheet_remote_datasource.dart';

class SheetRepositoryImpl implements SheetRepository {
  final SheetRemoteDataSource remoteDataSource;

  SheetRepositoryImpl({required this.remoteDataSource});

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
    SheetProductionDetailsReport report,
  ) => remoteDataSource.submitProductionDetailsReport(report);
  @override
  Future<List<SheetProductionDetailsReport>> getProductionDetailsReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) => remoteDataSource.getProductionDetailsReports(
    machineNumber: machineNumber,
    startDate: startDate,
    endDate: endDate,
  );
  @override
  Future<SheetProductionDetailsReport?> getProductionDetailsReport(
    String machineNumber,
    DateTime date,
    String shift,
  ) => remoteDataSource.getProductionDetailsReport(machineNumber, date, shift);
  @override
  Future<void> submitProductionRunningFeetReport(
    SheetProductionRunningFeetReport report,
  ) => remoteDataSource.submitProductionRunningFeetReport(report);
  @override
  Future<List<SheetProductionRunningFeetReport>>
  getProductionRunningFeetReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) => remoteDataSource.getProductionRunningFeetReports(
    machineNumber: machineNumber,
    startDate: startDate,
    endDate: endDate,
  );
  @override
  Future<void> submitShiftPackingReport(SheetShiftPackingReport report) =>
      remoteDataSource.submitShiftPackingReport(report);
  @override
  Future<List<SheetShiftPackingReport>> getShiftPackingReports({
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
    SheetCustomerRejectionReport report,
  ) => remoteDataSource.submitCustomerRejectionReport(report);
  @override
  Future<List<SheetCustomerRejectionReport>> getCustomerRejectionReports({
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
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0, 23, 59, 59);

    final cleaningReports = await getMachineCleaningReports(
      startDate: startDate,
      endDate: endDate,
    );
    final a = cleaningReports.isEmpty
        ? 0.0
        : cleaningReports.map((r) => r.percentage).reduce((a, b) => a + b) /
              cleaningReports.length;

    final toolsReports = await getToolsCountReports(
      startDate: startDate,
      endDate: endDate,
    );
    final b = toolsReports.isEmpty
        ? 0.0
        : toolsReports
                  .map((r) => r.percentageAvailable)
                  .reduce((a, b) => a + b) /
              toolsReports.length;

    final rfReports = await getProductionRunningFeetReports(
      startDate: startDate,
      endDate: endDate,
    );
    final operatorRf = rfReports
        .where((r) => r.createdBy == operatorId)
        .toList();
    final c = operatorRf.isEmpty
        ? 0.0
        : operatorRf
                  .map((r) => r.efficiencyPercentage)
                  .reduce((a, b) => a + b) /
              operatorRf.length;

    final packingReports = await getShiftPackingReports(
      startDate: startDate,
      endDate: endDate,
    );
    final d = packingReports.isEmpty
        ? 0.0
        : packingReports
                  .map((r) => r.qualityAcceptancePercentage)
                  .reduce((a, b) => a + b) /
              packingReports.length;
    final e = packingReports.isEmpty
        ? 0.0
        : packingReports
                  .map((r) => r.packingEfficiency)
                  .reduce((a, b) => a + b) /
              packingReports.length;

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
