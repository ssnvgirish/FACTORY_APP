/// Result of merging a newly fetched report page into an existing list.
class ReportPageMerge<T> {
  final List<T> items;
  final bool hasMore;
  final DateTime? oldestLoadedStart;

  const ReportPageMerge({
    required this.items,
    required this.hasMore,
    required this.oldestLoadedStart,
  });
}

/// Merges a fetched week of reports for list pagination.
///
/// Initial loads always keep [hasMore] true so older weeks can be requested.
/// Append loads set [hasMore] false when the fetched week is empty.
ReportPageMerge<T> mergeReportPage<T>({
  required bool append,
  List<T>? existing,
  required List<T> fetched,
  required DateTime? requestStart,
  DateTime? previousOldestStart,
}) {
  if (!append) {
    return ReportPageMerge(
      items: fetched,
      hasMore: true,
      oldestLoadedStart: requestStart,
    );
  }

  return ReportPageMerge(
    items: [...?existing, ...fetched],
    hasMore: fetched.isNotEmpty,
    oldestLoadedStart: requestStart ?? previousOldestStart,
  );
}
