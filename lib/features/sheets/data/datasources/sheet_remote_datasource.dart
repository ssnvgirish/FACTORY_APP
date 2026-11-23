import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/data/collections.dart';
import '../../../../core/data/firestore_support.dart';
import '../../../../core/data/stock_ledger.dart';
import '../../../frames/domain/entities/frame_entities.dart';
import '../../domain/entities/sheet_entities.dart';

abstract class SheetRemoteDataSource {
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
  Future<void> deleteProductionDetailsReport(String id);
  Future<void> submitProductionRunningFeetReport(
    SheetProductionRunningFeetReport report,
  );
  Future<List<SheetProductionRunningFeetReport>>
  getProductionRunningFeetReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteProductionRunningFeetReport(String id);
  Future<void> submitShiftPackingReport(SheetShiftPackingReport report);
  Future<List<SheetShiftPackingReport>> getShiftPackingReports({
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
    SheetCustomerRejectionReport report,
  );
  Future<List<SheetCustomerRejectionReport>> getCustomerRejectionReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<void> deleteCustomerRejectionReport(String id);
}

class SheetRemoteDataSourceImpl implements SheetRemoteDataSource {
  SheetRemoteDataSourceImpl({required FirebaseFirestore firestore})
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

  Map<String, dynamic> _productionItemToMap(SheetProductionLineItem i) => {
    'thickness': i.thickness,
    'density': i.density,
    'color': i.color,
    'length': i.length,
    'width': i.width,
    'quantity': i.quantity,
    'sqft': i.sqft,
    'perPieceWeight': i.perPieceWeight,
    'totalWeight': i.totalWeight,
    'totalRunningFeet': i.totalRunningFeet,
    'timeOfChange': toTimestamp(i.timeOfChange),
    'manualWeightPerSqft': i.manualWeightPerSqft,
  };

  SheetProductionLineItem _productionItem(DocRow li) => SheetProductionLineItem(
    thickness: li.str('thickness'),
    density: li.str('density'),
    color: li.str('color'),
    length: li.real('length'),
    width: li.real('width'),
    quantity: li.integer('quantity'),
    sqft: li.real('sqft'),
    perPieceWeight: li.real('perPieceWeight'),
    totalWeight: li.real('totalWeight'),
    totalRunningFeet: li.real('totalRunningFeet'),
    timeOfChange: li.timestamp('timeOfChange'),
    manualWeightPerSqft: li.realOrNull('manualWeightPerSqft'),
  );

  Map<String, dynamic> _packingItemToMap(SheetPackingLineItem i) => {
    'thickness': i.thickness,
    'density': i.density,
    'color': i.color,
    'length': i.length,
    'width': i.width,
    'productionQuantity': i.productionQuantity,
    'perPieceWeight': i.perPieceWeight,
    'runningFeetPerItem': i.runningFeetPerItem,
    'packed': i.packed,
    'onlySanding': i.onlySanding,
    'sandingAndPacked': i.sandingAndPacked,
    'rejectedQuality': i.rejectedQuality,
  };

  SheetPackingLineItem _packingItem(DocRow li) => SheetPackingLineItem(
    thickness: li.str('thickness'),
    density: li.str('density'),
    color: li.str('color'),
    length: li.real('length'),
    width: li.real('width'),
    productionQuantity: li.integer('productionQuantity'),
    perPieceWeight: li.real('perPieceWeight'),
    runningFeetPerItem: li.real('runningFeetPerItem'),
    packed: li.integer('packed'),
    onlySanding: li.integer('onlySanding'),
    sandingAndPacked: li.integer('sandingAndPacked'),
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
          variant: i.str('thickness'),
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
          variant: i.str('thickness'),
          density: i.str('density'),
          color: i.str('color'),
          packed: i.integer('packed'),
          rejected: i.integer('rejectedQuality'),
          packedAmount: i.integer('packed') * i.real('runningFeetPerItem'),
          rejectedAmount:
              i.integer('rejectedQuality') * i.real('runningFeetPerItem'),
        ),
      )
      .toList();

  List<Map<String, dynamic>> _rawChildren(DocRow row, String key) =>
      row.children(key).map((c) => c.data).toList();

  // ── Cleaning ──

  @override
  Future<void> submitMachineCleaningReport(MachineCleaningReport report) async {
    await _reports.add(Col.sheetCleaning, {
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
      Col.sheetCleaning,
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
      _reports.delete(Col.sheetCleaning, id);

  // ── Tools count ──

  @override
  Future<void> submitToolsCountReport(ToolsCountReport report) async {
    await _reports.add(Col.sheetToolsCount, {
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
      Col.sheetToolsCount,
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
      _reports.delete(Col.sheetToolsCount, id);

  // ── Machine health ──

  @override
  Future<void> submitMachineHealthReport(MachineHealthReport report) async {
    await _reports.add(Col.sheetHealth, {
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
      Col.sheetHealth,
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
            totalMaintenanceDurationHours: r.real(
              'totalMaintenanceDurationHours',
            ),
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
      _reports.delete(Col.sheetHealth, id);

  // ── Production details (maintains stock) ──

  @override
  Future<void> submitProductionDetailsReport(
    SheetProductionDetailsReport report,
  ) async {
    final items = report.lineItems.map(_productionItemToMap).toList();
    final ref = _db.collection(Col.sheetProductionDetails).doc();
    final batch = _db.batch();
    batch.set(
      ref,
      _reports.stamp({
        'date': dateKey(report.date),
        'machineNumber': report.machineNumber,
        'shift': report.shift,
        'totalQuantity': report.totalQuantity,
        'totalWeight': report.totalWeight,
        'totalRunningFeet': report.totalRunningFeet,
        'createdBy': report.createdBy,
        'submittedAt': toTimestamp(report.submittedAt),
        'lineItems': items,
      }),
    );
    StockLedger.apply(
      batch,
      _db,
      kind: StockKind.sheet,
      lines: _productionStock(items),
      producedAmount: report.totalRunningFeet,
    );
    await batch.commit();
  }

  SheetProductionDetailsReport _productionReport(DocRow r) =>
      SheetProductionDetailsReport(
        id: r.id,
        date: r.date('date'),
        machineNumber: r.str('machineNumber'),
        shift: r.str('shift'),
        lineItems: r.children('lineItems').map(_productionItem).toList(),
        totalQuantity: r.integer('totalQuantity'),
        totalWeight: r.real('totalWeight'),
        totalRunningFeet: r.real('totalRunningFeet'),
        createdBy: r.str('createdBy'),
        submittedAt: r.timestamp('submittedAt'),
        timestamp: r.timestamp('timestamp'),
      );

  @override
  Future<List<SheetProductionDetailsReport>> getProductionDetailsReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.sheetProductionDetails,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows.map(_productionReport).toList();
  }

  @override
  Future<SheetProductionDetailsReport?> getProductionDetailsReport(
    String machineNumber,
    DateTime date,
    String shift,
  ) async {
    final row = await _reports.findOne(Col.sheetProductionDetails, {
      'machineNumber': machineNumber,
      'date': dateKey(date),
      'shift': shift,
    });
    return row == null ? null : _productionReport(row);
  }

  @override
  Future<void> deleteProductionDetailsReport(String id) async {
    final ref = _db.collection(Col.sheetProductionDetails).doc(id);
    final snap = await ref.get();
    if (!snap.exists) return;
    final row = DocRow.fromSnapshot(snap);
    final batch = _db.batch();
    batch.delete(ref);
    StockLedger.apply(
      batch,
      _db,
      kind: StockKind.sheet,
      lines: _productionStock(_rawChildren(row, 'lineItems')),
      producedAmount: row.real('totalRunningFeet'),
      sign: -1,
    );
    await batch.commit();
  }

  // ── Running feet ──

  @override
  Future<void> submitProductionRunningFeetReport(
    SheetProductionRunningFeetReport report,
  ) async {
    await _reports.add(Col.sheetRunningFeet, {
      'date': dateKey(report.date),
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'productionRunningFeet': report.productionRunningFeet,
      'maintenanceRunningFeet': report.maintenanceRunningFeet,
      'totalProductionRunningFeet': report.totalProductionRunningFeet,
      'targetRunningFeet': report.targetRunningFeet,
      'efficiencyPercentage': report.efficiencyPercentage,
      'createdBy': report.createdBy,
    });
  }

  @override
  Future<List<SheetProductionRunningFeetReport>>
  getProductionRunningFeetReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.sheetRunningFeet,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => SheetProductionRunningFeetReport(
            id: r.id,
            date: r.date('date'),
            machineNumber: r.str('machineNumber'),
            shift: r.str('shift'),
            productionRunningFeet: r.real('productionRunningFeet'),
            maintenanceRunningFeet: r.real('maintenanceRunningFeet'),
            totalProductionRunningFeet: r.real('totalProductionRunningFeet'),
            targetRunningFeet: r.real('targetRunningFeet'),
            efficiencyPercentage: r.real('efficiencyPercentage'),
            createdBy: r.str('createdBy'),
            timestamp: r.timestamp('timestamp'),
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteProductionRunningFeetReport(String id) =>
      _reports.delete(Col.sheetRunningFeet, id);

  // ── Shift packing (maintains stock) ──

  @override
  Future<void> submitShiftPackingReport(SheetShiftPackingReport report) async {
    final items = report.lineItems.map(_packingItemToMap).toList();
    final ref = _db.collection(Col.sheetShiftPacking).doc();
    final batch = _db.batch();
    batch.set(
      ref,
      _reports.stamp({
        'date': dateKey(report.date),
        'machineNumber': report.machineNumber,
        'shift': report.shift,
        'totalRejectedRunningFeet': report.totalRejectedRunningFeet,
        'qualityAcceptancePercentage': report.qualityAcceptancePercentage,
        'packingEfficiency': report.packingEfficiency,
        'createdBy': report.createdBy,
        'lineItems': items,
      }),
    );
    StockLedger.apply(
      batch,
      _db,
      kind: StockKind.sheet,
      lines: _packingStock(items),
    );
    await batch.commit();
  }

  @override
  Future<List<SheetShiftPackingReport>> getShiftPackingReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.sheetShiftPacking,
      machineNumber: machineNumber,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => SheetShiftPackingReport(
            id: r.id,
            date: r.date('date'),
            machineNumber: r.str('machineNumber'),
            shift: r.str('shift'),
            lineItems: r.children('lineItems').map(_packingItem).toList(),
            totalRejectedRunningFeet: r.real('totalRejectedRunningFeet'),
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
    final ref = _db.collection(Col.sheetShiftPacking).doc(id);
    final snap = await ref.get();
    if (!snap.exists) return;
    final row = DocRow.fromSnapshot(snap);
    final batch = _db.batch();
    batch.delete(ref);
    StockLedger.apply(
      batch,
      _db,
      kind: StockKind.sheet,
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
      Col.sheetWritingEfficiency,
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
  Future<void> deleteWritingEfficiency(String id) =>
      _reports.delete(Col.sheetWritingEfficiency, id);

  @override
  Future<void> submitWritingEfficiency(
    ReportWritingEfficiencyRecord record,
  ) async {
    await _reports.add(Col.sheetWritingEfficiency, {
      'date': dateKey(record.date),
      'machineNumber': record.machineNumber,
      'shift': record.shift,
      'shiftEndTime': toTimestamp(record.shiftEndTime),
      'score': record.score,
      'operatorId': record.operatorId,
      'submittedAt': toTimestamp(record.submittedAt ?? DateTime.now()),
    });
  }

  // ── Customer rejection ──

  @override
  Future<void> submitCustomerRejectionReport(
    SheetCustomerRejectionReport report,
  ) async {
    await _reports.add(Col.sheetCustomerRejection, {
      'originalProductionDate': dateKey(report.originalProductionDate),
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'totalRejectedRunningFeet': report.totalRejectedRunningFeet,
      'createdBy': report.createdBy,
      'rejectedItems': report.rejectedItems.map(_productionItemToMap).toList(),
    });
  }

  @override
  Future<List<SheetCustomerRejectionReport>> getCustomerRejectionReports({
    String? machineNumber,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rows = await _list(
      Col.sheetCustomerRejection,
      machineNumber: machineNumber,
      dateField: 'originalProductionDate',
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map(
          (r) => SheetCustomerRejectionReport(
            id: r.id,
            originalProductionDate: r.date('originalProductionDate'),
            machineNumber: r.str('machineNumber'),
            shift: r.str('shift'),
            rejectedItems: r
                .children('rejectedItems')
                .map(_productionItem)
                .toList(),
            totalRejectedRunningFeet: r.real('totalRejectedRunningFeet'),
            createdBy: r.str('createdBy'),
            timestamp: r.timestamp('timestamp'),
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteCustomerRejectionReport(String id) =>
      _reports.delete(Col.sheetCustomerRejection, id);
}
