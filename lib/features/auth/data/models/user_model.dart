import '../../domain/entities/user_entity.dart';

class UserModel extends AppUser {
  const UserModel({
    required super.uid,
    required super.name,
    super.phone,
    super.email,
    required super.roles,
    super.assignedMachines,
    super.fixedSalary,
    super.isActive,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, {required String uid}) {
    return UserModel(
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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'roles': roles,
      'assignedMachines': assignedMachines,
      'fixedSalary': fixedSalary,
      'isActive': isActive,
    };
  }

  factory UserModel.fromEntity(AppUser user) {
    return UserModel(
      uid: user.uid,
      name: user.name,
      phone: user.phone,
      email: user.email,
      roles: user.roles,
      assignedMachines: user.assignedMachines,
      fixedSalary: user.fixedSalary,
      isActive: user.isActive,
    );
  }
}
