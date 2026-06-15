import '../entities/admin_entities.dart';

abstract class AdminRepository {
  // User Management
  Future<List<ManagedUser>> getAllUsers();
  Future<ManagedUser> getUserById(String uid);
  Future<void> createUser({
    required String name,
    required String phone,
    required String password,
    required List<String> roles,
    required List<String> assignedMachines,
    required double fixedSalary,
  });
  Future<void> updateUser(ManagedUser user);
  Future<void> toggleUserActive(String uid, bool isActive);

  // ── Master Dropdown Tables ──
  Future<List<MasterTableItem>> getMasterTable(MasterTableType tableType);
  Future<void> insertMasterItem(
    MasterTableType tableType,
    MasterTableItem item,
  );
  Future<void> updateMasterItem(
    MasterTableType tableType,
    MasterTableItem item,
  );
  Future<void> deleteMasterItem(MasterTableType tableType, String id);

  // ── Master Lookup Tables ──
  Future<List<MasterWeightEntry>> getWeightTable(MasterLookupType type);
  Future<void> insertWeightEntry(
    MasterLookupType type,
    MasterWeightEntry entry,
  );
  Future<void> updateWeightEntry(
    MasterLookupType type,
    MasterWeightEntry entry,
  );
  Future<void> deleteWeightEntry(MasterLookupType type, String id);

  Future<List<MasterTargetEntry>> getTargetTable(MasterLookupType type);
  Future<void> insertTargetEntry(
    MasterLookupType type,
    MasterTargetEntry entry,
  );
  Future<void> updateTargetEntry(
    MasterLookupType type,
    MasterTargetEntry entry,
  );
  Future<void> deleteTargetEntry(MasterLookupType type, String id);

  Future<List<MasterSalaryWeightageEntry>> getSalaryWeightages({
    String category = 'frame_sheet',
  });
  Future<void> insertSalaryWeightage(MasterSalaryWeightageEntry entry);
  Future<void> updateSalaryWeightage(MasterSalaryWeightageEntry entry);
  Future<void> deleteSalaryWeightage(String id);
}
