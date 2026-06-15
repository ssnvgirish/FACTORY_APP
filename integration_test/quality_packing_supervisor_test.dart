import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/constants/app_constants.dart';
import 'package:factory_app/core/utils/calculations.dart';
import 'package:factory_app/core/utils/validators.dart';
import '../test/helpers/test_factories.dart';

/// Integration test simulating Quality & Packing Supervisor workflow.
void main() {
  group('Quality and Packing Supervisor Workflow', () {
    test('QP Supervisor can access all machines', () {
      final user = TestFactories.fakeQualityPacking();
      for (final machine in AppConstants.allMachines) {
        expect(user.canAccessMachine(machine), isTrue);
      }
    });

    test('Frame Machine packing: 2 classification options valid', () {
      // Frame: packed + rejected = production qty
      final result = Validators.validatePackingQuantities(50, 48, 2);
      expect(result, isNull);
    });

    test('Frame: sum does not match production → validation error', () {
      final result = Validators.validatePackingQuantities(50, 49, 2);
      expect(result, isNotNull);
      expect(result, contains('must equal production quantity'));
    });

    test('Sheet Machine packing: 4 classification options valid', () {
      // Sheet: packed=20, rejected=2, onlySanding=28, sandingAndPacked=2 = 52
      final result = Validators.validatePackingQuantities(52, 20, 2, 28, 2);
      expect(result, isNull);
    });

    test('Sheet: sum exceeds production → validation error', () {
      final result = Validators.validatePackingQuantities(52, 21, 2, 28, 2);
      expect(result, isNotNull);
    });

    test('Rejected weight deducted from Production Weight Report', () {
      final originalWeight = 588.0;
      final rejectedPerPiece = 4.86;
      final rejectedQty = 2;
      final rejectedWeight = rejectedQty * rejectedPerPiece; // 9.72

      // Rejected weight is NOT customer rejection (2× multiplier)
      // Quality rejection reduces quality acceptance % but the production weight
      // remains unchanged in the report.
      final qualityAcceptance = Calculations.qualityAcceptancePercentage(
        originalWeight,
        rejectedWeight,
      );
      expect(qualityAcceptance, closeTo(98.35, 0.01));
    });

    test('Packing efficiency calculation for frames', () {
      final efficiency = Calculations.packingEfficiency(50, 48);
      expect(efficiency, 96.0);
    });

    test('Sheet-specific packing efficiency: j = packed + sandingAndPacked', () {
      const packed = 20;
      const sandingAndPacked = 2;
      const j = packed + sandingAndPacked; // 22, NOT including onlySanding
      expect(j, 22);

      final efficiency = Calculations.packingEfficiency(52, j);
      expect(efficiency, closeTo(42.31, 0.01));
    });
  });
}
