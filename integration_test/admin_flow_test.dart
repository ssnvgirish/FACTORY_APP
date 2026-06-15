import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/constants/app_constants.dart';
import 'package:factory_app/core/utils/validators.dart';
import '../test/helpers/test_factories.dart';

/// Integration test simulating Admin user management flow.
void main() {
  group('Admin User Management Flow', () {
    test('admin can access all machines', () {
      final admin = TestFactories.fakeAdmin();
      for (final machine in AppConstants.allMachines) {
        expect(admin.canAccessMachine(machine), isTrue);
      }
    });

    test('admin isAdmin flag is true', () {
      final admin = TestFactories.fakeAdmin();
      expect(admin.isAdmin, isTrue);
    });

    test('create new user with valid data', () {
      final newUser = TestFactories.fakeOperator(
        uid: 'new-op',
        name: 'Test Operator',
        email: 'test@factory.com',
        assignedMachines: [AppConstants.frameMachine1],
      );
      expect(newUser.name, 'Test Operator');
      expect(newUser.email, 'test@factory.com');
      expect(newUser.roles, contains(AppConstants.roleMachineOperator));
      expect(newUser.assignedMachines, contains(AppConstants.frameMachine1));
    });

    test('weightages must sum to 100', () {
      final valid = Validators.validateWeightagesSum({
        'a': 10, 'b': 10, 'c': 30, 'd': 20, 'e': 20, 'f': 10,
      });
      expect(valid, isNull);
    });

    test('weightages summing to 95 → error', () {
      final invalid = Validators.validateWeightagesSum({
        'a': 0, 'b': 10, 'c': 40, 'd': 20, 'e': 20, 'f': 5,
      });
      expect(invalid, isNotNull);
    });

    test('changing weightage a from 10 to 0 and c from 30 to 40 keeps sum=100', () {
      final updated = Validators.validateWeightagesSum({
        'a': 0, 'b': 10, 'c': 40, 'd': 20, 'e': 20, 'f': 10,
      });
      expect(updated, isNull);
    });

    test('fixed salary persists for operator', () {
      final user = TestFactories.fakeOperator(fixedSalary: 50000);
      expect(user.fixedSalary, 50000);
    });

    test('email validation', () {
      expect(Validators.email('test@factory.com'), isNull);
      expect(Validators.email('invalid-email'), isNotNull);
      expect(Validators.email(''), isNotNull);
      expect(Validators.email(null), isNotNull);
    });
  });
}
