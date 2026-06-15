import '../../domain/entities/admin_entities.dart';
import '../../domain/repositories/admin_repository.dart';
import '../datasources/admin_remote_datasource.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDatasource _datasource;

  AdminRepositoryImpl(this._datasource);

  @override
  Future<List<ManagedUser>> getAllUsers() => _datasource.getAllUsers();

  @override
  Future<ManagedUser> getUserById(String uid) => _datasource.getUserById(uid);

  @override
  Future<void> createUser({
    required String name,
    required String phone,
    required String password,
    required List<String> roles,
    required List<String> assignedMachines,
    required double fixedSalary,
  }) => _datasource.createUser(
    name: name,
    phone: phone,
    password: password,
    roles: roles,
    assignedMachines: assignedMachines,
    fixedSalary: fixedSalary,
  );

  @override
  Future<void> updateUser(ManagedUser user) => _datasource.updateUser(user);

  @override
  Future<void> toggleUserActive(String uid, bool isActive) =>
      _datasource.toggleUserActive(uid, isActive);

  // ── Master Dropdown Tables ──

  @override
  Future<List<MasterTableItem>> getMasterTable(MasterTableType tableType) =>
      _datasource.getMasterTable(tableType);

  @override
  Future<void> insertMasterItem(
    MasterTableType tableType,
    MasterTableItem item,
  ) => _datasource.insertMasterItem(tableType, item);

  @override
  Future<void> updateMasterItem(
    MasterTableType tableType,
    MasterTableItem item,
  ) => _datasource.updateMasterItem(tableType, item);

  @override
  Future<void> deleteMasterItem(MasterTableType tableType, String id) =>
      _datasource.deleteMasterItem(tableType, id);

  // ── Master Lookup Tables ──

  @override
  Future<List<MasterWeightEntry>> getWeightTable(MasterLookupType type) =>
      _datasource.getWeightTable(type);

  @override
  Future<void> insertWeightEntry(
    MasterLookupType type,
    MasterWeightEntry entry,
  ) => _datasource.insertWeightEntry(type, entry);

  @override
  Future<void> updateWeightEntry(
    MasterLookupType type,
    MasterWeightEntry entry,
  ) => _datasource.updateWeightEntry(type, entry);

  @override
  Future<void> deleteWeightEntry(MasterLookupType type, String id) =>
      _datasource.deleteWeightEntry(type, id);

  @override
  Future<List<MasterTargetEntry>> getTargetTable(MasterLookupType type) =>
      _datasource.getTargetTable(type);

  @override
  Future<void> insertTargetEntry(
    MasterLookupType type,
    MasterTargetEntry entry,
  ) => _datasource.insertTargetEntry(type, entry);

  @override
  Future<void> updateTargetEntry(
    MasterLookupType type,
    MasterTargetEntry entry,
  ) => _datasource.updateTargetEntry(type, entry);

  @override
  Future<void> deleteTargetEntry(MasterLookupType type, String id) =>
      _datasource.deleteTargetEntry(type, id);

  @override
  Future<List<MasterSalaryWeightageEntry>> getSalaryWeightages({
    String category = 'frame_sheet',
  }) => _datasource.getSalaryWeightages(category: category);

  @override
  Future<void> insertSalaryWeightage(MasterSalaryWeightageEntry entry) =>
      _datasource.insertSalaryWeightage(entry);

  @override
  Future<void> updateSalaryWeightage(MasterSalaryWeightageEntry entry) =>
      _datasource.updateSalaryWeightage(entry);

  @override
  Future<void> deleteSalaryWeightage(String id) =>
      _datasource.deleteSalaryWeightage(id);
}
