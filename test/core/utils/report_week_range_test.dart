import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/utils/report_week_range.dart';

void main() {
  group('ReportWeekRange.weekOfMonthIndex', () {
    test('returns the bucket whose window contains the date', () {
      for (final day in [1, 7, 8, 14, 15, 21, 22, 28, 29, 30]) {
        final date = DateTime(2026, 9, day);
        final week = ReportWeekRange.weekOfMonthIndex(date);
        final range = ReportWeekRange.weekOfMonth(
          ReportWeekRange.monthStart(date),
          week,
        );

        expect(
          !date.isBefore(range.start) && !date.isAfter(range.end),
          isTrue,
          reason:
              'Sep $day should fall inside week $week '
              '(${range.start} — ${range.end})',
        );
      }
    });

    test('every day of a 31-day month lands in a window containing it', () {
      for (var day = 1; day <= 31; day++) {
        final date = DateTime(2026, 7, day);
        final range = ReportWeekRange.weekOfMonth(
          ReportWeekRange.monthStart(date),
          ReportWeekRange.weekOfMonthIndex(date),
        );

        expect(!date.isBefore(range.start) && !date.isAfter(range.end), isTrue);
      }
    });

    test('index stays within weeksInMonth', () {
      for (var month = 1; month <= 12; month++) {
        final last = DateTime(2026, month + 1, 0);
        final index = ReportWeekRange.weekOfMonthIndex(last);

        expect(
          index,
          lessThanOrEqualTo(ReportWeekRange.weeksInMonth(last)),
        );
      }
    });

    test('early-month dates are not in the final week of the month', () {
      // Regression: report list pages defaulted to weeksInMonth(), which for
      // a 30-day month is Sep 29–30 — a window that excludes most of the month
      // and left the list empty on any other day.
      final earlyDate = DateTime(2026, 9, 3);
      final lastWeek = ReportWeekRange.weekOfMonth(
        ReportWeekRange.monthStart(earlyDate),
        ReportWeekRange.weeksInMonth(earlyDate),
      );

      expect(earlyDate.isBefore(lastWeek.start), isTrue);
      expect(ReportWeekRange.weekOfMonthIndex(earlyDate), 1);
    });
  });
}
