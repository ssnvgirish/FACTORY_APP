import 'package:equatable/equatable.dart';

// ═══════════════════════════════════════
// 1. MACHINE CLEANING REPORT (variable 'a')
// ═══════════════════════════════════════

class ScrapCleaningReport extends Equatable {
  final String? id;
  final DateTime date;
  final String machineNumber;
  final int machineCondition; // 1-10
  final int groundCondition; // 1-10
  final int totalScore; // sum of above, max 20
  final double percentage; // totalScore / 20 * 100
  final String createdBy;
  final DateTime? timestamp;

  const ScrapCleaningReport({
    this.id,
    required this.date,
    required this.machineNumber,
    required this.machineCondition,
    required this.groundCondition,
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
  ];
}

// ═══════════════════════════════════════
// 2. TOOLS COUNT REPORT (variable 'b')
// ═══════════════════════════════════════

class ScrapToolsCountReport extends Equatable {
  final String? id;
  final DateTime date;
  final String machineNumber;
  final int totalToolsGiven;
  final int totalToolsAvailable;
  final double percentageAvailable; // available / given * 100
  final String createdBy;
  final DateTime? timestamp;

  const ScrapToolsCountReport({
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

// ═══════════════════════════════════════
// 3. MACHINE HEALTH REPORT (variable 'c' = total maintenance duration)
// ═══════════════════════════════════════

class ScrapMaintenanceEntry extends Equatable {
  final String maintenanceItem;
  final DateTime startTime;
  final DateTime endTime;
  final String personDoingMaintenance;
  final String description;
  final double durationHours; // auto-calculated

  const ScrapMaintenanceEntry({
    required this.maintenanceItem,
    required this.startTime,
    required this.endTime,
    required this.personDoingMaintenance,
    required this.description,
    required this.durationHours,
  });

  @override
  List<Object?> get props => [
    maintenanceItem,
    startTime,
    endTime,
    personDoingMaintenance,
  ];
}

class ScrapMachineHealthReport extends Equatable {
  final String? id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final List<ScrapMaintenanceEntry> entries;
  final double totalMaintenanceDurationHours; // 'c' value
  final String createdBy;
  final DateTime? timestamp;
  final DateTime? submittedAt;

  const ScrapMachineHealthReport({
    this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.entries,
    required this.totalMaintenanceDurationHours,
    required this.createdBy,
    this.timestamp,
    this.submittedAt,
  });

  @override
  List<Object?> get props => [id, date, machineNumber, shift, entries];
}

// ═══════════════════════════════════════
// 4. PRODUCTION DETAILS REPORT (variable 'd' = total production weight)
// ═══════════════════════════════════════

class ScrapProductionLineItem extends Equatable {
  final String product;
  final double weightPerBag;
  final int totalBags;
  final double totalWeight; // weightPerBag × totalBags

  const ScrapProductionLineItem({
    required this.product,
    required this.weightPerBag,
    required this.totalBags,
    required this.totalWeight,
  });

  @override
  List<Object?> get props => [product, weightPerBag, totalBags];
}

class ScrapProductionDetailsReport extends Equatable {
  final String? id;
  final DateTime date;
  final String machineNumber; // Pulverizer 1-3 only
  final String shift;
  final List<ScrapProductionLineItem> lineItems;
  final double totalProductionWeight; // 'd' value
  final String createdBy;
  final DateTime? timestamp;
  final DateTime? submittedAt;

  const ScrapProductionDetailsReport({
    this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.lineItems,
    required this.totalProductionWeight,
    required this.createdBy,
    this.timestamp,
    this.submittedAt,
  });

  @override
  List<Object?> get props => [id, date, machineNumber, shift, lineItems];
}

// ═══════════════════════════════════════
// 5. PRODUCTION WEIGHT CALCULATION REPORT (variable 'e' = efficiency %)
// ═══════════════════════════════════════

class ScrapProductionWeightReport extends Equatable {
  final String? id;
  final DateTime date;
  final String machineNumber; // Pulverizer 1-3 only
  final String shift;
  final double totalProductionWeight; // 'd' auto-populated
  final double maintenanceWeight; // 'c' × target per hour
  final double totalWeight; // production + maintenance
  final double targetWeight; // based on section time × target/hr
  final double efficiencyPercentage; // totalWeight / targetWeight * 100
  final String createdBy;
  final DateTime? timestamp;

  const ScrapProductionWeightReport({
    this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalProductionWeight,
    required this.maintenanceWeight,
    required this.totalWeight,
    required this.targetWeight,
    required this.efficiencyPercentage,
    required this.createdBy,
    this.timestamp,
  });

  @override
  List<Object?> get props => [id, date, machineNumber, shift];
}

// ═══════════════════════════════════════
// 6. REPORT WRITING EFFICIENCY (variable 'f')
// ═══════════════════════════════════════

class ScrapReportWritingEfficiency extends Equatable {
  final String? id;
  final DateTime date;
  final String machineNumber; // Pulverizer 1-3
  final String shift;
  final DateTime? submittedAt;
  final DateTime shiftEndTime;
  final int score; // 0-5
  final String operatorId;

  const ScrapReportWritingEfficiency({
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

// ═══════════════════════════════════════
// 7. SCRAP QUALITY REPORT (variable 'g')
// ═══════════════════════════════════════

class ScrapQualityReport extends Equatable {
  final String? id;
  final DateTime date;
  final String machineNumber; // Frame Machine 1-2, Sheet Machine 3-5
  final String shift;
  final String product;
  final int qualityRating; // 1-10
  final String? comments;
  final String createdBy;
  final DateTime? timestamp;

  const ScrapQualityReport({
    this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.product,
    required this.qualityRating,
    this.comments,
    required this.createdBy,
    this.timestamp,
  });

  @override
  List<Object?> get props => [
    id,
    date,
    machineNumber,
    shift,
    product,
    qualityRating,
  ];
}

// ═══════════════════════════════════════
// SCRAP SALARY CALCULATION
// ═══════════════════════════════════════

class ScrapSalaryCalculation extends Equatable {
  final String? id;
  final String operatorId;
  final String operatorName;
  final int year;
  final int month;
  final double a; // Machine Cleaning %
  final double b; // Tools Count %
  final double e; // Production Efficiency %
  final double f; // Report Writing Efficiency %
  final double g; // Scrap Quality Rating %
  final double wA, wB, wE, wF, wG; // weightages
  final double multiplier;
  final double fixedSalary;
  final double calculatedSalary;

  const ScrapSalaryCalculation({
    this.id,
    required this.operatorId,
    required this.operatorName,
    required this.year,
    required this.month,
    required this.a,
    required this.b,
    required this.e,
    required this.f,
    required this.g,
    required this.wA,
    required this.wB,
    required this.wE,
    required this.wF,
    required this.wG,
    required this.multiplier,
    required this.fixedSalary,
    required this.calculatedSalary,
  });

  @override
  List<Object?> get props => [
    id,
    operatorId,
    year,
    month,
    multiplier,
    calculatedSalary,
  ];
}

class ScrapSalaryWeightages extends Equatable {
  final double wA;
  final double wB;
  final double wE;
  final double wF;
  final double wG;

  const ScrapSalaryWeightages({
    required this.wA,
    required this.wB,
    required this.wE,
    required this.wF,
    required this.wG,
  });

  double get total => wA + wB + wE + wF + wG;

  @override
  List<Object?> get props => [wA, wB, wE, wF, wG];
}
