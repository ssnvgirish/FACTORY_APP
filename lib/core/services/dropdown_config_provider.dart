import '../../features/admin/domain/entities/admin_entities.dart';
import '../../features/admin/domain/repositories/admin_repository.dart';
import '../constants/app_constants.dart';
import '../di/injection.dart';

/// Shorthand to access the [DropdownConfigProvider] singleton.
DropdownConfigProvider get ddp => sl<DropdownConfigProvider>();

/// Loads dropdown values from individual master tables and provides them
/// app-wide.  Falls back to [AppConstants] defaults if the backend is
/// unavailable.
class DropdownConfigProvider {
  final AdminRepository _adminRepository;

  // Cached master-table rows keyed by MasterTableType.
  final Map<MasterTableType, List<MasterTableItem>> _dropdownCache = {};

  // Cached lookup tables.
  Map<String, Map<String, double>> _frameWeightsCache = {};
  Map<String, Map<String, double>> _sheetWeightsCache = {};
  Map<String, double> _frameTargetsCache = {};
  Map<String, double> _sheetTargetsCache = {};
  Map<String, double> _salaryWeightagesCache = {};
  Map<String, double> _scrapTargetsCache = {};
  bool _loaded = false;

  DropdownConfigProvider({required AdminRepository adminRepository})
    : _adminRepository = adminRepository;

  Future<void> load() async {
    try {
      // Load all dropdown master tables in parallel.
      final futures = MasterTableType.values.map((t) async {
        final items = await _adminRepository.getMasterTable(t);
        _dropdownCache[t] = items;
      });
      await Future.wait(futures);

      // Load lookup tables.
      await _loadWeightTable(
        MasterLookupType.frameWeights,
        (m) => _frameWeightsCache = m,
      );
      await _loadWeightTable(
        MasterLookupType.sheetWeights,
        (m) => _sheetWeightsCache = m,
      );
      await _loadTargetTable(
        MasterLookupType.frameTargets,
        (m) => _frameTargetsCache = m,
      );
      await _loadTargetTable(
        MasterLookupType.sheetTargets,
        (m) => _sheetTargetsCache = m,
      );
      await _loadTargetTable(
        MasterLookupType.scrapTargets,
        (m) => _scrapTargetsCache = m,
      );
      await _loadSalaryWeightages();

      _loaded = true;
    } catch (_) {
      _loaded = false;
    }
  }

  // ── Private helpers ──

  List<String> _activeValues(MasterTableType type, List<String> fallback) {
    final items = _dropdownCache[type];
    if (items == null || items.isEmpty) return fallback;
    return items.where((i) => i.isActive).map((i) => i.value).toList();
  }

  List<String> _activeValuesByType(
    MasterTableType type,
    String filterType,
    List<String> fallback,
  ) {
    final items = _dropdownCache[type];
    if (items == null || items.isEmpty) return fallback;
    return items
        .where((i) => i.isActive && i.type == filterType)
        .map((i) => i.value)
        .toList();
  }

  Future<void> _loadWeightTable(
    MasterLookupType type,
    void Function(Map<String, Map<String, double>>) assign,
  ) async {
    try {
      final entries = await _adminRepository.getWeightTable(type);
      if (entries.isNotEmpty) {
        final nested = <String, Map<String, double>>{};
        for (final e in entries) {
          nested.putIfAbsent(e.key1, () => {})[e.key2] = e.weight;
        }
        assign(nested);
      }
    } catch (_) {}
  }

  Future<void> _loadTargetTable(
    MasterLookupType type,
    void Function(Map<String, double>) assign,
  ) async {
    try {
      final entries = await _adminRepository.getTargetTable(type);
      if (entries.isNotEmpty) {
        // For frame/sheet targets, use "key|density" as the combined lookup key.
        // For scrap targets (no density), use just "key".
        assign({
          for (final e in entries)
            e.density != null ? '${e.key}|${e.density}' : e.key: e.target,
        });
      }
    } catch (_) {}
  }

  Future<void> _loadSalaryWeightages() async {
    try {
      final entries = await _adminRepository.getSalaryWeightages(
        category: 'frame_sheet',
      );
      if (entries.isNotEmpty) {
        _salaryWeightagesCache = {
          for (final e in entries) e.variable: e.percentage,
        };
      }
    } catch (_) {}
  }

  // ── Dropdown getters ──

  List<String> get frameMachines => _activeValuesByType(
    MasterTableType.machines,
    'frame',
    AppConstants.frameMachines,
  );

  List<String> get sheetMachines => _activeValuesByType(
    MasterTableType.machines,
    'sheet',
    AppConstants.sheetMachines,
  );

  List<String> get scrapMachines => _activeValuesByType(
    MasterTableType.machines,
    'scrap',
    AppConstants.scrapAllMachines,
  );

  List<String> get allMachines => [...frameMachines, ...sheetMachines];

  List<String> get shifts =>
      _activeValues(MasterTableType.shifts, AppConstants.shifts);

  List<String> get roles =>
      _activeValues(MasterTableType.roles, AppConstants.allRoles);

  Map<String, String> get roleDisplayNames {
    final items = _dropdownCache[MasterTableType.roles];
    if (items == null || items.isEmpty) return AppConstants.roleDisplayNames;
    return {
      for (final i in items.where((i) => i.isActive))
        i.value: i.displayName ?? i.value,
    };
  }

  List<String> get frameSections => _activeValues(
    MasterTableType.frameSections,
    AppConstants.defaultFrameSections,
  );

  List<String> get frameDensities => _activeValues(
    MasterTableType.frameDensities,
    AppConstants.defaultFrameDensities,
  );

  List<String> get frameColors => _activeValues(
    MasterTableType.frameColors,
    AppConstants.defaultFrameColors,
  );

  List<String> get sheetThicknesses => _activeValues(
    MasterTableType.sheetThicknesses,
    AppConstants.defaultSheetThicknesses,
  );

  List<String> get sheetDensities => _activeValues(
    MasterTableType.sheetDensities,
    AppConstants.defaultSheetDensities,
  );

  List<String> get sheetColors => _activeValues(
    MasterTableType.sheetColors,
    AppConstants.defaultSheetColors,
  );

  List<String> get maintenanceItems => _activeValuesByType(
    MasterTableType.maintenanceItems,
    'frame',
    AppConstants.defaultMaintenanceItems,
  );

  List<String> get scrapMaintenanceItems => _activeValuesByType(
    MasterTableType.maintenanceItems,
    'scrap',
    AppConstants.scrapMaintenanceItems,
  );

  List<String> get scrapProducts =>
      _activeValues(MasterTableType.scrapProducts, AppConstants.scrapProducts);

  // ── Lookup-table getters ──

  Map<String, Map<String, double>> get frameWeights =>
      _frameWeightsCache.isNotEmpty
      ? _frameWeightsCache
      : AppConstants.defaultFrameWeights;

  Map<String, Map<String, double>> get sheetWeights =>
      _sheetWeightsCache.isNotEmpty
      ? _sheetWeightsCache
      : AppConstants.defaultSheetWeights;

  Map<String, double> get frameTargets => _frameTargetsCache.isNotEmpty
      ? _frameTargetsCache
      : _nestedToFlat(AppConstants.defaultFrameTargets);

  Map<String, double> get sheetTargets => _sheetTargetsCache.isNotEmpty
      ? _sheetTargetsCache
      : _nestedToFlat(AppConstants.defaultSheetTargets);

  Map<String, double> get scrapTargets => _scrapTargetsCache.isNotEmpty
      ? _scrapTargetsCache
      : AppConstants.scrapTargetWeightPerHour;

  Map<String, double> get salaryWeightages => _salaryWeightagesCache.isNotEmpty
      ? _salaryWeightagesCache
      : AppConstants.defaultSalaryWeightages;

  bool get isLoaded => _loaded;

  /// Force reload from the backend.
  Future<void> refresh() async => load();

  /// Converts a nested `Map<key1, Map<key2, value>>` into a flat
  /// `Map<"key1|key2", value>` for use by [Calculations.calculateTargetWeight].
  static Map<String, double> _nestedToFlat(
    Map<String, Map<String, double>> nested,
  ) {
    final flat = <String, double>{};
    for (final outer in nested.entries) {
      for (final inner in outer.value.entries) {
        flat['${outer.key}|${inner.key}'] = inner.value;
      }
    }
    return flat;
  }
}
