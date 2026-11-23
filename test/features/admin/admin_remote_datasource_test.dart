import 'package:factory_app/features/admin/data/datasources/admin_remote_datasource.dart';
import 'package:factory_app/features/admin/data/datasources/user_account_creator.dart';
import 'package:factory_app/features/admin/domain/entities/admin_entities.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAccounts implements UserAccountCreator {
  final created = <String>[];
  @override
  Future<String> create({required String email, required String password}) async {
    created.add('$email|$password');
    return 'auth-${created.length}';
  }
}

void main() {
  late FakeFirebaseFirestore db;
  late _FakeAccounts accounts;
  late AdminRemoteDatasource ds;

  setUp(() {
    db = FakeFirebaseFirestore();
    accounts = _FakeAccounts();
    ds = AdminRemoteDatasource(firestore: db, accounts: accounts);
  });

  group('users', () {
    test('createUser makes an Auth account and a profile keyed by auth uid', () async {
      await ds.createUser(
        name: 'Ravi', phone: '9876543210', password: '1234',
        roles: ['machine_operator'], assignedMachines: ['Frame Machine 1'], fixedSalary: 500,
      );
      expect(accounts.created.single, '919876543210@prabitha.app|prb#1234');
      final doc = await db.doc('users/auth-1').get();
      expect(doc.data()!['uid'], '+919876543210');
      expect(doc.data()!.containsKey('password'), isFalse);
      final all = await ds.getAllUsers();
      expect(all.single.uid, '+919876543210');
      expect(all.single.isActive, isTrue);
    });

    test('update and toggle find the user by legacy uid; phone change is rejected', () async {
      await ds.createUser(name: 'A', phone: '+919876543210', password: 'p',
          roles: [], assignedMachines: [], fixedSalary: 0);
      final u = (await ds.getAllUsers()).single;
      await ds.updateUser(ManagedUser(uid: u.uid, name: 'B', phone: u.phone,
          roles: ['admin'], assignedMachines: [], fixedSalary: 9, isActive: true));
      expect((await ds.getUserById(u.uid)).name, 'B');
      await ds.toggleUserActive(u.uid, false);
      expect((await ds.getUserById(u.uid)).isActive, isFalse);
      await expectLater(
        ds.updateUser(ManagedUser(uid: u.uid, name: 'B', phone: '+910000000000',
            roles: [], assignedMachines: [], fixedSalary: 9, isActive: true)),
        throwsA(predicate((e) => e.toString().contains('phone'))),
      );
    });
  });

  group('master tables', () {
    test('insert, list ordered by sortOrder, update, delete', () async {
      await ds.insertMasterItem(MasterTableType.machines,
          const MasterTableItem(id: '', value: 'Frame Machine 2', type: 'frame', sortOrder: 2, isActive: true));
      await ds.insertMasterItem(MasterTableType.machines,
          const MasterTableItem(id: '', value: 'Frame Machine 1', sortOrder: 1, isActive: true));
      final items = await ds.getMasterTable(MasterTableType.machines);
      expect(items.map((i) => i.value), ['Frame Machine 1', 'Frame Machine 2']);
      expect(items.first.type, 'frame'); // default when no type supplied
      await ds.updateMasterItem(MasterTableType.machines,
          MasterTableItem(id: items.first.id, value: 'Frame Machine 1', type: 'frame', sortOrder: 1, isActive: false));
      expect((await ds.getMasterTable(MasterTableType.machines)).first.isActive, isFalse);
      await ds.deleteMasterItem(MasterTableType.machines, items.first.id);
      expect(await ds.getMasterTable(MasterTableType.machines), hasLength(1));
    });

    test('duplicate value is rejected', () async {
      const item = MasterTableItem(id: '', value: 'Red', sortOrder: 1, isActive: true);
      await ds.insertMasterItem(MasterTableType.frameColors, item);
      await expectLater(ds.insertMasterItem(MasterTableType.frameColors, item),
          throwsA(predicate((e) => e.toString().contains('already exists'))));
    });

    test('roles store code and displayName', () async {
      await ds.insertMasterItem(MasterTableType.roles,
          const MasterTableItem(id: '', value: 'admin', displayName: 'Administrator', sortOrder: 1, isActive: true));
      final r = (await ds.getMasterTable(MasterTableType.roles)).single;
      expect([r.value, r.displayName], ['admin', 'Administrator']);
    });

    test('renaming a frame section rewrites weights and targets', () async {
      await ds.insertMasterItem(MasterTableType.frameSections,
          const MasterTableItem(id: '', value: '3x2', sortOrder: 1, isActive: true));
      await ds.insertWeightEntry(MasterLookupType.frameWeights,
          const MasterWeightEntry(id: '', key1: '3x2', key2: '0.8', weight: 1.5));
      await ds.insertTargetEntry(MasterLookupType.frameTargets,
          const MasterTargetEntry(id: '', key: '3x2', density: '0.8', target: 40));
      final sec = (await ds.getMasterTable(MasterTableType.frameSections)).single;
      await ds.updateMasterItem(MasterTableType.frameSections,
          MasterTableItem(id: sec.id, value: '3x3', sortOrder: 1, isActive: true));
      expect((await ds.getMasterTable(MasterTableType.frameSections)).single.value, '3x3');
      expect((await ds.getWeightTable(MasterLookupType.frameWeights)).single.key1, '3x3');
      expect((await ds.getTargetTable(MasterLookupType.frameTargets)).single.key, '3x3');
    });
  });

  group('lookup tables', () {
    test('inserting an existing weight cell (0.8 vs 0.80) updates it instead', () async {
      await ds.insertWeightEntry(MasterLookupType.frameWeights,
          const MasterWeightEntry(id: '', key1: '3x2', key2: '0.8', weight: 1));
      await ds.insertWeightEntry(MasterLookupType.frameWeights,
          const MasterWeightEntry(id: '', key1: '3x2', key2: '0.80', weight: 2));
      final rows = await ds.getWeightTable(MasterLookupType.frameWeights);
      expect(rows, hasLength(1));
      expect(rows.single.weight, 2);
    });

    test('sheet targets require density; scrap targets do not', () async {
      await expectLater(
        ds.insertTargetEntry(MasterLookupType.sheetTargets,
            const MasterTargetEntry(id: '', key: '9mm', target: 5)),
        throwsA(isA<ArgumentError>()),
      );
      await ds.insertTargetEntry(MasterLookupType.scrapTargets,
          const MasterTargetEntry(id: '', key: 'Crusher', target: 80));
      final t = (await ds.getTargetTable(MasterLookupType.scrapTargets)).single;
      expect([t.key, t.density, t.target], ['Crusher', null, 80]);
    });

    test('salary weightages filter by category and support CRUD', () async {
      await ds.insertSalaryWeightage(const MasterSalaryWeightageEntry(
          id: '', variable: 'wA', label: 'Cleaning', category: 'frame_sheet', percentage: 15));
      await ds.insertSalaryWeightage(const MasterSalaryWeightageEntry(
          id: '', variable: 'wA', label: 'Cleaning %', category: 'scrap', percentage: 20));
      final fs = await ds.getSalaryWeightages();
      expect(fs.single.percentage, 15);
      await ds.updateSalaryWeightage(MasterSalaryWeightageEntry(
          id: fs.single.id, variable: 'wA', label: 'Cleaning', category: 'frame_sheet', percentage: 18));
      expect((await ds.getSalaryWeightages()).single.percentage, 18);
      await ds.deleteSalaryWeightage(fs.single.id);
      expect(await ds.getSalaryWeightages(), isEmpty);
      expect(await ds.getSalaryWeightages(category: 'scrap'), hasLength(1));
    });
  });
}
