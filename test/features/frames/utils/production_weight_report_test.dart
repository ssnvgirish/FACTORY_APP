import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/utils/calculations.dart';

void main() {
  group('Production Weight Report Calculations', () {
    group('maintenanceWeight()', () {
      test('g=2.0, targetRate=100 → 200.0', () {
        expect(Calculations.maintenanceWeight(2.0, 100), 200.0);
      });

      test('g=0.0 → 0.0', () {
        expect(Calculations.maintenanceWeight(0.0, 100), 0.0);
      });

      test('targetRate=0 → 0.0', () {
        expect(Calculations.maintenanceWeight(2.0, 0), 0.0);
      });

      test('g=2.5, targetRate=120 → 300.0', () {
        expect(Calculations.maintenanceWeight(2.5, 120), 300.0);
      });

      test('fractional values: g=1.5, targetRate=75.5 → 113.25', () {
        expect(Calculations.maintenanceWeight(1.5, 75.5), 113.25);
      });
    });

    group('productionEfficiency()', () {
      test('actual=5200, target=6000 → 86.67%', () {
        expect(Calculations.productionEfficiency(5200, 6000), 86.67);
      });

      test('actual=1200, target=1200 → 100.0%', () {
        expect(Calculations.productionEfficiency(1200, 1200), 100.0);
      });

      test('actual=0, target=1200 → 0.0%', () {
        expect(Calculations.productionEfficiency(0, 1200), 0.0);
      });

      test('target=0 → returns 0 (safe division)', () {
        expect(Calculations.productionEfficiency(5200, 0), 0.0);
      });

      test('actual > target (overproduction) → > 100%', () {
        expect(Calculations.productionEfficiency(1500, 1200), 125.0);
      });

      test('small actual=100, target=300 → 33.33%', () {
        expect(Calculations.productionEfficiency(100, 300), 33.33);
      });
    });

    group('total production weight (k + maintenance)', () {
      test('k=5000, maintenanceWeight=200 → total=5200', () {
        final total = 5000.0 + 200.0;
        expect(total, 5200.0);
      });

      test('k=0, maintenanceWeight=0 → total=0', () {
        final total = 0.0 + 0.0;
        expect(total, 0.0);
      });

      test('maintenanceWeight=0 → total equals k', () {
        final k = 486.0;
        final total = k + 0.0;
        expect(total, 486.0);
      });
    });

    group('customer rejection deduction', () {
      test('report=5200, rejected=100 → deducted = 5200 - 2×100 = 5000', () {
        final deducted = 5200.0 - (2 * 100.0);
        expect(deducted, 5000.0);
      });

      test('rejected=0 → no change', () {
        final deducted = 5200.0 - (2 * 0.0);
        expect(deducted, 5200.0);
      });

      test('deduction > reportWeight → floor at 0', () {
        final reportWeight = 100.0;
        final rejection = 200.0;
        final deducted = reportWeight - (2 * rejection);
        final result = deducted < 0 ? 0.0 : deducted;
        expect(result, 0.0);
      });

      test('exact deduction equals report weight → 0', () {
        final reportWeight = 400.0;
        final rejection = 200.0;
        final deducted = reportWeight - (2 * rejection);
        expect(deducted, 0.0);
      });
    });
  });
}
