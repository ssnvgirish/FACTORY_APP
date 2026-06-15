import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/utils/calculations.dart';

void main() {
  group('Maintenance Duration Calculations', () {
    group('maintenanceDurationHours()', () {
      test('09:00–10:30 → 1.5 hours', () {
        final start = DateTime(2026, 3, 15, 9, 0);
        final end = DateTime(2026, 3, 15, 10, 30);
        expect(Calculations.maintenanceDurationHours(start, end), 1.5);
      });

      test('09:00–12:00 → 3.0 hours', () {
        final start = DateTime(2026, 3, 15, 9, 0);
        final end = DateTime(2026, 3, 15, 12, 0);
        expect(Calculations.maintenanceDurationHours(start, end), 3.0);
      });

      test('13:00–13:30 → 0.5 hours', () {
        final start = DateTime(2026, 3, 15, 13, 0);
        final end = DateTime(2026, 3, 15, 13, 30);
        expect(Calculations.maintenanceDurationHours(start, end), 0.5);
      });

      test('start == end → 0.0 hours', () {
        final time = DateTime(2026, 3, 15, 9, 0);
        expect(Calculations.maintenanceDurationHours(time, time), 0.0);
      });

      test('22:00–02:00 next day (4 hours crossing midnight)', () {
        final start = DateTime(2026, 3, 15, 22, 0);
        final end = DateTime(2026, 3, 16, 2, 0);
        expect(Calculations.maintenanceDurationHours(start, end), 4.0);
      });

      test('23:30–02:30 next day (3 hours crossing midnight)', () {
        final start = DateTime(2026, 3, 15, 23, 30);
        final end = DateTime(2026, 3, 16, 2, 30);
        expect(Calculations.maintenanceDurationHours(start, end), 3.0);
      });
    });

    group('maintenanceDuration() raw Duration', () {
      test('returns correct Duration object', () {
        final start = DateTime(2026, 3, 15, 9, 0);
        final end = DateTime(2026, 3, 15, 11, 15);
        final duration = Calculations.maintenanceDuration(start, end);
        expect(duration.inHours, 2);
        expect(duration.inMinutes, 135);
      });
    });

    group('formatDuration()', () {
      test('2h 30m formatted correctly', () {
        expect(Calculations.formatDuration(const Duration(hours: 2, minutes: 30)), '2h 30m');
      });

      test('0h 0m formatted correctly', () {
        expect(Calculations.formatDuration(Duration.zero), '0h 0m');
      });

      test('1h 0m formatted correctly', () {
        expect(Calculations.formatDuration(const Duration(hours: 1)), '1h 0m');
      });
    });

    group('cappedMaintenanceDuration() - Frame Machine', () {
      test('Die Change, 3.0hr → capped at 2.0', () {
        expect(
          Calculations.cappedMaintenanceDuration(
            maintenanceItem: 'Die Change',
            actualHours: 3.0,
            isFrameMachine: true,
          ),
          2.0,
        );
      });

      test('Die Change, 1.5hr → returns 1.5 (under cap)', () {
        expect(
          Calculations.cappedMaintenanceDuration(
            maintenanceItem: 'Die Change',
            actualHours: 1.5,
            isFrameMachine: true,
          ),
          1.5,
        );
      });

      test('Die Change, 2.0hr → returns 2.0 (exactly at cap)', () {
        expect(
          Calculations.cappedMaintenanceDuration(
            maintenanceItem: 'Die Change',
            actualHours: 2.0,
            isFrameMachine: true,
          ),
          2.0,
        );
      });

      test('Die Cleaning, 2.0hr → capped at 1.0', () {
        expect(
          Calculations.cappedMaintenanceDuration(
            maintenanceItem: 'Die Cleaning',
            actualHours: 2.0,
            isFrameMachine: true,
          ),
          1.0,
        );
      });

      test('Die Cleaning, 0.5hr → returns 0.5', () {
        expect(
          Calculations.cappedMaintenanceDuration(
            maintenanceItem: 'Die Cleaning',
            actualHours: 0.5,
            isFrameMachine: true,
          ),
          0.5,
        );
      });

      test('Generator Maintenance, 5.0hr → returns 5.0 (no cap)', () {
        expect(
          Calculations.cappedMaintenanceDuration(
            maintenanceItem: 'Generator Maintenance',
            actualHours: 5.0,
            isFrameMachine: true,
          ),
          5.0,
        );
      });

      test('Others, 10.0hr → returns 10.0 (no cap)', () {
        expect(
          Calculations.cappedMaintenanceDuration(
            maintenanceItem: 'Others',
            actualHours: 10.0,
            isFrameMachine: true,
          ),
          10.0,
        );
      });
    });

    group('cappedMaintenanceDuration() - Sheet Machine', () {
      test('Die Change, 5.0hr → capped at 4.0', () {
        expect(
          Calculations.cappedMaintenanceDuration(
            maintenanceItem: 'Die Change',
            actualHours: 5.0,
            isFrameMachine: false,
          ),
          4.0,
        );
      });

      test('Die Change, 3.0hr → returns 3.0 (under cap)', () {
        expect(
          Calculations.cappedMaintenanceDuration(
            maintenanceItem: 'Die Change',
            actualHours: 3.0,
            isFrameMachine: false,
          ),
          3.0,
        );
      });

      test('Die Cleaning, 3.0hr → capped at 2.0', () {
        expect(
          Calculations.cappedMaintenanceDuration(
            maintenanceItem: 'Die Cleaning',
            actualHours: 3.0,
            isFrameMachine: false,
          ),
          2.0,
        );
      });

      test('Die Cleaning, 1.0hr → returns 1.0', () {
        expect(
          Calculations.cappedMaintenanceDuration(
            maintenanceItem: 'Die Cleaning',
            actualHours: 1.0,
            isFrameMachine: false,
          ),
          1.0,
        );
      });

      test('Air Compressor Maintenance → returns actual (no cap)', () {
        expect(
          Calculations.cappedMaintenanceDuration(
            maintenanceItem: 'Air Compressor Maintenance',
            actualHours: 7.0,
            isFrameMachine: false,
          ),
          7.0,
        );
      });
    });

    group('totalMaintenanceDuration()', () {
      test('mixed items with caps applied for frame machine', () {
        final entries = [
          {'maintenanceItem': 'Die Change', 'durationHours': 3.0},
          {'maintenanceItem': 'Generator Maintenance', 'durationHours': 0.5},
        ];
        // Die Change capped at 2.0, Generator at 0.5 → total 2.5
        expect(
          Calculations.totalMaintenanceDuration(entries: entries, isFrameMachine: true),
          2.5,
        );
      });

      test('empty list → 0.0', () {
        expect(
          Calculations.totalMaintenanceDuration(entries: [], isFrameMachine: true),
          0.0,
        );
      });

      test('single entry → correct capped duration', () {
        final entries = [
          {'maintenanceItem': 'Die Cleaning', 'durationHours': 1.5},
        ];
        expect(
          Calculations.totalMaintenanceDuration(entries: entries, isFrameMachine: true),
          1.0,
        );
      });

      test('multiple items all uncapped', () {
        final entries = [
          {'maintenanceItem': 'Generator Maintenance', 'durationHours': 1.0},
          {'maintenanceItem': 'Others', 'durationHours': 2.0},
          {'maintenanceItem': 'Chiller Maintenance', 'durationHours': 0.5},
        ];
        expect(
          Calculations.totalMaintenanceDuration(entries: entries, isFrameMachine: true),
          3.5,
        );
      });

      test('sheet machine caps applied correctly in total', () {
        final entries = [
          {'maintenanceItem': 'Die Change', 'durationHours': 5.0},
          {'maintenanceItem': 'Die Cleaning', 'durationHours': 3.0},
        ];
        // Die Change capped at 4.0, Die Cleaning capped at 2.0 → total 6.0
        expect(
          Calculations.totalMaintenanceDuration(entries: entries, isFrameMachine: false),
          6.0,
        );
      });
    });
  });
}
