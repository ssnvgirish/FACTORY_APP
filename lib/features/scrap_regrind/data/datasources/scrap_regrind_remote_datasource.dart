import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/data/collections.dart';
import '../../../../core/data/firestore_support.dart';
import '../../domain/entities/scrap_regrind_entities.dart';

abstract class ScrapRegrindRemoteDataSource {
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
  Future<void> submitWritingEfficiency(ScrapReportWritingEfficiency record);

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
  ScrapRegrindRemoteDataSourceImpl({required FirebaseFirestore firestore})
    : _db = firestore,
      _reports = Reports(firestore);

  final FirebaseFirestore _db;
  final Reports _reports;

  Future<List<DocRow>> _list(
    String collection, {
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
    String equalsField = 'machineNumber',
    String? equalsValue,
  }) => _reports.list(
    collection,
    equalsField: equalsField,
    equalsValue: equalsValue ?? machineNumber,
    startDate: startDate,
    endDate: endDate,
  );

  Future<DocRow?> _userByUid(String operatorId) async {
    final snap = await _db
        .collection(Col.users)
        .where('uid', isEqualTo: operatorId)
        .limit(1)
        .get();
    return snap.docs.isEmpty ? null : DocRow.fromSnapshot(snap.docs.first);
  }

  // ═══════════════════════════════════════
  // MACHINE CLEANING REPORT
  // ═══════════════════════════════════════

  @override
  Future<void> submitCleaningReport(ScrapCleaningReport report) async {
    await _reports.add(Col.scrapCleaning, {
      'date': dateKey(report.date),
      'machineNumber': report.machineNumber,
      'machineCondition': report.machineCondition,
      'groundCondition': report.groundCondition,
      'totalScore': report.totalScore,
      'percentage': report.percentage,
      'createdBy': report.createdBy,
    });
  }

  @override
  Future<List<ScrapCleaningReport>> getCleaningReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.scrapCleaning,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => ScrapCleaningReport(
            id: r.id,
            date: r.date('date'),
            machineNumber: r.str('machineNumber'),
            machineCondition: r.integer('machineCondition'),
            groundCondition: r.integer('groundCondition'),
            totalScore: r.integer('totalScore'),
            percentage: r.real('percentage'),
            createdBy: r.str('createdBy'),
            timestamp: r.timestamp('timestamp'),
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteCleaningReport(String id) =>
      _reports.delete(Col.scrapCleaning, id);

  // ═══════════════════════════════════════
  // TOOLS COUNT REPORT
  // ═══════════════════════════════════════

  @override
  Future<void> submitToolsCountReport(ScrapToolsCountReport report) async {
    await _reports.add(Col.scrapToolsCount, {
      'date': dateKey(report.date),
      'machineNumber': report.machineNumber,
      'totalToolsGiven': report.totalToolsGiven,
      'totalToolsAvailable': report.totalToolsAvailable,
      'percentageAvailable': report.percentageAvailable,
      'createdBy': report.createdBy,
    });
  }

  @override
  Future<List<ScrapToolsCountReport>> getToolsCountReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.scrapToolsCount,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => ScrapToolsCountReport(
            id: r.id,
            date: r.date('date'),
            machineNumber: r.str('machineNumber'),
            totalToolsGiven: r.integer('totalToolsGiven'),
            totalToolsAvailable: r.integer('totalToolsAvailable'),
            percentageAvailable: r.real('percentageAvailable'),
            createdBy: r.str('createdBy'),
            timestamp: r.timestamp('timestamp'),
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteToolsCountReport(String id) =>
      _reports.delete(Col.scrapToolsCount, id);

  // ═══════════════════════════════════════
  // MACHINE HEALTH REPORT
  // ═══════════════════════════════════════

  Map<String, dynamic> _entryToMap(ScrapMaintenanceEntry e) => {
    'maintenanceItem': e.maintenanceItem,
    'startTime': toTimestamp(e.startTime),
    'endTime': toTimestamp(e.endTime),
    'personDoingMaintenance': e.personDoingMaintenance,
    'description': e.description,
    'durationHours': e.durationHours,
  };

  ScrapMaintenanceEntry _entry(DocRow e) => ScrapMaintenanceEntry(
    maintenanceItem: e.str('maintenanceItem'),
    startTime: e.timestamp('startTime')!,
    endTime: e.timestamp('endTime')!,
    personDoingMaintenance: e.str('personDoingMaintenance'),
    description: e.str('description'),
    durationHours: e.real('durationHours'),
  );

  ScrapMachineHealthReport _healthReport(DocRow r) => ScrapMachineHealthReport(
    id: r.id,
    date: r.date('date'),
    machineNumber: r.str('machineNumber'),
    shift: r.str('shift'),
    entries: r.children('entries').map(_entry).toList(),
    totalMaintenanceDurationHours: r.real('totalMaintenanceDurationHours'),
    createdBy: r.str('createdBy'),
    timestamp: r.timestamp('timestamp'),
    submittedAt: r.timestamp('submittedAt'),
  );

  @override
  Future<void> submitMachineHealthReport(
    ScrapMachineHealthReport report,
  ) async {
    await _reports.add(Col.scrapHealth, {
      'date': dateKey(report.date),
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'totalMaintenanceDurationHours': report.totalMaintenanceDurationHours,
      'createdBy': report.createdBy,
      'submittedAt': toTimestamp(report.submittedAt),
      'entries': report.entries.map(_entryToMap).toList(),
    });
  }

  @override
  Future<List<ScrapMachineHealthReport>> getMachineHealthReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.scrapHealth,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows.map(_healthReport).toList();
  }

  @override
  Future<ScrapMachineHealthReport?> getMachineHealthReport(
    String machineNumber,
    DateTime date,
    String shift,
  ) async {
    final row = await _reports.findOne(Col.scrapHealth, {
      'machineNumber': machineNumber,
      'date': dateKey(date),
      'shift': shift,
    });
    return row == null ? null : _healthReport(row);
  }

  @override
  Future<void> deleteMachineHealthReport(String id) =>
      _reports.delete(Col.scrapHealth, id);

  // ═══════════════════════════════════════
  // PRODUCTION DETAILS REPORT
  // ═══════════════════════════════════════

  Map<String, dynamic> _lineItemToMap(ScrapProductionLineItem i) => {
    'product': i.product,
    'weightPerBag': i.weightPerBag,
    'totalBags': i.totalBags,
    'totalWeight': i.totalWeight,
  };

  ScrapProductionLineItem _lineItem(DocRow i) => ScrapProductionLineItem(
    product: i.str('product'),
    weightPerBag: i.real('weightPerBag'),
    totalBags: i.integer('totalBags'),
    totalWeight: i.real('totalWeight'),
  );

  ScrapProductionDetailsReport _productionReport(DocRow r) =>
      ScrapProductionDetailsReport(
        id: r.id,
        date: r.date('date'),
        machineNumber: r.str('machineNumber'),
        shift: r.str('shift'),
        lineItems: r.children('lineItems').map(_lineItem).toList(),
        totalProductionWeight: r.real('totalProductionWeight'),
        createdBy: r.str('createdBy'),
        timestamp: r.timestamp('timestamp'),
        submittedAt: r.timestamp('submittedAt'),
      );

  @override
  Future<void> submitProductionDetailsReport(
    ScrapProductionDetailsReport report,
  ) async {
    await _reports.add(Col.scrapProductionDetails, {
      'date': dateKey(report.date),
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'totalProductionWeight': report.totalProductionWeight,
      'createdBy': report.createdBy,
      'submittedAt': toTimestamp(report.submittedAt),
      'lineItems': report.lineItems.map(_lineItemToMap).toList(),
    });
  }

  @override
  Future<List<ScrapProductionDetailsReport>> getProductionDetailsReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.scrapProductionDetails,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows.map(_productionReport).toList();
  }

  @override
  Future<ScrapProductionDetailsReport?> getProductionDetailsReport(
    String machineNumber,
    DateTime date,
    String shift,
  ) async {
    final row = await _reports.findOne(Col.scrapProductionDetails, {
      'machineNumber': machineNumber,
      'date': dateKey(date),
      'shift': shift,
    });
    return row == null ? null : _productionReport(row);
  }

  @override
  Future<void> deleteProductionDetailsReport(String id) =>
      _reports.delete(Col.scrapProductionDetails, id);

  // ═══════════════════════════════════════
  // PRODUCTION WEIGHT REPORT
  // ═══════════════════════════════════════

  @override
  Future<void> submitProductionWeightReport(
    ScrapProductionWeightReport report,
  ) async {
    await _reports.add(Col.scrapProductionWeight, {
      'date': dateKey(report.date),
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'totalProductionWeight': report.totalProductionWeight,
      'maintenanceWeight': report.maintenanceWeight,
      'totalWeight': report.totalWeight,
      'targetWeight': report.targetWeight,
      'efficiencyPercentage': report.efficiencyPercentage,
      'createdBy': report.createdBy,
    });
  }

  @override
  Future<List<ScrapProductionWeightReport>> getProductionWeightReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.scrapProductionWeight,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => ScrapProductionWeightReport(
            id: r.id,
            date: r.date('date'),
            machineNumber: r.str('machineNumber'),
            shift: r.str('shift'),
            totalProductionWeight: r.real('totalProductionWeight'),
            maintenanceWeight: r.real('maintenanceWeight'),
            totalWeight: r.real('totalWeight'),
            targetWeight: r.real('targetWeight'),
            efficiencyPercentage: r.real('efficiencyPercentage'),
            createdBy: r.str('createdBy'),
            timestamp: r.timestamp('timestamp'),
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteProductionWeightReport(String id) =>
      _reports.delete(Col.scrapProductionWeight, id);

  // ═══════════════════════════════════════
  // REPORT WRITING EFFICIENCY
  // ═══════════════════════════════════════

  @override
  Future<List<ScrapReportWritingEfficiency>> getReportWritingEfficiency({
    String? operatorId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    // Preserved quirk: the old query filtered `machineNumber` using the
    // `operatorId` argument.
    final rows = await _list(
      Col.scrapWritingEfficiency,
      equalsField: 'machineNumber',
      equalsValue: operatorId,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => ScrapReportWritingEfficiency(
            id: r.id,
            date: r.date('date'),
            machineNumber: r.str('machineNumber'),
            shift: r.str('shift'),
            submittedAt: r.timestamp('submittedAt'),
            shiftEndTime: r.timestamp('shiftEndTime')!,
            score: r.integer('score'),
            operatorId: r.str('operatorId'),
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteWritingEfficiency(String id) =>
      _reports.delete(Col.scrapWritingEfficiency, id);

  @override
  Future<void> submitWritingEfficiency(
    ScrapReportWritingEfficiency record,
  ) async {
    await _reports.add(Col.scrapWritingEfficiency, {
      'date': dateKey(record.date),
      'machineNumber': record.machineNumber,
      'shift': record.shift,
      'shiftEndTime': toTimestamp(record.shiftEndTime),
      'score': record.score,
      'operatorId': record.operatorId,
      'submittedAt': toTimestamp(record.submittedAt ?? DateTime.now()),
    });
  }

  // ═══════════════════════════════════════
  // SCRAP QUALITY REPORT
  // ═══════════════════════════════════════

  @override
  Future<void> submitScrapQualityReport(ScrapQualityReport report) async {
    await _reports.add(Col.scrapQuality, {
      'date': dateKey(report.date),
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'product': report.product,
      'qualityRating': report.qualityRating,
      'comments': report.comments,
      'createdBy': report.createdBy,
    });
  }

  @override
  Future<List<ScrapQualityReport>> getScrapQualityReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.scrapQuality,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => ScrapQualityReport(
            id: r.id,
            date: r.date('date'),
            machineNumber: r.str('machineNumber'),
            shift: r.str('shift'),
            product: r.str('product'),
            qualityRating: r.integer('qualityRating'),
            comments: r.strOrNull('comments'),
            createdBy: r.str('createdBy'),
            timestamp: r.timestamp('timestamp'),
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteScrapQualityReport(String id) =>
      _reports.delete(Col.scrapQuality, id);

  // ═══════════════════════════════════════
  // SALARY
  // ═══════════════════════════════════════

  @override
  Future<ScrapSalaryWeightages> getSalaryWeightages() async {
    final snap = await _db
        .collection(Col.masterSalaryWeightages)
        .where('category', isEqualTo: 'scrap')
        .get();
    final items = snap.docs.map(DocRow.fromSnapshot).toList();
    if (items.isEmpty) {
      return const ScrapSalaryWeightages(
        wA: 20,
        wB: 15,
        wE: 25,
        wF: 15,
        wG: 25,
      );
    }
    double val(String variable) =>
        items
            .where((w) => w.str('variable') == variable)
            .firstOrNull
            ?.real('percentage') ??
        0;
    return ScrapSalaryWeightages(
      wA: val('wA'),
      wB: val('wB'),
      wE: val('wE'),
      wF: val('wF'),
      wG: val('wG'),
    );
  }

  @override
  Future<Map<String, double>> getMonthlyAggregates(
    String operatorId,
    int year,
    int month,
  ) async {
    final user = await _userByUid(operatorId);
    final assigned = user?.strings('assignedMachines') ?? const <String>[];
    final machineNumber = assigned.isNotEmpty ? assigned.first : operatorId;

    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0, 23, 59, 59);

    Future<List<DocRow>> inRange(String collection) => _list(
      collection,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );

    final aScores = (await inRange(
      Col.scrapCleaning,
    )).map((r) => r.real('percentage')).toList();
    final bScores = (await inRange(
      Col.scrapToolsCount,
    )).map((r) => r.real('percentageAvailable')).toList();
    final eScores = (await inRange(
      Col.scrapProductionWeight,
    )).map((r) => r.real('efficiencyPercentage')).toList();
    final fScores = (await inRange(
      Col.scrapWritingEfficiency,
    )).map((r) => r.integer('score').toDouble()).toList();
    final gScores = (await inRange(
      Col.scrapQuality,
    )).map((r) => r.integer('qualityRating').toDouble()).toList();

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
    final user = await _userByUid(operatorId);
    return user?.real('fixedSalary') ?? 0.0;
  }

  @override
  Future<String> getOperatorName(String operatorId) async {
    final user = await _userByUid(operatorId);
    return user?.strOrNull('name') ?? 'Unknown';
  }

  @override
  Future<void> saveSalaryCalculation(ScrapSalaryCalculation calculation) async {
    await _reports.add(Col.scrapSalaryCalculations, {
      'operatorId': calculation.operatorId,
      'operatorName': calculation.operatorName,
      'year': calculation.year,
      'month': calculation.month,
      'a': calculation.a,
      'b': calculation.b,
      'e': calculation.e,
      'f': calculation.f,
      'g': calculation.g,
      'wA': calculation.wA,
      'wB': calculation.wB,
      'wE': calculation.wE,
      'wF': calculation.wF,
      'wG': calculation.wG,
      'multiplier': calculation.multiplier,
      'fixedSalary': calculation.fixedSalary,
      'calculatedSalary': calculation.calculatedSalary,
    });
  }

  @override
  Future<ScrapSalaryCalculation?> getSavedCalculation(
    String operatorId,
    int year,
    int month,
  ) async {
    final data = await _reports.findOne(Col.scrapSalaryCalculations, {
      'operatorId': operatorId,
      'year': year,
      'month': month,
    });
    if (data == null) return null;
    return ScrapSalaryCalculation(
      id: data.id,
      operatorId: data.str('operatorId'),
      operatorName: data.str('operatorName'),
      year: data.integer('year'),
      month: data.integer('month'),
      a: data.real('a'),
      b: data.real('b'),
      e: data.real('e'),
      f: data.real('f'),
      g: data.real('g'),
      wA: data.real('wA'),
      wB: data.real('wB'),
      wE: data.real('wE'),
      wF: data.real('wF'),
      wG: data.real('wG'),
      multiplier: data.real('multiplier'),
      fixedSalary: data.real('fixedSalary'),
      calculatedSalary: data.real('calculatedSalary'),
    );
  }
}
