import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/utils/calculations.dart';

void main() {
  group('Report Writing Efficiency', () {
    group('reportWritingScore() - Day Shift (ends 21:00)', () {
      final shiftEnd = DateTime(2026, 3, 15, 21, 0);

      test('submission at shift end → score=5', () {
        expect(Calculations.reportWritingScore(shiftEnd, shiftEnd), 5);
      });

      test('submission 30 min after → score=5', () {
        final sub = DateTime(2026, 3, 15, 21, 30);
        expect(Calculations.reportWritingScore(sub, shiftEnd), 5);
      });

      test('submission 59 min after → score=5', () {
        final sub = DateTime(2026, 3, 15, 21, 59);
        expect(Calculations.reportWritingScore(sub, shiftEnd), 5);
      });

      test(
        'submission exactly 1 hour after → score=5 (boundary inclusive)',
        () {
          final sub = DateTime(2026, 3, 15, 22, 0);
          expect(Calculations.reportWritingScore(sub, shiftEnd), 5);
        },
      );

      test('submission 1hr 1min after → score=4', () {
        final sub = DateTime(2026, 3, 15, 22, 1);
        expect(Calculations.reportWritingScore(sub, shiftEnd), 4);
      });

      test('submission 5hr 59min after → score=4', () {
        final sub = DateTime(2026, 3, 16, 2, 59);
        expect(Calculations.reportWritingScore(sub, shiftEnd), 4);
      });

      test(
        'submission exactly 6 hours after → score=4 (boundary inclusive)',
        () {
          final sub = DateTime(2026, 3, 16, 3, 0);
          expect(Calculations.reportWritingScore(sub, shiftEnd), 4);
        },
      );

      test('submission 6hr 1min after → score=3', () {
        final sub = DateTime(2026, 3, 16, 3, 1);
        expect(Calculations.reportWritingScore(sub, shiftEnd), 3);
      });

      test('submission 11hr 59min after → score=3', () {
        final sub = DateTime(2026, 3, 16, 8, 59);
        expect(Calculations.reportWritingScore(sub, shiftEnd), 3);
      });

      test(
        'submission exactly 12 hours after → score=3 (boundary inclusive)',
        () {
          final sub = DateTime(2026, 3, 16, 9, 0);
          expect(Calculations.reportWritingScore(sub, shiftEnd), 3);
        },
      );

      test('submission 12hr 1min after → score=2', () {
        final sub = DateTime(2026, 3, 16, 9, 1);
        expect(Calculations.reportWritingScore(sub, shiftEnd), 2);
      });

      test('submission 23hr 59min after → score=2', () {
        final sub = DateTime(2026, 3, 16, 20, 59);
        expect(Calculations.reportWritingScore(sub, shiftEnd), 2);
      });

      test(
        'submission exactly 24 hours after → score=2 (boundary inclusive)',
        () {
          final sub = DateTime(2026, 3, 16, 21, 0);
          expect(Calculations.reportWritingScore(sub, shiftEnd), 2);
        },
      );

      test('submission 24hr 1min after → score=0', () {
        final sub = DateTime(2026, 3, 16, 21, 1);
        expect(Calculations.reportWritingScore(sub, shiftEnd), 0);
      });
    });

    group('reportWritingScore() - Night Shift (ends 09:00)', () {
      final shiftEnd = DateTime(2026, 3, 16, 9, 0);

      test('submission at shift end → score=5', () {
        expect(Calculations.reportWritingScore(shiftEnd, shiftEnd), 5);
      });

      test('submission 45 min after → score=5', () {
        final sub = DateTime(2026, 3, 16, 9, 45);
        expect(Calculations.reportWritingScore(sub, shiftEnd), 5);
      });

      test('submission 1hr 30min after → score=4', () {
        final sub = DateTime(2026, 3, 16, 10, 30);
        expect(Calculations.reportWritingScore(sub, shiftEnd), 4);
      });

      test('submission 11hr 59min after → score=3', () {
        final sub = DateTime(2026, 3, 16, 20, 59);
        expect(Calculations.reportWritingScore(sub, shiftEnd), 3);
      });

      test('submission 13hr after → score=2', () {
        final sub = DateTime(2026, 3, 16, 22, 0);
        expect(Calculations.reportWritingScore(sub, shiftEnd), 2);
      });

      test('submission 25hr after → score=0', () {
        final sub = DateTime(2026, 3, 17, 10, 0);
        expect(Calculations.reportWritingScore(sub, shiftEnd), 0);
      });
    });

    group('monthly average score', () {
      test('[5, 4, 3, 2, 0] → avg=2.8, percentage=56.0%', () {
        final scores = [5.0, 4.0, 3.0, 2.0, 0.0];
        final avg = Calculations.monthlyAverage(scores);
        expect(avg, 2.8);
        final percentage = (avg / 5) * 100;
        expect(percentage, closeTo(56.0, 0.01));
      });

      test('empty list → 0.0%', () {
        final avg = Calculations.monthlyAverage([]);
        expect(avg, 0.0);
        final percentage = (avg / 5) * 100;
        expect(percentage, 0.0);
      });

      test('all 5s → 100.0%', () {
        final scores = [5.0, 5.0, 5.0, 5.0, 5.0];
        final avg = Calculations.monthlyAverage(scores);
        expect(avg, 5.0);
        final percentage = (avg / 5) * 100;
        expect(percentage, 100.0);
      });

      test('all 0s → 0.0%', () {
        final scores = [0.0, 0.0, 0.0, 0.0];
        final avg = Calculations.monthlyAverage(scores);
        expect(avg, 0.0);
      });

      test('single score → that score as average', () {
        final avg = Calculations.monthlyAverage([4.0]);
        expect(avg, 4.0);
        final percentage = (avg / 5) * 100;
        expect(percentage, 80.0);
      });
    });
  });
}
