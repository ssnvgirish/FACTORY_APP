import '../../../../generated/dataconnect/default.dart';
import '../../domain/entities/admin_entities.dart';
import '../models/admin_models.dart';

class AdminRemoteDatasource {
  final DefaultConnector _connector;

  AdminRemoteDatasource({DefaultConnector? connector})
    : _connector = connector ?? DefaultConnector.instance;

  // ─── User Management ───
  Future<List<ManagedUserModel>> getAllUsers() async {
    final result = await _connector.listAllUsers().execute();
    return result.data.users
        .map(
          (u) => ManagedUserModel(
            uid: u.uid,
            name: u.name,
            phone: u.phone,
            email: u.email,
            roles: u.roles,
            assignedMachines: u.assignedMachines,
            fixedSalary: u.fixedSalary,
            isActive: u.isActive,
          ),
        )
        .toList();
  }

  Future<ManagedUserModel> getUserById(String uid) async {
    final result = await _connector.listAllUsers().execute();
    final match = result.data.users.where((u) => u.uid == uid);
    if (match.isEmpty) throw Exception('User not found');
    final u = match.first;
    return ManagedUserModel(
      uid: u.uid,
      name: u.name,
      phone: u.phone,
      email: u.email,
      roles: u.roles,
      assignedMachines: u.assignedMachines,
      fixedSalary: u.fixedSalary,
      isActive: u.isActive,
    );
  }

  Future<void> createUser({
    required String name,
    required String phone,
    required String password,
    required List<String> roles,
    required List<String> assignedMachines,
    required double fixedSalary,
  }) async {
    await _connector
        .createUser(
          uid: phone, // Use phone as uid for simplicity
          name: name,
          phone: phone,
          password: password,
          email: '',
          roles: roles,
          assignedMachines: assignedMachines,
          fixedSalary: fixedSalary,
          isActive: true,
        )
        .execute();
  }

  Future<void> updateUser(ManagedUser user) async {
    // Find the Data Connect key for this user by uid
    final allUsers = await _connector.listAllUsers().execute();
    final match = allUsers.data.users.where((u) => u.uid == user.uid);
    if (match.isEmpty) throw Exception('User not found');
    final dcId = match.first.id;

    await _connector
        .updateUser(
          id: UpdateUserVariablesId(id: dcId),
          name: user.name,
          phone: user.phone,
          roles: user.roles,
          assignedMachines: user.assignedMachines,
          fixedSalary: user.fixedSalary,
          isActive: user.isActive,
        )
        .execute();
  }

  Future<void> toggleUserActive(String uid, bool isActive) async {
    final allUsers = await _connector.listAllUsers().execute();
    final match = allUsers.data.users.where((u) => u.uid == uid);
    if (match.isEmpty) throw Exception('User not found');
    final dcId = match.first.id;

    await _connector
        .toggleUserActive(
          id: ToggleUserActiveVariablesId(id: dcId),
          isActive: isActive,
        )
        .execute();
  }

  // ─── Master Dropdown Tables ───

  Future<List<MasterTableItem>> getMasterTable(
    MasterTableType tableType,
  ) async {
    switch (tableType) {
      case MasterTableType.machines:
        final r = await _connector.listMasterMachines().execute();
        return r.data.masterMachines
            .map(
              (m) => MasterTableItem(
                id: m.id,
                value: m.name,
                type: m.type,
                sortOrder: m.sortOrder,
                isActive: m.isActive,
              ),
            )
            .toList();

      case MasterTableType.shifts:
        final r = await _connector.listMasterShifts().execute();
        return r.data.masterShifts
            .map(
              (m) => MasterTableItem(
                id: m.id,
                value: m.name,
                sortOrder: m.sortOrder,
                isActive: m.isActive,
              ),
            )
            .toList();

      case MasterTableType.roles:
        final r = await _connector.listMasterRoles().execute();
        return r.data.masterRoles
            .map(
              (m) => MasterTableItem(
                id: m.id,
                value: m.code,
                displayName: m.displayName,
                sortOrder: m.sortOrder,
                isActive: m.isActive,
              ),
            )
            .toList();

      case MasterTableType.frameSections:
        final r = await _connector.listMasterFrameSections().execute();
        return r.data.masterFrameSections
            .map(
              (m) => MasterTableItem(
                id: m.id,
                value: m.name,
                sortOrder: m.sortOrder,
                isActive: m.isActive,
              ),
            )
            .toList();

      case MasterTableType.frameDensities:
        final r = await _connector.listMasterFrameDensities().execute();
        return r.data.masterFrameDensities
            .map(
              (m) => MasterTableItem(
                id: m.id,
                value: m.value,
                sortOrder: m.sortOrder,
                isActive: m.isActive,
              ),
            )
            .toList();

      case MasterTableType.frameColors:
        final r = await _connector.listMasterFrameColors().execute();
        return r.data.masterFrameColors
            .map(
              (m) => MasterTableItem(
                id: m.id,
                value: m.name,
                sortOrder: m.sortOrder,
                isActive: m.isActive,
              ),
            )
            .toList();

      case MasterTableType.sheetThicknesses:
        final r = await _connector.listMasterSheetThicknesses().execute();
        return r.data.masterSheetThicknesses
            .map(
              (m) => MasterTableItem(
                id: m.id,
                value: m.value,
                sortOrder: m.sortOrder,
                isActive: m.isActive,
              ),
            )
            .toList();

      case MasterTableType.sheetDensities:
        final r = await _connector.listMasterSheetDensities().execute();
        return r.data.masterSheetDensities
            .map(
              (m) => MasterTableItem(
                id: m.id,
                value: m.value,
                sortOrder: m.sortOrder,
                isActive: m.isActive,
              ),
            )
            .toList();

      case MasterTableType.sheetColors:
        final r = await _connector.listMasterSheetColors().execute();
        return r.data.masterSheetColors
            .map(
              (m) => MasterTableItem(
                id: m.id,
                value: m.name,
                sortOrder: m.sortOrder,
                isActive: m.isActive,
              ),
            )
            .toList();

      case MasterTableType.maintenanceItems:
        final r = await _connector.listMasterMaintenanceItems().execute();
        return r.data.masterMaintenanceItems
            .map(
              (m) => MasterTableItem(
                id: m.id,
                value: m.name,
                type: m.category,
                sortOrder: m.sortOrder,
                isActive: m.isActive,
              ),
            )
            .toList();

      case MasterTableType.scrapProducts:
        final r = await _connector.listMasterScrapProducts().execute();
        return r.data.masterScrapProducts
            .map(
              (m) => MasterTableItem(
                id: m.id,
                value: m.name,
                sortOrder: m.sortOrder,
                isActive: m.isActive,
              ),
            )
            .toList();
    }
  }

  Future<void> insertMasterItem(
    MasterTableType tableType,
    MasterTableItem item,
  ) async {
    switch (tableType) {
      case MasterTableType.machines:
        await _connector
            .insertMasterMachine(
              name: item.value,
              type: item.type ?? 'frame',
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.shifts:
        await _connector
            .insertMasterShift(
              name: item.value,
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.roles:
        await _connector
            .insertMasterRole(
              code: item.value,
              displayName: item.displayName ?? item.value,
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.frameSections:
        await _connector
            .insertMasterFrameSection(
              name: item.value,
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.frameDensities:
        await _connector
            .insertMasterFrameDensity(
              value: item.value,
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.frameColors:
        await _connector
            .insertMasterFrameColor(
              name: item.value,
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.sheetThicknesses:
        await _connector
            .insertMasterSheetThickness(
              value: item.value,
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.sheetDensities:
        await _connector
            .insertMasterSheetDensity(
              value: item.value,
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.sheetColors:
        await _connector
            .insertMasterSheetColor(
              name: item.value,
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.maintenanceItems:
        await _connector
            .insertMasterMaintenanceItem(
              name: item.value,
              category: item.type ?? 'frame',
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.scrapProducts:
        await _connector
            .insertMasterScrapProduct(
              name: item.value,
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
    }
  }

  Future<void> updateMasterItem(
    MasterTableType tableType,
    MasterTableItem item,
  ) async {
    switch (tableType) {
      case MasterTableType.machines:
        await _connector
            .updateMasterMachine(
              id: UpdateMasterMachineVariablesId(id: item.id),
              name: item.value,
              type: item.type ?? 'frame',
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.shifts:
        await _connector
            .updateMasterShift(
              id: UpdateMasterShiftVariablesId(id: item.id),
              name: item.value,
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.roles:
        await _connector
            .updateMasterRole(
              id: UpdateMasterRoleVariablesId(id: item.id),
              code: item.value,
              displayName: item.displayName ?? item.value,
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.frameSections:
        await _connector
            .updateMasterFrameSection(
              id: UpdateMasterFrameSectionVariablesId(id: item.id),
              name: item.value,
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.frameDensities:
        await _connector
            .updateMasterFrameDensity(
              id: UpdateMasterFrameDensityVariablesId(id: item.id),
              value: item.value,
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.frameColors:
        await _connector
            .updateMasterFrameColor(
              id: UpdateMasterFrameColorVariablesId(id: item.id),
              name: item.value,
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.sheetThicknesses:
        await _connector
            .updateMasterSheetThickness(
              id: UpdateMasterSheetThicknessVariablesId(id: item.id),
              value: item.value,
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.sheetDensities:
        await _connector
            .updateMasterSheetDensity(
              id: UpdateMasterSheetDensityVariablesId(id: item.id),
              value: item.value,
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.sheetColors:
        await _connector
            .updateMasterSheetColor(
              id: UpdateMasterSheetColorVariablesId(id: item.id),
              name: item.value,
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.maintenanceItems:
        await _connector
            .updateMasterMaintenanceItem(
              id: UpdateMasterMaintenanceItemVariablesId(id: item.id),
              name: item.value,
              category: item.type ?? 'frame',
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
      case MasterTableType.scrapProducts:
        await _connector
            .updateMasterScrapProduct(
              id: UpdateMasterScrapProductVariablesId(id: item.id),
              name: item.value,
              sortOrder: item.sortOrder,
              isActive: item.isActive,
            )
            .execute();
    }
  }

  Future<void> deleteMasterItem(MasterTableType tableType, String id) async {
    switch (tableType) {
      case MasterTableType.machines:
        await _connector
            .deleteMasterMachine(id: DeleteMasterMachineVariablesId(id: id))
            .execute();
      case MasterTableType.shifts:
        await _connector
            .deleteMasterShift(id: DeleteMasterShiftVariablesId(id: id))
            .execute();
      case MasterTableType.roles:
        await _connector
            .deleteMasterRole(id: DeleteMasterRoleVariablesId(id: id))
            .execute();
      case MasterTableType.frameSections:
        await _connector
            .deleteMasterFrameSection(
              id: DeleteMasterFrameSectionVariablesId(id: id),
            )
            .execute();
      case MasterTableType.frameDensities:
        await _connector
            .deleteMasterFrameDensity(
              id: DeleteMasterFrameDensityVariablesId(id: id),
            )
            .execute();
      case MasterTableType.frameColors:
        await _connector
            .deleteMasterFrameColor(
              id: DeleteMasterFrameColorVariablesId(id: id),
            )
            .execute();
      case MasterTableType.sheetThicknesses:
        await _connector
            .deleteMasterSheetThickness(
              id: DeleteMasterSheetThicknessVariablesId(id: id),
            )
            .execute();
      case MasterTableType.sheetDensities:
        await _connector
            .deleteMasterSheetDensity(
              id: DeleteMasterSheetDensityVariablesId(id: id),
            )
            .execute();
      case MasterTableType.sheetColors:
        await _connector
            .deleteMasterSheetColor(
              id: DeleteMasterSheetColorVariablesId(id: id),
            )
            .execute();
      case MasterTableType.maintenanceItems:
        await _connector
            .deleteMasterMaintenanceItem(
              id: DeleteMasterMaintenanceItemVariablesId(id: id),
            )
            .execute();
      case MasterTableType.scrapProducts:
        await _connector
            .deleteMasterScrapProduct(
              id: DeleteMasterScrapProductVariablesId(id: id),
            )
            .execute();
    }
  }

  // ─── Master Lookup Tables ───

  Future<List<MasterWeightEntry>> getWeightTable(MasterLookupType type) async {
    switch (type) {
      case MasterLookupType.frameWeights:
        final r = await _connector.listMasterFrameWeights().execute();
        return r.data.masterFrameWeights
            .map(
              (w) => MasterWeightEntry(
                id: w.id,
                key1: w.section,
                key2: w.density,
                weight: w.weightPerFoot,
              ),
            )
            .toList();
      case MasterLookupType.sheetWeights:
        final r = await _connector.listMasterSheetWeights().execute();
        return r.data.masterSheetWeights
            .map(
              (w) => MasterWeightEntry(
                id: w.id,
                key1: w.thickness,
                key2: w.density,
                weight: w.weightPerSqft,
              ),
            )
            .toList();
      default:
        return [];
    }
  }

  Future<void> insertWeightEntry(
    MasterLookupType type,
    MasterWeightEntry entry,
  ) async {
    switch (type) {
      case MasterLookupType.frameWeights:
        await _connector
            .insertMasterFrameWeight(
              section: entry.key1,
              density: entry.key2,
              weightPerFoot: entry.weight,
            )
            .execute();
      case MasterLookupType.sheetWeights:
        await _connector
            .insertMasterSheetWeight(
              thickness: entry.key1,
              density: entry.key2,
              weightPerSqft: entry.weight,
            )
            .execute();
      default:
        break;
    }
  }

  Future<void> updateWeightEntry(
    MasterLookupType type,
    MasterWeightEntry entry,
  ) async {
    switch (type) {
      case MasterLookupType.frameWeights:
        await _connector
            .updateMasterFrameWeight(
              id: UpdateMasterFrameWeightVariablesId(id: entry.id),
              section: entry.key1,
              density: entry.key2,
              weightPerFoot: entry.weight,
            )
            .execute();
      case MasterLookupType.sheetWeights:
        await _connector
            .updateMasterSheetWeight(
              id: UpdateMasterSheetWeightVariablesId(id: entry.id),
              thickness: entry.key1,
              density: entry.key2,
              weightPerSqft: entry.weight,
            )
            .execute();
      default:
        break;
    }
  }

  Future<void> deleteWeightEntry(MasterLookupType type, String id) async {
    switch (type) {
      case MasterLookupType.frameWeights:
        await _connector
            .deleteMasterFrameWeight(
              id: DeleteMasterFrameWeightVariablesId(id: id),
            )
            .execute();
      case MasterLookupType.sheetWeights:
        await _connector
            .deleteMasterSheetWeight(
              id: DeleteMasterSheetWeightVariablesId(id: id),
            )
            .execute();
      default:
        break;
    }
  }

  Future<List<MasterTargetEntry>> getTargetTable(MasterLookupType type) async {
    switch (type) {
      case MasterLookupType.frameTargets:
        final r = await _connector.listMasterFrameTargets().execute();
        return r.data.masterFrameTargets
            .map(
              (t) => MasterTargetEntry(
                id: t.id,
                key: t.section,
                density: t.density,
                target: t.targetKgPerHour,
              ),
            )
            .toList();
      case MasterLookupType.sheetTargets:
        final r = await _connector.listMasterSheetTargets().execute();
        return r.data.masterSheetTargets
            .map(
              (t) => MasterTargetEntry(
                id: t.id,
                key: t.thickness,
                density: t.density,
                target: t.targetFeetPerHour,
              ),
            )
            .toList();
      case MasterLookupType.scrapTargets:
        final r = await _connector.listMasterScrapTargets().execute();
        return r.data.masterScrapTargets
            .map(
              (t) => MasterTargetEntry(
                id: t.id,
                key: t.product,
                target: t.targetKgPerHour,
              ),
            )
            .toList();
      default:
        return [];
    }
  }

  Future<void> insertTargetEntry(
    MasterLookupType type,
    MasterTargetEntry entry,
  ) async {
    switch (type) {
      case MasterLookupType.frameTargets:
        if (entry.density == null || entry.density!.isEmpty) {
          throw ArgumentError('Density is required for frame targets');
        }
        await _connector
            .insertMasterFrameTarget(
              section: entry.key,
              density: entry.density!,
              targetKgPerHour: entry.target,
            )
            .execute();
      case MasterLookupType.sheetTargets:
        if (entry.density == null || entry.density!.isEmpty) {
          throw ArgumentError('Density is required for sheet targets');
        }
        await _connector
            .insertMasterSheetTarget(
              thickness: entry.key,
              density: entry.density!,
              targetFeetPerHour: entry.target,
            )
            .execute();
      case MasterLookupType.scrapTargets:
        await _connector
            .insertMasterScrapTarget(
              product: entry.key,
              targetKgPerHour: entry.target,
            )
            .execute();
      default:
        break;
    }
  }

  Future<void> updateTargetEntry(
    MasterLookupType type,
    MasterTargetEntry entry,
  ) async {
    switch (type) {
      case MasterLookupType.frameTargets:
        if (entry.density == null || entry.density!.isEmpty) {
          throw ArgumentError('Density is required for frame targets');
        }
        await _connector
            .updateMasterFrameTarget(
              id: UpdateMasterFrameTargetVariablesId(id: entry.id),
              section: entry.key,
              density: entry.density!,
              targetKgPerHour: entry.target,
            )
            .execute();
      case MasterLookupType.sheetTargets:
        if (entry.density == null || entry.density!.isEmpty) {
          throw ArgumentError('Density is required for sheet targets');
        }
        await _connector
            .updateMasterSheetTarget(
              id: UpdateMasterSheetTargetVariablesId(id: entry.id),
              thickness: entry.key,
              density: entry.density!,
              targetFeetPerHour: entry.target,
            )
            .execute();
      case MasterLookupType.scrapTargets:
        await _connector
            .updateMasterScrapTarget(
              id: UpdateMasterScrapTargetVariablesId(id: entry.id),
              product: entry.key,
              targetKgPerHour: entry.target,
            )
            .execute();
      default:
        break;
    }
  }

  Future<void> deleteTargetEntry(MasterLookupType type, String id) async {
    switch (type) {
      case MasterLookupType.frameTargets:
        await _connector
            .deleteMasterFrameTarget(
              id: DeleteMasterFrameTargetVariablesId(id: id),
            )
            .execute();
      case MasterLookupType.sheetTargets:
        await _connector
            .deleteMasterSheetTarget(
              id: DeleteMasterSheetTargetVariablesId(id: id),
            )
            .execute();
      case MasterLookupType.scrapTargets:
        await _connector
            .deleteMasterScrapTarget(
              id: DeleteMasterScrapTargetVariablesId(id: id),
            )
            .execute();
      default:
        break;
    }
  }

  // ─── Salary Weightages ───

  Future<List<MasterSalaryWeightageEntry>> getSalaryWeightages({
    String category = 'frame_sheet',
  }) async {
    final r = await _connector.listMasterSalaryWeightages().execute();
    return r.data.masterSalaryWeightages
        .where((w) => w.category == category)
        .map(
          (w) => MasterSalaryWeightageEntry(
            id: w.id,
            variable: w.variable,
            label: w.label,
            category: w.category,
            percentage: w.percentage,
          ),
        )
        .toList();
  }

  Future<void> insertSalaryWeightage(MasterSalaryWeightageEntry entry) async {
    await _connector
        .insertMasterSalaryWeightage(
          variable: entry.variable,
          label: entry.label,
          category: entry.category,
          percentage: entry.percentage,
        )
        .execute();
  }

  Future<void> updateSalaryWeightage(MasterSalaryWeightageEntry entry) async {
    await _connector
        .updateMasterSalaryWeightage(
          id: UpdateMasterSalaryWeightageVariablesId(id: entry.id),
          variable: entry.variable,
          label: entry.label,
          category: entry.category,
          percentage: entry.percentage,
        )
        .execute();
  }

  Future<void> deleteSalaryWeightage(String id) async {
    await _connector
        .deleteMasterSalaryWeightage(
          id: DeleteMasterSalaryWeightageVariablesId(id: id),
        )
        .execute();
  }
}
