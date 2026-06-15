import 'package:equatable/equatable.dart';

class MachineCleaningReport extends Equatable {
  final String? id;
  final DateTime date;
  final String machineNumber;
  final int machineCondition;
  final int groundCondition;
  final int mouldCondition;
  final int totalScore;
  final double percentage;
  final String createdBy;
  final DateTime? timestamp;

  const MachineCleaningReport({
    this.id,
    required this.date,
    required this.machineNumber,
    required this.machineCondition,
    required this.groundCondition,
    required this.mouldCondition,
    required this.totalScore,
    required this.percentage,
    required this.createdBy,
    this.timestamp,
  });

  @override
  List<Object?> get props => [
    id,
    date,
    machineNumber,
    machineCondition,
    groundCondition,
    mouldCondition,
  ];
}

class ToolsCountReport extends Equatable {
  final String? id;
  final DateTime date;
  final String machineNumber;
  final int totalToolsGiven;
  final int totalToolsAvailable;
  final double percentageAvailable; // available / given * 100
  final String createdBy;
  final DateTime? timestamp;

  const ToolsCountReport({
    this.id,
    required this.date,
    required this.machineNumber,
    required this.totalToolsGiven,
    required this.totalToolsAvailable,
    required this.percentageAvailable,
    required this.createdBy,
    this.timestamp,
  });

  @override
  List<Object?> get props => [
    id,
    date,
    machineNumber,
    totalToolsGiven,
    totalToolsAvailable,
  ];
}

class HealthRatingItem extends Equatable {
  final String item; // e.g., 'Die Cleaning', 'Generator Maintenance'
  final int rating; // 1-10

  const HealthRatingItem({required this.item, required this.rating});

  @override
  List<Object?> get props => [item, rating];
}

class MachineHealthReport extends Equatable {
  final String? id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final List<HealthRatingItem> ratings;
  final int totalScore; // sum of all ratings
  final double percentage; // totalScore / (ratings.length * 10) * 100
  final String createdBy;
  final DateTime? timestamp;
  final DateTime? submittedAt;

  const MachineHealthReport({
    this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.ratings,
    required this.totalScore,
    required this.percentage,
    required this.createdBy,
    this.timestamp,
    this.submittedAt,
  });

  @override
  List<Object?> get props => [id, date, machineNumber, shift, ratings];
}

class FrameProductionLineItem extends Equatable {
  final String section;
  final String density;
  final String color;
  final double length;
  final int quantity;
  final double perPieceWeight;
  final double totalWeight;
  final DateTime? timeOfChange;
  final double? manualWeightPerFoot; // for 'Others' density

  const FrameProductionLineItem({
    required this.section,
    required this.density,
    required this.color,
    required this.length,
    required this.quantity,
    required this.perPieceWeight,
    required this.totalWeight,
    this.timeOfChange,
    this.manualWeightPerFoot,
  });

  @override
  List<Object?> get props => [section, density, color, length, quantity];
}

class FrameProductionDetailsReport extends Equatable {
  final String? id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final List<FrameProductionLineItem> lineItems;
  final int totalQuantity; // h
  final double totalWeight; // k
  final String createdBy;
  final DateTime? timestamp;
  final DateTime? submittedAt;

  const FrameProductionDetailsReport({
    this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.lineItems,
    required this.totalQuantity,
    required this.totalWeight,
    required this.createdBy,
    this.timestamp,
    this.submittedAt,
  });

  @override
  List<Object?> get props => [id, date, machineNumber, shift, lineItems];
}

class FrameProductionWeightReport extends Equatable {
  final String? id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final double productionWeight; // k from production details
  final double maintenanceWeight; // g × target per hour
  final double totalProductionWeight; // production + maintenance
  final double targetWeight;
  final double efficiencyPercentage;
  final String createdBy;
  final DateTime? timestamp;

  const FrameProductionWeightReport({
    this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.productionWeight,
    required this.maintenanceWeight,
    required this.totalProductionWeight,
    required this.targetWeight,
    required this.efficiencyPercentage,
    required this.createdBy,
    this.timestamp,
  });

  @override
  List<Object?> get props => [id, date, machineNumber, shift];
}

class FramePackingLineItem extends Equatable {
  final String section;
  final String density;
  final String color;
  final double length;
  final int productionQuantity;
  final double perPieceWeight;
  final int packed;
  final int rejectedQuality;

  const FramePackingLineItem({
    required this.section,
    required this.density,
    required this.color,
    required this.length,
    required this.productionQuantity,
    required this.perPieceWeight,
    required this.packed,
    required this.rejectedQuality,
  });

  double get rejectedWeight => rejectedQuality * perPieceWeight;

  @override
  List<Object?> get props => [
    section,
    density,
    color,
    length,
    productionQuantity,
    packed,
    rejectedQuality,
  ];
}

class FrameShiftPackingReport extends Equatable {
  final String? id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final List<FramePackingLineItem> lineItems;
  final double totalRejectedWeight;
  final double qualityAcceptancePercentage;
  final double packingEfficiency;
  final String createdBy;
  final DateTime? timestamp;

  const FrameShiftPackingReport({
    this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.lineItems,
    required this.totalRejectedWeight,
    required this.qualityAcceptancePercentage,
    required this.packingEfficiency,
    required this.createdBy,
    this.timestamp,
  });

  @override
  List<Object?> get props => [id, date, machineNumber, shift, lineItems];
}

class ReportWritingEfficiencyRecord extends Equatable {
  final String? id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final DateTime? submittedAt;
  final DateTime shiftEndTime;
  final int score; // 0-5
  final String operatorId;

  const ReportWritingEfficiencyRecord({
    this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    this.submittedAt,
    required this.shiftEndTime,
    required this.score,
    required this.operatorId,
  });

  @override
  List<Object?> get props => [id, date, machineNumber, shift, score];
}

class FrameCustomerRejectionReport extends Equatable {
  final String? id;
  final DateTime originalProductionDate;
  final DateTime rejectionDate;
  final String machineNumber;
  final String shift;
  final List<FrameProductionLineItem> rejectedItems;
  final double totalRejectedWeight;
  final String createdBy;
  final DateTime? timestamp;

  const FrameCustomerRejectionReport({
    this.id,
    required this.originalProductionDate,
    required this.rejectionDate,
    required this.machineNumber,
    required this.shift,
    required this.rejectedItems,
    required this.totalRejectedWeight,
    required this.createdBy,
    this.timestamp,
  });

  @override
  List<Object?> get props => [
    id,
    originalProductionDate,
    rejectionDate,
    machineNumber,
    shift,
    rejectedItems,
  ];
}
