import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/utils/calculations.dart';
import 'package:factory_app/core/utils/validators.dart';

void main() {
  group('Quality Acceptance Calculations', () {
    group('qualityAcceptancePercentage()', () {
      test('x=5000, y=200 → ((5000-200)/5000)*100 = 96.0%', () {
        expect(Calculations.qualityAcceptancePercentage(5000, 200), 96.0);
      });

      test('y=0 → 100.0%', () {
        expect(Calculations.qualityAcceptancePercentage(5000, 0), 100.0);
      });

      test('y=x → 0.0%', () {
        expect(Calculations.qualityAcceptancePercentage(5000, 5000), 0.0);
      });

      test('x=0 → 0.0% (safe division)', () {
        expect(Calculations.qualityAcceptancePercentage(0, 0), 0.0);
      });

      test('normal case: x=1000, y=50 → 95.0%', () {
        expect(Calculations.qualityAcceptancePercentage(1000, 50), 95.0);
      });

      test('x=100, y=1 → 99.0%', () {
        expect(Calculations.qualityAcceptancePercentage(100, 1), 99.0);
      });

      test('small rejection: x=2000, y=10 → 99.5%', () {
        expect(Calculations.qualityAcceptancePercentage(2000, 10), 99.5);
      });

      test('large rejection: x=100, y=90 → 10.0%', () {
        expect(Calculations.qualityAcceptancePercentage(100, 90), 10.0);
      });
    });

    group('packingEfficiency()', () {
      test('h=1000, j=950 → 95.0%', () {
        expect(Calculations.packingEfficiency(1000, 950), 95.0);
      });

      test('j=0 → 0.0%', () {
        expect(Calculations.packingEfficiency(1000, 0), 0.0);
      });

      test('h=0 → 0.0% (safe division)', () {
        expect(Calculations.packingEfficiency(0, 0), 0.0);
      });

      test('j=h → 100.0%', () {
        expect(Calculations.packingEfficiency(100, 100), 100.0);
      });

      test('normal case: h=500, j=480 → 96.0%', () {
        expect(Calculations.packingEfficiency(500, 480), 96.0);
      });

      test('low packing: h=200, j=50 → 25.0%', () {
        expect(Calculations.packingEfficiency(200, 50), 25.0);
      });
    });

    group('sheet packing — j calculation (packed + sanding_and_packed)', () {
      test('packed=20, onlySanding=28, sandingAndPacked=2, rejected=2, h=52 → j=22', () {
        // For sheet packing efficiency, j = packed + sandingAndPacked
        const packed = 20;
        const sandingAndPacked = 2;
        const j = packed + sandingAndPacked;
        expect(j, 22);

        // h = total production quantity
        const h = 52;
        final efficiency = Calculations.packingEfficiency(h, j);
        expect(efficiency, closeTo(42.31, 0.01));
      });

      test('all packed, no sanding → j = packed', () {
        const packed = 50;
        const sandingAndPacked = 0;
        const j = packed + sandingAndPacked;
        expect(j, 50);
      });

      test('all sanding_and_packed → j = sandingAndPacked', () {
        const packed = 0;
        const sandingAndPacked = 30;
        const j = packed + sandingAndPacked;
        expect(j, 30);
      });
    });

    group('validatePackingQuantities()', () {
      test('frame packing: packed + rejected = production → valid', () {
        final result = Validators.validatePackingQuantities(50, 48, 2);
        expect(result, isNull);
      });

      test('frame packing: sum does not equal production → error', () {
        final result = Validators.validatePackingQuantities(50, 49, 2);
        expect(result, isNotNull);
        expect(result, contains('must equal production quantity'));
      });

      test('sheet packing: all categories sum to production → valid', () {
        final result = Validators.validatePackingQuantities(52, 20, 2, 28, 2);
        expect(result, isNull);
      });

      test('sheet packing: sum exceeds production → error', () {
        final result = Validators.validatePackingQuantities(52, 21, 2, 28, 2);
        expect(result, isNotNull);
      });

      test('sheet packing: sum less than production → error', () {
        final result = Validators.validatePackingQuantities(52, 19, 2, 28, 2);
        expect(result, isNotNull);
      });
    });
  });
}
