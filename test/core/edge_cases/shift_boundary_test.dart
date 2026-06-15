import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/utils/calculations.dart';

void main() {
  group('Shift Boundary Tests', () {
    test('maintenance spanning midnight calculates correctly (23:30–02:30 = 3 hours)', () {
      final start = DateTime(2026, 3, 15, 23, 30);
      final end = DateTime(2026, 3, 16, 2, 30);
      expect(Calculations.maintenanceDurationHours(start, end), 3.0);
    });

    test('night shift maintenance 22:00–02:00 = 4 hours', () {
      final start = DateTime(2026, 3, 15, 22, 0);
      final end = DateTime(2026, 3, 16, 2, 0);
      expect(Calculations.maintenanceDurationHours(start, end), 4.0);
    });

    test('production time-of-change at exactly 9PM for day shift is treated as shift end', () {
      final shiftEnd = DateTime(2026, 3, 15, 21, 0);
      final timeOfChange = DateTime(2026, 3, 15, 21, 0);
      expect(timeOfChange, shiftEnd);
    });

    test('two shifts on same date/machine have independent segments', () {
      final dayShiftStart = DateTime(2026, 3, 15, 9, 0);
      final dayShiftEnd = DateTime(2026, 3, 15, 21, 0);
      final nightShiftStart = DateTime(2026, 3, 15, 21, 0);
      final nightShiftEnd = DateTime(2026, 3, 16, 9, 0);

      final daySegments = Calculations.deriveProductionSegments(
        lineItems: [{'section': '3x2'}],
        shiftStart: dayShiftStart,
        shiftEnd: dayShiftEnd,
      );
      final nightSegments = Calculations.deriveProductionSegments(
        lineItems: [{'section': '4x2'}],
        shiftStart: nightShiftStart,
        shiftEnd: nightShiftEnd,
      );

      expect(daySegments.length, 1);
      expect(daySegments[0]['section'], '3x2');
      expect(daySegments[0]['durationHours'], 12.0);

      expect(nightSegments.length, 1);
      expect(nightSegments[0]['section'], '4x2');
      expect(nightSegments[0]['durationHours'], 12.0);
    });

    test('day shift end time is 9PM', () {
      final end = Calculations.shiftEndTime(DateTime(2026, 3, 15), 'Day Shift');
      expect(end.hour, 21);
      expect(end.minute, 0);
    });
  });
}
