import 'package:firebase_data_connect/firebase_data_connect.dart';
import '../../../../generated/dataconnect/default.dart';
import '../../../frames/domain/entities/frame_entities.dart';
import '../../domain/entities/sheet_entities.dart';

abstract class SheetRemoteDataSource {
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
  Future<void> submitProductionRunningFeetReport(
    SheetProductionRunningFeetReport report,
  );
  Future<List<SheetProductionRunningFeetReport>>
  getProductionRunningFeetReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> submitShiftPackingReport(SheetShiftPackingReport report);
  Future<List<SheetShiftPackingReport>> getShiftPackingReports({
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
    SheetCustomerRejectionReport report,
  );
  Future<List<SheetCustomerRejectionReport>> getCustomerRejectionReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
}

class SheetRemoteDataSourceImpl implements SheetRemoteDataSource {
  final DefaultConnector connector;

  SheetRemoteDataSourceImpl({required this.connector});

  @override
  Future<void> submitMachineCleaningReport(MachineCleaningReport report) async {
    await connector
        .createSheetCleaningReport(
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
    final builder = connector.listSheetCleaningReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.sheetCleaningReports
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
        .createSheetToolsCountReport(
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
    final builder = connector.listSheetToolsCountReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.sheetToolsCountReports
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
        .createSheetHealthReport(
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

    final reportId = result.data.sheetHealthReport_insert.id;
    for (final rating in report.ratings) {
      await connector
          .createSheetHealthRatingItem(
            reportId: CreateSheetHealthRatingItemVariablesReportId(
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
    final builder = connector.listSheetHealthReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.sheetHealthReports
        .map(
          (r) => MachineHealthReport(
            id: r.id,
            date: r.date,
            machineNumber: r.machineNumber,
            shift: r.shift,
            ratings: r.sheetHealthRatingItems_on_report
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
    SheetProductionDetailsReport report,
  ) async {
    final result = await connector
        .createSheetProductionDetailsReport(
          date: report.date,
          machineNumber: report.machineNumber,
          shift: report.shift,
          totalQuantity: report.totalQuantity,
          totalWeight: report.totalWeight,
          totalRunningFeet: report.totalRunningFeet,
          createdBy: report.createdBy,
        )
        .submittedAt(
          report.submittedAt != null
              ? Timestamp(0, report.submittedAt!.millisecondsSinceEpoch ~/ 1000)
              : null,
        )
        .execute();

    final reportId = result.data.sheetProductionDetailsReport_insert.id;
    for (final item in report.lineItems) {
      await connector
          .createSheetProductionLineItem(
            reportId: CreateSheetProductionLineItemVariablesReportId(
              id: reportId,
            ),
            thickness: item.thickness,
            density: item.density,
            color: item.color,
            length: item.length,
            width: item.width,
            quantity: item.quantity,
            sqft: item.sqft,
            perPieceWeight: item.perPieceWeight,
            totalWeight: item.totalWeight,
            totalRunningFeet: item.totalRunningFeet,
          )
          .timeOfChange(
            item.timeOfChange != null
                ? Timestamp(
                    0,
                    item.timeOfChange!.millisecondsSinceEpoch ~/ 1000,
                  )
                : null,
          )
          .manualWeightPerSqft(item.manualWeightPerSqft)
          .execute();
    }
  }

  @override
  Future<List<SheetProductionDetailsReport>> getProductionDetailsReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listSheetProductionDetailsReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.sheetProductionDetailsReports
        .map(
          (r) => SheetProductionDetailsReport(
            id: r.id,
            date: r.date,
            machineNumber: r.machineNumber,
            shift: r.shift,
            lineItems: r.sheetProductionLineItems_on_report
                .map(
                  (li) => SheetProductionLineItem(
                    thickness: li.thickness,
                    density: li.density,
                    color: li.color,
                    length: li.length,
                    width: li.width,
                    quantity: li.quantity,
                    sqft: li.sqft,
                    perPieceWeight: li.perPieceWeight,
                    totalWeight: li.totalWeight,
                    totalRunningFeet: li.totalRunningFeet,
                    timeOfChange: li.timeOfChange?.toDateTime(),
                    manualWeightPerSqft: li.manualWeightPerSqft,
                  ),
                )
                .toList(),
            totalQuantity: r.totalQuantity,
            totalWeight: r.totalWeight,
            totalRunningFeet: r.totalRunningFeet,
            createdBy: r.createdBy,
            submittedAt: r.submittedAt?.toDateTime(),
            timestamp: r.timestamp?.toDateTime(),
          ),
        )
        .toList();
  }

  @override
  Future<SheetProductionDetailsReport?> getProductionDetailsReport(
    String machineNumber,
    DateTime date,
    String shift,
  ) async {
    final result = await connector
        .getSheetProductionDetailsReport(
          machineNumber: machineNumber,
          date: DateTime(date.year, date.month, date.day),
          shift: shift,
        )
        .execute();

    final reports = result.data.sheetProductionDetailsReports;
    if (reports.isEmpty) return null;
    final r = reports.first;
    return SheetProductionDetailsReport(
      id: r.id,
      date: r.date,
      machineNumber: r.machineNumber,
      shift: r.shift,
      lineItems: r.sheetProductionLineItems_on_report
          .map(
            (li) => SheetProductionLineItem(
              thickness: li.thickness,
              density: li.density,
              color: li.color,
              length: li.length,
              width: li.width,
              quantity: li.quantity,
              sqft: li.sqft,
              perPieceWeight: li.perPieceWeight,
              totalWeight: li.totalWeight,
              totalRunningFeet: li.totalRunningFeet,
            ),
          )
          .toList(),
      totalQuantity: r.totalQuantity,
      totalWeight: r.totalWeight,
      totalRunningFeet: r.totalRunningFeet,
      createdBy: r.createdBy,
      submittedAt: r.submittedAt?.toDateTime(),
    );
  }

  @override
  Future<void> submitProductionRunningFeetReport(
    SheetProductionRunningFeetReport report,
  ) async {
    await connector
        .createSheetRunningFeetReport(
          date: report.date,
          machineNumber: report.machineNumber,
          shift: report.shift,
          productionRunningFeet: report.productionRunningFeet,
          maintenanceRunningFeet: report.maintenanceRunningFeet,
          totalProductionRunningFeet: report.totalProductionRunningFeet,
          targetRunningFeet: report.targetRunningFeet,
          efficiencyPercentage: report.efficiencyPercentage,
          createdBy: report.createdBy,
        )
        .execute();
  }

  @override
  Future<List<SheetProductionRunningFeetReport>>
  getProductionRunningFeetReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listSheetRunningFeetReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.sheetRunningFeetReports
        .map(
          (r) => SheetProductionRunningFeetReport(
            id: r.id,
            date: r.date,
            machineNumber: r.machineNumber,
            shift: r.shift,
            productionRunningFeet: r.productionRunningFeet,
            maintenanceRunningFeet: r.maintenanceRunningFeet,
            totalProductionRunningFeet: r.totalProductionRunningFeet,
            targetRunningFeet: r.targetRunningFeet,
            efficiencyPercentage: r.efficiencyPercentage,
            createdBy: r.createdBy,
            timestamp: r.timestamp?.toDateTime(),
          ),
        )
        .toList();
  }

  @override
  Future<void> submitShiftPackingReport(SheetShiftPackingReport report) async {
    final result = await connector
        .createSheetShiftPackingReport(
          date: report.date,
          machineNumber: report.machineNumber,
          shift: report.shift,
          totalRejectedRunningFeet: report.totalRejectedRunningFeet,
          qualityAcceptancePercentage: report.qualityAcceptancePercentage,
          packingEfficiency: report.packingEfficiency,
          createdBy: report.createdBy,
        )
        .execute();

    final reportId = result.data.sheetShiftPackingReport_insert.id;
    for (final item in report.lineItems) {
      await connector
          .createSheetPackingLineItem(
            reportId: CreateSheetPackingLineItemVariablesReportId(id: reportId),
            thickness: item.thickness,
            density: item.density,
            color: item.color,
            length: item.length,
            width: item.width,
            productionQuantity: item.productionQuantity,
            perPieceWeight: item.perPieceWeight,
            runningFeetPerItem: item.runningFeetPerItem,
            packed: item.packed,
            onlySanding: item.onlySanding,
            sandingAndPacked: item.sandingAndPacked,
            rejectedQuality: item.rejectedQuality,
          )
          .execute();
    }
  }

  @override
  Future<List<SheetShiftPackingReport>> getShiftPackingReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listSheetShiftPackingReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.sheetShiftPackingReports
        .map(
          (r) => SheetShiftPackingReport(
            id: r.id,
            date: r.date,
            machineNumber: r.machineNumber,
            shift: r.shift,
            lineItems: r.sheetPackingLineItems_on_report
                .map(
                  (li) => SheetPackingLineItem(
                    thickness: li.thickness,
                    density: li.density,
                    color: li.color,
                    length: li.length,
                    width: li.width,
                    productionQuantity: li.productionQuantity,
                    perPieceWeight: li.perPieceWeight,
                    runningFeetPerItem: li.runningFeetPerItem,
                    packed: li.packed,
                    onlySanding: li.onlySanding,
                    sandingAndPacked: li.sandingAndPacked,
                    rejectedQuality: li.rejectedQuality,
                  ),
                )
                .toList(),
            totalRejectedRunningFeet: r.totalRejectedRunningFeet,
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
    final builder = connector.listSheetWritingEfficiency();
    if (operatorId != null) builder.operatorId(operatorId);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.sheetWritingEfficiencies
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
    SheetCustomerRejectionReport report,
  ) async {
    final result = await connector
        .createSheetCustomerRejectionReport(
          originalProductionDate: report.originalProductionDate,
          machineNumber: report.machineNumber,
          shift: report.shift,
          totalRejectedRunningFeet: report.totalRejectedRunningFeet,
          createdBy: report.createdBy,
        )
        .execute();

    final reportId = result.data.sheetCustomerRejectionReport_insert.id;
    for (final item in report.rejectedItems) {
      await connector
          .createSheetCustomerRejectionItem(
            reportId: CreateSheetCustomerRejectionItemVariablesReportId(
              id: reportId,
            ),
            thickness: item.thickness,
            density: item.density,
            color: item.color,
            length: item.length,
            width: item.width,
            quantity: item.quantity,
            sqft: item.sqft,
            perPieceWeight: item.perPieceWeight,
            totalWeight: item.totalWeight,
            totalRunningFeet: item.totalRunningFeet,
          )
          .execute();
    }
  }

  @override
  Future<List<SheetCustomerRejectionReport>> getCustomerRejectionReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listSheetCustomerRejectionReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.sheetCustomerRejectionReports
        .map(
          (r) => SheetCustomerRejectionReport(
            id: r.id,
            originalProductionDate: r.originalProductionDate,
            machineNumber: r.machineNumber,
            shift: r.shift,
            rejectedItems: r.sheetCustomerRejectionItems_on_report
                .map(
                  (li) => SheetProductionLineItem(
                    thickness: li.thickness,
                    density: li.density,
                    color: li.color,
                    length: li.length,
                    width: li.width,
                    quantity: li.quantity,
                    sqft: li.sqft,
                    perPieceWeight: li.perPieceWeight,
                    totalWeight: li.totalWeight,
                    totalRunningFeet: li.totalRunningFeet,
                  ),
                )
                .toList(),
            totalRejectedRunningFeet: r.totalRejectedRunningFeet,
            createdBy: r.createdBy,
            timestamp: r.timestamp?.toDateTime(),
          ),
        )
        .toList();
  }
}
