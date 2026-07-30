/// Inclusive week windows for report list pagination.
class ReportWeekRange {
  ReportWeekRange._();

  static const int daysPerPage = 7;

  static DateTime dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  /// Most recent [daysPerPage] days ending today (inclusive).
  static ({DateTime start, DateTime end}) initial({DateTime? now}) {
    final end = dateOnly(now ?? DateTime.now());
    final start = end.subtract(const Duration(days: daysPerPage - 1));
    return (start: start, end: end);
  }

  /// Inclusive week immediately before [currentStart].
  static ({DateTime start, DateTime end}) previousWeek(DateTime currentStart) {
    final end = dateOnly(currentStart).subtract(const Duration(days: 1));
    final start = end.subtract(const Duration(days: daysPerPage - 1));
    return (start: start, end: end);
  }
}
