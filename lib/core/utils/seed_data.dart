import 'package:firebase_data_connect/firebase_data_connect.dart';

import '../../generated/dataconnect/default.dart';
import '../../features/admin/domain/entities/admin_entities.dart';
import '../../features/admin/domain/repositories/admin_repository.dart';
import '../../features/frames/domain/entities/frame_entities.dart';
import '../../features/scrap_regrind/domain/entities/scrap_regrind_entities.dart';
import '../../features/scrap_regrind/domain/repositories/scrap_regrind_repository.dart';
import '../../features/frames/domain/repositories/frame_repository.dart';
import '../../features/salary/domain/entities/salary_entities.dart';
import '../../features/salary/domain/repositories/salary_repository.dart';
import '../../features/sheets/domain/entities/sheet_entities.dart';
import '../../features/sheets/domain/repositories/sheet_repository.dart';
import '../constants/app_constants.dart';
import '../di/injection.dart';

Future<void> seedSampleData() async {
  final frameRepo = sl<FrameRepository>();
  final sheetRepo = sl<SheetRepository>();
  final adminRepo = sl<AdminRepository>();
  final salaryRepo = sl<SalaryRepository>();
  final scrapRepo = sl<ScrapRegrindRepository>();
  final connector = DefaultConnector.instance;
  Timestamp toTimestamp(DateTime value) =>
      Timestamp(0, value.millisecondsSinceEpoch ~/ 1000);

  final sampleUsers = [
    {
      'id': 'op-1',
      'name': 'Ravi Kumar',
      'phone': '+911111111111',
      'password': '1234',
      'machines': ['Frame Machine 1'],
      'salary': 18000.0,
      'roles': ['machine_operator'],
    },
    {
      'id': 'op-2',
      'name': 'Suresh Yadav',
      'phone': '+912222222222',
      'password': '1234',
      'machines': ['Frame Machine 2'],
      'salary': 16000.0,
      'roles': ['machine_operator'],
    },
    {
      'id': 'op-3',
      'name': 'Amit Sharma',
      'phone': '+913333333333',
      'password': '1234',
      'machines': ['Sheet Machine 3'],
      'salary': 17500.0,
      'roles': ['machine_operator'],
    },
    {
      'id': 'op-4',
      'name': 'Deepak Verma',
      'phone': '+914444444444',
      'password': '1234',
      'machines': ['Sheet Machine 4'],
      'salary': 15500.0,
      'roles': ['machine_operator'],
    },
    {
      'id': 'qp-1',
      'name': 'Pooja Singh',
      'phone': '+915555555555',
      'password': '1234',
      'machines': <String>[],
      'salary': 22000.0,
      'roles': [AppConstants.roleQualityPacking],
    },
    {
      'id': 'scrap-op-1',
      'name': 'Imran Ali',
      'phone': '+916666666666',
      'password': '1234',
      'machines': [AppConstants.pulverizerMachine1],
      'salary': 17000.0,
      'roles': ['machine_operator'],
    },
    {
      'id': 'scrap-op-2',
      'name': 'Rakesh Das',
      'phone': '+917777777777',
      'password': '1234',
      'machines': [AppConstants.pulverizerMachine2],
      'salary': 16500.0,
      'roles': ['machine_operator'],
    },
  ];

  await connector
      .createUser(
        uid: 'admin-1',
        name: 'Admin',
        phone: '+910000000000',
        password: 'admin123',
        email: '',
        roles: ['admin', 'plant_manager'],
        assignedMachines: [],
        fixedSalary: 0,
        isActive: true,
      )
      .execute();

  for (final user in sampleUsers) {
    await connector
        .createUser(
          uid: user['id'] as String,
          name: user['name'] as String,
          phone: user['phone'] as String,
          password: user['password'] as String,
          email: '',
          roles: user['roles'] as List<String>,
          assignedMachines: user['machines'] as List<String>,
          fixedSalary: user['salary'] as double,
          isActive: true,
        )
        .execute();
  }

  // ══════════════════════════════════════
  // SEED MASTER TABLES TO DATABASE
  // ══════════════════════════════════════

  // Machines
  for (var i = 0; i < AppConstants.frameMachines.length; i++) {
    await adminRepo.insertMasterItem(
      MasterTableType.machines,
      MasterTableItem(
        id: '',
        value: AppConstants.frameMachines[i],
        type: 'frame',
        sortOrder: i + 1,
      ),
    );
  }
  for (var i = 0; i < AppConstants.sheetMachines.length; i++) {
    await adminRepo.insertMasterItem(
      MasterTableType.machines,
      MasterTableItem(
        id: '',
        value: AppConstants.sheetMachines[i],
        type: 'sheet',
        sortOrder: 10 + i,
      ),
    );
  }
  for (var i = 0; i < AppConstants.scrapAllMachines.length; i++) {
    await adminRepo.insertMasterItem(
      MasterTableType.machines,
      MasterTableItem(
        id: '',
        value: AppConstants.scrapAllMachines[i],
        type: 'scrap',
        sortOrder: 20 + i,
      ),
    );
  }

  // Shifts
  for (var i = 0; i < AppConstants.shifts.length; i++) {
    await adminRepo.insertMasterItem(
      MasterTableType.shifts,
      MasterTableItem(id: '', value: AppConstants.shifts[i], sortOrder: i + 1),
    );
  }

  // Roles
  for (var i = 0; i < AppConstants.allRoles.length; i++) {
    final code = AppConstants.allRoles[i];
    await adminRepo.insertMasterItem(
      MasterTableType.roles,
      MasterTableItem(
        id: '',
        value: code,
        displayName: AppConstants.roleDisplayNames[code],
        sortOrder: i + 1,
      ),
    );
  }

  // Frame sections, densities, colors
  for (var i = 0; i < AppConstants.defaultFrameSections.length; i++) {
    await adminRepo.insertMasterItem(
      MasterTableType.frameSections,
      MasterTableItem(
        id: '',
        value: AppConstants.defaultFrameSections[i],
        sortOrder: i + 1,
      ),
    );
  }
  for (var i = 0; i < AppConstants.defaultFrameDensities.length; i++) {
    await adminRepo.insertMasterItem(
      MasterTableType.frameDensities,
      MasterTableItem(
        id: '',
        value: AppConstants.defaultFrameDensities[i],
        sortOrder: i + 1,
      ),
    );
  }
  for (var i = 0; i < AppConstants.defaultFrameColors.length; i++) {
    await adminRepo.insertMasterItem(
      MasterTableType.frameColors,
      MasterTableItem(
        id: '',
        value: AppConstants.defaultFrameColors[i],
        sortOrder: i + 1,
      ),
    );
  }

  // Sheet thicknesses, densities, colors
  for (var i = 0; i < AppConstants.defaultSheetThicknesses.length; i++) {
    await adminRepo.insertMasterItem(
      MasterTableType.sheetThicknesses,
      MasterTableItem(
        id: '',
        value: AppConstants.defaultSheetThicknesses[i],
        sortOrder: i + 1,
      ),
    );
  }
  for (var i = 0; i < AppConstants.defaultSheetDensities.length; i++) {
    await adminRepo.insertMasterItem(
      MasterTableType.sheetDensities,
      MasterTableItem(
        id: '',
        value: AppConstants.defaultSheetDensities[i],
        sortOrder: i + 1,
      ),
    );
  }
  for (var i = 0; i < AppConstants.defaultSheetColors.length; i++) {
    await adminRepo.insertMasterItem(
      MasterTableType.sheetColors,
      MasterTableItem(
        id: '',
        value: AppConstants.defaultSheetColors[i],
        sortOrder: i + 1,
      ),
    );
  }

  // Maintenance items
  for (var i = 0; i < AppConstants.defaultMaintenanceItems.length; i++) {
    await adminRepo.insertMasterItem(
      MasterTableType.maintenanceItems,
      MasterTableItem(
        id: '',
        value: AppConstants.defaultMaintenanceItems[i],
        type: 'frame',
        sortOrder: i + 1,
      ),
    );
  }
  for (var i = 0; i < AppConstants.scrapMaintenanceItems.length; i++) {
    await adminRepo.insertMasterItem(
      MasterTableType.maintenanceItems,
      MasterTableItem(
        id: '',
        value: AppConstants.scrapMaintenanceItems[i],
        type: 'scrap',
        sortOrder: 100 + i,
      ),
    );
  }

  // Scrap products
  for (var i = 0; i < AppConstants.scrapProducts.length; i++) {
    await adminRepo.insertMasterItem(
      MasterTableType.scrapProducts,
      MasterTableItem(
        id: '',
        value: AppConstants.scrapProducts[i],
        sortOrder: i + 1,
      ),
    );
  }

  // Frame weight reference table (individual rows)
  for (final section in AppConstants.defaultFrameWeights.entries) {
    for (final density in section.value.entries) {
      await adminRepo.insertWeightEntry(
        MasterLookupType.frameWeights,
        MasterWeightEntry(
          id: '',
          key1: section.key,
          key2: density.key,
          weight: density.value,
        ),
      );
    }
  }

  final now = DateTime.now();

  // ── Frame Machine Cleaning Reports ──
  for (var i = 0; i < 5; i++) {
    final date = now.subtract(Duration(days: i * 3));
    final machine = i.isEven ? 'Frame Machine 1' : 'Frame Machine 2';
    final createdBy = machine == 'Frame Machine 1' ? 'op-1' : 'op-2';
    final mc = 7 + (i % 4); // 7-10
    final gc = 6 + (i % 5); // 6-10
    final moc = 8 + (i % 3); // 8-10
    final total = mc + gc + moc;
    await frameRepo.submitMachineCleaningReport(
      MachineCleaningReport(
        date: date,
        machineNumber: machine,
        machineCondition: mc,
        groundCondition: gc,
        mouldCondition: moc,
        totalScore: total,
        percentage: total / 30 * 100,
        createdBy: createdBy,
      ),
    );
  }

  // ── Frame Tools Count Reports ──
  for (var i = 0; i < 5; i++) {
    final date = now.subtract(Duration(days: i * 2));
    final machine = i.isEven ? 'Frame Machine 1' : 'Frame Machine 2';
    final createdBy = machine == 'Frame Machine 1' ? 'op-1' : 'op-2';
    final totalGiven = 80 + (i * 10);
    final totalAvailable = (totalGiven * (0.7 + (i % 3) * 0.1)).round();
    final pct = totalGiven == 0 ? 0.0 : (totalAvailable / totalGiven) * 100;
    await frameRepo.submitToolsCountReport(
      ToolsCountReport(
        date: date,
        machineNumber: machine,
        totalToolsGiven: totalGiven,
        totalToolsAvailable: totalAvailable,
        percentageAvailable: pct,
        createdBy: createdBy,
      ),
    );
  }

  // ── Frame Machine Health Reports ──
  const healthItems = [
    'Die Cleaning',
    'Generator Maintenance',
    'Hydraulic System',
    'Electrical System',
    'Cooling System',
    'Lubrication',
    'Safety Guards',
  ];
  for (var i = 0; i < 5; i++) {
    final date = now.subtract(Duration(days: i * 2));
    final machine = i.isEven ? 'Frame Machine 1' : 'Frame Machine 2';
    final shift = i.isEven ? 'Day Shift' : 'Night Shift';
    final createdBy = machine == 'Frame Machine 1' ? 'op-1' : 'op-2';
    final entry = FrameMaintenanceEntry(
      maintenanceItem: healthItems[i % healthItems.length],
      startTime: date.copyWith(hour: 8, minute: 0),
      endTime: date.copyWith(hour: 9, minute: 0),
      personDoingMaintenance: createdBy,
      description: 'Routine maintenance',
      durationHours: 1.0,
    );
    await frameRepo.submitMachineHealthReport(
      MachineHealthReport(
        date: date,
        machineNumber: machine,
        shift: shift,
        entries: [entry],
        totalMaintenanceDurationHours: 1.0,
        createdBy: createdBy,
        submittedAt: date,
      ),
    );
  }

  // ── Frame Production Details Reports ──
  for (var i = 0; i < 4; i++) {
    final date = now.subtract(Duration(days: i * 3));
    final machine = i.isEven ? 'Frame Machine 1' : 'Frame Machine 2';
    final shift = i.isEven ? 'Day Shift' : 'Night Shift';
    final createdBy = machine == 'Frame Machine 1' ? 'op-1' : 'op-2';
    final lineItems = [
      FrameProductionLineItem(
        section: '3x2',
        density: '0.75',
        color: 'Brown',
        length: 10.0,
        quantity: 50 + i * 10,
        perPieceWeight: 4.86,
        totalWeight: (50 + i * 10) * 4.86,
      ),
      FrameProductionLineItem(
        section: '4x2',
        density: '0.80',
        color: 'Ivory',
        length: 12.0,
        quantity: 30 + i * 5,
        perPieceWeight: 7.78,
        totalWeight: (30 + i * 5) * 7.78,
      ),
    ];
    final totalQty = lineItems.fold<int>(0, (s, li) => s + li.quantity);
    final totalWt = lineItems.fold<double>(0, (s, li) => s + li.totalWeight);
    await frameRepo.submitProductionDetailsReport(
      FrameProductionDetailsReport(
        date: date,
        machineNumber: machine,
        shift: shift,
        lineItems: lineItems,
        totalQuantity: totalQty,
        totalWeight: totalWt,
        createdBy: createdBy,
        submittedAt: date,
      ),
    );
  }

  // ── Frame Production Weight Reports ──
  for (var i = 0; i < 4; i++) {
    final date = now.subtract(Duration(days: i * 3));
    final machine = i.isEven ? 'Frame Machine 1' : 'Frame Machine 2';
    final shift = i.isEven ? 'Day Shift' : 'Night Shift';
    final createdBy = machine == 'Frame Machine 1' ? 'op-1' : 'op-2';
    final prodWeight = 480.0 + i * 50;
    final maintWeight = 200.0 + i * 30;
    final totalProd = prodWeight + maintWeight;
    final target = 1200.0;
    await frameRepo.submitProductionWeightReport(
      FrameProductionWeightReport(
        date: date,
        machineNumber: machine,
        shift: shift,
        productionWeight: prodWeight,
        maintenanceWeight: maintWeight,
        totalProductionWeight: totalProd,
        targetWeight: target,
        efficiencyPercentage: totalProd / target * 100,
        createdBy: createdBy,
      ),
    );
  }

  // ── Frame Shift Packing Reports ──
  for (var i = 0; i < 4; i++) {
    final date = now.subtract(Duration(days: i * 3));
    final machine = i.isEven ? 'Frame Machine 1' : 'Frame Machine 2';
    final shift = i.isEven ? 'Day Shift' : 'Night Shift';
    final qty = 50 + i * 10;
    final packed = qty - 2 - i;
    final rejected = 2 + i;
    final lineItems = [
      FramePackingLineItem(
        section: '3x2',
        density: '0.75',
        color: 'Brown',
        length: 10.0,
        productionQuantity: qty,
        perPieceWeight: 4.86,
        packed: packed,
        rejectedQuality: rejected,
      ),
    ];
    final totalRejWt = lineItems.fold<double>(
      0,
      (s, li) => s + li.rejectedWeight,
    );
    final totalProdWt = lineItems.fold<double>(
      0,
      (s, li) => s + li.productionQuantity * li.perPieceWeight,
    );
    await frameRepo.submitShiftPackingReport(
      FrameShiftPackingReport(
        date: date,
        machineNumber: machine,
        shift: shift,
        lineItems: lineItems,
        totalRejectedWeight: totalRejWt,
        qualityAcceptancePercentage: (1 - totalRejWt / totalProdWt) * 100,
        packingEfficiency:
            lineItems.fold<int>(0, (s, li) => s + li.packed) / qty * 100,
        createdBy: 'qp-1',
      ),
    );
  }

  // ── Frame Customer Rejection Reports ──
  for (var i = 0; i < 3; i++) {
    final origDate = now.subtract(Duration(days: 10 + i * 5));
    final machine = i.isEven ? 'Frame Machine 1' : 'Frame Machine 2';
    final rejectedItems = [
      FrameProductionLineItem(
        section: '4x2.5',
        density: '0.90',
        color: 'Brown',
        length: 10.0,
        quantity: 5 + i * 2,
        perPieceWeight: 9.22,
        totalWeight: (5 + i * 2) * 9.22,
      ),
    ];
    final totalRejWt = rejectedItems.fold<double>(
      0,
      (s, li) => s + li.totalWeight,
    );
    await frameRepo.submitCustomerRejectionReport(
      FrameCustomerRejectionReport(
        originalProductionDate: origDate,
        rejectionDate: origDate.add(const Duration(days: 2)),
        machineNumber: machine,
        shift: 'Day Shift',
        rejectedItems: rejectedItems,
        totalRejectedWeight: totalRejWt,
        createdBy: 'qp-1',
      ),
    );
  }

  // ── Frame Report Writing Efficiency ──
  for (var i = 0; i < 4; i++) {
    final date = now.subtract(Duration(days: i * 3));
    final machine = i.isEven ? 'Frame Machine 1' : 'Frame Machine 2';
    final shift = i.isEven ? 'Day Shift' : 'Night Shift';
    final operatorId = machine == 'Frame Machine 1' ? 'op-1' : 'op-2';
    final shiftEnd = shift == 'Day Shift'
        ? DateTime(date.year, date.month, date.day, 21)
        : DateTime(date.year, date.month, date.day + 1, 9);
    final submittedAt = shiftEnd.add(Duration(minutes: 20 + i * 15));

    await connector
        .createFrameWritingEfficiency(
          date: date,
          machineNumber: machine,
          shift: shift,
          shiftEndTime: toTimestamp(shiftEnd),
          score: 5 - (i % 2),
          operatorId: operatorId,
        )
        .submittedAt(toTimestamp(submittedAt))
        .execute();
  }

  // ══════════════════════════════════════
  // SHEET REPORTS
  // ══════════════════════════════════════

  // ── Sheet Cleaning Reports (uses same MachineCleaningReport entity) ──
  for (var i = 0; i < 5; i++) {
    final date = now.subtract(Duration(days: i * 2));
    final machine = i % 3 == 0
        ? 'Sheet Machine 3'
        : i % 3 == 1
        ? 'Sheet Machine 4'
        : 'Sheet Machine 5';
    final createdBy = machine == 'Sheet Machine 3' ? 'op-3' : 'op-4';
    final mc = 8 + (i % 3);
    final gc = 7 + (i % 4);
    final moc = 9 + (i % 2);
    final total = mc + gc + moc;
    await sheetRepo.submitMachineCleaningReport(
      MachineCleaningReport(
        date: date,
        machineNumber: machine,
        machineCondition: mc,
        groundCondition: gc,
        mouldCondition: moc,
        totalScore: total,
        percentage: total / 30 * 100,
        createdBy: createdBy,
      ),
    );
  }

  // ── Sheet Tools Count Reports ──
  for (var i = 0; i < 5; i++) {
    final date = now.subtract(Duration(days: i * 2));
    final machine = i.isEven ? 'Sheet Machine 3' : 'Sheet Machine 4';
    final createdBy = machine == 'Sheet Machine 3' ? 'op-3' : 'op-4';
    final totalGiven = 80 + (i * 10);
    final totalAvailable = (totalGiven * (0.7 + (i % 3) * 0.1)).round();
    final pct = totalGiven == 0 ? 0.0 : (totalAvailable / totalGiven) * 100;

    await sheetRepo.submitToolsCountReport(
      ToolsCountReport(
        date: date,
        machineNumber: machine,
        totalToolsGiven: totalGiven,
        totalToolsAvailable: totalAvailable,
        percentageAvailable: pct,
        createdBy: createdBy,
      ),
    );
  }

  // ── Sheet Machine Health Reports ──
  for (var i = 0; i < 4; i++) {
    final date = now.subtract(Duration(days: i * 3));
    final machine = i.isEven ? 'Sheet Machine 3' : 'Sheet Machine 4';
    final shift = i.isEven ? 'Day Shift' : 'Night Shift';
    final createdBy = machine == 'Sheet Machine 3' ? 'op-3' : 'op-4';
    final entry = FrameMaintenanceEntry(
      maintenanceItem: healthItems[i % healthItems.length],
      startTime: date.copyWith(hour: 8, minute: 0),
      endTime: date.copyWith(hour: 9, minute: 0),
      personDoingMaintenance: createdBy,
      description: 'Routine maintenance',
      durationHours: 1.0,
    );

    await sheetRepo.submitMachineHealthReport(
      MachineHealthReport(
        date: date,
        machineNumber: machine,
        shift: shift,
        entries: [entry],
        totalMaintenanceDurationHours: 1.0,
        createdBy: createdBy,
        submittedAt: date,
      ),
    );
  }

  // ── Sheet Production Details Reports ──
  for (var i = 0; i < 4; i++) {
    final date = now.subtract(Duration(days: i * 3));
    final machine = i.isEven ? 'Sheet Machine 3' : 'Sheet Machine 4';
    final shift = i.isEven ? 'Day Shift' : 'Night Shift';
    final createdBy = machine == 'Sheet Machine 3' ? 'op-3' : 'op-4';
    final lineItems = [
      SheetProductionLineItem(
        thickness: '9mm',
        density: '0.55',
        color: 'Brown',
        length: 96.0,
        width: 48.0,
        quantity: 40 + i * 5,
        sqft: 32.0,
        perPieceWeight: 10.56,
        totalWeight: (40 + i * 5) * 10.56,
        totalRunningFeet: (40 + i * 5) * 8.0,
      ),
      SheetProductionLineItem(
        thickness: '12mm',
        density: '0.60',
        color: 'Ivory',
        length: 96.0,
        width: 48.0,
        quantity: 25 + i * 3,
        sqft: 32.0,
        perPieceWeight: 14.08,
        totalWeight: (25 + i * 3) * 14.08,
        totalRunningFeet: (25 + i * 3) * 8.0,
      ),
    ];
    final totalQty = lineItems.fold<int>(0, (s, li) => s + li.quantity);
    final totalWt = lineItems.fold<double>(0, (s, li) => s + li.totalWeight);
    final totalFt = lineItems.fold<double>(
      0,
      (s, li) => s + li.totalRunningFeet,
    );
    await sheetRepo.submitProductionDetailsReport(
      SheetProductionDetailsReport(
        date: date,
        machineNumber: machine,
        shift: shift,
        lineItems: lineItems,
        totalQuantity: totalQty,
        totalWeight: totalWt,
        totalRunningFeet: totalFt,
        createdBy: createdBy,
        submittedAt: date,
      ),
    );
  }

  // ── Sheet Production Running Feet Reports ──
  for (var i = 0; i < 4; i++) {
    final date = now.subtract(Duration(days: i * 3));
    final machine = i.isEven ? 'Sheet Machine 3' : 'Sheet Machine 4';
    final shift = i.isEven ? 'Day Shift' : 'Night Shift';
    final createdBy = machine == 'Sheet Machine 3' ? 'op-3' : 'op-4';
    final productionRunningFeet = 620.0 + i * 55;
    final maintenanceRunningFeet = 110.0 + i * 20;
    final totalProductionRunningFeet =
        productionRunningFeet + maintenanceRunningFeet;
    final targetRunningFeet = 900.0;

    await sheetRepo.submitProductionRunningFeetReport(
      SheetProductionRunningFeetReport(
        date: date,
        machineNumber: machine,
        shift: shift,
        productionRunningFeet: productionRunningFeet,
        maintenanceRunningFeet: maintenanceRunningFeet,
        totalProductionRunningFeet: totalProductionRunningFeet,
        targetRunningFeet: targetRunningFeet,
        efficiencyPercentage:
            totalProductionRunningFeet / targetRunningFeet * 100,
        createdBy: createdBy,
      ),
    );
  }

  // ── Sheet Shift Packing Reports ──
  for (var i = 0; i < 4; i++) {
    final date = now.subtract(Duration(days: i * 3));
    final machine = i.isEven ? 'Sheet Machine 3' : 'Sheet Machine 4';
    final shift = i.isEven ? 'Day Shift' : 'Night Shift';
    final totalProduced = 42 + i * 6;
    final packed = totalProduced - (2 + i);
    final rejectedQuality = 2 + (i % 3);
    final createdBy = 'qp-1';
    final lineItems = [
      SheetPackingLineItem(
        thickness: '9mm',
        density: '0.55',
        color: 'Brown',
        length: 96,
        width: 48,
        productionQuantity: totalProduced,
        perPieceWeight: 10.56,
        runningFeetPerItem: 8.0,
        packed: packed,
        onlySanding: 1,
        sandingAndPacked: packed - 1,
        rejectedQuality: rejectedQuality,
      ),
    ];
    final totalRejectedRunningFeet = lineItems.fold<double>(
      0,
      (sum, item) => sum + item.rejectedRunningFeet,
    );
    final totalProductionRunningFeet = lineItems.fold<double>(
      0,
      (sum, item) => sum + item.productionQuantity * item.runningFeetPerItem,
    );

    await sheetRepo.submitShiftPackingReport(
      SheetShiftPackingReport(
        date: date,
        machineNumber: machine,
        shift: shift,
        lineItems: lineItems,
        totalRejectedRunningFeet: totalRejectedRunningFeet,
        qualityAcceptancePercentage:
            (1 - totalRejectedRunningFeet / totalProductionRunningFeet) * 100,
        packingEfficiency:
            lineItems.fold<int>(0, (sum, item) => sum + item.packed) /
            totalProduced *
            100,
        createdBy: createdBy,
      ),
    );
  }

  // ── Sheet Report Writing Efficiency ──
  for (var i = 0; i < 4; i++) {
    final date = now.subtract(Duration(days: i * 3));
    final machine = i.isEven ? 'Sheet Machine 3' : 'Sheet Machine 4';
    final shift = i.isEven ? 'Day Shift' : 'Night Shift';
    final operatorId = machine == 'Sheet Machine 3' ? 'op-3' : 'op-4';
    final shiftEnd = shift == 'Day Shift'
        ? DateTime(date.year, date.month, date.day, 21)
        : DateTime(date.year, date.month, date.day + 1, 9);
    final submittedAt = shiftEnd.add(Duration(minutes: 25 + i * 12));

    await connector
        .createSheetWritingEfficiency(
          date: date,
          machineNumber: machine,
          shift: shift,
          shiftEndTime: toTimestamp(shiftEnd),
          score: 5 - (i % 2),
          operatorId: operatorId,
        )
        .submittedAt(toTimestamp(submittedAt))
        .execute();
  }

  // ── Sheet Customer Rejection Reports ──
  for (var i = 0; i < 3; i++) {
    final originalProductionDate = now.subtract(Duration(days: 8 + i * 4));
    final machine = i.isEven ? 'Sheet Machine 3' : 'Sheet Machine 4';
    final rejectedItems = [
      SheetProductionLineItem(
        thickness: '12mm',
        density: '0.60',
        color: 'Ivory',
        length: 96.0,
        width: 48.0,
        quantity: 3 + i,
        sqft: 32.0,
        perPieceWeight: 14.08,
        totalWeight: (3 + i) * 14.08,
        totalRunningFeet: (3 + i) * 8.0,
      ),
    ];
    final totalRejectedRunningFeet = rejectedItems.fold<double>(
      0,
      (sum, item) => sum + item.totalRunningFeet,
    );

    await sheetRepo.submitCustomerRejectionReport(
      SheetCustomerRejectionReport(
        originalProductionDate: originalProductionDate,
        machineNumber: machine,
        shift: 'Day Shift',
        rejectedItems: rejectedItems,
        totalRejectedRunningFeet: totalRejectedRunningFeet,
        createdBy: 'qp-1',
      ),
    );
  }

  // ══════════════════════════════════════
  // SCRAP REGRIND REPORTS
  // ══════════════════════════════════════

  for (var i = 0; i < 4; i++) {
    final date = now.subtract(Duration(days: i * 2));
    final machine = i.isEven
        ? AppConstants.pulverizerMachine1
        : AppConstants.pulverizerMachine2;
    final createdBy = machine == AppConstants.pulverizerMachine1
        ? 'scrap-op-1'
        : 'scrap-op-2';
    final machineCondition = 7 + (i % 3);
    final groundCondition = 8 + (i % 2);
    final totalScore = machineCondition + groundCondition;

    await scrapRepo.submitCleaningReport(
      ScrapCleaningReport(
        date: date,
        machineNumber: machine,
        machineCondition: machineCondition,
        groundCondition: groundCondition,
        totalScore: totalScore,
        percentage: totalScore / 20 * 100,
        createdBy: createdBy,
      ),
    );
  }

  for (var i = 0; i < 4; i++) {
    final date = now.subtract(Duration(days: i * 2));
    final machine = i.isEven
        ? AppConstants.pulverizerMachine1
        : AppConstants.pulverizerMachine2;
    final createdBy = machine == AppConstants.pulverizerMachine1
        ? 'scrap-op-1'
        : 'scrap-op-2';
    final totalToolsGiven = 20 + i;
    final totalToolsAvailable = totalToolsGiven - (1 + i % 2);

    await scrapRepo.submitToolsCountReport(
      ScrapToolsCountReport(
        date: date,
        machineNumber: machine,
        totalToolsGiven: totalToolsGiven,
        totalToolsAvailable: totalToolsAvailable,
        percentageAvailable: totalToolsAvailable / totalToolsGiven * 100,
        createdBy: createdBy,
      ),
    );
  }

  for (var i = 0; i < 3; i++) {
    final date = now.subtract(Duration(days: i * 3));
    final machine = i.isEven
        ? AppConstants.pulverizerMachine1
        : AppConstants.pulverizerMachine2;
    final shift = i.isEven ? 'Day Shift' : 'Night Shift';
    final createdBy = machine == AppConstants.pulverizerMachine1
        ? 'scrap-op-1'
        : 'scrap-op-2';
    final entries = [
      ScrapMaintenanceEntry(
        maintenanceItem: 'Blade replacement',
        startTime: DateTime(date.year, date.month, date.day, 9),
        endTime: DateTime(date.year, date.month, date.day, 10),
        personDoingMaintenance: createdBy,
        description: 'Routine blade replacement',
        durationHours: 1,
      ),
      ScrapMaintenanceEntry(
        maintenanceItem: 'Generator maintenance',
        startTime: DateTime(date.year, date.month, date.day, 11),
        endTime: DateTime(date.year, date.month, date.day, 12, 30),
        personDoingMaintenance: createdBy,
        description: 'Generator output check',
        durationHours: 1.5,
      ),
    ];

    await scrapRepo.submitMachineHealthReport(
      ScrapMachineHealthReport(
        date: date,
        machineNumber: machine,
        shift: shift,
        entries: entries,
        totalMaintenanceDurationHours: 2.5,
        createdBy: createdBy,
        submittedAt: date,
      ),
    );
  }

  for (var i = 0; i < 3; i++) {
    final date = now.subtract(Duration(days: i * 3));
    final machine = i.isEven
        ? AppConstants.pulverizerMachine1
        : AppConstants.pulverizerMachine2;
    final shift = i.isEven ? 'Day Shift' : 'Night Shift';
    final createdBy = machine == AppConstants.pulverizerMachine1
        ? 'scrap-op-1'
        : 'scrap-op-2';
    final lineItems = [
      ScrapProductionLineItem(
        product: AppConstants.framesBrownScrap,
        weightPerBag: 25,
        totalBags: 14 + i,
        totalWeight: 25.0 * (14 + i),
      ),
      ScrapProductionLineItem(
        product: AppConstants.sheetsIvoryScrap,
        weightPerBag: 20,
        totalBags: 10 + i,
        totalWeight: 20.0 * (10 + i),
      ),
    ];
    final totalProductionWeight = lineItems.fold<double>(
      0,
      (sum, item) => sum + item.totalWeight,
    );

    await scrapRepo.submitProductionDetailsReport(
      ScrapProductionDetailsReport(
        date: date,
        machineNumber: machine,
        shift: shift,
        lineItems: lineItems,
        totalProductionWeight: totalProductionWeight,
        createdBy: createdBy,
        submittedAt: date,
      ),
    );
  }

  for (var i = 0; i < 3; i++) {
    final date = now.subtract(Duration(days: i * 3));
    final machine = i.isEven
        ? AppConstants.pulverizerMachine1
        : AppConstants.pulverizerMachine2;
    final shift = i.isEven ? 'Day Shift' : 'Night Shift';
    final createdBy = machine == AppConstants.pulverizerMachine1
        ? 'scrap-op-1'
        : 'scrap-op-2';
    final totalProductionWeight = 520.0 + i * 45;
    final maintenanceWeight = 95.0 + i * 10;
    final totalWeight = totalProductionWeight + maintenanceWeight;
    const targetWeight = 820.0;

    await scrapRepo.submitProductionWeightReport(
      ScrapProductionWeightReport(
        date: date,
        machineNumber: machine,
        shift: shift,
        totalProductionWeight: totalProductionWeight,
        maintenanceWeight: maintenanceWeight,
        totalWeight: totalWeight,
        targetWeight: targetWeight,
        efficiencyPercentage: totalWeight / targetWeight * 100,
        createdBy: createdBy,
      ),
    );
  }

  for (var i = 0; i < 3; i++) {
    final date = now.subtract(Duration(days: i * 3));
    final machine = i.isEven
        ? AppConstants.pulverizerMachine1
        : AppConstants.pulverizerMachine2;
    final shift = i.isEven ? 'Day Shift' : 'Night Shift';
    final operatorId = machine == AppConstants.pulverizerMachine1
        ? 'scrap-op-1'
        : 'scrap-op-2';
    final shiftEnd = shift == 'Day Shift'
        ? DateTime(date.year, date.month, date.day, 21)
        : DateTime(date.year, date.month, date.day + 1, 9);
    final submittedAt = shiftEnd.add(Duration(minutes: 15 + i * 20));

    await connector
        .createScrapWritingEfficiency(
          date: date,
          machineNumber: machine,
          shift: shift,
          shiftEndTime: toTimestamp(shiftEnd),
          score: 5 - (i % 2),
          operatorId: operatorId,
        )
        .submittedAt(toTimestamp(submittedAt))
        .execute();
  }

  for (var i = 0; i < 4; i++) {
    final date = now.subtract(Duration(days: i * 2));
    final machine = i.isEven ? 'Frame Machine 1' : 'Sheet Machine 3';
    final shift = i.isEven ? 'Day Shift' : 'Night Shift';
    final product =
        AppConstants.scrapProducts[i % AppConstants.scrapProducts.length];

    await scrapRepo.submitScrapQualityReport(
      ScrapQualityReport(
        date: date,
        machineNumber: machine,
        shift: shift,
        product: product,
        qualityRating: 7 + (i % 3),
        createdBy: 'qp-1',
      ),
    );
  }

  // ══════════════════════════════════════
  // SEED SAMPLE OPERATOR USERS
  // ══════════════════════════════════════

  // ══════════════════════════════════════
  // SEED SALARY CALCULATIONS
  // ══════════════════════════════════════
  final currentMonth = now.month;
  final currentYear = now.year;

  for (final user in sampleUsers.where((user) {
    final machines = user['machines'] as List<String>;
    return machines.isNotEmpty &&
        (machines.first.startsWith('Frame') ||
            machines.first.startsWith('Sheet'));
  })) {
    final calculation = await salaryRepo.calculateSalary(
      user['id'] as String,
      currentYear,
      currentMonth,
    );
    await salaryRepo.saveSalaryCalculation(
      SalaryCalculation(
        operatorId: calculation.operatorId,
        operatorName: calculation.operatorName,
        year: calculation.year,
        month: calculation.month,
        a: calculation.a,
        b: calculation.b,
        c: calculation.c,
        d: calculation.d,
        e: calculation.e,
        f: calculation.f,
        wA: calculation.wA,
        wB: calculation.wB,
        wC: calculation.wC,
        wD: calculation.wD,
        wE: calculation.wE,
        wF: calculation.wF,
        multiplier: calculation.multiplier,
        fixedSalary: calculation.fixedSalary,
        calculatedSalary: calculation.calculatedSalary,
      ),
    );
  }
}
