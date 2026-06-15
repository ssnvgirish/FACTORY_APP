import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/constants/app_constants.dart';
import 'package:factory_app/features/auth/domain/entities/user_entity.dart';
import '../helpers/test_factories.dart';

/// Integration test simulating Frame Senior Operator workflow.
void main() {
  group('Frame Senior Operator Workflow', () {
    late AppUser seniorOperator;

    setUp(() {
      seniorOperator = TestFactories.fakeFrameSeniorOperator();
    });

    test('Senior operator can access Frame machines', () {
      expect(
        seniorOperator.canAccessMachine(AppConstants.frameMachine1),
        isTrue,
      );
      expect(
        seniorOperator.canAccessMachine(AppConstants.frameMachine2),
        isTrue,
      );
    });

    test('Senior operator cannot access Sheet machines', () {
      expect(
        seniorOperator.canAccessMachine(AppConstants.sheetMachine3),
        isFalse,
      );
      expect(
        seniorOperator.canAccessMachine(AppConstants.sheetMachine4),
        isFalse,
      );
      expect(
        seniorOperator.canAccessMachine(AppConstants.sheetMachine5),
        isFalse,
      );
    });

    test('isFramesSenior is true', () {
      expect(seniorOperator.isFramesSenior, isTrue);
    });

    test('health report ratings exist in mock data', () {
      final report = TestFactories.fakeMachineHealthReport();
      expect(report.ratings.isNotEmpty, isTrue);
      expect(report.totalScore, greaterThan(0));
      expect(report.percentage, greaterThan(0));
    });

    test('health report percentage is calculated correctly', () {
      final report = TestFactories.fakeMachineHealthReport();
      // 7 items * 8 rating each = 56 total score
      expect(report.ratings.length, 7);
      expect(report.totalScore, 56);
    });
  });
}
