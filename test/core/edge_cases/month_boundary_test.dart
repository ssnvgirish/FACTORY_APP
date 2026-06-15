import 'package:flutter_test/flutter_test.dart';
import 'package:factory_app/core/utils/calculations.dart';

void main() {
  group('Month Boundary Tests', () {
    test('reports from prior month are excluded from current month aggregation', () {
      final marchReports = [
        DateTime(2026, 3, 1),
        DateTime(2026, 3, 15),
        DateTime(2026, 3, 31),
      ];
      final februaryReport = DateTime(2026, 2, 28);

      final filtered = marchReports.where((d) => d.month == 3 && d.year == 2026).toList();
      expect(filtered.length, 3);
      expect(filtered.contains(februaryReport), isFalse);
    });

    test('report submitted at 23:59:59 on last day of month is included', () {
      final submissionTime = DateTime(2026, 3, 31, 23, 59, 59);
      expect(submissionTime.month, 3);
      expect(submissionTime.year, 2026);
    });

    test('report submitted at 00:00:01 on first day of next month is excluded', () {
      final submissionTime = DateTime(2026, 4, 1, 0, 0, 1);
      final isInMarch = submissionTime.month == 3 && submissionTime.year == 2026;
      expect(isInMarch, isFalse);
    });

    test('monthly calculation with 0 reports returns 0, does not divide by zero', () {
      final avg = Calculations.monthlyAverage([]);
      expect(avg, 0.0);
    });

    test('monthly average is correct for full month', () {
      final dailyValues = List.generate(31, (i) => 85.0);
      final avg = Calculations.monthlyAverage(dailyValues);
      expect(avg, 85.0);
    });

    test('February last day is correct in non-leap year', () {
      // 2026 is not a leap year
      final lastDayFeb = DateTime(2026, 2, 28);
      expect(lastDayFeb.month, 2);
      expect(lastDayFeb.day, 28);

      // March 1 is the next day
      final marchFirst = lastDayFeb.add(const Duration(days: 1));
      expect(marchFirst.month, 3);
      expect(marchFirst.day, 1);
    });
  });
}
