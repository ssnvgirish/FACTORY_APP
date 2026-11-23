import '../../features/admin/data/datasources/admin_remote_datasource.dart';
import '../../features/admin/domain/entities/admin_entities.dart';
import '../constants/app_constants.dart';

/// Seeds all master tables with data from [AppConstants].
/// Safe to run multiple times — duplicates are skipped.
class MasterTableSeeder {
  MasterTableSeeder._();

  static Future<String> seed(AdminRemoteDatasource ds) async {
    var inserted = 0;
    var skipped = 0;

    Future<void> run(Future<void> Function() fn) async {
      try {
        await fn();
        inserted++;
      } catch (_) {
        skipped++;
      }
    }

    Future<void> items(
      MasterTableType type,
      Iterable<String> values, {
      String? itemType,
      String Function(String)? displayName,
    }) async {
      var order = 0;
      for (final v in values) {
        await run(
          () => ds.insertMasterItem(
            type,
            MasterTableItem(
              id: '',
              value: v,
              type: itemType,
              displayName: displayName?.call(v),
              sortOrder: ++order,
              isActive: true,
            ),
          ),
        );
      }
    }

    // ── Machines (one running sort order across kinds) ──
    var order = 0;
    for (final entry in [
      ('frame', AppConstants.frameMachines),
      ('sheet', AppConstants.sheetMachines),
      ('scrap', AppConstants.scrapAllMachines),
    ]) {
      for (final m in entry.$2) {
        await run(
          () => ds.insertMasterItem(
            MasterTableType.machines,
            MasterTableItem(
              id: '',
              value: m,
              type: entry.$1,
              sortOrder: ++order,
              isActive: true,
            ),
          ),
        );
      }
    }

    await items(MasterTableType.shifts, AppConstants.shifts);
    await items(
      MasterTableType.roles,
      AppConstants.allRoles,
      displayName: (c) => AppConstants.roleDisplayNames[c] ?? c,
    );
    await items(MasterTableType.frameSections, AppConstants.defaultFrameSections);
    await items(MasterTableType.frameDensities, AppConstants.defaultFrameDensities);
    await items(MasterTableType.frameColors, AppConstants.defaultFrameColors);
    await items(MasterTableType.sheetThicknesses, AppConstants.defaultSheetThicknesses);
    await items(MasterTableType.sheetDensities, AppConstants.defaultSheetDensities);
    await items(MasterTableType.sheetColors, AppConstants.defaultSheetColors);

    // Maintenance items share one table; frame and scrap rows keep one running order.
    order = 0;
    for (final entry in [
      ('frame', AppConstants.defaultMaintenanceItems),
      ('scrap', AppConstants.scrapMaintenanceItems),
    ]) {
      for (final v in entry.$2) {
        await run(
          () => ds.insertMasterItem(
            MasterTableType.maintenanceItems,
            MasterTableItem(
              id: '',
              value: v,
              type: entry.$1,
              sortOrder: ++order,
              isActive: true,
            ),
          ),
        );
      }
    }
    await items(MasterTableType.scrapProducts, AppConstants.scrapProducts);

    // ── Lookup tables ──
    for (final section in AppConstants.defaultFrameWeights.entries) {
      for (final density in section.value.entries) {
        await run(
          () => ds.insertWeightEntry(
            MasterLookupType.frameWeights,
            MasterWeightEntry(id: '', key1: section.key, key2: density.key, weight: density.value),
          ),
        );
      }
    }
    for (final thickness in AppConstants.defaultSheetWeights.entries) {
      for (final density in thickness.value.entries) {
        await run(
          () => ds.insertWeightEntry(
            MasterLookupType.sheetWeights,
            MasterWeightEntry(id: '', key1: thickness.key, key2: density.key, weight: density.value),
          ),
        );
      }
    }
    for (final section in AppConstants.defaultFrameTargets.entries) {
      for (final density in section.value.entries) {
        await run(
          () => ds.insertTargetEntry(
            MasterLookupType.frameTargets,
            MasterTargetEntry(id: '', key: section.key, density: density.key, target: density.value),
          ),
        );
      }
    }
    for (final thickness in AppConstants.defaultSheetTargets.entries) {
      for (final density in thickness.value.entries) {
        await run(
          () => ds.insertTargetEntry(
            MasterLookupType.sheetTargets,
            MasterTargetEntry(id: '', key: thickness.key, density: density.key, target: density.value),
          ),
        );
      }
    }
    for (final entry in AppConstants.scrapTargetWeightPerHour.entries) {
      await run(
        () => ds.insertTargetEntry(
          MasterLookupType.scrapTargets,
          MasterTargetEntry(id: '', key: entry.key, target: entry.value),
        ),
      );
    }

    // ── Salary weightages ──
    const salaryLabels = {
      'wA': 'Machine Cleaning',
      'wB': 'Tools Count',
      'wC': 'Machine Health',
      'wD': 'Production Efficiency',
      'wE': 'Report Writing',
      'wF': 'Quality / Packing',
    };
    final existing = {
      'frame_sheet': (await ds.getSalaryWeightages()).map((e) => e.variable).toSet(),
      'scrap': (await ds.getSalaryWeightages(category: 'scrap')).map((e) => e.variable).toSet(),
    };
    Future<void> weightage(String category, String variable, String label, double pct) async {
      if (existing[category]!.contains(variable)) {
        skipped++;
        return;
      }
      await run(
        () => ds.insertSalaryWeightage(
          MasterSalaryWeightageEntry(
            id: '', variable: variable, label: label, category: category, percentage: pct,
          ),
        ),
      );
    }

    for (final e in AppConstants.defaultSalaryWeightages.entries) {
      await weightage('frame_sheet', e.key, salaryLabels[e.key] ?? e.key, e.value);
    }
    const scrapSalary = {'wA': 15.0, 'wB': 10.0, 'wE': 30.0, 'wF': 20.0, 'wG': 25.0};
    const scrapLabels = {
      'wA': 'Machine Cleaning %',
      'wB': 'Tools Count %',
      'wE': 'Production Efficiency %',
      'wF': 'Report Writing Efficiency %',
      'wG': 'Scrap Quality Rating %',
    };
    for (final e in scrapSalary.entries) {
      await weightage('scrap', e.key, scrapLabels[e.key] ?? e.key, e.value);
    }

    return 'Inserted: $inserted, Skipped (duplicates): $skipped';
  }
}
