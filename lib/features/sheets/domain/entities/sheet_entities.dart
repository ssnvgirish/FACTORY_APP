import 'package:equatable/equatable.dart';

class SheetProductionLineItem extends Equatable {
  final String thickness;
  final String density;
  final String color;
  final double length; // inches
  final double width; // inches
  final int quantity;
  final double sqft;
  final double perPieceWeight;
  final double totalWeight;
  final double totalRunningFeet;
  final DateTime? timeOfChange;
  final double? manualWeightPerSqft; // for 'Others' density

  const SheetProductionLineItem({
    required this.thickness,
    required this.density,
    required this.color,
    required this.length,
    required this.width,
    required this.quantity,
    required this.sqft,
    required this.perPieceWeight,
    required this.totalWeight,
    required this.totalRunningFeet,
    this.timeOfChange,
    this.manualWeightPerSqft,
  });

  @override
  List<Object?> get props => [
    thickness,
    density,
    color,
    length,
    width,
    quantity,
  ];
}

class SheetProductionDetailsReport extends Equatable {
  final String? id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final List<SheetProductionLineItem> lineItems;
  final int totalQuantity; // h
  final double totalWeight; // k
  final double totalRunningFeet; // l
  final String createdBy;
  final DateTime? timestamp;
  final DateTime? submittedAt;

  const SheetProductionDetailsReport({
    this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.lineItems,
    required this.totalQuantity,
    required this.totalWeight,
    required this.totalRunningFeet,
    required this.createdBy,
    this.timestamp,
    this.submittedAt,
  });

  @override
  List<Object?> get props => [id, date, machineNumber, shift, lineItems];
}

class SheetProductionRunningFeetReport extends Equatable {
  final String? id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final double productionRunningFeet; // l
  final double maintenanceRunningFeet; // g × target/hr
  final double totalProductionRunningFeet;
  final double targetRunningFeet;
  final double efficiencyPercentage;
  final String createdBy;
  final DateTime? timestamp;

  const SheetProductionRunningFeetReport({
    this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.productionRunningFeet,
    required this.maintenanceRunningFeet,
    required this.totalProductionRunningFeet,
    required this.targetRunningFeet,
    required this.efficiencyPercentage,
    required this.createdBy,
    this.timestamp,
  });

  @override
  List<Object?> get props => [id, date, machineNumber, shift];
}

class SheetPackingLineItem extends Equatable {
  final String thickness;
  final String density;
  final String color;
  final double length;
  final double width;
  final int productionQuantity;
  final double perPieceWeight;
  final double runningFeetPerItem;
  final int packed;
  final int onlySanding;
  final int sandingAndPacked;
  final int rejectedQuality;

  const SheetPackingLineItem({
    required this.thickness,
    required this.density,
    required this.color,
    required this.length,
    required this.width,
    required this.productionQuantity,
    required this.perPieceWeight,
    required this.runningFeetPerItem,
    required this.packed,
    required this.onlySanding,
    required this.sandingAndPacked,
    required this.rejectedQuality,
  });

  double get rejectedRunningFeet => rejectedQuality * runningFeetPerItem;

  @override
  List<Object?> get props => [
    thickness,
    density,
    color,
    length,
    width,
    productionQuantity,
  ];
}

class SheetShiftPackingReport extends Equatable {
  final String? id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final List<SheetPackingLineItem> lineItems;
  final double totalRejectedRunningFeet;
  final double qualityAcceptancePercentage;
  final double packingEfficiency;
  final String createdBy;
  final DateTime? timestamp;

  const SheetShiftPackingReport({
    this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.lineItems,
    required this.totalRejectedRunningFeet,
    required this.qualityAcceptancePercentage,
    required this.packingEfficiency,
    required this.createdBy,
    this.timestamp,
  });

  @override
  List<Object?> get props => [id, date, machineNumber, shift, lineItems];
}

class SheetCustomerRejectionReport extends Equatable {
  final String? id;
  final DateTime originalProductionDate;
  final String machineNumber;
  final String shift;
  final List<SheetProductionLineItem> rejectedItems;
  final double totalRejectedRunningFeet;
  final String createdBy;
  final DateTime? timestamp;

  const SheetCustomerRejectionReport({
    this.id,
    required this.originalProductionDate,
    required this.machineNumber,
    required this.shift,
    required this.rejectedItems,
    required this.totalRejectedRunningFeet,
    required this.createdBy,
    this.timestamp,
  });

  @override
  List<Object?> get props => [
    id,
    originalProductionDate,
    machineNumber,
    shift,
    rejectedItems,
  ];
}

// Re-use MachineCleaningReport, ToolsCountReport, MachineHealthReport, ReportWritingEfficiencyRecord from frames
// They share the same structure, just with different machine numbers
