import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/utils/calculations.dart';
import 'package:factory_app/core/utils/validators.dart';

void main() {
  group('Salary Multiplier Calculations', () {
    group('variableMultiplier()', () {
      test('100% value with 100% weightage returns 1.0', () {
        expect(Calculations.variableMultiplier(100, 100), 1.0);
      });

      test('0% value returns 0.0 regardless of weightage', () {
        expect(Calculations.variableMultiplier(0, 50), 0.0);
      });

      test('50% value with 50% weightage returns 0.25', () {
        expect(Calculations.variableMultiplier(50, 50), 0.25);
      });

      test('80% value with 10% weightage returns 0.08', () {
        expect(Calculations.variableMultiplier(80, 10), closeTo(0.08, 0.001));
      });
    });

    group('totalSalaryMultiplier()', () {
      test(
        'all variables at 100% with equal weightages summing to ~100 returns ~1.0',
        () {
          // 6 equal weights of 16.667 each ≈ 100
          // Use weights that sum to exactly 100 for precision.
          // Using weights: 20, 20, 20, 10, 10, 20 = 100
          final result = Calculations.totalSalaryMultiplier(
            a: 100,
            b: 100,
            c: 100,
            d: 100,
            e: 100,
            f: 100,
            wA: 20,
            wB: 20,
            wC: 20,
            wD: 10,
            wE: 10,
            wF: 20,
          );
          expect(result, closeTo(1.0, 0.001));
        },
      );

      test('all variables at 0% returns 0.0', () {
        final result = Calculations.totalSalaryMultiplier(
          a: 0,
          b: 0,
          c: 0,
          d: 0,
          e: 0,
          f: 0,
          wA: 10,
          wB: 10,
          wC: 30,
          wD: 20,
          wE: 20,
          wF: 10,
        );
        expect(result, 0.0);
      });

      test(
        'mixed values with specified weightages returns correct multiplier',
        () {
          // a=80, b=90, c=75, d=85, e=70, f=60
          // wA=10, wB=10, wC=30, wD=20, wE=20, wF=10
          // = 0.08 + 0.09 + 0.225 + 0.17 + 0.14 + 0.06 = 0.765
          final result = Calculations.totalSalaryMultiplier(
            a: 80,
            b: 90,
            c: 75,
            d: 85,
            e: 70,
            f: 60,
            wA: 10,
            wB: 10,
            wC: 30,
            wD: 20,
            wE: 20,
            wF: 10,
          );
          expect(result, closeTo(0.765, 0.001));
        },
      );

      test(
        'single variable at 100, rest at 0 returns that variables weightage/100',
        () {
          final result = Calculations.totalSalaryMultiplier(
            a: 100,
            b: 0,
            c: 0,
            d: 0,
            e: 0,
            f: 0,
            wA: 10,
            wB: 10,
            wC: 30,
            wD: 20,
            wE: 20,
            wF: 10,
          );
          expect(result, closeTo(0.10, 0.001));
        },
      );

      test('only variable c at 100, rest 0 returns wC/100', () {
        final result = Calculations.totalSalaryMultiplier(
          a: 0,
          b: 0,
          c: 100,
          d: 0,
          e: 0,
          f: 0,
          wA: 10,
          wB: 10,
          wC: 30,
          wD: 20,
          wE: 20,
          wF: 10,
        );
        expect(result, closeTo(0.30, 0.001));
      });

      test('all at 50% with equal weights [20 each] returns 0.5', () {
        final result = Calculations.totalSalaryMultiplier(
          a: 50,
          b: 50,
          c: 50,
          d: 50,
          e: 50,
          f: 50,
          wA: 20,
          wB: 20,
          wC: 20,
          wD: 10,
          wE: 10,
          wF: 20,
        );
        expect(result, closeTo(0.5, 0.001));
      });
    });

    group('monthlySalary()', () {
      test('fixedSalary × multiplier computed correctly', () {
        expect(Calculations.monthlySalary(50000, 0.765), 38250.0);
      });

      test('fixedSalary = 0 returns 0 regardless of multiplier', () {
        expect(Calculations.monthlySalary(0, 0.765), 0.0);
      });

      test('multiplier = 0 returns 0 regardless of salary', () {
        expect(Calculations.monthlySalary(50000, 0), 0.0);
      });

      test('multiplier = 1.0 returns full salary', () {
        expect(Calculations.monthlySalary(50000, 1.0), 50000.0);
      });

      test('result is rounded to 2 decimal places', () {
        // 33333 × 0.765 = 25499.745 → toStringAsFixed(2) rounds
        final result = Calculations.monthlySalary(33333, 0.765);
        expect(result, closeTo(25499.75, 0.01));
      });
    });

    group('monthlyAverage()', () {
      test('calculates average correctly', () {
        expect(Calculations.monthlyAverage([5, 4, 3, 2, 0]), 2.8);
      });

      test('empty list returns 0', () {
        expect(Calculations.monthlyAverage([]), 0.0);
      });

      test('all same values returns that value', () {
        expect(Calculations.monthlyAverage([5, 5, 5, 5, 5]), 5.0);
      });

      test('single value returns itself', () {
        expect(Calculations.monthlyAverage([3.5]), 3.5);
      });
    });

    group('validateWeightagesSum()', () {
      test('weightages summing to 100 passes validation', () {
        final result = Validators.validateWeightagesSum({
          'a': 10,
          'b': 10,
          'c': 30,
          'd': 20,
          'e': 20,
          'f': 10,
        });
        expect(result, isNull);
      });

      test('weightages summing to 95 fails validation', () {
        final result = Validators.validateWeightagesSum({
          'a': 10,
          'b': 10,
          'c': 25,
          'd': 20,
          'e': 20,
          'f': 10,
        });
        expect(result, isNotNull);
        expect(result, contains('must sum to 100'));
      });

      test('weightages summing to 110 fails validation', () {
        final result = Validators.validateWeightagesSum({
          'a': 20,
          'b': 20,
          'c': 30,
          'd': 20,
          'e': 20,
          'f': 10,
        });
        expect(result, contains('must sum to 100'));
      });
    });
  });
}
