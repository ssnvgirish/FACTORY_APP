import '../../../../core/utils/date_value_codec.dart';
import '../../domain/entities/frame_entities.dart';

class MachineCleaningReportModel {
  static MachineCleaningReport fromMap(
    Map<String, dynamic> data, {
    String id = '',
  }) {
    return MachineCleaningReport(
      id: id,
      date: requireDateTime(data['date'], 'date'),
      machineNumber: data['machineNumber'] ?? '',
      machineCondition: data['machineCondition'] ?? 0,
      groundCondition: data['groundCondition'] ?? 0,
      mouldCondition: data['mouldCondition'] ?? 0,
      totalScore: data['totalScore'] ?? 0,
      percentage: (data['percentage'] ?? 0).toDouble(),
      createdBy: data['createdBy'] ?? '',
      timestamp: dateTimeOrNull(data['timestamp']),
    );
  }

  static Map<String, dynamic> toMap(MachineCleaningReport report) {
    return {
      'date': report.date,
      'machineNumber': report.machineNumber,
      'machineCondition': report.machineCondition,
      'groundCondition': report.groundCondition,
      'mouldCondition': report.mouldCondition,
      'totalScore': report.totalScore,
      'percentage': report.percentage,
      'createdBy': report.createdBy,
      'timestamp': writeTimestamp(report.timestamp),
    };
  }
}

class ToolsCountReportModel {
  static ToolsCountReport fromMap(Map<String, dynamic> data, {String id = ''}) {
    return ToolsCountReport(
      id: id,
      date: requireDateTime(data['date'], 'date'),
      machineNumber: data['machineNumber'] ?? '',
      totalToolsGiven: data['totalToolsGiven'] ?? 0,
      totalToolsAvailable: data['totalToolsAvailable'] ?? 0,
      percentageAvailable: (data['percentageAvailable'] ?? 0).toDouble(),
      createdBy: data['createdBy'] ?? '',
      timestamp: dateTimeOrNull(data['timestamp']),
    );
  }

  static Map<String, dynamic> toMap(ToolsCountReport report) {
    return {
      'date': report.date,
      'machineNumber': report.machineNumber,
      'totalToolsGiven': report.totalToolsGiven,
      'totalToolsAvailable': report.totalToolsAvailable,
      'percentageAvailable': report.percentageAvailable,
      'createdBy': report.createdBy,
      'timestamp': writeTimestamp(report.timestamp),
    };
  }
}

class HealthRatingItemModel {
  static HealthRatingItem fromMap(Map<String, dynamic> data) {
    return HealthRatingItem(
      item: data['item'] ?? '',
      rating: data['rating'] ?? 0,
    );
  }

  static Map<String, dynamic> toMap(HealthRatingItem item) {
    return {'item': item.item, 'rating': item.rating};
  }
}

class MachineHealthReportModel {
  static MachineHealthReport fromMap(
    Map<String, dynamic> data, {
    String id = '',
  }) {
    final ratings = (data['ratings'] as List<dynamic>? ?? [])
        .map((e) => HealthRatingItemModel.fromMap(e as Map<String, dynamic>))
        .toList();
    return MachineHealthReport(
      id: id,
      date: requireDateTime(data['date'], 'date'),
      machineNumber: data['machineNumber'] ?? '',
      shift: data['shift'] ?? '',
      ratings: ratings,
      totalScore: data['totalScore'] ?? 0,
      percentage: (data['percentage'] ?? 0).toDouble(),
      createdBy: data['createdBy'] ?? '',
      timestamp: dateTimeOrNull(data['timestamp']),
      submittedAt: dateTimeOrNull(data['submittedAt']),
    );
  }

  static Map<String, dynamic> toMap(MachineHealthReport report) {
    return {
      'date': report.date,
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'ratings': report.ratings
          .map((e) => HealthRatingItemModel.toMap(e))
          .toList(),
      'totalScore': report.totalScore,
      'percentage': report.percentage,
      'createdBy': report.createdBy,
      'timestamp': writeTimestamp(report.timestamp),
      'submittedAt': writeTimestamp(report.submittedAt),
    };
  }
}

class FrameProductionLineItemModel {
  static FrameProductionLineItem fromMap(Map<String, dynamic> data) {
    return FrameProductionLineItem(
      section: data['section'] ?? '',
      density: data['density'] ?? '',
      color: data['color'] ?? '',
      length: (data['length'] ?? 0).toDouble(),
      quantity: data['quantity'] ?? 0,
      perPieceWeight: (data['perPieceWeight'] ?? 0).toDouble(),
      totalWeight: (data['totalWeight'] ?? 0).toDouble(),
      timeOfChange: dateTimeOrNull(data['timeOfChange']),
      manualWeightPerFoot: data['manualWeightPerFoot']?.toDouble(),
    );
  }

  static Map<String, dynamic> toMap(FrameProductionLineItem item) {
    return {
      'section': item.section,
      'density': item.density,
      'color': item.color,
      'length': item.length,
      'quantity': item.quantity,
      'perPieceWeight': item.perPieceWeight,
      'totalWeight': item.totalWeight,
      'timeOfChange': item.timeOfChange,
      'manualWeightPerFoot': item.manualWeightPerFoot,
    };
  }
}

class FrameProductionDetailsReportModel {
  static FrameProductionDetailsReport fromMap(
    Map<String, dynamic> data, {
    String id = '',
  }) {
    final lineItems = (data['lineItems'] as List<dynamic>? ?? [])
        .map(
          (e) =>
              FrameProductionLineItemModel.fromMap(e as Map<String, dynamic>),
        )
        .toList();
    return FrameProductionDetailsReport(
      id: id,
      date: requireDateTime(data['date'], 'date'),
      machineNumber: data['machineNumber'] ?? '',
      shift: data['shift'] ?? '',
      lineItems: lineItems,
      totalQuantity: data['totalQuantity'] ?? 0,
      totalWeight: (data['totalWeight'] ?? 0).toDouble(),
      createdBy: data['createdBy'] ?? '',
      timestamp: dateTimeOrNull(data['timestamp']),
      submittedAt: dateTimeOrNull(data['submittedAt']),
    );
  }

  static Map<String, dynamic> toMap(FrameProductionDetailsReport report) {
    return {
      'date': report.date,
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'lineItems': report.lineItems
          .map((e) => FrameProductionLineItemModel.toMap(e))
          .toList(),
      'totalQuantity': report.totalQuantity,
      'totalWeight': report.totalWeight,
      'createdBy': report.createdBy,
      'timestamp': writeTimestamp(report.timestamp),
      'submittedAt': writeTimestamp(report.submittedAt),
    };
  }
}

class FrameProductionWeightReportModel {
  static FrameProductionWeightReport fromMap(
    Map<String, dynamic> data, {
    String id = '',
  }) {
    return FrameProductionWeightReport(
      id: id,
      date: requireDateTime(data['date'], 'date'),
      machineNumber: data['machineNumber'] ?? '',
      shift: data['shift'] ?? '',
      productionWeight: (data['productionWeight'] ?? 0).toDouble(),
      maintenanceWeight: (data['maintenanceWeight'] ?? 0).toDouble(),
      totalProductionWeight: (data['totalProductionWeight'] ?? 0).toDouble(),
      targetWeight: (data['targetWeight'] ?? 0).toDouble(),
      efficiencyPercentage: (data['efficiencyPercentage'] ?? 0).toDouble(),
      createdBy: data['createdBy'] ?? '',
      timestamp: dateTimeOrNull(data['timestamp']),
    );
  }

  static Map<String, dynamic> toMap(FrameProductionWeightReport report) {
    return {
      'date': report.date,
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'productionWeight': report.productionWeight,
      'maintenanceWeight': report.maintenanceWeight,
      'totalProductionWeight': report.totalProductionWeight,
      'targetWeight': report.targetWeight,
      'efficiencyPercentage': report.efficiencyPercentage,
      'createdBy': report.createdBy,
      'timestamp': writeTimestamp(report.timestamp),
    };
  }
}

class FramePackingLineItemModel {
  static FramePackingLineItem fromMap(Map<String, dynamic> data) {
    return FramePackingLineItem(
      section: data['section'] ?? '',
      density: data['density'] ?? '',
      color: data['color'] ?? '',
      length: (data['length'] ?? 0).toDouble(),
      productionQuantity: data['productionQuantity'] ?? 0,
      perPieceWeight: (data['perPieceWeight'] ?? 0).toDouble(),
      packed: data['packed'] ?? 0,
      rejectedQuality: data['rejectedQuality'] ?? 0,
    );
  }

  static Map<String, dynamic> toMap(FramePackingLineItem item) {
    return {
      'section': item.section,
      'density': item.density,
      'color': item.color,
      'length': item.length,
      'productionQuantity': item.productionQuantity,
      'perPieceWeight': item.perPieceWeight,
      'packed': item.packed,
      'rejectedQuality': item.rejectedQuality,
    };
  }
}

class FrameShiftPackingReportModel {
  static FrameShiftPackingReport fromMap(
    Map<String, dynamic> data, {
    String id = '',
  }) {
    final lineItems = (data['lineItems'] as List<dynamic>? ?? [])
        .map(
          (e) => FramePackingLineItemModel.fromMap(e as Map<String, dynamic>),
        )
        .toList();
    return FrameShiftPackingReport(
      id: id,
      date: requireDateTime(data['date'], 'date'),
      machineNumber: data['machineNumber'] ?? '',
      shift: data['shift'] ?? '',
      lineItems: lineItems,
      totalRejectedWeight: (data['totalRejectedWeight'] ?? 0).toDouble(),
      qualityAcceptancePercentage: (data['qualityAcceptancePercentage'] ?? 0)
          .toDouble(),
      packingEfficiency: (data['packingEfficiency'] ?? 0).toDouble(),
      createdBy: data['createdBy'] ?? '',
      timestamp: dateTimeOrNull(data['timestamp']),
    );
  }

  static Map<String, dynamic> toMap(FrameShiftPackingReport report) {
    return {
      'date': report.date,
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'lineItems': report.lineItems
          .map((e) => FramePackingLineItemModel.toMap(e))
          .toList(),
      'totalRejectedWeight': report.totalRejectedWeight,
      'qualityAcceptancePercentage': report.qualityAcceptancePercentage,
      'packingEfficiency': report.packingEfficiency,
      'createdBy': report.createdBy,
      'timestamp': writeTimestamp(report.timestamp),
    };
  }
}

class ReportWritingEfficiencyModel {
  static ReportWritingEfficiencyRecord fromMap(
    Map<String, dynamic> data, {
    String id = '',
  }) {
    return ReportWritingEfficiencyRecord(
      id: id,
      date: requireDateTime(data['date'], 'date'),
      machineNumber: data['machineNumber'] ?? '',
      shift: data['shift'] ?? '',
      submittedAt: dateTimeOrNull(data['submittedAt']),
      shiftEndTime: requireDateTime(data['shiftEndTime'], 'shiftEndTime'),
      score: data['score'] ?? 0,
      operatorId: data['operatorId'] ?? '',
    );
  }

  static Map<String, dynamic> toMap(ReportWritingEfficiencyRecord record) {
    return {
      'date': record.date,
      'machineNumber': record.machineNumber,
      'shift': record.shift,
      'submittedAt': record.submittedAt,
      'shiftEndTime': record.shiftEndTime,
      'score': record.score,
      'operatorId': record.operatorId,
    };
  }
}

class FrameCustomerRejectionReportModel {
  static FrameCustomerRejectionReport fromMap(
    Map<String, dynamic> data, {
    String id = '',
  }) {
    final items = (data['rejectedItems'] as List<dynamic>? ?? [])
        .map(
          (e) =>
              FrameProductionLineItemModel.fromMap(e as Map<String, dynamic>),
        )
        .toList();
    return FrameCustomerRejectionReport(
      id: id,
      originalProductionDate: requireDateTime(
        data['originalProductionDate'],
        'originalProductionDate',
      ),
      rejectionDate: requireDateTime(data['rejectionDate'], 'rejectionDate'),
      machineNumber: data['machineNumber'] ?? '',
      shift: data['shift'] ?? '',
      rejectedItems: items,
      totalRejectedWeight: (data['totalRejectedWeight'] ?? 0).toDouble(),
      createdBy: data['createdBy'] ?? '',
      timestamp: dateTimeOrNull(data['timestamp']),
    );
  }

  static Map<String, dynamic> toMap(FrameCustomerRejectionReport report) {
    return {
      'originalProductionDate': report.originalProductionDate,
      'rejectionDate': report.rejectionDate,
      'machineNumber': report.machineNumber,
      'shift': report.shift,
      'rejectedItems': report.rejectedItems
          .map((e) => FrameProductionLineItemModel.toMap(e))
          .toList(),
      'totalRejectedWeight': report.totalRejectedWeight,
      'createdBy': report.createdBy,
      'timestamp': writeTimestamp(report.timestamp),
    };
  }
}
