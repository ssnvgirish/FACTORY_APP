import '../../domain/entities/admin_entities.dart';

class ManagedUserModel extends ManagedUser {
  const ManagedUserModel({
    required super.uid,
    required super.name,
    super.phone,
    super.email,
    required super.roles,
    required super.assignedMachines,
    required super.fixedSalary,
    required super.isActive,
  });

  factory ManagedUserModel.fromMap(
    Map<String, dynamic> data, {
    required String uid,
  }) {
    return ManagedUserModel(
      uid: uid,
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      email: data['email'] ?? '',
      roles: List<String>.from(data['roles'] ?? []),
      assignedMachines: List<String>.from(data['assignedMachines'] ?? []),
      fixedSalary: (data['fixedSalary'] ?? 0).toDouble(),
      isActive: data['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'phone': phone,
    'email': email,
    'roles': roles,
    'assignedMachines': assignedMachines,
    'fixedSalary': fixedSalary,
    'isActive': isActive,
  };
}
