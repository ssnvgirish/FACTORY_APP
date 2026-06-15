import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/utils/calculations.dart';

/// End-to-end salary calculation test with known values.
void main() {
  group('Salary Calculation E2E', () {
    // Setup values:
    // a=80, b=90, c=75, d=85, e=70, f=60
    // wA=10, wB=10, wC=30, wD=20, wE=20, wF=10
    // fixedSalary=50000

    test('individual variable multipliers are correct', () {
      expect(Calculations.variableMultiplier(80, 10), closeTo(0.08, 0.001));
      expect(Calculations.variableMultiplier(90, 10), closeTo(0.09, 0.001));
      expect(Calculations.variableMultiplier(75, 30), closeTo(0.225, 0.001));
      expect(Calculations.variableMultiplier(85, 20), closeTo(0.17, 0.001));
      expect(Calculations.variableMultiplier(70, 20), closeTo(0.14, 0.001));
      expect(Calculations.variableMultiplier(60, 10), closeTo(0.06, 0.001));
    });

    test('total salary multiplier = 0.765', () {
      final multiplier = Calculations.totalSalaryMultiplier(
        a: 80, b: 90, c: 75, d: 85, e: 70, f: 60,
        wA: 10, wB: 10, wC: 30, wD: 20, wE: 20, wF: 10,
      );
      expect(multiplier, closeTo(0.765, 0.001));
    });

    test('calculated salary = 50000 × 0.765 = 38250', () {
      final salary = Calculations.monthlySalary(50000, 0.765);
      expect(salary, 38250.0);
    });

    test('full pipeline from raw percentages to salary', () {
      final multiplier = Calculations.totalSalaryMultiplier(
        a: 80, b: 90, c: 75, d: 85, e: 70, f: 60,
        wA: 10, wB: 10, wC: 30, wD: 20, wE: 20, wF: 10,
      );
      final salary = Calculations.monthlySalary(50000, multiplier);

      // Expected: 0.08 + 0.09 + 0.225 + 0.17 + 0.14 + 0.06 = 0.765
      // Salary: 50000 × 0.765 = 38250
      expect(multiplier, closeTo(0.765, 0.001));
      expect(salary, closeTo(38250, 1));
    });
  });
}
