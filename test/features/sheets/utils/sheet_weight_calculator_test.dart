import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/utils/calculations.dart';

void main() {
  group('Sheet Weight Calculations', () {
    group('sheetSqft()', () {
      test('length=96, width=48 → (96×48)/144 = 32.0', () {
        expect(Calculations.sheetSqft(96, 48), 32.0);
      });

      test('length=81, width=36 → (81×36)/144 = 20.25', () {
        expect(Calculations.sheetSqft(81, 36), 20.25);
      });

      test('length=0 → 0', () {
        expect(Calculations.sheetSqft(0, 48), 0.0);
      });

      test('width=0 → 0', () {
        expect(Calculations.sheetSqft(96, 0), 0.0);
      });

      test('length=144, width=144 → 144', () {
        expect(Calculations.sheetSqft(144, 144), 144.0);
      });

      test('small dimensions: length=12, width=12 → 1.0', () {
        expect(Calculations.sheetSqft(12, 12), 1.0);
      });

      test('length=48, width=48 → 16.0', () {
        expect(Calculations.sheetSqft(48, 48), 16.0);
      });
    });

    group('sheetPerPieceWeight()', () {
      test('sqft=32, weightPerSqft=0.33 → 10.56', () {
        expect(Calculations.sheetPerPieceWeight(32, 0.33), 10.56);
      });

      test('sqft=20.25, weightPerSqft=0.45 → 9.113', () {
        expect(Calculations.sheetPerPieceWeight(20.25, 0.45), 9.113);
      });

      test('sqft=0 → 0', () {
        expect(Calculations.sheetPerPieceWeight(0, 0.33), 0.0);
      });

      test('weightPerSqft=0 → 0', () {
        expect(Calculations.sheetPerPieceWeight(32, 0), 0.0);
      });

      test('sqft=1, weightPerSqft=1 → 1.0', () {
        expect(Calculations.sheetPerPieceWeight(1, 1), 1.0);
      });

      test('large sqft=100, weightPerSqft=0.5 → 50.0', () {
        expect(Calculations.sheetPerPieceWeight(100, 0.5), 50.0);
      });
    });

    group('totalRunningFeet()', () {
      test('length=96, quantity=50 → (96×50)/12 = 400.0', () {
        expect(Calculations.totalRunningFeet(96, 50), 400.0);
      });

      test('length=81, quantity=30 → (81×30)/12 = 202.5', () {
        expect(Calculations.totalRunningFeet(81, 30), 202.5);
      });

      test('quantity=0 → 0.0', () {
        expect(Calculations.totalRunningFeet(96, 0), 0.0);
      });

      test('length=0 → 0.0', () {
        expect(Calculations.totalRunningFeet(0, 50), 0.0);
      });

      test('length=12, quantity=12 → 12.0', () {
        expect(Calculations.totalRunningFeet(12, 12), 12.0);
      });

      test('length=48, quantity=100 → 400.0', () {
        expect(Calculations.totalRunningFeet(48, 100), 400.0);
      });
    });

    group('totalWeight() for sheets', () {
      test('quantity=50, perPieceWeight=10.56 → 528.0', () {
        expect(Calculations.totalWeight(50, 10.56), 528.0);
      });

      test('quantity=0 → 0.0', () {
        expect(Calculations.totalWeight(0, 10.56), 0.0);
      });

      test('perPieceWeight=0 → 0.0', () {
        expect(Calculations.totalWeight(50, 0), 0.0);
      });

      test('quantity=1, perPieceWeight=1 → 1.0', () {
        expect(Calculations.totalWeight(1, 1), 1.0);
      });

      test('quantity=100, perPieceWeight=5.5 → 550.0', () {
        expect(Calculations.totalWeight(100, 5.5), 550.0);
      });
    });

    group('multiple line items total running feet', () {
      test('sum of running feet from multiple items', () {
        final items = [
          {'length': 96.0, 'quantity': 50},
          {'length': 81.0, 'quantity': 30},
          {'length': 48.0, 'quantity': 20},
        ];
        double total = 0;
        for (final item in items) {
          total += Calculations.totalRunningFeet(
            item['length'] as double,
            item['quantity'] as int,
          );
        }
        // 400.0 + 202.5 + 80.0 = 682.5
        expect(total, closeTo(682.5, 0.01));
      });

      test('empty list → 0.0', () {
        double total = 0;
        for (final _ in <Map<String, dynamic>>[]) {
          // no-op
        }
        expect(total, 0.0);
      });
    });

    group('sheet SQFT edge cases', () {
      test('very large dimensions', () {
        // 1000 × 1000 / 144 = 6944.444...
        expect(Calculations.sheetSqft(1000, 1000), closeTo(6944.444, 0.01));
      });

      test('fractional dimensions', () {
        expect(Calculations.sheetSqft(96.5, 48.5), closeTo(32.503, 0.01));
      });
    });

    group('sheet weight precision', () {
      test('result is rounded to 3 decimal places', () {
        final result = Calculations.sheetPerPieceWeight(32.123, 0.456);
        // 32.123 × 0.456 = 14.648088 → truncated to 3dp = 14.648
        expect(result.toString().split('.').last.length, lessThanOrEqualTo(3));
      });

      test('running feet rounded to 3 decimal places', () {
        final result = Calculations.totalRunningFeet(97, 33);
        // 97 × 33 / 12 = 266.75
        expect(result, 266.75);
      });
    });
  });
}
