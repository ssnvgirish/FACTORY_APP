import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String uid;
  final String name;
  final String phone;
  final String email;
  final List<String> roles;
  final List<String> assignedMachines;
  final double fixedSalary;
  final bool isActive;

  const AppUser({
    required this.uid,
    required this.name,
    this.phone = '',
    this.email = '',
    required this.roles,
    this.assignedMachines = const [],
    this.fixedSalary = 0,
    this.isActive = true,
  });

  bool get isMachineOperator => roles.contains('machine_operator');
  bool get isQualityPacking => roles.contains('quality_packing_supervisor');
  bool get isFramesSenior => roles.contains('frames_senior_operator');
  bool get isSheetSenior => roles.contains('sheet_senior_operator');
  bool get isPlantManager => roles.contains('plant_manager');
  bool get isAdmin => roles.contains('admin');

  bool get canAccessFrames =>
      isFramesSenior ||
      isPlantManager ||
      isAdmin ||
      (isMachineOperator &&
          assignedMachines.any((m) => m.startsWith('Frame'))) ||
      isQualityPacking;

  bool get canAccessSheets =>
      isSheetSenior ||
      isPlantManager ||
      isAdmin ||
      (isMachineOperator &&
          assignedMachines.any((m) => m.startsWith('Sheet'))) ||
      isQualityPacking;

  bool canAccessMachine(String machine) {
    if (isAdmin || isPlantManager) return true;
    if (isQualityPacking) return true;
    if (isFramesSenior && machine.startsWith('Frame')) return true;
    if (isSheetSenior && machine.startsWith('Sheet')) return true;
    if (isMachineOperator && assignedMachines.contains(machine)) return true;
    return false;
  }

  bool canEditReport(String evaluatedBy) {
    if (isAdmin || isPlantManager) return true;
    if (evaluatedBy == 'machine_operator' && isMachineOperator) return true;
    if (evaluatedBy == 'quality_packing_supervisor' && isQualityPacking) {
      return true;
    }
    if (evaluatedBy == 'frames_senior_operator' && isFramesSenior) return true;
    if (evaluatedBy == 'sheet_senior_operator' && isSheetSenior) return true;
    return false;
  }

  AppUser copyWith({
    String? uid,
    String? name,
    String? phone,
    String? email,
    List<String>? roles,
    List<String>? assignedMachines,
    double? fixedSalary,
    bool? isActive,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      roles: roles ?? this.roles,
      assignedMachines: assignedMachines ?? this.assignedMachines,
      fixedSalary: fixedSalary ?? this.fixedSalary,
      isActive: isActive ?? this.isActive,
    );
  }

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
