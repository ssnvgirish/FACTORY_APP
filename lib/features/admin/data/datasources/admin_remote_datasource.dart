import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/data/collections.dart';
import '../../../../core/data/firestore_support.dart';
import '../../../auth/data/auth_identity.dart';
import '../../domain/entities/admin_entities.dart';
import '../models/admin_models.dart';
import 'user_account_creator.dart';

bool _keysMatch(String a, String b) {
  final left = a.trim();
  final right = b.trim();
  if (left == right) return true;
  final na = double.tryParse(left);
  final nb = double.tryParse(right);
  return na != null && nb != null && na == nb;
}

class _MasterSpec {
  const _MasterSpec(
    this.collection,
    this.valueField, {
    this.typeField,
    this.displayField,
    this.renames = const [],
  });

  final String collection;
  final String valueField;
  final String? typeField; // machine `type`, maintenance `category`
  final String? displayField; // role `displayName`

  /// Weight/target collections + field that hold this master's value.
  final List<(String collection, String field)> renames;
}

const _masterSpecs = <MasterTableType, _MasterSpec>{
  MasterTableType.machines: _MasterSpec(Col.masterMachines, 'name', typeField: 'type'),
  MasterTableType.shifts: _MasterSpec(Col.masterShifts, 'name'),
  MasterTableType.roles: _MasterSpec(Col.masterRoles, 'code', displayField: 'displayName'),
  MasterTableType.frameSections: _MasterSpec(Col.masterFrameSections, 'name', renames: [
    (Col.masterFrameWeights, 'section'),
    (Col.masterFrameTargets, 'section'),
  ]),
  MasterTableType.frameDensities: _MasterSpec(Col.masterFrameDensities, 'value', renames: [
    (Col.masterFrameWeights, 'density'),
    (Col.masterFrameTargets, 'density'),
  ]),
  MasterTableType.frameColors: _MasterSpec(Col.masterFrameColors, 'name'),
  MasterTableType.sheetThicknesses: _MasterSpec(Col.masterSheetThicknesses, 'value', renames: [
    (Col.masterSheetWeights, 'thickness'),
    (Col.masterSheetTargets, 'thickness'),
  ]),
  MasterTableType.sheetDensities: _MasterSpec(Col.masterSheetDensities, 'value', renames: [
    (Col.masterSheetWeights, 'density'),
    (Col.masterSheetTargets, 'density'),
  ]),
  MasterTableType.sheetColors: _MasterSpec(Col.masterSheetColors, 'name'),
  MasterTableType.maintenanceItems: _MasterSpec(Col.masterMaintenanceItems, 'name', typeField: 'category'),
  MasterTableType.scrapProducts: _MasterSpec(Col.masterScrapProducts, 'name'),
};

class _WeightSpec {
  const _WeightSpec(this.collection, this.key1, this.key2, this.weight);
  final String collection;
  final String key1;
  final String key2;
  final String weight;
}

const _weightSpecs = <MasterLookupType, _WeightSpec>{
  MasterLookupType.frameWeights: _WeightSpec(Col.masterFrameWeights, 'section', 'density', 'weightPerFoot'),
  MasterLookupType.sheetWeights: _WeightSpec(Col.masterSheetWeights, 'thickness', 'density', 'weightPerSqft'),
};

class _TargetSpec {
  const _TargetSpec(this.collection, this.key, this.density, this.target);
  final String collection;
  final String key;
  final String? density; // null for scrap targets
  final String target;
}

const _targetSpecs = <MasterLookupType, _TargetSpec>{
  MasterLookupType.frameTargets: _TargetSpec(Col.masterFrameTargets, 'section', 'density', 'targetKgPerHour'),
  MasterLookupType.sheetTargets: _TargetSpec(Col.masterSheetTargets, 'thickness', 'density', 'targetFeetPerHour'),
  MasterLookupType.scrapTargets: _TargetSpec(Col.masterScrapTargets, 'product', null, 'targetKgPerHour'),
};

class AdminRemoteDatasource {
  AdminRemoteDatasource({
    required FirebaseFirestore firestore,
    required UserAccountCreator accounts,
  }) : _db = firestore,
       _accounts = accounts;

  final FirebaseFirestore _db;
  final UserAccountCreator _accounts;

  // ─── User Management ───

  ManagedUserModel _toUser(DocRow u) => ManagedUserModel(
    uid: u.str('uid'),
    name: u.str('name'),
    phone: u.str('phone'),
    email: u.str('email'),
    roles: u.strings('roles'),
    assignedMachines: u.strings('assignedMachines'),
    fixedSalary: u.real('fixedSalary'),
    isActive: u.flag('isActive'),
  );

  Future<DocumentReference<Map<String, dynamic>>> _userRef(String uid) async {
    final snap = await _db
        .collection(Col.users)
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) throw Exception('User not found');
    return snap.docs.first.reference;
  }

  Future<List<ManagedUserModel>> getAllUsers() async {
    final snap = await _db.collection(Col.users).get();
    return snap.docs.map((d) => _toUser(DocRow.fromSnapshot(d))).toList();
  }

  Future<ManagedUserModel> getUserById(String uid) async {
    final ref = await _userRef(uid);
    return _toUser(DocRow.fromSnapshot(await ref.get()));
  }

  Future<void> createUser({
    required String name,
    required String phone,
    required String password,
    required List<String> roles,
    required List<String> assignedMachines,
    required double fixedSalary,
  }) async {
    final normalized = AuthIdentity.normalizePhone(phone);
    final authUid = await _accounts.create(
      email: AuthIdentity.emailFor(normalized),
      password: AuthIdentity.passwordFor(password),
    );
    await _db.collection(Col.users).doc(authUid).set({
      'uid': normalized, // legacy identity: reports reference operators by it
      'name': name,
      'phone': normalized,
      'email': '',
      'roles': roles,
      'assignedMachines': assignedMachines,
      'fixedSalary': fixedSalary,
      'isActive': true,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateUser(ManagedUser user) async {
    final ref = await _userRef(user.uid);
    final current = DocRow.fromSnapshot(await ref.get());
    if (current.str('phone') != user.phone) {
      throw Exception(
        'Changing a phone number is not supported. Deactivate this user and create a new one.',
      );
    }
    await ref.update({
      'name': user.name,
      'roles': user.roles,
      'assignedMachines': user.assignedMachines,
      'fixedSalary': user.fixedSalary,
      'isActive': user.isActive,
    });
  }

  Future<void> toggleUserActive(String uid, bool isActive) async {
    final ref = await _userRef(uid);
    await ref.update({'isActive': isActive});
  }

  // ─── Master Dropdown Tables ───

  Future<List<MasterTableItem>> getMasterTable(MasterTableType tableType) async {
    final spec = _masterSpecs[tableType]!;
    final snap = await _db.collection(spec.collection).orderBy('sortOrder').get();
    return snap.docs.map((d) {
      final r = DocRow.fromSnapshot(d);
      return MasterTableItem(
        id: r.id,
        value: r.str(spec.valueField),
        type: spec.typeField == null ? null : r.strOrNull(spec.typeField!),
        displayName: spec.displayField == null ? null : r.strOrNull(spec.displayField!),
        sortOrder: r.integer('sortOrder'),
        isActive: r.flag('isActive'),
      );
    }).toList();
  }

  Map<String, dynamic> _masterData(_MasterSpec spec, MasterTableItem item) => {
    spec.valueField: item.value,
    if (spec.typeField != null) spec.typeField!: item.type ?? 'frame',
    if (spec.displayField != null) spec.displayField!: item.displayName ?? item.value,
    'sortOrder': item.sortOrder,
    'isActive': item.isActive,
  };

  Future<bool> _valueExists(_MasterSpec spec, String value, {String? exceptId}) async {
    final snap = await _db
        .collection(spec.collection)
        .where(spec.valueField, isEqualTo: value)
        .get();
    return snap.docs.any((d) => d.id != exceptId);
  }

  Future<void> insertMasterItem(MasterTableType tableType, MasterTableItem item) async {
    final spec = _masterSpecs[tableType]!;
    if (await _valueExists(spec, item.value)) {
      throw Exception('"${item.value}" already exists');
    }
    await _db.collection(spec.collection).add(_masterData(spec, item));
  }

  Future<void> updateMasterItem(MasterTableType tableType, MasterTableItem item) async {
    final spec = _masterSpecs[tableType]!;
    final ref = _db.collection(spec.collection).doc(item.id);
    final old = await ref.get();
    if (!old.exists) return;
    final oldValue = old.data()![spec.valueField] as String? ?? '';
    if (oldValue != item.value) {
      if (await _valueExists(spec, item.value, exceptId: item.id)) {
        throw Exception('"${item.value}" already exists');
      }
    }

    final batch = _db.batch();
    batch.update(ref, _masterData(spec, item));
    if (oldValue != item.value) {
      for (final (collection, field) in spec.renames) {
        final rows = await _db.collection(collection).where(field, isEqualTo: oldValue).get();
        for (final row in rows.docs) {
          batch.update(row.reference, {field: item.value});
        }
      }
    }
    await batch.commit();
  }

  Future<void> deleteMasterItem(MasterTableType tableType, String id) =>
      _db.collection(_masterSpecs[tableType]!.collection).doc(id).delete();

  // ─── Master Lookup Tables ───

  Future<List<MasterWeightEntry>> getWeightTable(MasterLookupType type) async {
    final spec = _weightSpecs[type];
    if (spec == null) return [];
    final snap = await _db.collection(spec.collection).get();
    return snap.docs.map((d) {
      final r = DocRow.fromSnapshot(d);
      return MasterWeightEntry(
        id: r.id,
        key1: r.str(spec.key1),
        key2: r.str(spec.key2),
        weight: r.real(spec.weight),
      );
    }).toList();
  }

  Future<void> insertWeightEntry(MasterLookupType type, MasterWeightEntry entry) async {
    final spec = _weightSpecs[type];
    if (spec == null) return;
    // The cell may already exist, often hidden by a 0.8 vs 0.80 key mismatch.
    // Write the new weight onto that row instead of creating a duplicate.
    final existing = await getWeightTable(type);
    final match = existing
        .where((row) => _keysMatch(row.key1, entry.key1) && _keysMatch(row.key2, entry.key2))
        .firstOrNull;
    if (match != null) {
      await updateWeightEntry(
        type,
        MasterWeightEntry(id: match.id, key1: match.key1, key2: match.key2, weight: entry.weight),
      );
      return;
    }
    await _db.collection(spec.collection).add({
      spec.key1: entry.key1,
      spec.key2: entry.key2,
      spec.weight: entry.weight,
    });
  }

  Future<void> updateWeightEntry(MasterLookupType type, MasterWeightEntry entry) async {
    final spec = _weightSpecs[type];
    if (spec == null) return;
    await _db.collection(spec.collection).doc(entry.id).update({
      spec.key1: entry.key1,
      spec.key2: entry.key2,
      spec.weight: entry.weight,
    });
  }

  Future<void> deleteWeightEntry(MasterLookupType type, String id) async {
    final spec = _weightSpecs[type];
    if (spec == null) return;
    await _db.collection(spec.collection).doc(id).delete();
  }

  Future<List<MasterTargetEntry>> getTargetTable(MasterLookupType type) async {
    final spec = _targetSpecs[type];
    if (spec == null) return [];
    final snap = await _db.collection(spec.collection).get();
    return snap.docs.map((d) {
      final r = DocRow.fromSnapshot(d);
      return MasterTargetEntry(
        id: r.id,
        key: r.str(spec.key),
        density: spec.density == null ? null : r.str(spec.density!),
        target: r.real(spec.target),
      );
    }).toList();
  }

  void _requireDensity(_TargetSpec spec, MasterTargetEntry entry, MasterLookupType type) {
    if (spec.density != null && (entry.density == null || entry.density!.isEmpty)) {
      throw ArgumentError(
        'Density is required for ${type == MasterLookupType.frameTargets ? 'frame' : 'sheet'} targets',
      );
    }
  }

  Map<String, dynamic> _targetData(_TargetSpec spec, MasterTargetEntry entry) => {
    spec.key: entry.key,
    if (spec.density != null) spec.density!: entry.density,
    spec.target: entry.target,
  };

  Future<void> insertTargetEntry(MasterLookupType type, MasterTargetEntry entry) async {
    final spec = _targetSpecs[type];
    if (spec == null) return;
    _requireDensity(spec, entry, type);
    final existing = await getTargetTable(type);
    final duplicate = existing.any(
      (row) =>
          _keysMatch(row.key, entry.key) &&
          (spec.density == null || _keysMatch(row.density ?? '', entry.density ?? '')),
    );
    if (duplicate) throw Exception('A target for "${entry.key}" already exists');
    await _db.collection(spec.collection).add(_targetData(spec, entry));
  }

  Future<void> updateTargetEntry(MasterLookupType type, MasterTargetEntry entry) async {
    final spec = _targetSpecs[type];
    if (spec == null) return;
    _requireDensity(spec, entry, type);
    await _db.collection(spec.collection).doc(entry.id).update(_targetData(spec, entry));
  }

  Future<void> deleteTargetEntry(MasterLookupType type, String id) async {
    final spec = _targetSpecs[type];
    if (spec == null) return;
    await _db.collection(spec.collection).doc(id).delete();
  }

  // ─── Salary Weightages ───

  Future<List<MasterSalaryWeightageEntry>> getSalaryWeightages({
    String category = 'frame_sheet',
  }) async {
    final snap = await _db
        .collection(Col.masterSalaryWeightages)
        .where('category', isEqualTo: category)
        .get();
    return snap.docs.map((d) {
      final r = DocRow.fromSnapshot(d);
      return MasterSalaryWeightageEntry(
        id: r.id,
        variable: r.str('variable'),
        label: r.str('label'),
        category: r.str('category'),
        percentage: r.real('percentage'),
      );
    }).toList();
  }

  Map<String, dynamic> _weightageData(MasterSalaryWeightageEntry e) => {
    'variable': e.variable,
    'label': e.label,
    'category': e.category,
    'percentage': e.percentage,
  };

  Future<void> insertSalaryWeightage(MasterSalaryWeightageEntry entry) =>
      _db.collection(Col.masterSalaryWeightages).add(_weightageData(entry));

  Future<void> updateSalaryWeightage(MasterSalaryWeightageEntry entry) =>
      _db.collection(Col.masterSalaryWeightages).doc(entry.id).update(_weightageData(entry));

  Future<void> deleteSalaryWeightage(String id) =>
      _db.collection(Col.masterSalaryWeightages).doc(id).delete();
}
