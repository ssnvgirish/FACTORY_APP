import 'package:factory_app/features/auth/domain/entities/user_entity.dart';
import 'package:factory_app/features/frames/domain/entities/frame_entities.dart';
import 'package:factory_app/features/sheets/domain/entities/sheet_entities.dart';
import 'package:factory_app/features/salary/domain/entities/salary_entities.dart';
import 'package:factory_app/features/dashboard/domain/entities/dashboard_entities.dart';
import 'package:factory_app/core/constants/app_constants.dart';

/// Factory methods for test data generation.
class TestFactories {
  TestFactories._();

  // ═══════════════════════════════════════
  // USER FACTORIES
  // ═══════════════════════════════════════

  static AppUser fakeOperator({
    String uid = 'op-1',
    String name = 'Test Operator',
    String email = 'operator@factory.com',
    List<String> assignedMachines = const ['Frame Machine 1'],
    double fixedSalary = 50000,
  }) {
    return AppUser(
      uid: uid,
      name: name,
      email: email,
      roles: [AppConstants.roleMachineOperator],
      assignedMachines: assignedMachines,
      fixedSalary: fixedSalary,
    );
  }

  static AppUser fakeFrameSeniorOperator({
    String uid = 'fso-1',
    String name = 'Frame Senior',
    String email = 'frame.senior@factory.com',
  }) {
    return AppUser(
      uid: uid,
      name: name,
      email: email,
      roles: [AppConstants.roleFramesSenior],
      assignedMachines: AppConstants.frameMachines,
    );
  }

  static AppUser fakeSheetSeniorOperator({
    String uid = 'sso-1',
    String name = 'Sheet Senior',
    String email = 'sheet.senior@factory.com',
  }) {
    return AppUser(
      uid: uid,
      name: name,
      email: email,
      roles: [AppConstants.roleSheetSenior],
      assignedMachines: AppConstants.sheetMachines,
    );
  }

  static AppUser fakeQualityPacking({
    String uid = 'qp-1',
    String name = 'QP Supervisor',
    String email = 'qp@factory.com',
  }) {
    return AppUser(
      uid: uid,
      name: name,
      email: email,
      roles: [AppConstants.roleQualityPacking],
      assignedMachines: AppConstants.allMachines,
    );
  }

  static AppUser fakePlantManager({
    String uid = 'pm-1',
    String name = 'Plant Manager',
    String email = 'pm@factory.com',
  }) {
    return AppUser(
      uid: uid,
      name: name,
      email: email,
      roles: [AppConstants.rolePlantManager],
    );
  }

  static AppUser fakeAdmin({
    String uid = 'admin-1',
    String name = 'Admin User',
    String email = 'admin@factory.com',
  }) {
    return AppUser(
      uid: uid,
      name: name,
      email: email,
      roles: [AppConstants.roleAdmin],
    );
  }

  // ═══════════════════════════════════════
  // MACHINE CLEANING FACTORIES
  // ═══════════════════════════════════════

  static MachineCleaningReport fakeMachineCleaningReport({
    String? id,
    DateTime? date,
    String machineNumber = 'Frame Machine 1',
    int machineCondition = 8,
    int groundCondition = 7,
    int mouldCondition = 9,
    int totalScore = 24,
    double percentage = 80.0,
    String createdBy = 'op-1',
  }) {
    return MachineCleaningReport(
      id: id,
      date: date ?? DateTime(2026, 3, 15),
      machineNumber: machineNumber,
      machineCondition: machineCondition,
      groundCondition: groundCondition,
      mouldCondition: mouldCondition,
      totalScore: totalScore,
      percentage: percentage,
      createdBy: createdBy,
    );
  }

  // ═══════════════════════════════════════
  // TOOLS COUNT FACTORIES
  // ═══════════════════════════════════════

  static ToolsCountReport fakeToolsCountReport({
    String? id,
    DateTime? date,
    String machineNumber = 'Frame Machine 1',
    int totalToolsGiven = 100,
    int totalToolsAvailable = 85,
    double percentageAvailable = 85.0,
    String createdBy = 'op-1',
  }) {
    return ToolsCountReport(
      id: id,
      date: date ?? DateTime(2026, 3, 15),
      machineNumber: machineNumber,
      totalToolsGiven: totalToolsGiven,
      totalToolsAvailable: totalToolsAvailable,
      percentageAvailable: percentageAvailable,
      createdBy: createdBy,
    );
  }

  // ═══════════════════════════════════════
  // HEALTH RATING ITEM FACTORIES
  // ═══════════════════════════════════════

  static FrameMaintenanceEntry fakeMaintenanceEntry({
    String maintenanceItem = 'Die Change',
    DateTime? startTime,
    DateTime? endTime,
    String personDoingMaintenance = 'John',
    String description = 'Routine check',
    double durationHours = 1.0,
  }) {
    return FrameMaintenanceEntry(
      maintenanceItem: maintenanceItem,
      startTime: startTime ?? DateTime(2026, 3, 15, 8, 0),
      endTime: endTime ?? DateTime(2026, 3, 15, 9, 0),
      personDoingMaintenance: personDoingMaintenance,
      description: description,
      durationHours: durationHours,
    );
  }

  // ═══════════════════════════════════════
  // MACHINE HEALTH REPORT FACTORIES
  // ═══════════════════════════════════════

  static MachineHealthReport fakeMachineHealthReport({
    String? id,
    DateTime? date,
    String machineNumber = 'Frame Machine 1',
    String shift = 'Day Shift',
    List<FrameMaintenanceEntry>? entries,
    double totalMaintenanceDurationHours = 1.0,
    String createdBy = 'op-1',
  }) {
    return MachineHealthReport(
      id: id,
      date: date ?? DateTime(2026, 3, 15),
      machineNumber: machineNumber,
      shift: shift,
      entries: entries ?? [fakeMaintenanceEntry(maintenanceItem: 'Die Change')],
      totalMaintenanceDurationHours: totalMaintenanceDurationHours,
      createdBy: createdBy,
    );
  }

  // ═══════════════════════════════════════
  // FRAME PRODUCTION FACTORIES
  // ═══════════════════════════════════════

  static FrameProductionLineItem fakeFrameLineItem({
    String section = '3x2',
    String density = '0.75',
    String color = 'Brown',
    double length = 10.0,
    int quantity = 50,
    double perPieceWeight = 4.86,
    double totalWeight = 243.0,
    DateTime? timeOfChange,
    double? manualWeightPerFoot,
  }) {
    return FrameProductionLineItem(
      section: section,
      density: density,
      color: color,
      length: length,
      quantity: quantity,
      perPieceWeight: perPieceWeight,
      totalWeight: totalWeight,
      timeOfChange: timeOfChange,
      manualWeightPerFoot: manualWeightPerFoot,
    );
  }

  static FrameProductionDetailsReport fakeFrameProductionReport({
    String? id,
    DateTime? date,
    String machineNumber = 'Frame Machine 1',
    String shift = 'Day Shift',
    List<FrameProductionLineItem>? lineItems,
    int totalQuantity = 100,
    double totalWeight = 486.0,
    String createdBy = 'op-1',
  }) {
    return FrameProductionDetailsReport(
      id: id,
      date: date ?? DateTime(2026, 3, 15),
      machineNumber: machineNumber,
      shift: shift,
      lineItems:
          lineItems ??
          [
            fakeFrameLineItem(),
            fakeFrameLineItem(
              section: '4x2',
              density: '0.80',
              perPieceWeight: 6.90,
              totalWeight: 345.0,
              timeOfChange: DateTime(2026, 3, 15, 15, 0),
            ),
          ],
      totalQuantity: totalQuantity,
      totalWeight: totalWeight,
      createdBy: createdBy,
    );
  }

  // ═══════════════════════════════════════
  // FRAME PRODUCTION WEIGHT FACTORIES
  // ═══════════════════════════════════════

  static FrameProductionWeightReport fakeFrameWeightReport({
    String? id,
    DateTime? date,
    String machineNumber = 'Frame Machine 1',
    String shift = 'Day Shift',
    double productionWeight = 486.0,
    double maintenanceWeight = 250.0,
    double totalProductionWeight = 736.0,
    double targetWeight = 1200.0,
    double efficiencyPercentage = 61.33,
    String createdBy = 'op-1',
  }) {
    return FrameProductionWeightReport(
      id: id,
      date: date ?? DateTime(2026, 3, 15),
      machineNumber: machineNumber,
      shift: shift,
      productionWeight: productionWeight,
      maintenanceWeight: maintenanceWeight,
      totalProductionWeight: totalProductionWeight,
      targetWeight: targetWeight,
      efficiencyPercentage: efficiencyPercentage,
      createdBy: createdBy,
    );
  }

  // ═══════════════════════════════════════
  // FRAME PACKING FACTORIES
  // ═══════════════════════════════════════

  static FramePackingLineItem fakeFramePackingItem({
    String section = '3x2',
    String density = '0.75',
    String color = 'Brown',
    double length = 10.0,
    int productionQuantity = 50,
    double perPieceWeight = 4.86,
    int packed = 48,
    int rejectedQuality = 2,
  }) {
    return FramePackingLineItem(
      section: section,
      density: density,
      color: color,
      length: length,
      productionQuantity: productionQuantity,
      perPieceWeight: perPieceWeight,
      packed: packed,
      rejectedQuality: rejectedQuality,
    );
  }

  static FrameShiftPackingReport fakeFramePackingReport({
    String? id,
    DateTime? date,
    String machineNumber = 'Frame Machine 1',
    String shift = 'Day Shift',
    List<FramePackingLineItem>? lineItems,
    double totalRejectedWeight = 9.72,
    double qualityAcceptancePercentage = 96.0,
    double packingEfficiency = 96.0,
    String createdBy = 'qp-1',
  }) {
    return FrameShiftPackingReport(
      id: id,
      date: date ?? DateTime(2026, 3, 15),
      machineNumber: machineNumber,
      shift: shift,
      lineItems: lineItems ?? [fakeFramePackingItem()],
      totalRejectedWeight: totalRejectedWeight,
      qualityAcceptancePercentage: qualityAcceptancePercentage,
      packingEfficiency: packingEfficiency,
      createdBy: createdBy,
    );
  }

  // ═══════════════════════════════════════
  // REPORT WRITING EFFICIENCY FACTORIES
  // ═══════════════════════════════════════

  static ReportWritingEfficiencyRecord fakeReportWritingRecord({
    String? id,
    DateTime? date,
    String machineNumber = 'Frame Machine 1',
    String shift = 'Day Shift',
    DateTime? submittedAt,
    DateTime? shiftEndTime,
    int score = 5,
    String operatorId = 'op-1',
  }) {
    return ReportWritingEfficiencyRecord(
      id: id,
      date: date ?? DateTime(2026, 3, 15),
      machineNumber: machineNumber,
      shift: shift,
      submittedAt: submittedAt ?? DateTime(2026, 3, 15, 21, 30),
      shiftEndTime: shiftEndTime ?? DateTime(2026, 3, 15, 21, 0),
      score: score,
      operatorId: operatorId,
    );
  }

  // ═══════════════════════════════════════
  // CUSTOMER REJECTION FACTORIES
  // ═══════════════════════════════════════

  static FrameCustomerRejectionReport fakeCustomerRejection({
    String? id,
    DateTime? originalProductionDate,
    DateTime? rejectionDate,
    String machineNumber = 'Frame Machine 1',
    String shift = 'Day Shift',
    List<FrameProductionLineItem>? rejectedItems,
    double totalRejectedWeight = 48.6,
    String createdBy = 'fso-1',
  }) {
    return FrameCustomerRejectionReport(
      id: id,
      originalProductionDate: originalProductionDate ?? DateTime(2026, 3, 14),
      rejectionDate: rejectionDate ?? DateTime(2026, 3, 15),
      machineNumber: machineNumber,
      shift: shift,
      rejectedItems:
          rejectedItems ?? [fakeFrameLineItem(quantity: 10, totalWeight: 48.6)],
      totalRejectedWeight: totalRejectedWeight,
      createdBy: createdBy,
    );
  }

  // ═══════════════════════════════════════
  // SHEET PRODUCTION FACTORIES
  // ═══════════════════════════════════════

  static SheetProductionLineItem fakeSheetLineItem({
    String thickness = '9mm',
    String density = '0.55',
    String color = 'Brown',
    double length = 96,
    double width = 48,
    int quantity = 50,
    double sqft = 32.0,
    double perPieceWeight = 10.56,
    double totalWeight = 528.0,
    double totalRunningFeet = 400.0,
    DateTime? timeOfChange,
    double? manualWeightPerSqft,
  }) {
    return SheetProductionLineItem(
      thickness: thickness,
      density: density,
      color: color,
      length: length,
      width: width,
      quantity: quantity,
      sqft: sqft,
      perPieceWeight: perPieceWeight,
      totalWeight: totalWeight,
      totalRunningFeet: totalRunningFeet,
      timeOfChange: timeOfChange,
      manualWeightPerSqft: manualWeightPerSqft,
    );
  }

  static SheetProductionDetailsReport fakeSheetProductionReport({
    String? id,
    DateTime? date,
    String machineNumber = 'Sheet Machine 3',
    String shift = 'Day Shift',
    List<SheetProductionLineItem>? lineItems,
    int totalQuantity = 50,
    double totalWeight = 528.0,
    double totalRunningFeet = 400.0,
    String createdBy = 'op-2',
  }) {
    return SheetProductionDetailsReport(
      id: id,
      date: date ?? DateTime(2026, 3, 15),
      machineNumber: machineNumber,
      shift: shift,
      lineItems: lineItems ?? [fakeSheetLineItem()],
      totalQuantity: totalQuantity,
      totalWeight: totalWeight,
      totalRunningFeet: totalRunningFeet,
      createdBy: createdBy,
    );
  }

  static SheetPackingLineItem fakeSheetPackingItem({
    String thickness = '9mm',
    String density = '0.55',
    String color = 'Brown',
    double length = 96,
    double width = 48,
    int productionQuantity = 52,
    double perPieceWeight = 10.56,
    double runningFeetPerItem = 8.0,
    int packed = 20,
    int onlySanding = 28,
    int sandingAndPacked = 2,
    int rejectedQuality = 2,
  }) {
    return SheetPackingLineItem(
      thickness: thickness,
      density: density,
      color: color,
      length: length,
      width: width,
      productionQuantity: productionQuantity,
      perPieceWeight: perPieceWeight,
      runningFeetPerItem: runningFeetPerItem,
      packed: packed,
      onlySanding: onlySanding,
      sandingAndPacked: sandingAndPacked,
      rejectedQuality: rejectedQuality,
    );
  }

  // ═══════════════════════════════════════
  // SALARY FACTORIES
  // ═══════════════════════════════════════

  static SalaryCalculation fakeSalaryCalculation({
    String? id,
    String operatorId = 'op-1',
    String operatorName = 'Test Operator',
    int year = 2026,
    int month = 3,
    double a = 80,
    double b = 90,
    double c = 75,
    double d = 85,
    double e = 70,
    double f = 60,
    double wA = 10,
    double wB = 10,
    double wC = 30,
    double wD = 20,
    double wE = 20,
    double wF = 10,
    double multiplier = 0.765,
    double fixedSalary = 50000,
    double calculatedSalary = 38250,
  }) {
    return SalaryCalculation(
      id: id,
      operatorId: operatorId,
      operatorName: operatorName,
      year: year,
      month: month,
      a: a,
      b: b,
      c: c,
      d: d,
      e: e,
      f: f,
      wA: wA,
      wB: wB,
      wC: wC,
      wD: wD,
      wE: wE,
      wF: wF,
      multiplier: multiplier,
      fixedSalary: fixedSalary,
      calculatedSalary: calculatedSalary,
    );
  }

  static SalaryWeightages fakeWeightages({
    double wA = 10,
    double wB = 10,
    double wC = 30,
    double wD = 20,
    double wE = 20,
    double wF = 10,
  }) {
    return SalaryWeightages(wA: wA, wB: wB, wC: wC, wD: wD, wE: wE, wF: wF);
  }

  // ═══════════════════════════════════════
  // DASHBOARD FACTORIES
  // ═══════════════════════════════════════

  static DashboardSummary fakeDashboardSummary({
    int totalOperators = 10,
    int activeOperators = 8,
    int pendingApprovals = 3,
    double todayFrameWeight = 1200.0,
    double todaySheetRunningFeet = 3500.0,
    double avgFrameEfficiency = 85.5,
    double avgSheetEfficiency = 90.2,
  }) {
    return DashboardSummary(
      totalOperators: totalOperators,
      activeOperators: activeOperators,
      pendingApprovals: pendingApprovals,
      todayFrameWeight: todayFrameWeight,
      todaySheetRunningFeet: todaySheetRunningFeet,
      avgFrameEfficiency: avgFrameEfficiency,
      avgSheetEfficiency: avgSheetEfficiency,
      weeklyFrameProduction: List.generate(
        7,
        (i) => DailyProduction(
          date: DateTime(2026, 3, 9 + i),
          value: 1000 + (i * 50.0),
        ),
      ),
      weeklySheetProduction: List.generate(
        7,
        (i) => DailyProduction(
          date: DateTime(2026, 3, 9 + i),
          value: 3000 + (i * 100.0),
        ),
      ),
      frameStock: const StockSummary(
        totalProduced: 5000.0,
        totalPacked: 3500.0,
        totalRejected: 200.0,
        stockInPlace: 1300.0,
      ),
      sheetStock: const StockSummary(
        totalProduced: 15000.0,
        totalPacked: 12000.0,
        totalRejected: 500.0,
        stockInPlace: 2500.0,
      ),
    );
  }

  // ═══════════════════════════════════════
  // MONTHLY AGGREGATE FACTORIES
  // ═══════════════════════════════════════

  static Map<String, double> fakeMonthlyAggregates({
    double a = 80,
    double b = 90,
    double c = 75,
    double d = 85,
    double e = 70,
    double f = 60,
  }) {
    return {
      'machineCleaningAvg': a,
      'toolsCountAvg': b,
      'productionEfficiencyAvg': c,
      'qualityAcceptanceAvg': d,
      'packingEfficiencyAvg': e,
      'reportWritingEfficiencyAvg': f,
    };
  }
}
