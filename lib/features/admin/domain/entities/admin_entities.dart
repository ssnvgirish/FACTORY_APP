import 'package:equatable/equatable.dart';

class ManagedUser extends Equatable {
  final String uid;
  final String name;
  final String phone;
  final String email;
  final List<String> roles;
  final List<String> assignedMachines;
  final double fixedSalary;
  final bool isActive;

  const ManagedUser({
    required this.uid,
    required this.name,
    this.phone = '',
    this.email = '',
    required this.roles,
    required this.assignedMachines,
    required this.fixedSalary,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
    uid,
    name,
    phone,
    email,
    roles,
    assignedMachines,
    fixedSalary,
    isActive,
  ];
}

/// Generic row in any master dropdown table.
class MasterTableItem extends Equatable {
  final String id;
  final String value; // the display name / code
  final String?
  type; // optional type/category column (machine type, maintenance category …)
  final String?
  displayName; // optional separate display label (e.g. Role displayName)
  final int sortOrder;
  final bool isActive;

  const MasterTableItem({
    required this.id,
    required this.value,
    this.type,
    this.displayName,
    this.sortOrder = 0,
    this.isActive = true,
  });

  MasterTableItem copyWith({
    String? id,
    String? value,
    String? type,
    String? displayName,
    int? sortOrder,
    bool? isActive,
  }) {
    return MasterTableItem(
      id: id ?? this.id,
      value: value ?? this.value,
      type: type ?? this.type,
      displayName: displayName ?? this.displayName,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [
    id,
    value,
    type,
    displayName,
    sortOrder,
    isActive,
  ];
}

/// Row in a weight lookup table (frame or sheet).
class MasterWeightEntry extends Equatable {
  final String id;
  final String key1; // section (frame) or thickness (sheet)
  final String key2; // density
  final double weight;

  const MasterWeightEntry({
    required this.id,
    required this.key1,
    required this.key2,
    required this.weight,
  });

  @override
  List<Object?> get props => [id, key1, key2, weight];
}

/// Row in a production-target table.
class MasterTargetEntry extends Equatable {
  final String id;
  final String key; // section (frame) or thickness (sheet) or product (scrap)
  final String? density; // non-null for frame/sheet targets; null for scrap
  final double target;

  const MasterTargetEntry({
    required this.id,
    required this.key,
    this.density,
    required this.target,
  });

  @override
  List<Object?> get props => [id, key, density, target];
}

/// Row in the salary-weightage table.
class MasterSalaryWeightageEntry extends Equatable {
  final String id;
  final String variable; // wA, wB, …
  final String label;
  final String category; // "frame_sheet" or "scrap"
  final double percentage;

  const MasterSalaryWeightageEntry({
    required this.id,
    required this.variable,
    required this.label,
    required this.category,
    required this.percentage,
  });

  @override
  List<Object?> get props => [id, variable, label, category, percentage];
}

/// Identifies which master table a list of [MasterTableItem]s belongs to.
enum MasterTableType {
  machines,
  shifts,
  roles,
  frameSections,
  frameDensities,
  frameColors,
  sheetThicknesses,
  sheetDensities,
  sheetColors,
  maintenanceItems,
  scrapProducts,
}

/// Identifies which lookup table is being viewed / edited.
enum MasterLookupType {
  frameWeights,
  sheetWeights,
  frameTargets,
  sheetTargets,
  salaryWeightages,
  scrapTargets,
}
