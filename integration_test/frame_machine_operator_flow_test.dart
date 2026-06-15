import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/utils/calculations.dart';
import 'package:factory_app/core/constants/app_constants.dart';
import 'package:factory_app/features/auth/domain/entities/user_entity.dart';
import '../test/helpers/test_factories.dart';

/// Integration test simulating a complete Frame Machine Operator shift workflow.
/// Runs as a unit-style integration test without needing a full app instance.
void main() {
  group('Frame Machine Operator Full Workflow', () {
    late AppUser operator;

    setUp(() {
      operator = TestFactories.fakeOperator(
        assignedMachines: [AppConstants.frameMachine1],
      );
    });

    test('Step 1: Operator can only access Frame Machine 1', () {
      expect(operator.canAccessMachine(AppConstants.frameMachine1), isTrue);
      expect(operator.canAccessMachine(AppConstants.frameMachine2), isFalse);
      expect(operator.canAccessMachine(AppConstants.sheetMachine3), isFalse);
      expect(operator.canAccessMachine(AppConstants.sheetMachine4), isFalse);
      expect(operator.canAccessMachine(AppConstants.sheetMachine5), isFalse);
    });

    test('Step 2: Machine Health — Die Change 09:00–12:00 capped at 2hr', () {
      final start = DateTime(2026, 3, 15, 9, 0);
      final end = DateTime(2026, 3, 15, 12, 0);
      final actual = Calculations.maintenanceDurationHours(start, end);
      expect(actual, 3.0);

      final capped = Calculations.cappedMaintenanceDuration(
        maintenanceItem: 'Die Change',
        actualHours: actual,
        isFrameMachine: true,
      );
      expect(capped, 2.0);
    });

    test('Step 2: Machine Health — Generator Maintenance 13:00–13:30 = 0.5hr uncapped', () {
      final start = DateTime(2026, 3, 15, 13, 0);
      final end = DateTime(2026, 3, 15, 13, 30);
      final actual = Calculations.maintenanceDurationHours(start, end);
      expect(actual, 0.5);

      final capped = Calculations.cappedMaintenanceDuration(
        maintenanceItem: 'Generator Maintenance',
        actualHours: actual,
        isFrameMachine: true,
      );
      expect(capped, 0.5);
    });

    test('Step 2: Total maintenance = 2.5 hours', () {
      final entries = [
        {'maintenanceItem': 'Die Change', 'durationHours': 3.0},
        {'maintenanceItem': 'Generator Maintenance', 'durationHours': 0.5},
      ];
      final total = Calculations.totalMaintenanceDuration(
        entries: entries,
        isFrameMachine: true,
      );
      expect(total, 2.5);
    });

    test('Step 3: Production Details — line item 1 weight calculation', () {
      // 3x2, 0.75 density, length=10
      final weightPerFoot = AppConstants.defaultFrameWeights['3x2']!['0.75']!;
      expect(weightPerFoot, 0.486);

      final perPiece = Calculations.framePerPieceWeight(
        lengthFeet: 10,
        weightPerFoot: weightPerFoot,
      );
      expect(perPiece, 4.86);

      final totalWeight = Calculations.totalWeight(50, perPiece);
      expect(totalWeight, 243.0);
    });

    test('Step 3: Production Details — line item 2 weight (4x2, 0.80)', () {
      final weightPerFoot = AppConstants.defaultFrameWeights['4x2']!['0.80']!;
      expect(weightPerFoot, 0.690);

      final perPiece = Calculations.framePerPieceWeight(
        lengthFeet: 10,
        weightPerFoot: weightPerFoot,
      );
      expect(perPiece, 6.9);

      final totalWeight = Calculations.totalWeight(50, perPiece);
      expect(totalWeight, 345.0);
    });

    test('Step 3: Total production — h=100, k=588.0', () {
      final totalQty = 50 + 50;
      expect(totalQty, 100);

      final totalWeight = 243.0 + 345.0;
      expect(totalWeight, 588.0);
    });

    test('Step 4: Production Weight Report calculations', () {
      final k = 588.0; // total production weight
      final g = 2.5; // approved maintenance hours (capped)

      // Target calculation: 3x2 for 6hrs, 4x2 for 6hrs (assume section change at 3PM)
      final targetPerHour = {'3x2': 100.0, '4x2': 120.0};
      final segments = [
        {'section': '3x2', 'durationHours': 6.0},
        {'section': '4x2', 'durationHours': 6.0},
      ];
      final targetWeight = Calculations.calculateTargetWeight(
        segments: segments,
        targetPerHour: targetPerHour,
      );
      expect(targetWeight, 1320.0);

      // Maintenance weight = g × average target rate
      // Using the active section rate during maintenance.
      // g=2.5 hours, assuming avg target of 100
      final mWeight = Calculations.maintenanceWeight(g, 100);
      expect(mWeight, 250.0);

      final totalProduction = k + mWeight;
      expect(totalProduction, 838.0);

      final efficiency = Calculations.productionEfficiency(totalProduction, targetWeight);
      expect(efficiency, closeTo(63.48, 0.01));
    });

    test('Step 5: Report writing score — submitted within 30 min → score=5', () {
      final shiftEnd = DateTime(2026, 3, 15, 21, 0);
      final submittedAt = DateTime(2026, 3, 15, 21, 30);
      expect(Calculations.reportWritingScore(submittedAt, shiftEnd), 5);
    });
  });
}
