import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../frames/domain/entities/frame_entities.dart';
import '../../domain/entities/sheet_entities.dart';
import '../../domain/repositories/sheet_repository.dart';

// ═══════════════════════════════════════
// EVENTS
// ═══════════════════════════════════════

abstract class SheetReportsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSheetCleaningReports extends SheetReportsEvent {
  final String? machineNumber;
  LoadSheetCleaningReports({this.machineNumber});
}

class SubmitSheetCleaningReport extends SheetReportsEvent {
  final MachineCleaningReport report;
  SubmitSheetCleaningReport(this.report);
}

class LoadSheetToolsCountReports extends SheetReportsEvent {
  final String? machineNumber;
  LoadSheetToolsCountReports({this.machineNumber});
}

class SubmitSheetToolsCountReport extends SheetReportsEvent {
  final ToolsCountReport report;
  SubmitSheetToolsCountReport(this.report);
}

class LoadSheetHealthReports extends SheetReportsEvent {
  final String? machineNumber;
  LoadSheetHealthReports({this.machineNumber});
}

class SubmitSheetHealthReport extends SheetReportsEvent {
  final MachineHealthReport report;
  SubmitSheetHealthReport(this.report);
}

class LoadSheetPendingApprovals extends SheetReportsEvent {}

class LoadSheetProductionDetailsReports extends SheetReportsEvent {
  final String? machineNumber;
  LoadSheetProductionDetailsReports({this.machineNumber});
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
  LoadSheetRunningFeetReports({this.machineNumber});
}

class SubmitSheetRunningFeetReport extends SheetReportsEvent {
  final SheetProductionRunningFeetReport report;
  SubmitSheetRunningFeetReport(this.report);
}

class LoadSheetPackingReports extends SheetReportsEvent {
  final String? machineNumber;
  LoadSheetPackingReports({this.machineNumber});
}

class SubmitSheetPackingReport extends SheetReportsEvent {
  final SheetShiftPackingReport report;
  SubmitSheetPackingReport(this.report);
}

class LoadSheetCustomerRejectionReports extends SheetReportsEvent {
  final String? machineNumber;
  LoadSheetCustomerRejectionReports({this.machineNumber});
}

class SubmitSheetCustomerRejectionReport extends SheetReportsEvent {
  final SheetCustomerRejectionReport report;
  SubmitSheetCustomerRejectionReport(this.report);
}

class LoadSheetWritingEfficiency extends SheetReportsEvent {
  final String? operatorId;
  final DateTime? startDate;
  final DateTime? endDate;
  LoadSheetWritingEfficiency({this.operatorId, this.startDate, this.endDate});
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
}

class SheetReportsError extends SheetReportsState {
  final String message;
  SheetReportsError(this.message);
  @override
  List<Object?> get props => [message];
}

class SheetCleaningReportsLoaded extends SheetReportsState {
  final List<MachineCleaningReport> reports;
  SheetCleaningReportsLoaded(this.reports);
}

class SheetToolsCountReportsLoaded extends SheetReportsState {
  final List<ToolsCountReport> reports;
  SheetToolsCountReportsLoaded(this.reports);
}

class SheetHealthReportsLoaded extends SheetReportsState {
  final List<MachineHealthReport> reports;
  SheetHealthReportsLoaded(this.reports);
}

class SheetPendingApprovalsLoaded extends SheetReportsState {
  final List<MachineHealthReport> reports;
  SheetPendingApprovalsLoaded(this.reports);
}

class SheetProductionDetailsLoaded extends SheetReportsState {
  final List<SheetProductionDetailsReport> reports;
  SheetProductionDetailsLoaded(this.reports);
}

class SheetProductionDetailsForShiftLoaded extends SheetReportsState {
  final SheetProductionDetailsReport? report;
  SheetProductionDetailsForShiftLoaded(this.report);
}

class SheetRunningFeetReportsLoaded extends SheetReportsState {
  final List<SheetProductionRunningFeetReport> reports;
  SheetRunningFeetReportsLoaded(this.reports);
}

class SheetPackingReportsLoaded extends SheetReportsState {
  final List<SheetShiftPackingReport> reports;
  SheetPackingReportsLoaded(this.reports);
}

class SheetCustomerRejectionReportsLoaded extends SheetReportsState {
  final List<SheetCustomerRejectionReport> reports;
  SheetCustomerRejectionReportsLoaded(this.reports);
}

class SheetWritingEfficiencyLoaded extends SheetReportsState {
  final List<ReportWritingEfficiencyRecord> records;
  SheetWritingEfficiencyLoaded(this.records);
}

// ═══════════════════════════════════════
// BLOC
// ═══════════════════════════════════════

class SheetReportsBloc extends Bloc<SheetReportsEvent, SheetReportsState> {
  final SheetRepository sheetRepository;

  SheetReportsBloc({required this.sheetRepository})
    : super(SheetReportsInitial()) {
    on<LoadSheetCleaningReports>((e, emit) async {
      emit(SheetReportsLoading());
      try {
        final r = await sheetRepository.getMachineCleaningReports(
          machineNumber: e.machineNumber,
        );
        emit(SheetCleaningReportsLoaded(r));
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
      emit(SheetReportsLoading());
      try {
        final r = await sheetRepository.getToolsCountReports(
          machineNumber: e.machineNumber,
        );
        emit(SheetToolsCountReportsLoaded(r));
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
      emit(SheetReportsLoading());
      try {
        final r = await sheetRepository.getMachineHealthReports(
          machineNumber: e.machineNumber,
        );
        emit(SheetHealthReportsLoaded(r));
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
      emit(SheetReportsLoading());
      try {
        final r = await sheetRepository.getProductionDetailsReports(
          machineNumber: e.machineNumber,
        );
        emit(SheetProductionDetailsLoaded(r));
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
      emit(SheetReportsLoading());
      try {
        final r = await sheetRepository.getProductionRunningFeetReports(
          machineNumber: e.machineNumber,
        );
        emit(SheetRunningFeetReportsLoaded(r));
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
      emit(SheetReportsLoading());
      try {
        final r = await sheetRepository.getShiftPackingReports(
          machineNumber: e.machineNumber,
        );
        emit(SheetPackingReportsLoaded(r));
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
      emit(SheetReportsLoading());
      try {
        final r = await sheetRepository.getCustomerRejectionReports(
          machineNumber: e.machineNumber,
        );
        emit(SheetCustomerRejectionReportsLoaded(r));
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
      emit(SheetReportsLoading());
      try {
        final records = await sheetRepository.getReportWritingEfficiency(
          operatorId: e.operatorId,
          startDate: e.startDate,
          endDate: e.endDate,
        );
        emit(SheetWritingEfficiencyLoaded(records));
      } catch (err) {
        emit(SheetReportsError(err.toString()));
      }
    });
  }
}
