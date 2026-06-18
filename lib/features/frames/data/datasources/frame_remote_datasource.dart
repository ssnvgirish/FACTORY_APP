import 'package:firebase_data_connect/firebase_data_connect.dart';
import '../../../../generated/dataconnect/default.dart';
import '../../domain/entities/frame_entities.dart';

abstract class FrameRemoteDataSource {
  Future<void> submitMachineCleaningReport(MachineCleaningReport report);
  Future<List<MachineCleaningReport>> getMachineCleaningReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> submitToolsCountReport(ToolsCountReport report);
  Future<List<ToolsCountReport>> getToolsCountReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> submitMachineHealthReport(MachineHealthReport report);
  Future<List<MachineHealthReport>> getMachineHealthReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<List<MachineHealthReport>> getPendingApprovals();
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
  Future<void> submitProductionWeightReport(FrameProductionWeightReport report);
  Future<List<FrameProductionWeightReport>> getProductionWeightReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> submitShiftPackingReport(FrameShiftPackingReport report);
  Future<List<FrameShiftPackingReport>> getShiftPackingReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<List<ReportWritingEfficiencyRecord>> getReportWritingEfficiency({
    String? operatorId,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> submitCustomerRejectionReport(
    FrameCustomerRejectionReport report,
  );
  Future<List<FrameCustomerRejectionReport>> getCustomerRejectionReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
}

class FrameRemoteDataSourceImpl implements FrameRemoteDataSource {
  final DefaultConnector connector;

  FrameRemoteDataSourceImpl({required this.connector});

  @override
  Future<void> submitMachineCleaningReport(MachineCleaningReport report) async {
    await connector
        .createFrameCleaningReport(
          date: report.date,
          machineNumber: report.machineNumber,
          machineCondition: report.machineCondition,
          groundCondition: report.groundCondition,
          mouldCondition: report.mouldCondition,
          totalScore: report.totalScore,
          percentage: report.percentage,
          createdBy: report.createdBy,
        )
        .execute();
  }

  @override
  Future<List<MachineCleaningReport>> getMachineCleaningReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listFrameCleaningReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.frameCleaningReports
        .map(
          (r) => MachineCleaningReport(
            id: r.id,
            date: r.date,
            machineNumber: r.machineNumber,
            machineCondition: r.machineCondition,
            groundCondition: r.groundCondition,
            mouldCondition: r.mouldCondition,
            totalScore: r.totalScore,
            percentage: r.percentage,
            createdBy: r.createdBy,
            timestamp: r.timestamp?.toDateTime(),
          ),
        )
        .toList();
  }

  @override
  Future<void> submitToolsCountReport(ToolsCountReport report) async {
    await connector
        .createFrameToolsCountReport(
          date: report.date,
          machineNumber: report.machineNumber,
          totalToolsGiven: report.totalToolsGiven,
          totalToolsAvailable: report.totalToolsAvailable,
          percentageAvailable: report.percentageAvailable,
          createdBy: report.createdBy,
        )
        .execute();
  }

  @override
  Future<List<ToolsCountReport>> getToolsCountReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listFrameToolsCountReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.frameToolsCountReports
        .map(
          (r) => ToolsCountReport(
            id: r.id,
            date: r.date,
            machineNumber: r.machineNumber,
            totalToolsGiven: r.totalToolsGiven,
            totalToolsAvailable: r.totalToolsAvailable,
            percentageAvailable: r.percentageAvailable,
            createdBy: r.createdBy,
            timestamp: r.timestamp?.toDateTime(),
          ),
        )
        .toList();
  }

  @override
  Future<void> submitMachineHealthReport(MachineHealthReport report) async {
    final result = await connector
        .createFrameHealthReport(
          date: report.date,
          machineNumber: report.machineNumber,
          shift: report.shift,
          totalScore: report.totalScore,
          percentage: report.percentage,
          createdBy: report.createdBy,
        )
        .submittedAt(
          report.submittedAt != null
              ? Timestamp(0, report.submittedAt!.millisecondsSinceEpoch ~/ 1000)
              : null,
        )
        .execute();

    final reportId = result.data.frameHealthReport_insert.id;
    for (final rating in report.ratings) {
      await connector
          .createFrameHealthRatingItem(
            reportId: CreateFrameHealthRatingItemVariablesReportId(
              id: reportId,
            ),
            item: rating.item,
            rating: rating.rating,
          )
          .execute();
    }
  }

  @override
  Future<List<MachineHealthReport>> getMachineHealthReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listFrameHealthReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.frameHealthReports
        .map(
          (r) => MachineHealthReport(
            id: r.id,
            date: r.date,
            machineNumber: r.machineNumber,
            shift: r.shift,
            ratings: r.frameHealthRatingItems_on_report
                .map((ri) => HealthRatingItem(item: ri.item, rating: ri.rating))
                .toList(),
            totalScore: r.totalScore,
            percentage: r.percentage,
            createdBy: r.createdBy,
            submittedAt: r.submittedAt?.toDateTime(),
            timestamp: r.timestamp?.toDateTime(),
          ),
        )
        .toList();
  }

  @override
  Future<List<MachineHealthReport>> getPendingApprovals() async {
    return getMachineHealthReports();
  }

  @override
  Future<void> submitProductionDetailsReport(
    FrameProductionDetailsReport report,
  ) async {
    final result = await connector
        .createFrameProductionDetailsReport(
          date: report.date,
          machineNumber: report.machineNumber,
          shift: report.shift,
          totalQuantity: report.totalQuantity,
          totalWeight: report.totalWeight,
          createdBy: report.createdBy,
        )
        .submittedAt(
          report.submittedAt != null
              ? Timestamp(0, report.submittedAt!.millisecondsSinceEpoch ~/ 1000)
              : null,
        )
        .execute();

    final reportId = result.data.frameProductionDetailsReport_insert.id;
    for (final item in report.lineItems) {
      await connector
          .createFrameProductionLineItem(
            reportId: CreateFrameProductionLineItemVariablesReportId(
              id: reportId,
            ),
            section: item.section,
            density: item.density,
            color: item.color,
            length: item.length,
            quantity: item.quantity,
            perPieceWeight: item.perPieceWeight,
            totalWeight: item.totalWeight,
          )
          .manualWeightPerFoot(item.manualWeightPerFoot)
          .execute();
    }
  }

  @override
  Future<List<FrameProductionDetailsReport>> getProductionDetailsReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listFrameProductionDetailsReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.frameProductionDetailsReports
        .map(
          (r) => FrameProductionDetailsReport(
            id: r.id,
            date: r.date,
            machineNumber: r.machineNumber,
            shift: r.shift,
            lineItems: r.frameProductionLineItems_on_report
                .map(
                  (li) => FrameProductionLineItem(
                    section: li.section,
                    density: li.density,
                    color: li.color,
                    length: li.length,
                    quantity: li.quantity,
                    perPieceWeight: li.perPieceWeight,
                    totalWeight: li.totalWeight,
                    manualWeightPerFoot: li.manualWeightPerFoot,
                  ),
                )
                .toList(),
            totalQuantity: r.totalQuantity,
            totalWeight: r.totalWeight,
            createdBy: r.createdBy,
            submittedAt: r.submittedAt?.toDateTime(),
            timestamp: r.timestamp?.toDateTime(),
          ),
        )
        .toList();
  }

  @override
  Future<FrameProductionDetailsReport?> getProductionDetailsReport(
    String machineNumber,
    DateTime date,
    String shift,
  ) async {
    final result = await connector
        .getFrameProductionDetailsReport(
          machineNumber: machineNumber,
          date: DateTime(date.year, date.month, date.day),
          shift: shift,
        )
        .execute();

    final reports = result.data.frameProductionDetailsReports;
    if (reports.isEmpty) return null;
    final r = reports.first;
    return FrameProductionDetailsReport(
      id: r.id,
      date: r.date,
      machineNumber: r.machineNumber,
      shift: r.shift,
      lineItems: r.frameProductionLineItems_on_report
          .map(
            (li) => FrameProductionLineItem(
              section: li.section,
              density: li.density,
              color: li.color,
              length: li.length,
              quantity: li.quantity,
              perPieceWeight: li.perPieceWeight,
              totalWeight: li.totalWeight,
            ),
          )
          .toList(),
      totalQuantity: r.totalQuantity,
      totalWeight: r.totalWeight,
      createdBy: r.createdBy,
      submittedAt: r.submittedAt?.toDateTime(),
    );
  }

  @override
  Future<void> submitProductionWeightReport(
    FrameProductionWeightReport report,
  ) async {
    await connector
        .createFrameProductionWeightReport(
          date: report.date,
          machineNumber: report.machineNumber,
          shift: report.shift,
          productionWeight: report.productionWeight,
          maintenanceWeight: report.maintenanceWeight,
          totalProductionWeight: report.totalProductionWeight,
          targetWeight: report.targetWeight,
          efficiencyPercentage: report.efficiencyPercentage,
          createdBy: report.createdBy,
        )
        .execute();
  }

  @override
  Future<List<FrameProductionWeightReport>> getProductionWeightReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listFrameProductionWeightReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.frameProductionWeightReports
        .map(
          (r) => FrameProductionWeightReport(
            id: r.id,
            date: r.date,
            machineNumber: r.machineNumber,
            shift: r.shift,
            productionWeight: r.productionWeight,
            maintenanceWeight: r.maintenanceWeight,
            totalProductionWeight: r.totalProductionWeight,
            targetWeight: r.targetWeight,
            efficiencyPercentage: r.efficiencyPercentage,
            createdBy: r.createdBy,
            timestamp: r.timestamp?.toDateTime(),
          ),
        )
        .toList();
  }

  @override
  Future<void> submitShiftPackingReport(FrameShiftPackingReport report) async {
    final result = await connector
        .createFrameShiftPackingReport(
          date: report.date,
          machineNumber: report.machineNumber,
          shift: report.shift,
          totalRejectedWeight: report.totalRejectedWeight,
          qualityAcceptancePercentage: report.qualityAcceptancePercentage,
          packingEfficiency: report.packingEfficiency,
          createdBy: report.createdBy,
        )
        .execute();

    final reportId = result.data.frameShiftPackingReport_insert.id;
    for (final item in report.lineItems) {
      await connector
          .createFramePackingLineItem(
            reportId: CreateFramePackingLineItemVariablesReportId(id: reportId),
            section: item.section,
            density: item.density,
            color: item.color,
            length: item.length,
            productionQuantity: item.productionQuantity,
            perPieceWeight: item.perPieceWeight,
            packed: item.packed,
            rejectedQuality: item.rejectedQuality,
          )
          .execute();
    }
  }

  @override
  Future<List<FrameShiftPackingReport>> getShiftPackingReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listFrameShiftPackingReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.frameShiftPackingReports
        .map(
          (r) => FrameShiftPackingReport(
            id: r.id,
            date: r.date,
            machineNumber: r.machineNumber,
            shift: r.shift,
            lineItems: r.framePackingLineItems_on_report
                .map(
                  (li) => FramePackingLineItem(
                    section: li.section,
                    density: li.density,
                    color: li.color,
                    length: li.length,
                    productionQuantity: li.productionQuantity,
                    perPieceWeight: li.perPieceWeight,
                    packed: li.packed,
                    rejectedQuality: li.rejectedQuality,
                  ),
                )
                .toList(),
            totalRejectedWeight: r.totalRejectedWeight,
            qualityAcceptancePercentage: r.qualityAcceptancePercentage,
            packingEfficiency: r.packingEfficiency,
            createdBy: r.createdBy,
            timestamp: r.timestamp?.toDateTime(),
          ),
        )
        .toList();
  }

  @override
  Future<List<ReportWritingEfficiencyRecord>> getReportWritingEfficiency({
    String? operatorId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listFrameWritingEfficiency();
    if (operatorId != null) builder.operatorId(operatorId);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.frameWritingEfficiencies
        .map(
          (r) => ReportWritingEfficiencyRecord(
            id: r.id,
            date: r.date,
            machineNumber: r.machineNumber,
            shift: r.shift,
            submittedAt: r.submittedAt?.toDateTime(),
            shiftEndTime: r.shiftEndTime.toDateTime(),
            score: r.score,
            operatorId: r.operatorId,
          ),
        )
        .toList();
  }

  @override
  Future<void> submitCustomerRejectionReport(
    FrameCustomerRejectionReport report,
  ) async {
    final result = await connector
        .createFrameCustomerRejectionReport(
          originalProductionDate: report.originalProductionDate,
          rejectionDate: report.rejectionDate,
          machineNumber: report.machineNumber,
          shift: report.shift,
          totalRejectedWeight: report.totalRejectedWeight,
          createdBy: report.createdBy,
        )
        .execute();

    final reportId = result.data.frameCustomerRejectionReport_insert.id;
    for (final item in report.rejectedItems) {
      await connector
          .createFrameCustomerRejectionItem(
            reportId: CreateFrameCustomerRejectionItemVariablesReportId(
              id: reportId,
            ),
            section: item.section,
            density: item.density,
            color: item.color,
            length: item.length,
            quantity: item.quantity,
            perPieceWeight: item.perPieceWeight,
            totalWeight: item.totalWeight,
          )
          .execute();
    }
  }

  @override
  Future<List<FrameCustomerRejectionReport>> getCustomerRejectionReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listFrameCustomerRejectionReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.frameCustomerRejectionReports
        .map(
          (r) => FrameCustomerRejectionReport(
            id: r.id,
            originalProductionDate: r.originalProductionDate,
            rejectionDate: r.rejectionDate,
            machineNumber: r.machineNumber,
            shift: r.shift,
            rejectedItems: r.frameCustomerRejectionItems_on_report
                .map(
                  (li) => FrameProductionLineItem(
                    section: li.section,
                    density: li.density,
                    color: li.color,
                    length: li.length,
                    quantity: li.quantity,
                    perPieceWeight: li.perPieceWeight,
                    totalWeight: li.totalWeight,
                  ),
                )
                .toList(),
            totalRejectedWeight: r.totalRejectedWeight,
            createdBy: r.createdBy,
            timestamp: r.timestamp?.toDateTime(),
          ),
        )
        .toList();
  }
}
