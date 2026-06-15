import '../../../../core/utils/date_value_codec.dart';
import '../../domain/entities/sheet_entities.dart';

class SheetProductionLineItemModel {
  static SheetProductionLineItem fromMap(Map<String, dynamic> data) {
    return SheetProductionLineItem(
      thickness: data['thickness'] ?? '',
      density: data['density'] ?? '',
      color: data['color'] ?? '',
      length: (data['length'] ?? 0).toDouble(),
      width: (data['width'] ?? 0).toDouble(),
      quantity: data['quantity'] ?? 0,
      sqft: (data['sqft'] ?? 0).toDouble(),
      perPieceWeight: (data['perPieceWeight'] ?? 0).toDouble(),
      totalWeight: (data['totalWeight'] ?? 0).toDouble(),
      totalRunningFeet: (data['totalRunningFeet'] ?? 0).toDouble(),
      timeOfChange: dateTimeOrNull(data['timeOfChange']),
      manualWeightPerSqft: data['manualWeightPerSqft']?.toDouble(),
    );
  }

  static Map<String, dynamic> toMap(SheetProductionLineItem item) {
    return {
      'thickness': item.thickness,
      'density': item.density,
      'color': item.color,
      'length': item.length,
      'width': item.width,
      'quantity': item.quantity,
      'sqft': item.sqft,
      'perPieceWeight': item.perPieceWeight,
      'totalWeight': item.totalWeight,
      'totalRunningFeet': item.totalRunningFeet,
      'timeOfChange': item.timeOfChange,
      'manualWeightPerSqft': item.manualWeightPerSqft,
    };
  }
}

class SheetProductionDetailsReportModel {
  static SheetProductionDetailsReport fromMap(
    Map<String, dynamic> data, {
    String id = '',
  }) {
    final items = (data['lineItems'] as List<dynamic>? ?? [])
        .map(
          (e) =>
              SheetProductionLineItemModel.fromMap(e as Map<String, dynamic>),
        )
        .toList();
    return SheetProductionDetailsReport(
      id: id,
      date: requireDateTime(data['date'], 'date'),
      machineNumber: data['machineNumber'] ?? '',
      shift: data['shift'] ?? '',
      lineItems: items,
      totalQuantity: data['totalQuantity'] ?? 0,
      totalWeight: (data['totalWeight'] ?? 0).toDouble(),
      totalRunningFeet: (data['totalRunningFeet'] ?? 0).toDouble(),
      createdBy: data['createdBy'] ?? '',
      timestamp: dateTimeOrNull(data['timestamp']),
      submittedAt: dateTimeOrNull(data['submittedAt']),
    );
  }

  static Map<String, dynamic> toMap(SheetProductionDetailsReport report) {
    return {
      'date': report.date,
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'lineItems': report.lineItems
          .map((e) => SheetProductionLineItemModel.toMap(e))
          .toList(),
      'totalQuantity': report.totalQuantity,
      'totalWeight': report.totalWeight,
      'totalRunningFeet': report.totalRunningFeet,
      'createdBy': report.createdBy,
      'timestamp': writeTimestamp(report.timestamp),
      'submittedAt': writeTimestamp(report.submittedAt),
    };
  }
}

class SheetProductionRunningFeetReportModel {
  static SheetProductionRunningFeetReport fromMap(
    Map<String, dynamic> data, {
    String id = '',
  }) {
    return SheetProductionRunningFeetReport(
      id: id,
      date: requireDateTime(data['date'], 'date'),
      machineNumber: data['machineNumber'] ?? '',
      shift: data['shift'] ?? '',
      productionRunningFeet: (data['productionRunningFeet'] ?? 0).toDouble(),
      maintenanceRunningFeet: (data['maintenanceRunningFeet'] ?? 0).toDouble(),
      totalProductionRunningFeet: (data['totalProductionRunningFeet'] ?? 0)
          .toDouble(),
      targetRunningFeet: (data['targetRunningFeet'] ?? 0).toDouble(),
      efficiencyPercentage: (data['efficiencyPercentage'] ?? 0).toDouble(),
      createdBy: data['createdBy'] ?? '',
      timestamp: dateTimeOrNull(data['timestamp']),
    );
  }

  static Map<String, dynamic> toMap(SheetProductionRunningFeetReport report) {
    return {
      'date': report.date,
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'productionRunningFeet': report.productionRunningFeet,
      'maintenanceRunningFeet': report.maintenanceRunningFeet,
      'totalProductionRunningFeet': report.totalProductionRunningFeet,
      'targetRunningFeet': report.targetRunningFeet,
      'efficiencyPercentage': report.efficiencyPercentage,
      'createdBy': report.createdBy,
      'timestamp': writeTimestamp(report.timestamp),
    };
  }
}

class SheetPackingLineItemModel {
  static SheetPackingLineItem fromMap(Map<String, dynamic> data) {
    return SheetPackingLineItem(
      thickness: data['thickness'] ?? '',
      density: data['density'] ?? '',
      color: data['color'] ?? '',
      length: (data['length'] ?? 0).toDouble(),
      width: (data['width'] ?? 0).toDouble(),
      productionQuantity: data['productionQuantity'] ?? 0,
      perPieceWeight: (data['perPieceWeight'] ?? 0).toDouble(),
      runningFeetPerItem: (data['runningFeetPerItem'] ?? 0).toDouble(),
      packed: data['packed'] ?? 0,
      onlySanding: data['onlySanding'] ?? 0,
      sandingAndPacked: data['sandingAndPacked'] ?? 0,
      rejectedQuality: data['rejectedQuality'] ?? 0,
    );
  }

  static Map<String, dynamic> toMap(SheetPackingLineItem item) {
    return {
      'thickness': item.thickness,
      'density': item.density,
      'color': item.color,
      'length': item.length,
      'width': item.width,
      'productionQuantity': item.productionQuantity,
      'perPieceWeight': item.perPieceWeight,
      'runningFeetPerItem': item.runningFeetPerItem,
      'packed': item.packed,
      'onlySanding': item.onlySanding,
      'sandingAndPacked': item.sandingAndPacked,
      'rejectedQuality': item.rejectedQuality,
    };
  }
}

class SheetShiftPackingReportModel {
  static SheetShiftPackingReport fromMap(
    Map<String, dynamic> data, {
    String id = '',
  }) {
    final items = (data['lineItems'] as List<dynamic>? ?? [])
        .map(
          (e) => SheetPackingLineItemModel.fromMap(e as Map<String, dynamic>),
        )
        .toList();
    return SheetShiftPackingReport(
      id: id,
      date: requireDateTime(data['date'], 'date'),
      machineNumber: data['machineNumber'] ?? '',
      shift: data['shift'] ?? '',
      lineItems: items,
      totalRejectedRunningFeet: (data['totalRejectedRunningFeet'] ?? 0)
          .toDouble(),
      qualityAcceptancePercentage: (data['qualityAcceptancePercentage'] ?? 0)
          .toDouble(),
      packingEfficiency: (data['packingEfficiency'] ?? 0).toDouble(),
      createdBy: data['createdBy'] ?? '',
      timestamp: dateTimeOrNull(data['timestamp']),
    );
  }

  static Map<String, dynamic> toMap(SheetShiftPackingReport report) {
    return {
      'date': report.date,
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'lineItems': report.lineItems
          .map((e) => SheetPackingLineItemModel.toMap(e))
          .toList(),
      'totalRejectedRunningFeet': report.totalRejectedRunningFeet,
      'qualityAcceptancePercentage': report.qualityAcceptancePercentage,
      'packingEfficiency': report.packingEfficiency,
      'createdBy': report.createdBy,
      'timestamp': writeTimestamp(report.timestamp),
    };
  }
}

class SheetCustomerRejectionReportModel {
  static SheetCustomerRejectionReport fromMap(
    Map<String, dynamic> data, {
    String id = '',
  }) {
    final items = (data['rejectedItems'] as List<dynamic>? ?? [])
        .map(
          (e) =>
              SheetProductionLineItemModel.fromMap(e as Map<String, dynamic>),
        )
        .toList();
    return SheetCustomerRejectionReport(
      id: id,
      originalProductionDate: requireDateTime(
        data['originalProductionDate'],
        'originalProductionDate',
      ),
      machineNumber: data['machineNumber'] ?? '',
      shift: data['shift'] ?? '',
      rejectedItems: items,
      totalRejectedRunningFeet: (data['totalRejectedRunningFeet'] ?? 0)
          .toDouble(),
      createdBy: data['createdBy'] ?? '',
      timestamp: dateTimeOrNull(data['timestamp']),
    );
  }

  static Map<String, dynamic> toMap(SheetCustomerRejectionReport report) {
    return {
      'originalProductionDate': report.originalProductionDate,
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'rejectedItems': report.rejectedItems
          .map((e) => SheetProductionLineItemModel.toMap(e))
          .toList(),
      'totalRejectedRunningFeet': report.totalRejectedRunningFeet,
      'createdBy': report.createdBy,
      'timestamp': writeTimestamp(report.timestamp),
    };
  }
}
