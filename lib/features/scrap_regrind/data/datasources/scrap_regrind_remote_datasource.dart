import 'package:firebase_data_connect/firebase_data_connect.dart';

import '../../../../generated/dataconnect/default.dart';
import '../../domain/entities/scrap_regrind_entities.dart';

abstract class ScrapRegrindRemoteDataSource {
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
  Future<Map<String, double>> getMonthlyAggregates(
    String operatorId,
    int year,
    int month,
  );
  Future<double> getFixedSalary(String operatorId);
  Future<String> getOperatorName(String operatorId);
  Future<void> saveSalaryCalculation(ScrapSalaryCalculation calculation);
  Future<ScrapSalaryCalculation?> getSavedCalculation(
    String operatorId,
    int year,
    int month,
  );
}

class ScrapRegrindRemoteDataSourceImpl implements ScrapRegrindRemoteDataSource {
  final DefaultConnector connector;

  ScrapRegrindRemoteDataSourceImpl({required this.connector});

  // ═══════════════════════════════════════
  // MACHINE CLEANING REPORT
  // ═══════════════════════════════════════

  @override
  Future<void> submitCleaningReport(ScrapCleaningReport report) async {
    await connector
        .createScrapCleaningReport(
          date: report.date,
          machineNumber: report.machineNumber,
          machineCondition: report.machineCondition,
          groundCondition: report.groundCondition,
          totalScore: report.totalScore,
          percentage: report.percentage,
          createdBy: report.createdBy,
        )
        .execute();
  }

  @override
  Future<List<ScrapCleaningReport>> getCleaningReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listScrapCleaningReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.scrapCleaningReports
        .map(
          (r) => ScrapCleaningReport(
            id: r.id,
            date: r.date,
            machineNumber: r.machineNumber,
            machineCondition: r.machineCondition,
            groundCondition: r.groundCondition,
            totalScore: r.totalScore,
            percentage: r.percentage,
            createdBy: r.createdBy,
            timestamp: r.timestamp?.toDateTime(),
          ),
        )
        .toList();
  }

  // ═══════════════════════════════════════
  // TOOLS COUNT REPORT
  // ═══════════════════════════════════════

  @override
  Future<void> submitToolsCountReport(ScrapToolsCountReport report) async {
    await connector
        .createScrapToolsCountReport(
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
  Future<List<ScrapToolsCountReport>> getToolsCountReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listScrapToolsCountReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.scrapToolsCountReports
        .map(
          (r) => ScrapToolsCountReport(
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

  // ═══════════════════════════════════════
  // MACHINE HEALTH REPORT
  // ═══════════════════════════════════════

  @override
  Future<void> submitMachineHealthReport(
    ScrapMachineHealthReport report,
  ) async {
    final result = await connector
        .createScrapMachineHealthReport(
          date: report.date,
          machineNumber: report.machineNumber,
          shift: report.shift,
          totalMaintenanceDurationHours: report.totalMaintenanceDurationHours,
          createdBy: report.createdBy,
        )
        .submittedAt(
          report.submittedAt != null
              ? Timestamp(0, report.submittedAt!.millisecondsSinceEpoch ~/ 1000)
              : null,
        )
        .execute();

    final reportId = result.data.scrapMachineHealthReport_insert.id;
    for (final entry in report.entries) {
      await connector
          .createScrapMaintenanceEntry(
            reportId: CreateScrapMaintenanceEntryVariablesReportId(
              id: reportId,
            ),
            maintenanceItem: entry.maintenanceItem,
            startTime: Timestamp(
              0,
              entry.startTime.millisecondsSinceEpoch ~/ 1000,
            ),
            endTime: Timestamp(0, entry.endTime.millisecondsSinceEpoch ~/ 1000),
            personDoingMaintenance: entry.personDoingMaintenance,
            description: entry.description,
            durationHours: entry.durationHours,
          )
          .execute();
    }
  }

  @override
  Future<List<ScrapMachineHealthReport>> getMachineHealthReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listScrapMachineHealthReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.scrapMachineHealthReports.map((r) {
      final entries = r.scrapMaintenanceEntries_on_report
          .map(
            (e) => ScrapMaintenanceEntry(
              maintenanceItem: e.maintenanceItem,
              startTime: e.startTime.toDateTime(),
              endTime: e.endTime.toDateTime(),
              personDoingMaintenance: e.personDoingMaintenance,
              description: e.description,
              durationHours: e.durationHours,
            ),
          )
          .toList();
      return ScrapMachineHealthReport(
        id: r.id,
        date: r.date,
        machineNumber: r.machineNumber,
        shift: r.shift,
        entries: entries,
        totalMaintenanceDurationHours: r.totalMaintenanceDurationHours,
        createdBy: r.createdBy,
        timestamp: r.timestamp?.toDateTime(),
        submittedAt: r.submittedAt?.toDateTime(),
      );
    }).toList();
  }

  @override
  Future<ScrapMachineHealthReport?> getMachineHealthReport(
    String machineNumber,
    DateTime date,
    String shift,
  ) async {
    final reports = await getMachineHealthReports(
      machineNumber: machineNumber,
      startDate: date,
      endDate: date,
    );
    return reports.cast<ScrapMachineHealthReport?>().firstWhere(
      (r) => r!.shift == shift,
      orElse: () => null,
    );
  }

  // ═══════════════════════════════════════
  // PRODUCTION DETAILS REPORT
  // ═══════════════════════════════════════

  @override
  Future<void> submitProductionDetailsReport(
    ScrapProductionDetailsReport report,
  ) async {
    final result = await connector
        .createScrapProductionDetailsReport(
          date: report.date,
          machineNumber: report.machineNumber,
          shift: report.shift,
          totalProductionWeight: report.totalProductionWeight,
          createdBy: report.createdBy,
        )
        .submittedAt(
          report.submittedAt != null
              ? Timestamp(0, report.submittedAt!.millisecondsSinceEpoch ~/ 1000)
              : null,
        )
        .execute();

    final reportId = result.data.scrapProductionDetailsReport_insert.id;
    for (final item in report.lineItems) {
      await connector
          .createScrapProductionLineItem(
            reportId: CreateScrapProductionLineItemVariablesReportId(
              id: reportId,
            ),
            product: item.product,
            weightPerBag: item.weightPerBag,
            totalBags: item.totalBags,
            totalWeight: item.totalWeight,
          )
          .execute();
    }
  }

  @override
  Future<List<ScrapProductionDetailsReport>> getProductionDetailsReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listScrapProductionDetailsReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.scrapProductionDetailsReports.map((r) {
      final lineItems = r.scrapProductionLineItems_on_report
          .map(
            (item) => ScrapProductionLineItem(
              product: item.product,
              weightPerBag: item.weightPerBag,
              totalBags: item.totalBags,
              totalWeight: item.totalWeight,
            ),
          )
          .toList();
      return ScrapProductionDetailsReport(
        id: r.id,
        date: r.date,
        machineNumber: r.machineNumber,
        shift: r.shift,
        lineItems: lineItems,
        totalProductionWeight: r.totalProductionWeight,
        createdBy: r.createdBy,
        timestamp: r.timestamp?.toDateTime(),
        submittedAt: r.submittedAt?.toDateTime(),
      );
    }).toList();
  }

  @override
  Future<ScrapProductionDetailsReport?> getProductionDetailsReport(
    String machineNumber,
    DateTime date,
    String shift,
  ) async {
    final reports = await getProductionDetailsReports(
      machineNumber: machineNumber,
      startDate: date,
      endDate: date,
    );
    return reports.cast<ScrapProductionDetailsReport?>().firstWhere(
      (r) => r!.shift == shift,
      orElse: () => null,
    );
  }

  // ═══════════════════════════════════════
  // PRODUCTION WEIGHT REPORT
  // ═══════════════════════════════════════

  @override
  Future<void> submitProductionWeightReport(
    ScrapProductionWeightReport report,
  ) async {
    await connector
        .createScrapProductionWeightReport(
          date: report.date,
          machineNumber: report.machineNumber,
          shift: report.shift,
          totalProductionWeight: report.totalProductionWeight,
          maintenanceWeight: report.maintenanceWeight,
          totalWeight: report.totalWeight,
          targetWeight: report.targetWeight,
          efficiencyPercentage: report.efficiencyPercentage,
          createdBy: report.createdBy,
        )
        .execute();
  }

  @override
  Future<List<ScrapProductionWeightReport>> getProductionWeightReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listScrapProductionWeightReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.scrapProductionWeightReports
        .map(
          (r) => ScrapProductionWeightReport(
            id: r.id,
            date: r.date,
            machineNumber: r.machineNumber,
            shift: r.shift,
            totalProductionWeight: r.totalProductionWeight,
            maintenanceWeight: r.maintenanceWeight,
            totalWeight: r.totalWeight,
            targetWeight: r.targetWeight,
            efficiencyPercentage: r.efficiencyPercentage,
            createdBy: r.createdBy,
            timestamp: r.timestamp?.toDateTime(),
          ),
        )
        .toList();
  }

  // ═══════════════════════════════════════
  // REPORT WRITING EFFICIENCY
  // ═══════════════════════════════════════

  @override
  Future<List<ScrapReportWritingEfficiency>> getReportWritingEfficiency({
    String? operatorId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listScrapReportWritingEfficiency();
    if (operatorId != null) builder.machineNumber(operatorId);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.scrapWritingEfficiencies
        .map(
          (r) => ScrapReportWritingEfficiency(
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

  // ═══════════════════════════════════════
  // SCRAP QUALITY REPORT
  // ═══════════════════════════════════════

  @override
  Future<void> submitScrapQualityReport(ScrapQualityReport report) async {
    final builder = connector.createScrapQualityReport(
      date: report.date,
      machineNumber: report.machineNumber,
      shift: report.shift,
      product: report.product,
      qualityRating: report.qualityRating,
      createdBy: report.createdBy,
    );
    // TODO: uncomment after running `flutterfire dataconnect:sdk:generate`
    // if (report.comments != null) builder.comments(report.comments!);
    await builder.execute();
  }

  @override
  Future<List<ScrapQualityReport>> getScrapQualityReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final builder = connector.listScrapQualityReports();
    if (machineNumber != null) builder.machineNumber(machineNumber);
    if (startDate != null) builder.startDate(startDate);
    if (endDate != null) builder.endDate(endDate);
    final result = await builder.execute();
    return result.data.scrapQualityReports
        .map(
          (r) => ScrapQualityReport(
            id: r.id,
            date: r.date,
            machineNumber: r.machineNumber,
            shift: r.shift,
            product: r.product,
            qualityRating: r.qualityRating,
            // TODO: uncomment after running `flutterfire dataconnect:sdk:generate`
            // comments: r.comments,
            createdBy: r.createdBy,
            timestamp: r.timestamp?.toDateTime(),
          ),
        )
        .toList();
  }

  // ═══════════════════════════════════════
  // SALARY
  // ═══════════════════════════════════════

  @override
  Future<ScrapSalaryWeightages> getSalaryWeightages() async {
    final result = await connector.getScrapSalaryWeightages().execute();
    final items = result.data.masterSalaryWeightages;
    if (items.isEmpty) {
      return const ScrapSalaryWeightages(
        wA: 20,
        wB: 15,
        wE: 25,
        wF: 15,
        wG: 25,
      );
    }
    double _val(String variable) =>
        items.where((w) => w.variable == variable).firstOrNull?.percentage ?? 0;
    return ScrapSalaryWeightages(
      wA: _val('wA'),
      wB: _val('wB'),
      wE: _val('wE'),
      wF: _val('wF'),
      wG: _val('wG'),
    );
  }

  @override
  Future<Map<String, double>> getMonthlyAggregates(
    String operatorId,
    int year,
    int month,
  ) async {
    final users = await connector.listAllUsers().execute();
    final user = users.data.users.where((u) => u.uid == operatorId).firstOrNull;
    final machineNumber = user?.assignedMachines.isNotEmpty == true
        ? user!.assignedMachines.first
        : operatorId;

    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0, 23, 59, 59);
    final result = await connector
        .getScrapMonthlyAggregates(
          machineNumber: machineNumber,
          startDate: startDate,
          endDate: endDate,
        )
        .execute();
    final data = result.data;

    final aScores = data.scrapCleaningReports.map((r) => r.percentage).toList();
    final bScores = data.scrapToolsCountReports
        .map((r) => r.percentageAvailable)
        .toList();
    final eScores = data.scrapProductionWeightReports
        .map((r) => r.efficiencyPercentage)
        .toList();
    final fScores = data.scrapWritingEfficiencies
        .map((r) => r.score.toDouble())
        .toList();
    final gScores = data.scrapQualityReports
        .map((r) => r.qualityRating.toDouble())
        .toList();

    double average(List<double> values) =>
        values.isEmpty ? 0.0 : values.reduce((x, y) => x + y) / values.length;

    return {
      'a': average(aScores),
      'b': average(bScores),
      'e': average(eScores),
      // Writing score is 0-5; convert to percentage.
      'f': fScores.isEmpty ? 0.0 : (average(fScores) / 5) * 100,
      // Quality rating is 1-10; convert to percentage.
      'g': gScores.isEmpty ? 0.0 : (average(gScores) / 10) * 100,
    };
  }

  @override
  Future<double> getFixedSalary(String operatorId) async {
    final result = await connector.listAllUsers().execute();
    final user = result.data.users
        .where((u) => u.uid == operatorId)
        .firstOrNull;
    return user?.fixedSalary ?? 0.0;
  }

  @override
  Future<String> getOperatorName(String operatorId) async {
    final result = await connector.listAllUsers().execute();
    final user = result.data.users
        .where((u) => u.uid == operatorId)
        .firstOrNull;
    return user?.name ?? 'Unknown';
  }

  @override
  Future<void> saveSalaryCalculation(ScrapSalaryCalculation calculation) async {
    await connector
        .createScrapSalaryCalculation(
          operatorId: calculation.operatorId,
          operatorName: calculation.operatorName,
          year: calculation.year,
          month: calculation.month,
          a: calculation.a,
          b: calculation.b,
          e: calculation.e,
          f: calculation.f,
          g: calculation.g,
          wA: calculation.wA,
          wB: calculation.wB,
          wE: calculation.wE,
          wF: calculation.wF,
          wG: calculation.wG,
          multiplier: calculation.multiplier,
          fixedSalary: calculation.fixedSalary,
          calculatedSalary: calculation.calculatedSalary,
        )
        .execute();
  }

  @override
  Future<ScrapSalaryCalculation?> getSavedCalculation(
    String operatorId,
    int year,
    int month,
  ) async {
    final result = await connector
        .getScrapSalaryCalculation(
          operatorId: operatorId,
          year: year,
          month: month,
        )
        .execute();
    final calcs = result.data.scrapSalaryCalculations;
    if (calcs.isEmpty) return null;
    final data = calcs.first;
    return ScrapSalaryCalculation(
      id: data.id,
      operatorId: data.operatorId,
      operatorName: data.operatorName,
      year: data.year,
      month: data.month,
      a: data.a,
      b: data.b,
      e: data.e,
      f: data.f,
      g: data.g,
      wA: data.wA,
      wB: data.wB,
      wE: data.wE,
      wF: data.wF,
      wG: data.wG,
      multiplier: data.multiplier,
      fixedSalary: data.fixedSalary,
      calculatedSalary: data.calculatedSalary,
    );
  }
}
