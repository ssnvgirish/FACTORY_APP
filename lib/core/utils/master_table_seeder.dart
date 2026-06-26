import '../../generated/dataconnect/default.dart';
import '../constants/app_constants.dart';

/// Seeds all master tables with data from [AppConstants].
/// Safe to run multiple times — duplicates are skipped (unique constraints).
class MasterTableSeeder {
  MasterTableSeeder._();

  static Future<String> seed() async {
    final c = DefaultConnector.instance;
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

    // ── Machines ──
    var order = 0;
    for (final m in AppConstants.frameMachines) {
      await run(
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
      await run(
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
      await run(
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
    order = 0;
    for (final s in AppConstants.shifts) {
      await run(
        () => c
            .insertMasterShift(name: s, sortOrder: ++order, isActive: true)
            .execute(),
      );
    }

    // ── Roles ──
    order = 0;
    for (final code in AppConstants.allRoles) {
      final display = AppConstants.roleDisplayNames[code] ?? code;
      await run(
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
    order = 0;
    for (final v in AppConstants.defaultFrameSections) {
      await run(
        () => c
            .insertMasterFrameSection(
              name: v,
              sortOrder: ++order,
              isActive: true,
            )
            .execute(),
      );
    }

    // ── Frame Densities ──
    order = 0;
    for (final v in AppConstants.defaultFrameDensities) {
      await run(
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
    order = 0;
    for (final v in AppConstants.defaultFrameColors) {
      await run(
        () => c
            .insertMasterFrameColor(name: v, sortOrder: ++order, isActive: true)
            .execute(),
      );
    }

    // ── Sheet Thicknesses ──
    order = 0;
    for (final v in AppConstants.defaultSheetThicknesses) {
      await run(
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
    order = 0;
    for (final v in AppConstants.defaultSheetDensities) {
      await run(
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
    order = 0;
    for (final v in AppConstants.defaultSheetColors) {
      await run(
        () => c
            .insertMasterSheetColor(name: v, sortOrder: ++order, isActive: true)
            .execute(),
      );
    }

    // ── Maintenance Items ──
    order = 0;
    for (final v in AppConstants.defaultMaintenanceItems) {
      await run(
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
      await run(
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
    order = 0;
    for (final v in AppConstants.scrapProducts) {
      await run(
        () => c
            .insertMasterScrapProduct(
              name: v,
              sortOrder: ++order,
              isActive: true,
            )
            .execute(),
      );
    }

    // ══════════════════════════════════════
    // LOOKUP TABLES
    // ══════════════════════════════════════

    // ── Frame Weights ──
    for (final section in AppConstants.defaultFrameWeights.entries) {
      for (final density in section.value.entries) {
        await run(
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

    // ── Sheet Weights ──
    for (final entry in AppConstants.defaultSheetWeightsFlat.entries) {
      final parts = entry.key.split('|');
      if (parts.length == 2) {
        await run(
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

    // ── Frame Targets ──
    // Frame/sheet targets now require both section/thickness AND density.
    // Seed each section with the most common frame density (0.80) as a starting
    // point; the admin can add density-specific entries via the reference tables.
    for (final entry in AppConstants.defaultFrameTargets.entries) {
      await run(
        () => c
            .insertMasterFrameTarget(
              section: entry.key,
              density: '0.80',
              targetKgPerHour: entry.value,
            )
            .execute(),
      );
    }

    // ── Sheet Targets ──
    // Seed each thickness with density 0.60 as a starting point.
    for (final entry in AppConstants.defaultSheetTargets.entries) {
      await run(
        () => c
            .insertMasterSheetTarget(
              thickness: entry.key,
              density: '0.60',
              targetFeetPerHour: entry.value,
            )
            .execute(),
      );
    }

    // ── Scrap Targets ──
    for (final entry in AppConstants.scrapTargetWeightPerHour.entries) {
      await run(
        () => c
            .insertMasterScrapTarget(
              product: entry.key,
              targetKgPerHour: entry.value,
            )
            .execute(),
      );
    }

    // ── Salary Weightages (frame_sheet) ──
    final salaryLabels = {
      'wA': 'Machine Cleaning',
      'wB': 'Tools Count',
      'wC': 'Machine Health',
      'wD': 'Production Efficiency',
      'wE': 'Report Writing',
      'wF': 'Quality / Packing',
    };
    for (final entry in AppConstants.defaultSalaryWeightages.entries) {
      await run(
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
      await run(
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

    return 'Inserted: $inserted, Skipped (duplicates): $skipped';
  }
}
