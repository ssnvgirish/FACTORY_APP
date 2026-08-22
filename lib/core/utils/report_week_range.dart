/// Inclusive date windows for report list pagination.
class ReportWeekRange {
  ReportWeekRange._();

  static const int daysPerPage = 7;
  static const int dayPerPage = 1;

  static DateTime dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  static DateTime monthStart(DateTime value) =>
      DateTime(value.year, value.month);

  /// Most recent [days] days ending today (inclusive). Defaults to a week.
  static ({DateTime start, DateTime end}) initial({
    DateTime? now,
    int days = daysPerPage,
  }) {
    final end = dateOnly(now ?? DateTime.now());
    final start = end.subtract(Duration(days: days - 1));
    return (start: start, end: end);
  }

  /// Inclusive window immediately before [currentStart].
  static ({DateTime start, DateTime end}) previousWeek(
    DateTime currentStart, {
    int days = daysPerPage,
  }) {
    final end = dateOnly(currentStart).subtract(const Duration(days: 1));
    final start = end.subtract(Duration(days: days - 1));
    return (start: start, end: end);
  }

  /// Inclusive window for the [week]th week of [month] (1-based, 7-day buckets).
  static ({DateTime start, DateTime end}) weekOfMonth(
    DateTime month,
    int week,
  ) {
    final last = DateTime(month.year, month.month + 1, 0);
    final startDay = 1 + (week - 1) * daysPerPage;
    final start = DateTime(
      month.year,
      month.month,
      startDay.clamp(1, last.day),
    );
    var end = start.add(const Duration(days: daysPerPage - 1));
    if (end.isAfter(last)) end = last;
    return (start: start, end: end);
  }

  static int weeksInMonth(DateTime month) {
    final last = DateTime(month.year, month.month + 1, 0);
    return ((last.day - 1) ~/ daysPerPage) + 1;
  }

  /// Today only (daily report lists).
  static ({DateTime start, DateTime end}) initialDay({DateTime? now}) =>
      initial(now: now, days: dayPerPage);

  /// Previous calendar day relative to [currentStart].
  static ({DateTime start, DateTime end}) previousDay(DateTime currentStart) =>
      previousWeek(currentStart, days: dayPerPage);
}
