import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/data/collections.dart';
import '../../../../core/data/firestore_support.dart';
import '../../../../core/data/stock_ledger.dart';
import '../../domain/entities/frame_entities.dart';

abstract class FrameRemoteDataSource {
  Future<void> submitMachineCleaningReport(MachineCleaningReport report);
  Future<List<MachineCleaningReport>> getMachineCleaningReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteMachineCleaningReport(String id);
  Future<void> submitToolsCountReport(ToolsCountReport report);
  Future<List<ToolsCountReport>> getToolsCountReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteToolsCountReport(String id);
  Future<void> submitMachineHealthReport(MachineHealthReport report);
  Future<List<MachineHealthReport>> getMachineHealthReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<List<MachineHealthReport>> getPendingApprovals();
  Future<void> deleteMachineHealthReport(String id);
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
  Future<void> submitProductionWeightReport(FrameProductionWeightReport report);
  Future<List<FrameProductionWeightReport>> getProductionWeightReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteProductionWeightReport(String id);
  Future<void> submitShiftPackingReport(FrameShiftPackingReport report);
  Future<List<FrameShiftPackingReport>> getShiftPackingReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteShiftPackingReport(String id);
  Future<List<ReportWritingEfficiencyRecord>> getReportWritingEfficiency({
    String? operatorId,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteWritingEfficiency(String id);
  Future<void> submitWritingEfficiency(ReportWritingEfficiencyRecord record);
  Future<void> submitCustomerRejectionReport(
    FrameCustomerRejectionReport report,
  );
  Future<List<FrameCustomerRejectionReport>> getCustomerRejectionReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteCustomerRejectionReport(String id);
}

class FrameRemoteDataSourceImpl implements FrameRemoteDataSource {
  FrameRemoteDataSourceImpl({required FirebaseFirestore firestore})
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
    String dateField = 'date',
  }) => _reports.list(
    collection,
    equalsField: equalsField,
    equalsValue: equalsValue ?? machineNumber,
    dateField: dateField,
    startDate: startDate,
    endDate: endDate,
  );

  // ── embedded item mapping ──

  Map<String, dynamic> _productionItemToMap(FrameProductionLineItem i) => {
    'section': i.section,
    'density': i.density,
    'color': i.color,
    'length': i.length,
    'quantity': i.quantity,
    'perPieceWeight': i.perPieceWeight,
    'totalWeight': i.totalWeight,
    'manualWeightPerFoot': i.manualWeightPerFoot,
  };

  FrameProductionLineItem _productionItem(DocRow li) => FrameProductionLineItem(
    section: li.str('section'),
    density: li.str('density'),
    color: li.str('color'),
    length: li.real('length'),
    quantity: li.integer('quantity'),
    perPieceWeight: li.real('perPieceWeight'),
    totalWeight: li.real('totalWeight'),
    manualWeightPerFoot: li.realOrNull('manualWeightPerFoot'),
  );

  Map<String, dynamic> _packingItemToMap(FramePackingLineItem i) => {
    'section': i.section,
    'density': i.density,
    'color': i.color,
    'length': i.length,
    'productionQuantity': i.productionQuantity,
    'perPieceWeight': i.perPieceWeight,
    'packed': i.packed,
    'rejectedQuality': i.rejectedQuality,
  };

  FramePackingLineItem _packingItem(DocRow li) => FramePackingLineItem(
    section: li.str('section'),
    density: li.str('density'),
    color: li.str('color'),
    length: li.real('length'),
    productionQuantity: li.integer('productionQuantity'),
    perPieceWeight: li.real('perPieceWeight'),
    packed: li.integer('packed'),
    rejectedQuality: li.integer('rejectedQuality'),
  );

  Map<String, dynamic> _entryToMap(FrameMaintenanceEntry e) => {
    'maintenanceItem': e.maintenanceItem,
    'startTime': toTimestamp(e.startTime),
    'endTime': toTimestamp(e.endTime),
    'personDoingMaintenance': e.personDoingMaintenance,
    'description': e.description,
    'durationHours': e.durationHours,
  };

  FrameMaintenanceEntry _entry(DocRow e) => FrameMaintenanceEntry(
    maintenanceItem: e.str('maintenanceItem'),
    startTime: e.timestamp('startTime')!,
    endTime: e.timestamp('endTime')!,
    personDoingMaintenance: e.str('personDoingMaintenance'),
    description: e.str('description'),
    durationHours: e.real('durationHours'),
  );

  // ── stock helpers (operate on stored maps so submit and delete share them) ──

  List<StockLine> _productionStock(List<Map<String, dynamic>> items) => items
      .map((m) => DocRow('', m))
      .map(
        (i) => StockLine(
          variant: i.str('section'),
          density: i.str('density'),
          color: i.str('color'),
          produced: i.integer('quantity'),
        ),
      )
      .toList();

  List<StockLine> _packingStock(List<Map<String, dynamic>> items) => items
      .map((m) => DocRow('', m))
      .map(
        (i) => StockLine(
          variant: i.str('section'),
          density: i.str('density'),
          color: i.str('color'),
          packed: i.integer('packed'),
          rejected: i.integer('rejectedQuality'),
          packedAmount: i.integer('packed') * i.real('perPieceWeight'),
          rejectedAmount: i.integer('rejectedQuality') * i.real('perPieceWeight'),
        ),
      )
      .toList();

  List<Map<String, dynamic>> _rawChildren(DocRow row, String key) =>
      row.children(key).map((c) => c.data).toList();

  // ── Cleaning ──

  @override
  Future<void> submitMachineCleaningReport(MachineCleaningReport report) async {
    await _reports.add(Col.frameCleaning, {
      'date': dateKey(report.date),
      'machineNumber': report.machineNumber,
      'machineCondition': report.machineCondition,
      'groundCondition': report.groundCondition,
      'mouldCondition': report.mouldCondition,
      'totalScore': report.totalScore,
      'percentage': report.percentage,
      'createdBy': report.createdBy,
    });
  }

  @override
  Future<List<MachineCleaningReport>> getMachineCleaningReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.frameCleaning,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => MachineCleaningReport(
            id: r.id,
            date: r.date('date'),
            machineNumber: r.str('machineNumber'),
            machineCondition: r.integer('machineCondition'),
            groundCondition: r.integer('groundCondition'),
            mouldCondition: r.integer('mouldCondition'),
            totalScore: r.integer('totalScore'),
            percentage: r.real('percentage'),
            createdBy: r.str('createdBy'),
            timestamp: r.timestamp('timestamp'),
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteMachineCleaningReport(String id) =>
      _reports.delete(Col.frameCleaning, id);

  // ── Tools count ──

  @override
  Future<void> submitToolsCountReport(ToolsCountReport report) async {
    await _reports.add(Col.frameToolsCount, {
      'date': dateKey(report.date),
      'machineNumber': report.machineNumber,
      'totalToolsGiven': report.totalToolsGiven,
      'totalToolsAvailable': report.totalToolsAvailable,
      'percentageAvailable': report.percentageAvailable,
      'createdBy': report.createdBy,
    });
  }

  @override
  Future<List<ToolsCountReport>> getToolsCountReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.frameToolsCount,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => ToolsCountReport(
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
      _reports.delete(Col.frameToolsCount, id);

  // ── Machine health ──

  @override
  Future<void> submitMachineHealthReport(MachineHealthReport report) async {
    await _reports.add(Col.frameHealth, {
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
  Future<List<MachineHealthReport>> getMachineHealthReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.frameHealth,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => MachineHealthReport(
            id: r.id,
            date: r.date('date'),
            machineNumber: r.str('machineNumber'),
            shift: r.str('shift'),
            entries: r.children('entries').map(_entry).toList(),
            totalMaintenanceDurationHours: r.real('totalMaintenanceDurationHours'),
            createdBy: r.str('createdBy'),
            submittedAt: r.timestamp('submittedAt'),
            timestamp: r.timestamp('timestamp'),
          ),
        )
        .toList();
  }

  @override
  Future<List<MachineHealthReport>> getPendingApprovals() =>
      getMachineHealthReports();

  @override
  Future<void> deleteMachineHealthReport(String id) =>
      _reports.delete(Col.frameHealth, id);

  // ── Production details (maintains stock) ──

  @override
  Future<void> submitProductionDetailsReport(
    FrameProductionDetailsReport report,
  ) async {
    final items = report.lineItems.map(_productionItemToMap).toList();
    final ref = _db.collection(Col.frameProductionDetails).doc();
    final batch = _db.batch();
    batch.set(
      ref,
      _reports.stamp({
        'date': dateKey(report.date),
        'machineNumber': report.machineNumber,
        'shift': report.shift,
        'totalQuantity': report.totalQuantity,
        'totalWeight': report.totalWeight,
        'createdBy': report.createdBy,
        'submittedAt': toTimestamp(report.submittedAt),
        'lineItems': items,
      }),
    );
    StockLedger.apply(
      batch,
      _db,
      kind: StockKind.frame,
      lines: _productionStock(items),
      producedAmount: report.totalWeight,
    );
    await batch.commit();
  }

  FrameProductionDetailsReport _productionReport(DocRow r) =>
      FrameProductionDetailsReport(
        id: r.id,
        date: r.date('date'),
        machineNumber: r.str('machineNumber'),
        shift: r.str('shift'),
        lineItems: r.children('lineItems').map(_productionItem).toList(),
        totalQuantity: r.integer('totalQuantity'),
        totalWeight: r.real('totalWeight'),
        createdBy: r.str('createdBy'),
        submittedAt: r.timestamp('submittedAt'),
        timestamp: r.timestamp('timestamp'),
      );

  @override
  Future<List<FrameProductionDetailsReport>> getProductionDetailsReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.frameProductionDetails,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows.map(_productionReport).toList();
  }

  @override
  Future<FrameProductionDetailsReport?> getProductionDetailsReport(
    String machineNumber,
    DateTime date,
    String shift,
  ) async {
    final row = await _reports.findOne(Col.frameProductionDetails, {
      'machineNumber': machineNumber,
      'date': dateKey(date),
      'shift': shift,
    });
    return row == null ? null : _productionReport(row);
  }

  @override
  Future<void> deleteProductionDetailsReport(String id) async {
    final ref = _db.collection(Col.frameProductionDetails).doc(id);
    final snap = await ref.get();
    if (!snap.exists) return;
    final row = DocRow.fromSnapshot(snap);
    final batch = _db.batch();
    batch.delete(ref);
    StockLedger.apply(
      batch,
      _db,
      kind: StockKind.frame,
      lines: _productionStock(_rawChildren(row, 'lineItems')),
      producedAmount: row.real('totalWeight'),
      sign: -1,
    );
    await batch.commit();
  }

  // ── Production weight ──

  @override
  Future<void> submitProductionWeightReport(
    FrameProductionWeightReport report,
  ) async {
    await _reports.add(Col.frameProductionWeight, {
      'date': dateKey(report.date),
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'productionWeight': report.productionWeight,
      'maintenanceWeight': report.maintenanceWeight,
      'totalProductionWeight': report.totalProductionWeight,
      'targetWeight': report.targetWeight,
      'efficiencyPercentage': report.efficiencyPercentage,
      'createdBy': report.createdBy,
    });
  }

  @override
  Future<List<FrameProductionWeightReport>> getProductionWeightReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.frameProductionWeight,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => FrameProductionWeightReport(
            id: r.id,
            date: r.date('date'),
            machineNumber: r.str('machineNumber'),
            shift: r.str('shift'),
            productionWeight: r.real('productionWeight'),
            maintenanceWeight: r.real('maintenanceWeight'),
            totalProductionWeight: r.real('totalProductionWeight'),
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
      _reports.delete(Col.frameProductionWeight, id);

  // ── Shift packing (maintains stock) ──

  @override
  Future<void> submitShiftPackingReport(FrameShiftPackingReport report) async {
    final items = report.lineItems.map(_packingItemToMap).toList();
    final ref = _db.collection(Col.frameShiftPacking).doc();
    final batch = _db.batch();
    batch.set(
      ref,
      _reports.stamp({
        'date': dateKey(report.date),
        'machineNumber': report.machineNumber,
        'shift': report.shift,
        'totalRejectedWeight': report.totalRejectedWeight,
        'qualityAcceptancePercentage': report.qualityAcceptancePercentage,
        'packingEfficiency': report.packingEfficiency,
        'createdBy': report.createdBy,
        'lineItems': items,
      }),
    );
    StockLedger.apply(
      batch,
      _db,
      kind: StockKind.frame,
      lines: _packingStock(items),
    );
    await batch.commit();
  }

  @override
  Future<List<FrameShiftPackingReport>> getShiftPackingReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.frameShiftPacking,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => FrameShiftPackingReport(
            id: r.id,
            date: r.date('date'),
            machineNumber: r.str('machineNumber'),
            shift: r.str('shift'),
            lineItems: r.children('lineItems').map(_packingItem).toList(),
            totalRejectedWeight: r.real('totalRejectedWeight'),
            qualityAcceptancePercentage: r.real('qualityAcceptancePercentage'),
            packingEfficiency: r.real('packingEfficiency'),
            createdBy: r.str('createdBy'),
            timestamp: r.timestamp('timestamp'),
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteShiftPackingReport(String id) async {
    final ref = _db.collection(Col.frameShiftPacking).doc(id);
    final snap = await ref.get();
    if (!snap.exists) return;
    final row = DocRow.fromSnapshot(snap);
    final batch = _db.batch();
    batch.delete(ref);
    StockLedger.apply(
      batch,
      _db,
      kind: StockKind.frame,
      lines: _packingStock(_rawChildren(row, 'lineItems')),
      sign: -1,
    );
    await batch.commit();
  }

  // ── Writing efficiency ──

  @override
  Future<List<ReportWritingEfficiencyRecord>> getReportWritingEfficiency({
    String? operatorId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.frameWritingEfficiency,
      equalsField: 'operatorId',
      equalsValue: operatorId,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => ReportWritingEfficiencyRecord(
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
  Future<void> submitWritingEfficiency(ReportWritingEfficiencyRecord record) async {
    await _reports.add(Col.frameWritingEfficiency, {
      'date': dateKey(record.date),
      'machineNumber': record.machineNumber,
      'shift': record.shift,
      'shiftEndTime': toTimestamp(record.shiftEndTime),
      'score': record.score,
      'operatorId': record.operatorId,
      'submittedAt': toTimestamp(record.submittedAt ?? DateTime.now()),
    });
  }

  @override
  Future<void> deleteWritingEfficiency(String id) =>
      _reports.delete(Col.frameWritingEfficiency, id);

  // ── Customer rejection ──

  @override
  Future<void> submitCustomerRejectionReport(
    FrameCustomerRejectionReport report,
  ) async {
    await _reports.add(Col.frameCustomerRejection, {
      'originalProductionDate': dateKey(report.originalProductionDate),
      'rejectionDate': dateKey(report.rejectionDate),
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'totalRejectedWeight': report.totalRejectedWeight,
      'createdBy': report.createdBy,
      'rejectedItems': report.rejectedItems.map(_productionItemToMap).toList(),
    });
  }

  @override
  Future<List<FrameCustomerRejectionReport>> getCustomerRejectionReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.frameCustomerRejection,
      machineNumber: machineNumber,
      dateField: 'originalProductionDate',
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => FrameCustomerRejectionReport(
            id: r.id,
            originalProductionDate: r.date('originalProductionDate'),
            rejectionDate: r.date('rejectionDate'),
            machineNumber: r.str('machineNumber'),
            shift: r.str('shift'),
            rejectedItems: r.children('rejectedItems').map(_productionItem).toList(),
            totalRejectedWeight: r.real('totalRejectedWeight'),
            createdBy: r.str('createdBy'),
            timestamp: r.timestamp('timestamp'),
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteCustomerRejectionReport(String id) =>
      _reports.delete(Col.frameCustomerRejection, id);
}
