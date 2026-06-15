import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/utils/calculations.dart';
import 'package:factory_app/core/utils/validators.dart';

void main() {
  group('Data Integrity Tests', () {
    group('Customer rejection deduction floor at 0', () {
      test('rejected weight larger than report weight → floor at 0', () {
        final reportWeight = 100.0;
        final rejectedWeight = 200.0;
        final deducted = reportWeight - (2 * rejectedWeight);
        final result = deducted < 0 ? 0.0 : deducted;
        expect(result, 0.0);
      });

      test('rejected weight equals half report weight → result is 0', () {
        final reportWeight = 400.0;
        final rejectedWeight = 200.0;
        final deducted = reportWeight - (2 * rejectedWeight);
        expect(deducted, 0.0);
      });

      test('no rejection → report weight unchanged', () {
        final reportWeight = 5000.0;
        final rejectedWeight = 0.0;
        final deducted = reportWeight - (2 * rejectedWeight);
        expect(deducted, 5000.0);
      });
    });

    group('Packing report: classified > production quantity', () {
      test('total classified > production → error', () {
        expect(Validators.validatePackingQuantities(50, 30, 25), isNotNull);
      });

      test('total classified < production → error', () {
        expect(Validators.validatePackingQuantities(50, 20, 10), isNotNull);
      });

      test('total classified == production → valid', () {
        expect(Validators.validatePackingQuantities(50, 48, 2), isNull);
      });
    });

    group('Tools count: available > given', () {
      test('available > given → validation error', () {
        expect(Validators.validateToolsCounts(100, 110), isNotNull);
      });

      test('available == given → valid', () {
        expect(Validators.validateToolsCounts(100, 100), isNull);
      });

      test('available < given → valid', () {
        expect(Validators.validateToolsCounts(100, 90), isNull);
      });
    });

    group('Score field validation', () {
      test('non-integer input (5.5) → rejected', () {
        expect(Validators.integerRange('5.5', 1, 10), isNotNull);
      });

      test('integer within range → valid', () {
        expect(Validators.integerRange('5', 1, 10), isNull);
      });

      test('integer out of range → rejected', () {
        expect(Validators.integerRange('11', 1, 10), isNotNull);
        expect(Validators.integerRange('0', 1, 10), isNotNull);
      });
    });

    group('Length=0 in production entry', () {
      test('length=0 → weight=0', () {
        final perPiece = Calculations.framePerPieceWeight(
          lengthFeet: 0,
          weightPerFoot: 0.486,
        );
        expect(perPiece, 0.0);
        final total = Calculations.totalWeight(50, perPiece);
        expect(total, 0.0);
      });
    });

    group('Quantity=0 in production entry', () {
      test('quantity=0 → totalWeight=0', () {
        final total = Calculations.totalWeight(0, 4.86);
        expect(total, 0.0);
      });

      test('quantity=0 → runningFeet=0', () {
        final rf = Calculations.totalRunningFeet(96, 0);
        expect(rf, 0.0);
      });
    });

    group('Tools rating edge cases', () {
      test('all zeros → 0', () {
        expect(Calculations.toolsTotalScore(0, 0, 0), 0);
      });

      test('normal case: 8, 9, 8 → 25', () {
        expect(Calculations.toolsTotalScore(8, 9, 8), 25);
      });
    });
  });
}
