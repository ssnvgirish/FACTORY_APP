import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/utils/calculations.dart';

void main() {
  group('Target Weight Calculations', () {
    group('calculateTargetWeight()', () {
      test('Scenario 1 — single section full shift (12 hrs)', () {
        final segments = [
          {'section': '3x2', 'durationHours': 12.0},
        ];
        final targets = {'3x2': 100.0};
        expect(
          Calculations.calculateTargetWeight(segments: segments, targetPerHour: targets),
          1200.0,
        );
      });

      test('Scenario 2 — section change mid-shift', () {
        // 3x2 for 6 hours, 4x2 for 6 hours
        final segments = [
          {'section': '3x2', 'durationHours': 6.0},
          {'section': '4x2', 'durationHours': 6.0},
        ];
        final targets = {'3x2': 100.0, '4x2': 120.0};
        // (6×100) + (6×120) = 600 + 720 = 1320
        expect(
          Calculations.calculateTargetWeight(segments: segments, targetPerHour: targets),
          1320.0,
        );
      });

      test('Scenario 3 — multiple section changes', () {
        // 3x2: 2hrs, 4x2.5: 5hrs, 5x2.5: 5hrs
        final segments = [
          {'section': '3x2', 'durationHours': 2.0},
          {'section': '4x2.5', 'durationHours': 5.0},
          {'section': '5x2.5', 'durationHours': 5.0},
        ];
        final targets = {'3x2': 100.0, '4x2.5': 130.0, '5x2.5': 150.0};
        // (2×100) + (5×130) + (5×150) = 200 + 650 + 750 = 1600
        expect(
          Calculations.calculateTargetWeight(segments: segments, targetPerHour: targets),
          1600.0,
        );
      });

      test('Scenario 4 — empty segments → 0', () {
        expect(
          Calculations.calculateTargetWeight(segments: [], targetPerHour: {'3x2': 100.0}),
          0.0,
        );
      });

      test('Scenario 5 — section not in target table uses 0 rate', () {
        final segments = [
          {'section': 'UnknownSection', 'durationHours': 12.0},
        ];
        expect(
          Calculations.calculateTargetWeight(segments: segments, targetPerHour: {'3x2': 100.0}),
          0.0,
        );
      });

      test('Scenario 6 — 0 duration segments', () {
        final segments = [
          {'section': '3x2', 'durationHours': 0.0},
        ];
        expect(
          Calculations.calculateTargetWeight(segments: segments, targetPerHour: {'3x2': 100.0}),
          0.0,
        );
      });
    });

    group('deriveProductionSegments()', () {
      test('single line item covers full shift', () {
        final shiftStart = DateTime(2026, 3, 15, 9, 0);
        final shiftEnd = DateTime(2026, 3, 15, 21, 0);
        final lineItems = [
          {'section': '3x2'},
        ];
        final segments = Calculations.deriveProductionSegments(
          lineItems: lineItems,
          shiftStart: shiftStart,
          shiftEnd: shiftEnd,
        );
        expect(segments.length, 1);
        expect(segments[0]['section'], '3x2');
        expect(segments[0]['durationHours'], 12.0);
      });

      test('two items with time-of-change', () {
        final shiftStart = DateTime(2026, 3, 15, 9, 0);
        final shiftEnd = DateTime(2026, 3, 15, 21, 0);
        final lineItems = [
          {'section': '3x2'},
          {'section': '4x2', 'timeOfChange': DateTime(2026, 3, 15, 15, 0)},
        ];
        final segments = Calculations.deriveProductionSegments(
          lineItems: lineItems,
          shiftStart: shiftStart,
          shiftEnd: shiftEnd,
        );
        expect(segments.length, 2);
        expect(segments[0]['section'], '3x2');
        expect(segments[0]['durationHours'], 6.0); // 9AM–3PM
        expect(segments[1]['section'], '4x2');
        expect(segments[1]['durationHours'], 6.0); // 3PM–9PM
      });

      test('three items with time-of-change', () {
        final shiftStart = DateTime(2026, 3, 15, 9, 0);
        final shiftEnd = DateTime(2026, 3, 15, 21, 0);
        final lineItems = [
          {'section': '3x2'},
          {'section': '4x2.5', 'timeOfChange': DateTime(2026, 3, 15, 11, 0)},
          {'section': '5x2.5', 'timeOfChange': DateTime(2026, 3, 15, 16, 0)},
        ];
        final segments = Calculations.deriveProductionSegments(
          lineItems: lineItems,
          shiftStart: shiftStart,
          shiftEnd: shiftEnd,
        );
        expect(segments.length, 3);
        expect(segments[0]['durationHours'], 2.0); // 9AM–11AM
        expect(segments[1]['durationHours'], 5.0); // 11AM–4PM
        expect(segments[2]['durationHours'], 5.0); // 4PM–9PM
      });

      test('night shift (9PM–9AM next day)', () {
        final shiftStart = DateTime(2026, 3, 15, 21, 0);
        final shiftEnd = DateTime(2026, 3, 16, 9, 0);
        final lineItems = [
          {'section': '3x2'},
          {'section': '4x2', 'timeOfChange': DateTime(2026, 3, 16, 3, 0)},
        ];
        final segments = Calculations.deriveProductionSegments(
          lineItems: lineItems,
          shiftStart: shiftStart,
          shiftEnd: shiftEnd,
        );
        expect(segments.length, 2);
        expect(segments[0]['durationHours'], 6.0); // 9PM–3AM
        expect(segments[1]['durationHours'], 6.0); // 3AM–9AM
      });

      test('empty line items → empty segments', () {
        final shiftStart = DateTime(2026, 3, 15, 9, 0);
        final shiftEnd = DateTime(2026, 3, 15, 21, 0);
        final segments = Calculations.deriveProductionSegments(
          lineItems: [],
          shiftStart: shiftStart,
          shiftEnd: shiftEnd,
        );
        expect(segments, isEmpty);
      });
    });

    group('shiftEndTime()', () {
      test('Day Shift ends at 9PM same day', () {
        final end = Calculations.shiftEndTime(DateTime(2026, 3, 15), 'Day Shift');
        expect(end, DateTime(2026, 3, 15, 21, 0));
      });

      test('Night Shift ends at 9AM next day', () {
        final end = Calculations.shiftEndTime(DateTime(2026, 3, 15), 'Night Shift');
        expect(end, DateTime(2026, 3, 16, 9, 0));
      });
    });
  });
}
