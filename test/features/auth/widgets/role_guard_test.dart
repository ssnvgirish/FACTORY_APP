import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/constants/app_constants.dart';
import '../../../helpers/test_factories.dart';

void main() {
  group('Role-Based Access Guard', () {
    group('Machine Operator access', () {
      test('can access assigned frame machine', () {
        final user = TestFactories.fakeOperator(
          assignedMachines: [AppConstants.frameMachine1],
        );
        expect(user.canAccessMachine(AppConstants.frameMachine1), isTrue);
      });

      test('cannot access other frame machine', () {
        final user = TestFactories.fakeOperator(
          assignedMachines: [AppConstants.frameMachine1],
        );
        expect(user.canAccessMachine(AppConstants.frameMachine2), isFalse);
      });

      test('cannot access sheet machines', () {
        final user = TestFactories.fakeOperator(
          assignedMachines: [AppConstants.frameMachine1],
        );
        expect(user.canAccessMachine(AppConstants.sheetMachine3), isFalse);
      });

      test('canAccessFrames is true when assigned to frame machine', () {
        final user = TestFactories.fakeOperator(
          assignedMachines: [AppConstants.frameMachine1],
        );
        expect(user.canAccessFrames, isTrue);
      });

      test('canAccessSheets is false when assigned only to frame machine', () {
        final user = TestFactories.fakeOperator(
          assignedMachines: [AppConstants.frameMachine1],
        );
        expect(user.canAccessSheets, isFalse);
      });
    });

    group('Quality and Packing Supervisor access', () {
      test('can access all machines', () {
        final user = TestFactories.fakeQualityPacking();
        for (final machine in AppConstants.allMachines) {
          expect(user.canAccessMachine(machine), isTrue);
        }
      });

      test('canAccessFrames is true', () {
        final user = TestFactories.fakeQualityPacking();
        expect(user.canAccessFrames, isTrue);
      });

      test('canAccessSheets is true', () {
        final user = TestFactories.fakeQualityPacking();
        expect(user.canAccessSheets, isTrue);
      });
    });

    group('Frame Senior Operator access', () {
      test('can access frame machines', () {
        final user = TestFactories.fakeFrameSeniorOperator();
        expect(user.canAccessMachine(AppConstants.frameMachine1), isTrue);
        expect(user.canAccessMachine(AppConstants.frameMachine2), isTrue);
      });

      test('cannot access sheet machines', () {
        final user = TestFactories.fakeFrameSeniorOperator();
        expect(user.canAccessMachine(AppConstants.sheetMachine3), isFalse);
      });

      test('canAccessFrames is true', () {
        final user = TestFactories.fakeFrameSeniorOperator();
        expect(user.canAccessFrames, isTrue);
      });

      test('canAccessSheets is false', () {
        final user = TestFactories.fakeFrameSeniorOperator();
        expect(user.canAccessSheets, isFalse);
      });
    });

    group('Sheet Senior Operator access', () {
      test('can access sheet machines', () {
        final user = TestFactories.fakeSheetSeniorOperator();
        expect(user.canAccessMachine(AppConstants.sheetMachine3), isTrue);
        expect(user.canAccessMachine(AppConstants.sheetMachine4), isTrue);
        expect(user.canAccessMachine(AppConstants.sheetMachine5), isTrue);
      });

      test('cannot access frame machines', () {
        final user = TestFactories.fakeSheetSeniorOperator();
        expect(user.canAccessMachine(AppConstants.frameMachine1), isFalse);
      });

      test('canAccessSheets is true', () {
        final user = TestFactories.fakeSheetSeniorOperator();
        expect(user.canAccessSheets, isTrue);
      });

      test('canAccessFrames is false', () {
        final user = TestFactories.fakeSheetSeniorOperator();
        expect(user.canAccessFrames, isFalse);
      });
    });

    group('Plant Manager access', () {
      test('can access all machines', () {
        final user = TestFactories.fakePlantManager();
        for (final machine in AppConstants.allMachines) {
          expect(user.canAccessMachine(machine), isTrue);
        }
      });
    });

    group('Admin access', () {
      test('can access all machines', () {
        final user = TestFactories.fakeAdmin();
        for (final machine in AppConstants.allMachines) {
          expect(user.canAccessMachine(machine), isTrue);
        }
      });

      test('isAdmin is true', () {
        final user = TestFactories.fakeAdmin();
        expect(user.isAdmin, isTrue);
      });

      test('non-admin roles are not admin', () {
        expect(TestFactories.fakeOperator().isAdmin, isFalse);
        expect(TestFactories.fakeFrameSeniorOperator().isAdmin, isFalse);
        expect(TestFactories.fakeQualityPacking().isAdmin, isFalse);
        expect(TestFactories.fakePlantManager().isAdmin, isFalse);
      });
    });
  });
}
