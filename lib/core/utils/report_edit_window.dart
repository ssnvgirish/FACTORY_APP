import '../constants/app_constants.dart';

/// Whether a submitted report can still be edited by the operator.
bool canEditSubmittedReport(DateTime? submittedAt, {DateTime? now}) {
  if (submittedAt == null) return false;
  final elapsed = (now ?? DateTime.now()).difference(submittedAt);
  return elapsed >= Duration.zero && elapsed <= AppConstants.reportEditWindow;
}
