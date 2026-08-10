/// Inclusive date windows for report list pagination.
class ReportWeekRange {
  ReportWeekRange._();

  static const int daysPerPage = 7;
  static const int dayPerPage = 1;

  static DateTime dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);

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

  /// Today only (daily report lists).
  static ({DateTime start, DateTime end}) initialDay({DateTime? now}) =>
      initial(now: now, days: dayPerPage);

  /// Previous calendar day relative to [currentStart].
  static ({DateTime start, DateTime end}) previousDay(DateTime currentStart) =>
      previousWeek(currentStart, days: dayPerPage);
}
