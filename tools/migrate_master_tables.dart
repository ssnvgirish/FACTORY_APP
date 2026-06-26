/// Migrates data from old DropdownConfig/ReferenceTable documents
/// into the new relational master tables.
///
/// Usage:
///   cd factory_app
///   dart run tools/migrate_master_tables.dart
///
/// Safe to run multiple times — unique constraints will skip duplicates.

import 'package:firebase_core/firebase_core.dart';
import '../lib/firebase_options.dart';
import '../lib/generated/dataconnect/default.dart';
import '../lib/core/constants/app_constants.dart';

Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final c = DefaultConnector.instance;

  print('═══════════════════════════════════════');
  print('  Migrating data to Master Tables');
  print('═══════════════════════════════════════');

  // ── Machines ──
  print('\n── Machines ──');
  var order = 0;
  for (final m in AppConstants.frameMachines) {
    await _run(
      'Frame: $m',
      () => c
          .insertMasterMachine(
            name: m,
            type: 'frame',
            sortOrder: ++order,
            isActive: true,
          )
          .execute(),
    );
  }
  for (final m in AppConstants.sheetMachines) {
    await _run(
      'Sheet: $m',
      () => c
          .insertMasterMachine(
            name: m,
            type: 'sheet',
            sortOrder: ++order,
            isActive: true,
          )
          .execute(),
    );
  }
  for (final m in AppConstants.scrapAllMachines) {
    await _run(
      'Scrap: $m',
      () => c
          .insertMasterMachine(
            name: m,
            type: 'scrap',
            sortOrder: ++order,
            isActive: true,
          )
          .execute(),
    );
  }

  // ── Shifts ──
  print('\n── Shifts ──');
  order = 0;
  for (final s in AppConstants.shifts) {
    await _run(
      s,
      () => c
          .insertMasterShift(name: s, sortOrder: ++order, isActive: true)
          .execute(),
    );
  }

  // ── Roles ──
  print('\n── Roles ──');
  order = 0;
  for (final code in AppConstants.allRoles) {
    final display = AppConstants.roleDisplayNames[code] ?? code;
    await _run(
      code,
      () => c
          .insertMasterRole(
            code: code,
            displayName: display,
            sortOrder: ++order,
            isActive: true,
          )
          .execute(),
    );
  }

  // ── Frame Sections ──
  print('\n── Frame Sections ──');
  order = 0;
  for (final v in AppConstants.defaultFrameSections) {
    await _run(
      v,
      () => c
          .insertMasterFrameSection(name: v, sortOrder: ++order, isActive: true)
          .execute(),
    );
  }

  // ── Frame Densities ──
  print('\n── Frame Densities ──');
  order = 0;
  for (final v in AppConstants.defaultFrameDensities) {
    await _run(
      v,
      () => c
          .insertMasterFrameDensity(
            value: v,
            sortOrder: ++order,
            isActive: true,
          )
          .execute(),
    );
  }

  // ── Frame Colors ──
  print('\n── Frame Colors ──');
  order = 0;
  for (final v in AppConstants.defaultFrameColors) {
    await _run(
      v,
      () => c
          .insertMasterFrameColor(name: v, sortOrder: ++order, isActive: true)
          .execute(),
    );
  }

  // ── Sheet Thicknesses ──
  print('\n── Sheet Thicknesses ──');
  order = 0;
  for (final v in AppConstants.defaultSheetThicknesses) {
    await _run(
      v,
      () => c
          .insertMasterSheetThickness(
            value: v,
            sortOrder: ++order,
            isActive: true,
          )
          .execute(),
    );
  }

  // ── Sheet Densities ──
  print('\n── Sheet Densities ──');
  order = 0;
  for (final v in AppConstants.defaultSheetDensities) {
    await _run(
      v,
      () => c
          .insertMasterSheetDensity(
            value: v,
            sortOrder: ++order,
            isActive: true,
          )
          .execute(),
    );
  }

  // ── Sheet Colors ──
  print('\n── Sheet Colors ──');
  order = 0;
  for (final v in AppConstants.defaultSheetColors) {
    await _run(
      v,
      () => c
          .insertMasterSheetColor(name: v, sortOrder: ++order, isActive: true)
          .execute(),
    );
  }

  // ── Maintenance Items (frame + scrap) ──
  print('\n── Maintenance Items ──');
  order = 0;
  for (final v in AppConstants.defaultMaintenanceItems) {
    await _run(
      'frame: $v',
      () => c
          .insertMasterMaintenanceItem(
            name: v,
            category: 'frame',
            sortOrder: ++order,
            isActive: true,
          )
          .execute(),
    );
  }
  for (final v in AppConstants.scrapMaintenanceItems) {
    await _run(
      'scrap: $v',
      () => c
          .insertMasterMaintenanceItem(
            name: v,
            category: 'scrap',
            sortOrder: ++order,
            isActive: true,
          )
          .execute(),
    );
  }

  // ── Scrap Products ──
  print('\n── Scrap Products ──');
  order = 0;
  for (final v in AppConstants.scrapProducts) {
    await _run(
      v,
      () => c
          .insertMasterScrapProduct(name: v, sortOrder: ++order, isActive: true)
          .execute(),
    );
  }

  // ═══════════════════════════════════════
  // LOOKUP / WEIGHT / TARGET TABLES
  // ═══════════════════════════════════════

  // ── Frame Weights (section × density → weight per foot) ──
  print('\n── Frame Weights ──');
  for (final section in AppConstants.defaultFrameWeights.entries) {
    for (final density in section.value.entries) {
      await _run(
        '${section.key} × ${density.key}',
        () => c
            .insertMasterFrameWeight(
              section: section.key,
              density: density.key,
              weightPerFoot: density.value,
            )
            .execute(),
      );
    }
  }

  // ── Sheet Weights (thickness × density → weight per sqft) ──
  print('\n── Sheet Weights ──');
  for (final entry in AppConstants.defaultSheetWeightsFlat.entries) {
    final parts = entry.key.split('|');
    if (parts.length == 2) {
      await _run(
        '${parts[0]} × ${parts[1]}',
        () => c
            .insertMasterSheetWeight(
              thickness: parts[0],
              density: parts[1],
              weightPerSqft: entry.value,
            )
            .execute(),
      );
    }
  }

  // ── Frame Production Targets ──
  print('\n── Frame Targets ──');
  for (final entry in AppConstants.defaultFrameTargets.entries) {
    await _run(
      entry.key,
      () => c
          .insertMasterFrameTarget(
            section: entry.key,
            density: '0.80',
            targetKgPerHour: entry.value,
          )
          .execute(),
    );
  }

  // ── Sheet Production Targets ──
  print('\n── Sheet Targets ──');
  for (final entry in AppConstants.defaultSheetTargets.entries) {
    await _run(
      entry.key,
      () => c
          .insertMasterSheetTarget(
            thickness: entry.key,
            density: '0.60',
            targetFeetPerHour: entry.value,
          )
          .execute(),
    );
  }

  // ── Scrap Production Targets ──
  print('\n── Scrap Targets ──');
  for (final entry in AppConstants.scrapTargetWeightPerHour.entries) {
    await _run(
      entry.key,
      () => c
          .insertMasterScrapTarget(
            product: entry.key,
            targetKgPerHour: entry.value,
          )
          .execute(),
    );
  }

  // ── Salary Weightages (frame_sheet) ──
  print('\n── Salary Weightages (frame_sheet) ──');
  final salaryLabels = {
    'wA': 'Machine Cleaning',
    'wB': 'Tools Count',
    'wC': 'Machine Health',
    'wD': 'Production Efficiency',
    'wE': 'Report Writing',
    'wF': 'Quality / Packing',
  };
  for (final entry in AppConstants.defaultSalaryWeightages.entries) {
    await _run(
      '${entry.key}: ${entry.value}%',
      () => c
          .insertMasterSalaryWeightage(
            variable: entry.key,
            label: salaryLabels[entry.key] ?? entry.key,
            category: 'frame_sheet',
            percentage: entry.value,
          )
          .execute(),
    );
  }

  // ── Salary Weightages (scrap) ──
  print('\n── Salary Weightages (scrap) ──');
  final scrapSalary = <String, double>{
    'wA': 15.0,
    'wB': 10.0,
    'wE': 30.0,
    'wF': 20.0,
    'wG': 25.0,
  };
  final scrapLabels = {
    'wA': 'Machine Cleaning %',
    'wB': 'Tools Count %',
    'wE': 'Production Efficiency %',
    'wF': 'Report Writing Efficiency %',
    'wG': 'Scrap Quality Rating %',
  };
  for (final entry in scrapSalary.entries) {
    await _run(
      '${entry.key}: ${entry.value}%',
      () => c
          .insertMasterSalaryWeightage(
            variable: entry.key,
            label: scrapLabels[entry.key] ?? entry.key,
            category: 'scrap',
            percentage: entry.value,
          )
          .execute(),
    );
  }

  print('\n═══════════════════════════════════════');
  print('  Migration Complete!');
  print('═══════════════════════════════════════');
}

Future<void> _run(String label, Future<void> Function() fn) async {
  try {
    await fn();
    print('  ✓ $label');
  } catch (e) {
    final msg = e.toString();
    if (msg.contains('unique') ||
        msg.contains('duplicate') ||
        msg.contains('already exists')) {
      print('  ○ $label (already exists)');
    } else {
      print('  ✗ $label: $msg');
    }
  }
}
