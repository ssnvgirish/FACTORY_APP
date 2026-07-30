import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../frames/domain/entities/frame_entities.dart';
import '../../domain/entities/sheet_entities.dart';
import '../../domain/repositories/sheet_repository.dart';
import '../../../../core/utils/report_list_pagination.dart';

// ═══════════════════════════════════════
// EVENTS
// ═══════════════════════════════════════

abstract class SheetReportsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSheetCleaningReports extends SheetReportsEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool append;
  LoadSheetCleaningReports({
    this.machineNumber,
    this.startDate,
    this.endDate,
    this.append = false,
  });
}

class SubmitSheetCleaningReport extends SheetReportsEvent {
  final MachineCleaningReport report;
  SubmitSheetCleaningReport(this.report);
}

class LoadSheetToolsCountReports extends SheetReportsEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool append;
  LoadSheetToolsCountReports({
    this.machineNumber,
    this.startDate,
    this.endDate,
    this.append = false,
  });
}

class SubmitSheetToolsCountReport extends SheetReportsEvent {
  final ToolsCountReport report;
  SubmitSheetToolsCountReport(this.report);
}

class LoadSheetHealthReports extends SheetReportsEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool append;
  LoadSheetHealthReports({
    this.machineNumber,
    this.startDate,
    this.endDate,
    this.append = false,
  });
}

class SubmitSheetHealthReport extends SheetReportsEvent {
  final MachineHealthReport report;
  SubmitSheetHealthReport(this.report);
}

class LoadSheetPendingApprovals extends SheetReportsEvent {}

class LoadSheetProductionDetailsReports extends SheetReportsEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool append;
  LoadSheetProductionDetailsReports({
    this.machineNumber,
    this.startDate,
    this.endDate,
    this.append = false,
  });
}

class SubmitSheetProductionDetailsReport extends SheetReportsEvent {
  final SheetProductionDetailsReport report;
  SubmitSheetProductionDetailsReport(this.report);
}

class LoadSheetProductionDetailsForShift extends SheetReportsEvent {
  final String machineNumber;
  final DateTime date;
  final String shift;
  LoadSheetProductionDetailsForShift({
    required this.machineNumber,
    required this.date,
    required this.shift,
  });
}

class LoadSheetRunningFeetReports extends SheetReportsEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool append;
  LoadSheetRunningFeetReports({
    this.machineNumber,
    this.startDate,
    this.endDate,
    this.append = false,
  });
}

class SubmitSheetRunningFeetReport extends SheetReportsEvent {
  final SheetProductionRunningFeetReport report;
  SubmitSheetRunningFeetReport(this.report);
}

class LoadSheetPackingReports extends SheetReportsEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool append;
  LoadSheetPackingReports({
    this.machineNumber,
    this.startDate,
    this.endDate,
    this.append = false,
  });
}

class SubmitSheetPackingReport extends SheetReportsEvent {
  final SheetShiftPackingReport report;
  SubmitSheetPackingReport(this.report);
}

class LoadSheetCustomerRejectionReports extends SheetReportsEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool append;
  LoadSheetCustomerRejectionReports({
    this.machineNumber,
    this.startDate,
    this.endDate,
    this.append = false,
  });
}

class SubmitSheetCustomerRejectionReport extends SheetReportsEvent {
  final SheetCustomerRejectionReport report;
  SubmitSheetCustomerRejectionReport(this.report);
}

class LoadSheetWritingEfficiency extends SheetReportsEvent {
  final String? operatorId;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool append;
  LoadSheetWritingEfficiency({
    this.operatorId,
    this.startDate,
    this.endDate,
    this.append = false,
  });
}

// ═══════════════════════════════════════
// STATES
// ═══════════════════════════════════════

abstract class SheetReportsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SheetReportsInitial extends SheetReportsState {}

class SheetReportsLoading extends SheetReportsState {}

class SheetReportsSubmitting extends SheetReportsState {}

class SheetReportsSubmitted extends SheetReportsState {
  final String message;
  SheetReportsSubmitted([this.message = 'Report submitted successfully']);
  @override
  List<Object?> get props => [message];
}

class SheetReportsError extends SheetReportsState {
  final String message;
  SheetReportsError(this.message);
  @override
  List<Object?> get props => [message];
}

class SheetCleaningReportsLoaded extends SheetReportsState {
  final List<MachineCleaningReport> reports;
  final bool hasMore;
  final bool isLoadingMore;
  final DateTime? oldestLoadedStart;
  SheetCleaningReportsLoaded(
    this.reports, {
    this.hasMore = true,
    this.isLoadingMore = false,
    this.oldestLoadedStart,
  });
  @override
  List<Object?> get props => [
    reports,
    hasMore,
    isLoadingMore,
    oldestLoadedStart,
  ];
}

class SheetToolsCountReportsLoaded extends SheetReportsState {
  final List<ToolsCountReport> reports;
  final bool hasMore;
  final bool isLoadingMore;
  final DateTime? oldestLoadedStart;
  SheetToolsCountReportsLoaded(
    this.reports, {
    this.hasMore = true,
    this.isLoadingMore = false,
    this.oldestLoadedStart,
  });
  @override
  List<Object?> get props => [
    reports,
    hasMore,
    isLoadingMore,
    oldestLoadedStart,
  ];
}

class SheetHealthReportsLoaded extends SheetReportsState {
  final List<MachineHealthReport> reports;
  final bool hasMore;
  final bool isLoadingMore;
  final DateTime? oldestLoadedStart;
  SheetHealthReportsLoaded(
    this.reports, {
    this.hasMore = true,
    this.isLoadingMore = false,
    this.oldestLoadedStart,
  });
  @override
  List<Object?> get props => [
    reports,
    hasMore,
    isLoadingMore,
    oldestLoadedStart,
  ];
}

class SheetPendingApprovalsLoaded extends SheetReportsState {
  final List<MachineHealthReport> reports;
  SheetPendingApprovalsLoaded(this.reports);
}

class SheetProductionDetailsLoaded extends SheetReportsState {
  final List<SheetProductionDetailsReport> reports;
  final bool hasMore;
  final bool isLoadingMore;
  final DateTime? oldestLoadedStart;
  SheetProductionDetailsLoaded(
    this.reports, {
    this.hasMore = true,
    this.isLoadingMore = false,
    this.oldestLoadedStart,
  });
  @override
  List<Object?> get props => [
    reports,
    hasMore,
    isLoadingMore,
    oldestLoadedStart,
  ];
}

class SheetProductionDetailsForShiftLoaded extends SheetReportsState {
  final SheetProductionDetailsReport? report;
  SheetProductionDetailsForShiftLoaded(this.report);
}

class SheetRunningFeetReportsLoaded extends SheetReportsState {
  final List<SheetProductionRunningFeetReport> reports;
  final bool hasMore;
  final bool isLoadingMore;
  final DateTime? oldestLoadedStart;
  SheetRunningFeetReportsLoaded(
    this.reports, {
    this.hasMore = true,
    this.isLoadingMore = false,
    this.oldestLoadedStart,
  });
  @override
  List<Object?> get props => [
    reports,
    hasMore,
    isLoadingMore,
    oldestLoadedStart,
  ];
}

class SheetPackingReportsLoaded extends SheetReportsState {
  final List<SheetShiftPackingReport> reports;
  final bool hasMore;
  final bool isLoadingMore;
  final DateTime? oldestLoadedStart;
  SheetPackingReportsLoaded(
    this.reports, {
    this.hasMore = true,
    this.isLoadingMore = false,
    this.oldestLoadedStart,
  });
  @override
  List<Object?> get props => [
    reports,
    hasMore,
    isLoadingMore,
    oldestLoadedStart,
  ];
}

class SheetCustomerRejectionReportsLoaded extends SheetReportsState {
  final List<SheetCustomerRejectionReport> reports;
  final bool hasMore;
  final bool isLoadingMore;
  final DateTime? oldestLoadedStart;
  SheetCustomerRejectionReportsLoaded(
    this.reports, {
    this.hasMore = true,
    this.isLoadingMore = false,
    this.oldestLoadedStart,
  });
  @override
  List<Object?> get props => [
    reports,
    hasMore,
    isLoadingMore,
    oldestLoadedStart,
  ];
}

class SheetWritingEfficiencyLoaded extends SheetReportsState {
  final List<ReportWritingEfficiencyRecord> records;
  final bool hasMore;
  final bool isLoadingMore;
  final DateTime? oldestLoadedStart;
  SheetWritingEfficiencyLoaded(
    this.records, {
    this.hasMore = true,
    this.isLoadingMore = false,
    this.oldestLoadedStart,
  });
  @override
  List<Object?> get props => [
    records,
    hasMore,
    isLoadingMore,
    oldestLoadedStart,
  ];
}

// ═══════════════════════════════════════
// BLOC
// ═══════════════════════════════════════

class SheetReportsBloc extends Bloc<SheetReportsEvent, SheetReportsState> {
  final SheetRepository sheetRepository;

  SheetReportsBloc({required this.sheetRepository})
    : super(SheetReportsInitial()) {
    on<LoadSheetCleaningReports>((e, emit) async {
      final previous = state is SheetCleaningReportsLoaded
          ? state as SheetCleaningReportsLoaded
          : null;
      if (e.append && previous != null) {
        emit(
          SheetCleaningReportsLoaded(
            previous.reports,
            hasMore: previous.hasMore,
            isLoadingMore: true,
            oldestLoadedStart: previous.oldestLoadedStart,
          ),
        );
      } else {
        emit(SheetReportsLoading());
      }
      try {
        final r = await sheetRepository.getMachineCleaningReports(
          machineNumber: e.machineNumber,
          startDate: e.startDate,
          endDate: e.endDate,
        );
        final merged = mergeReportPage(
          append: e.append && previous != null,
          existing: previous?.reports,
          fetched: r,
          requestStart: e.startDate,
          previousOldestStart: previous?.oldestLoadedStart,
        );
        emit(
          SheetCleaningReportsLoaded(
            merged.items,
            hasMore: merged.hasMore,
            oldestLoadedStart: merged.oldestLoadedStart,
          ),
        );
      } catch (err) {
        emit(SheetReportsError(err.toString()));
      }
    });
    on<SubmitSheetCleaningReport>((e, emit) async {
      emit(SheetReportsSubmitting());
      try {
        final existing = await sheetRepository.getMachineCleaningReports(
          machineNumber: e.report.machineNumber,
          startDate: e.report.date,
          endDate: e.report.date,
        );
        if (existing.isNotEmpty) {
          emit(
            SheetReportsError(
              'A cleaning report already exists for ${e.report.machineNumber} on this date',
            ),
          );
          return;
        }
        await sheetRepository.submitMachineCleaningReport(e.report);
        emit(SheetReportsSubmitted('Machine Cleaning Report submitted'));
      } catch (err) {
        emit(SheetReportsError(err.toString()));
      }
    });
    on<LoadSheetToolsCountReports>((e, emit) async {
      final previous = state is SheetToolsCountReportsLoaded
          ? state as SheetToolsCountReportsLoaded
          : null;
      if (e.append && previous != null) {
        emit(
          SheetToolsCountReportsLoaded(
            previous.reports,
            hasMore: previous.hasMore,
            isLoadingMore: true,
            oldestLoadedStart: previous.oldestLoadedStart,
          ),
        );
      } else {
        emit(SheetReportsLoading());
      }
      try {
        final r = await sheetRepository.getToolsCountReports(
          machineNumber: e.machineNumber,
          startDate: e.startDate,
          endDate: e.endDate,
        );
        final merged = mergeReportPage(
          append: e.append && previous != null,
          existing: previous?.reports,
          fetched: r,
          requestStart: e.startDate,
          previousOldestStart: previous?.oldestLoadedStart,
        );
        emit(
          SheetToolsCountReportsLoaded(
            merged.items,
            hasMore: merged.hasMore,
            oldestLoadedStart: merged.oldestLoadedStart,
          ),
        );
      } catch (err) {
        emit(SheetReportsError(err.toString()));
      }
    });
    on<SubmitSheetToolsCountReport>((e, emit) async {
      emit(SheetReportsSubmitting());
      try {
        final existing = await sheetRepository.getToolsCountReports(
          machineNumber: e.report.machineNumber,
          startDate: e.report.date,
          endDate: e.report.date,
        );
        if (existing.isNotEmpty) {
          emit(
            SheetReportsError(
              'A tools count report already exists for ${e.report.machineNumber} on this date',
            ),
          );
          return;
        }
        await sheetRepository.submitToolsCountReport(e.report);
        emit(SheetReportsSubmitted('Tools Count Report submitted'));
      } catch (err) {
        emit(SheetReportsError(err.toString()));
      }
    });
    on<LoadSheetHealthReports>((e, emit) async {
      final previous = state is SheetHealthReportsLoaded
          ? state as SheetHealthReportsLoaded
          : null;
      if (e.append && previous != null) {
        emit(
          SheetHealthReportsLoaded(
            previous.reports,
            hasMore: previous.hasMore,
            isLoadingMore: true,
            oldestLoadedStart: previous.oldestLoadedStart,
          ),
        );
      } else {
        emit(SheetReportsLoading());
      }
      try {
        final r = await sheetRepository.getMachineHealthReports(
          machineNumber: e.machineNumber,
          startDate: e.startDate,
          endDate: e.endDate,
        );
        final merged = mergeReportPage(
          append: e.append && previous != null,
          existing: previous?.reports,
          fetched: r,
          requestStart: e.startDate,
          previousOldestStart: previous?.oldestLoadedStart,
        );
        emit(
          SheetHealthReportsLoaded(
            merged.items,
            hasMore: merged.hasMore,
            oldestLoadedStart: merged.oldestLoadedStart,
          ),
        );
      } catch (err) {
        emit(SheetReportsError(err.toString()));
      }
    });
    on<SubmitSheetHealthReport>((e, emit) async {
      emit(SheetReportsSubmitting());
      try {
        final existing = await sheetRepository.getMachineHealthReports(
          machineNumber: e.report.machineNumber,
          startDate: e.report.date,
          endDate: e.report.date,
        );
        if (existing.any((r) => r.shift == e.report.shift)) {
          emit(
            SheetReportsError(
              'A health report already exists for ${e.report.machineNumber} — ${e.report.shift} on this date',
            ),
          );
          return;
        }
        await sheetRepository.submitMachineHealthReport(e.report);
        emit(SheetReportsSubmitted('Machine Health Report submitted'));
      } catch (err) {
        emit(SheetReportsError(err.toString()));
      }
    });
    on<LoadSheetPendingApprovals>((e, emit) async {
      emit(SheetReportsLoading());
      try {
        final r = await sheetRepository.getPendingApprovals();
        emit(SheetPendingApprovalsLoaded(r));
      } catch (err) {
        emit(SheetReportsError(err.toString()));
      }
    });
    on<LoadSheetProductionDetailsReports>((e, emit) async {
      final previous = state is SheetProductionDetailsLoaded
          ? state as SheetProductionDetailsLoaded
          : null;
      if (e.append && previous != null) {
        emit(
          SheetProductionDetailsLoaded(
            previous.reports,
            hasMore: previous.hasMore,
            isLoadingMore: true,
            oldestLoadedStart: previous.oldestLoadedStart,
          ),
        );
      } else {
        emit(SheetReportsLoading());
      }
      try {
        final r = await sheetRepository.getProductionDetailsReports(
          machineNumber: e.machineNumber,
          startDate: e.startDate,
          endDate: e.endDate,
        );
        final merged = mergeReportPage(
          append: e.append && previous != null,
          existing: previous?.reports,
          fetched: r,
          requestStart: e.startDate,
          previousOldestStart: previous?.oldestLoadedStart,
        );
        emit(
          SheetProductionDetailsLoaded(
            merged.items,
            hasMore: merged.hasMore,
            oldestLoadedStart: merged.oldestLoadedStart,
          ),
        );
      } catch (err) {
        emit(SheetReportsError(err.toString()));
      }
    });
    on<SubmitSheetProductionDetailsReport>((e, emit) async {
      emit(SheetReportsSubmitting());
      try {
        final existing = await sheetRepository.getProductionDetailsReport(
          e.report.machineNumber,
          e.report.date,
          e.report.shift,
        );
        if (existing != null) {
          emit(
            SheetReportsError(
              'Production details already exist for ${e.report.machineNumber} — ${e.report.shift} on this date',
            ),
          );
          return;
        }
        await sheetRepository.submitProductionDetailsReport(e.report);
        emit(SheetReportsSubmitted('Production Details Report submitted'));
      } catch (err) {
        emit(SheetReportsError(err.toString()));
      }
    });
    on<LoadSheetProductionDetailsForShift>((e, emit) async {
      emit(SheetReportsLoading());
      try {
        final r = await sheetRepository.getProductionDetailsReport(
          e.machineNumber,
          e.date,
          e.shift,
        );
        emit(SheetProductionDetailsForShiftLoaded(r));
      } catch (err) {
        emit(SheetReportsError(err.toString()));
      }
    });
    on<LoadSheetRunningFeetReports>((e, emit) async {
      final previous = state is SheetRunningFeetReportsLoaded
          ? state as SheetRunningFeetReportsLoaded
          : null;
      if (e.append && previous != null) {
        emit(
          SheetRunningFeetReportsLoaded(
            previous.reports,
            hasMore: previous.hasMore,
            isLoadingMore: true,
            oldestLoadedStart: previous.oldestLoadedStart,
          ),
        );
      } else {
        emit(SheetReportsLoading());
      }
      try {
        final r = await sheetRepository.getProductionRunningFeetReports(
          machineNumber: e.machineNumber,
          startDate: e.startDate,
          endDate: e.endDate,
        );
        final merged = mergeReportPage(
          append: e.append && previous != null,
          existing: previous?.reports,
          fetched: r,
          requestStart: e.startDate,
          previousOldestStart: previous?.oldestLoadedStart,
        );
        emit(
          SheetRunningFeetReportsLoaded(
            merged.items,
            hasMore: merged.hasMore,
            oldestLoadedStart: merged.oldestLoadedStart,
          ),
        );
      } catch (err) {
        emit(SheetReportsError(err.toString()));
      }
    });
    on<SubmitSheetRunningFeetReport>((e, emit) async {
      emit(SheetReportsSubmitting());
      try {
        final existing = await sheetRepository.getProductionRunningFeetReports(
          machineNumber: e.report.machineNumber,
          startDate: e.report.date,
          endDate: e.report.date,
        );
        if (existing.any((r) => r.shift == e.report.shift)) {
          emit(
            SheetReportsError(
              'A running feet report already exists for ${e.report.machineNumber} — ${e.report.shift} on this date',
            ),
          );
          return;
        }
        await sheetRepository.submitProductionRunningFeetReport(e.report);
        emit(SheetReportsSubmitted('Running Feet Report submitted'));
      } catch (err) {
        emit(SheetReportsError(err.toString()));
      }
    });
    on<LoadSheetPackingReports>((e, emit) async {
      final previous = state is SheetPackingReportsLoaded
          ? state as SheetPackingReportsLoaded
          : null;
      if (e.append && previous != null) {
        emit(
          SheetPackingReportsLoaded(
            previous.reports,
            hasMore: previous.hasMore,
            isLoadingMore: true,
            oldestLoadedStart: previous.oldestLoadedStart,
          ),
        );
      } else {
        emit(SheetReportsLoading());
      }
      try {
        final r = await sheetRepository.getShiftPackingReports(
          machineNumber: e.machineNumber,
          startDate: e.startDate,
          endDate: e.endDate,
        );
        final merged = mergeReportPage(
          append: e.append && previous != null,
          existing: previous?.reports,
          fetched: r,
          requestStart: e.startDate,
          previousOldestStart: previous?.oldestLoadedStart,
        );
        emit(
          SheetPackingReportsLoaded(
            merged.items,
            hasMore: merged.hasMore,
            oldestLoadedStart: merged.oldestLoadedStart,
          ),
        );
      } catch (err) {
        emit(SheetReportsError(err.toString()));
      }
    });
    on<SubmitSheetPackingReport>((e, emit) async {
      emit(SheetReportsSubmitting());
      try {
        final existing = await sheetRepository.getShiftPackingReports(
          machineNumber: e.report.machineNumber,
          startDate: e.report.date,
          endDate: e.report.date,
        );
        if (existing.any((r) => r.shift == e.report.shift)) {
          emit(
            SheetReportsError(
              'A packing report already exists for ${e.report.machineNumber} — ${e.report.shift} on this date',
            ),
          );
          return;
        }
        await sheetRepository.submitShiftPackingReport(e.report);
        emit(SheetReportsSubmitted('Shift Packing Report submitted'));
      } catch (err) {
        emit(SheetReportsError(err.toString()));
      }
    });
    on<LoadSheetCustomerRejectionReports>((e, emit) async {
      final previous = state is SheetCustomerRejectionReportsLoaded
          ? state as SheetCustomerRejectionReportsLoaded
          : null;
      if (e.append && previous != null) {
        emit(
          SheetCustomerRejectionReportsLoaded(
            previous.reports,
            hasMore: previous.hasMore,
            isLoadingMore: true,
            oldestLoadedStart: previous.oldestLoadedStart,
          ),
        );
      } else {
        emit(SheetReportsLoading());
      }
      try {
        final r = await sheetRepository.getCustomerRejectionReports(
          machineNumber: e.machineNumber,
          startDate: e.startDate,
          endDate: e.endDate,
        );
        final merged = mergeReportPage(
          append: e.append && previous != null,
          existing: previous?.reports,
          fetched: r,
          requestStart: e.startDate,
          previousOldestStart: previous?.oldestLoadedStart,
        );
        emit(
          SheetCustomerRejectionReportsLoaded(
            merged.items,
            hasMore: merged.hasMore,
            oldestLoadedStart: merged.oldestLoadedStart,
          ),
        );
      } catch (err) {
        emit(SheetReportsError(err.toString()));
      }
    });
    on<SubmitSheetCustomerRejectionReport>((e, emit) async {
      emit(SheetReportsSubmitting());
      try {
        final existing = await sheetRepository.getCustomerRejectionReports(
          machineNumber: e.report.machineNumber,
          startDate: e.report.originalProductionDate,
          endDate: e.report.originalProductionDate,
        );
        if (existing.any((r) => r.shift == e.report.shift)) {
          emit(
            SheetReportsError(
              'A customer rejection report already exists for ${e.report.machineNumber} — ${e.report.shift} on this date',
            ),
          );
          return;
        }
        await sheetRepository.submitCustomerRejectionReport(e.report);
        emit(SheetReportsSubmitted('Customer Rejection Report submitted'));
      } catch (err) {
        emit(SheetReportsError(err.toString()));
      }
    });
    on<LoadSheetWritingEfficiency>((e, emit) async {
      final previous = state is SheetWritingEfficiencyLoaded
          ? state as SheetWritingEfficiencyLoaded
          : null;
      if (e.append && previous != null) {
        emit(
          SheetWritingEfficiencyLoaded(
            previous.records,
            hasMore: previous.hasMore,
            isLoadingMore: true,
            oldestLoadedStart: previous.oldestLoadedStart,
          ),
        );
      } else {
        emit(SheetReportsLoading());
      }
      try {
        final records = await sheetRepository.getReportWritingEfficiency(
          operatorId: e.operatorId,
          startDate: e.startDate,
          endDate: e.endDate,
        );
        final merged = mergeReportPage(
          append: e.append && previous != null,
          existing: previous?.records,
          fetched: records,
          requestStart: e.startDate,
          previousOldestStart: previous?.oldestLoadedStart,
        );
        emit(
          SheetWritingEfficiencyLoaded(
            merged.items,
            hasMore: merged.hasMore,
            oldestLoadedStart: merged.oldestLoadedStart,
          ),
        );
      } catch (err) {
        emit(SheetReportsError(err.toString()));
      }
    });
  }
}
