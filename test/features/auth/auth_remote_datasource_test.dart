import 'package:factory_app/features/auth/data/auth_identity.dart';
import 'package:factory_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthIdentity', () {
    test('normalizes phones and derives email/password', () {
      expect(AuthIdentity.normalizePhone('9876543210'), '+919876543210');
      expect(AuthIdentity.normalizePhone(' +919876543210 '), '+919876543210');
      expect(AuthIdentity.emailFor('9876543210'), '919876543210@prabitha.app');
      expect(AuthIdentity.emailFor('+919876543210'), '919876543210@prabitha.app');
      expect(AuthIdentity.passwordFor('1234'), 'prb#1234');
    });
  });

  group('AuthRemoteDataSourceImpl', () {
    late FakeFirebaseFirestore db;

    Future<void> profile({bool active = true}) => db.doc('users/auth-1').set({
      'uid': '+919876543210',
      'name': 'Ravi',
      'phone': '+919876543210',
      'email': '',
      'roles': ['machine_operator'],
      'assignedMachines': ['Frame Machine 1'],
      'fixedSalary': 1000,
      'isActive': active,
    });

    AuthRemoteDataSourceImpl build({bool signedIn = false}) {
      final auth = MockFirebaseAuth(
        signedIn: signedIn,
        mockUser: MockUser(uid: 'auth-1', email: '919876543210@prabitha.app'),
      );
      return AuthRemoteDataSourceImpl(auth: auth, firestore: db);
    }

    setUp(() => db = FakeFirebaseFirestore());

    test('signIn returns the profile keyed by the legacy uid', () async {
      await profile();
      final user = await build().signIn('9876543210', '1234');
      expect(user.uid, '+919876543210');
      expect(user.name, 'Ravi');
      expect(user.roles, ['machine_operator']);
      expect(user.assignedMachines, ['Frame Machine 1']);
      expect(user.fixedSalary, 1000);
    });

    test('signIn rejects a deactivated account and signs out', () async {
      await profile(active: false);
      final ds = build();
      await expectLater(ds.signIn('9876543210', '1234'),
          throwsA(predicate((e) => e.toString().contains('deactivated'))));
      expect(await ds.getCurrentUser(), isNull);
    });

    test('signIn rejects an Auth user without a profile', () async {
      await expectLater(build().signIn('9876543210', '1234'),
          throwsA(predicate((e) => e.toString().contains('No account found'))));
    });

    test('getCurrentUser restores a signed-in session and signOut clears it', () async {
      await profile();
      final ds = build(signedIn: true);
      expect((await ds.getCurrentUser())!.name, 'Ravi');
      await ds.signOut();
      expect(await ds.getCurrentUser(), isNull);
    });
  });
}
