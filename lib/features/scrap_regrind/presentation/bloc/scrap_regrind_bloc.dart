import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/scrap_regrind_entities.dart';
import '../../domain/repositories/scrap_regrind_repository.dart';

// ═══════════════════════════════════════
// EVENTS
// ═══════════════════════════════════════

abstract class ScrapRegrindEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Machine Cleaning
class LoadScrapCleaningReports extends ScrapRegrindEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  LoadScrapCleaningReports({this.machineNumber, this.startDate, this.endDate});
}

class SubmitScrapCleaningReport extends ScrapRegrindEvent {
  final ScrapCleaningReport report;
  SubmitScrapCleaningReport(this.report);
}

// Tools Count
class LoadScrapToolsCountReports extends ScrapRegrindEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  LoadScrapToolsCountReports({
    this.machineNumber,
    this.startDate,
    this.endDate,
  });
}

class SubmitScrapToolsCountReport extends ScrapRegrindEvent {
  final ScrapToolsCountReport report;
  SubmitScrapToolsCountReport(this.report);
}

// Machine Health
class LoadScrapHealthReports extends ScrapRegrindEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  LoadScrapHealthReports({this.machineNumber, this.startDate, this.endDate});
}

class SubmitScrapHealthReport extends ScrapRegrindEvent {
  final ScrapMachineHealthReport report;
  SubmitScrapHealthReport(this.report);
}

class LoadScrapHealthReportForShift extends ScrapRegrindEvent {
  final String machineNumber;
  final DateTime date;
  final String shift;
  LoadScrapHealthReportForShift({
    required this.machineNumber,
    required this.date,
    required this.shift,
  });
}

// Production Details
class LoadScrapProductionDetailsReports extends ScrapRegrindEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  LoadScrapProductionDetailsReports({
    this.machineNumber,
    this.startDate,
    this.endDate,
  });
}

class SubmitScrapProductionDetailsReport extends ScrapRegrindEvent {
  final ScrapProductionDetailsReport report;
  SubmitScrapProductionDetailsReport(this.report);
}

class LoadScrapProductionDetailsForShift extends ScrapRegrindEvent {
  final String machineNumber;
  final DateTime date;
  final String shift;
  LoadScrapProductionDetailsForShift({
    required this.machineNumber,
    required this.date,
    required this.shift,
  });
}

// Production Weight
class LoadScrapProductionWeightReports extends ScrapRegrindEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  LoadScrapProductionWeightReports({
    this.machineNumber,
    this.startDate,
    this.endDate,
  });
}

class SubmitScrapProductionWeightReport extends ScrapRegrindEvent {
  final ScrapProductionWeightReport report;
  SubmitScrapProductionWeightReport(this.report);
}

// Report Writing Efficiency
class LoadScrapWritingEfficiency extends ScrapRegrindEvent {
  final String? operatorId;
  final DateTime? startDate;
  final DateTime? endDate;
  LoadScrapWritingEfficiency({this.operatorId, this.startDate, this.endDate});
}

// Scrap Quality
class LoadScrapQualityReports extends ScrapRegrindEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  LoadScrapQualityReports({this.machineNumber, this.startDate, this.endDate});
}

class SubmitScrapQualityReport extends ScrapRegrindEvent {
  final ScrapQualityReport report;
  SubmitScrapQualityReport(this.report);
}

// Salary
class LoadScrapSalaryCalculation extends ScrapRegrindEvent {
  final String operatorId;
  final int year;
  final int month;
  LoadScrapSalaryCalculation({
    required this.operatorId,
    required this.year,
    required this.month,
  });
}

// ═══════════════════════════════════════
// STATES
// ═══════════════════════════════════════

abstract class ScrapRegrindState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScrapRegrindInitial extends ScrapRegrindState {}

class ScrapRegrindLoading extends ScrapRegrindState {}

class ScrapRegrindSubmitting extends ScrapRegrindState {}

class ScrapRegrindSubmitted extends ScrapRegrindState {
  final String message;
  ScrapRegrindSubmitted([this.message = 'Report submitted successfully']);
}

class ScrapRegrindError extends ScrapRegrindState {
  final String message;
  ScrapRegrindError(this.message);
  @override
  List<Object?> get props => [message];
}

// Machine Cleaning
class ScrapCleaningReportsLoaded extends ScrapRegrindState {
  final List<ScrapCleaningReport> reports;
  ScrapCleaningReportsLoaded(this.reports);
  @override
  List<Object?> get props => [reports];
}

// Tools Count
class ScrapToolsCountReportsLoaded extends ScrapRegrindState {
  final List<ScrapToolsCountReport> reports;
  ScrapToolsCountReportsLoaded(this.reports);
  @override
  List<Object?> get props => [reports];
}

// Machine Health
class ScrapHealthReportsLoaded extends ScrapRegrindState {
  final List<ScrapMachineHealthReport> reports;
  ScrapHealthReportsLoaded(this.reports);
  @override
  List<Object?> get props => [reports];
}

class ScrapHealthReportForShiftLoaded extends ScrapRegrindState {
  final ScrapMachineHealthReport? report;
  ScrapHealthReportForShiftLoaded(this.report);
  @override
  List<Object?> get props => [report];
}

// Production Details
class ScrapProductionDetailsReportsLoaded extends ScrapRegrindState {
  final List<ScrapProductionDetailsReport> reports;
  ScrapProductionDetailsReportsLoaded(this.reports);
  @override
  List<Object?> get props => [reports];
}

class ScrapProductionDetailsForShiftLoaded extends ScrapRegrindState {
  final ScrapProductionDetailsReport? report;
  ScrapProductionDetailsForShiftLoaded(this.report);
  @override
  List<Object?> get props => [report];
}

// Production Weight
class ScrapProductionWeightReportsLoaded extends ScrapRegrindState {
  final List<ScrapProductionWeightReport> reports;
  ScrapProductionWeightReportsLoaded(this.reports);
  @override
  List<Object?> get props => [reports];
}

// Report Writing Efficiency
class ScrapWritingEfficiencyLoaded extends ScrapRegrindState {
  final List<ScrapReportWritingEfficiency> records;
  ScrapWritingEfficiencyLoaded(this.records);
  @override
  List<Object?> get props => [records];
}

// Scrap Quality
class ScrapQualityReportsLoaded extends ScrapRegrindState {
  final List<ScrapQualityReport> reports;
  ScrapQualityReportsLoaded(this.reports);
  @override
  List<Object?> get props => [reports];
}

// Salary
class ScrapSalaryCalculationLoaded extends ScrapRegrindState {
  final ScrapSalaryCalculation calculation;
  ScrapSalaryCalculationLoaded(this.calculation);
  @override
  List<Object?> get props => [calculation];
}

// ═══════════════════════════════════════
// BLOC
// ═══════════════════════════════════════

class ScrapRegrindBloc extends Bloc<ScrapRegrindEvent, ScrapRegrindState> {
  final ScrapRegrindRepository scrapRegrindRepository;

  ScrapRegrindBloc({required this.scrapRegrindRepository})
    : super(ScrapRegrindInitial()) {
    // Machine Cleaning
    on<LoadScrapCleaningReports>(_onLoadCleaningReports);
    on<SubmitScrapCleaningReport>(_onSubmitCleaningReport);

    // Tools Count
    on<LoadScrapToolsCountReports>(_onLoadToolsCountReports);
    on<SubmitScrapToolsCountReport>(_onSubmitToolsCountReport);

    // Machine Health
    on<LoadScrapHealthReports>(_onLoadHealthReports);
    on<SubmitScrapHealthReport>(_onSubmitHealthReport);
    on<LoadScrapHealthReportForShift>(_onLoadHealthReportForShift);

    // Production Details
    on<LoadScrapProductionDetailsReports>(_onLoadProductionDetailsReports);
    on<SubmitScrapProductionDetailsReport>(_onSubmitProductionDetailsReport);
    on<LoadScrapProductionDetailsForShift>(_onLoadProductionDetailsForShift);

    // Production Weight
    on<LoadScrapProductionWeightReports>(_onLoadProductionWeightReports);
    on<SubmitScrapProductionWeightReport>(_onSubmitProductionWeightReport);

    // Report Writing Efficiency
    on<LoadScrapWritingEfficiency>(_onLoadWritingEfficiency);

    // Scrap Quality
    on<LoadScrapQualityReports>(_onLoadQualityReports);
    on<SubmitScrapQualityReport>(_onSubmitQualityReport);

    // Salary
    on<LoadScrapSalaryCalculation>(_onLoadSalaryCalculation);
  }

  // ── Machine Cleaning ──

  Future<void> _onLoadCleaningReports(
    LoadScrapCleaningReports event,
    Emitter<ScrapRegrindState> emit,
  ) async {
    emit(ScrapRegrindLoading());
    try {
      final reports = await scrapRegrindRepository.getCleaningReports(
        machineNumber: event.machineNumber,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      emit(ScrapCleaningReportsLoaded(reports));
    } catch (e) {
      emit(ScrapRegrindError(e.toString()));
    }
  }

  Future<void> _onSubmitCleaningReport(
    SubmitScrapCleaningReport event,
    Emitter<ScrapRegrindState> emit,
  ) async {
    emit(ScrapRegrindSubmitting());
    try {
      final existing = await scrapRegrindRepository.getCleaningReports(
        machineNumber: event.report.machineNumber,
        startDate: event.report.date,
        endDate: event.report.date,
      );
      if (existing.isNotEmpty) {
        emit(
          ScrapRegrindError(
            'A cleaning report already exists for ${event.report.machineNumber} on this date',
          ),
        );
        return;
      }
      await scrapRegrindRepository.submitCleaningReport(event.report);
      emit(ScrapRegrindSubmitted('Machine cleaning report submitted'));
    } catch (e) {
      emit(ScrapRegrindError(e.toString()));
    }
  }

  // ── Tools Count ──

  Future<void> _onLoadToolsCountReports(
    LoadScrapToolsCountReports event,
    Emitter<ScrapRegrindState> emit,
  ) async {
    emit(ScrapRegrindLoading());
    try {
      final reports = await scrapRegrindRepository.getToolsCountReports(
        machineNumber: event.machineNumber,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      emit(ScrapToolsCountReportsLoaded(reports));
    } catch (e) {
      emit(ScrapRegrindError(e.toString()));
    }
  }

  Future<void> _onSubmitToolsCountReport(
    SubmitScrapToolsCountReport event,
    Emitter<ScrapRegrindState> emit,
  ) async {
    emit(ScrapRegrindSubmitting());
    try {
      final existing = await scrapRegrindRepository.getToolsCountReports(
        machineNumber: event.report.machineNumber,
        startDate: event.report.date,
        endDate: event.report.date,
      );
      if (existing.isNotEmpty) {
        emit(
          ScrapRegrindError(
            'A tools count report already exists for ${event.report.machineNumber} on this date',
          ),
        );
        return;
      }
      await scrapRegrindRepository.submitToolsCountReport(event.report);
      emit(ScrapRegrindSubmitted('Tools count report submitted'));
    } catch (e) {
      emit(ScrapRegrindError(e.toString()));
    }
  }

  // ── Machine Health ──

  Future<void> _onLoadHealthReports(
    LoadScrapHealthReports event,
    Emitter<ScrapRegrindState> emit,
  ) async {
    emit(ScrapRegrindLoading());
    try {
      final reports = await scrapRegrindRepository.getMachineHealthReports(
        machineNumber: event.machineNumber,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      emit(ScrapHealthReportsLoaded(reports));
    } catch (e) {
      emit(ScrapRegrindError(e.toString()));
    }
  }

  Future<void> _onSubmitHealthReport(
    SubmitScrapHealthReport event,
    Emitter<ScrapRegrindState> emit,
  ) async {
    emit(ScrapRegrindSubmitting());
    try {
      final existing = await scrapRegrindRepository.getMachineHealthReport(
        event.report.machineNumber,
        event.report.date,
        event.report.shift,
      );
      if (existing != null) {
        emit(
          ScrapRegrindError(
            'A health report already exists for ${event.report.machineNumber} — ${event.report.shift} on this date',
          ),
        );
        return;
      }
      await scrapRegrindRepository.submitMachineHealthReport(event.report);
      emit(ScrapRegrindSubmitted('Machine health report submitted'));
    } catch (e) {
      emit(ScrapRegrindError(e.toString()));
    }
  }

  Future<void> _onLoadHealthReportForShift(
    LoadScrapHealthReportForShift event,
    Emitter<ScrapRegrindState> emit,
  ) async {
    emit(ScrapRegrindLoading());
    try {
      final report = await scrapRegrindRepository.getMachineHealthReport(
        event.machineNumber,
        event.date,
        event.shift,
      );
      emit(ScrapHealthReportForShiftLoaded(report));
    } catch (e) {
      emit(ScrapRegrindError(e.toString()));
    }
  }

  // ── Production Details ──

  Future<void> _onLoadProductionDetailsReports(
    LoadScrapProductionDetailsReports event,
    Emitter<ScrapRegrindState> emit,
  ) async {
    emit(ScrapRegrindLoading());
    try {
      final reports = await scrapRegrindRepository.getProductionDetailsReports(
        machineNumber: event.machineNumber,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      emit(ScrapProductionDetailsReportsLoaded(reports));
    } catch (e) {
      emit(ScrapRegrindError(e.toString()));
    }
  }

  Future<void> _onSubmitProductionDetailsReport(
    SubmitScrapProductionDetailsReport event,
    Emitter<ScrapRegrindState> emit,
  ) async {
    emit(ScrapRegrindSubmitting());
    try {
      final existing = await scrapRegrindRepository.getProductionDetailsReport(
        event.report.machineNumber,
        event.report.date,
        event.report.shift,
      );
      if (existing != null) {
        emit(
          ScrapRegrindError(
            'Production details already exist for ${event.report.machineNumber} — ${event.report.shift} on this date',
          ),
        );
        return;
      }
      await scrapRegrindRepository.submitProductionDetailsReport(event.report);
      emit(ScrapRegrindSubmitted('Production details report submitted'));
    } catch (e) {
      emit(ScrapRegrindError(e.toString()));
    }
  }

  Future<void> _onLoadProductionDetailsForShift(
    LoadScrapProductionDetailsForShift event,
    Emitter<ScrapRegrindState> emit,
  ) async {
    emit(ScrapRegrindLoading());
    try {
      final report = await scrapRegrindRepository.getProductionDetailsReport(
        event.machineNumber,
        event.date,
        event.shift,
      );
      emit(ScrapProductionDetailsForShiftLoaded(report));
    } catch (e) {
      emit(ScrapRegrindError(e.toString()));
    }
  }

  // ── Production Weight ──

  Future<void> _onLoadProductionWeightReports(
    LoadScrapProductionWeightReports event,
    Emitter<ScrapRegrindState> emit,
  ) async {
    emit(ScrapRegrindLoading());
    try {
      final reports = await scrapRegrindRepository.getProductionWeightReports(
        machineNumber: event.machineNumber,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      emit(ScrapProductionWeightReportsLoaded(reports));
    } catch (e) {
      emit(ScrapRegrindError(e.toString()));
    }
  }

  Future<void> _onSubmitProductionWeightReport(
    SubmitScrapProductionWeightReport event,
    Emitter<ScrapRegrindState> emit,
  ) async {
    emit(ScrapRegrindSubmitting());
    try {
      await scrapRegrindRepository.submitProductionWeightReport(event.report);
      emit(ScrapRegrindSubmitted('Production weight report submitted'));
    } catch (e) {
      emit(ScrapRegrindError(e.toString()));
    }
  }

  // ── Report Writing Efficiency ──

  Future<void> _onLoadWritingEfficiency(
    LoadScrapWritingEfficiency event,
    Emitter<ScrapRegrindState> emit,
  ) async {
    emit(ScrapRegrindLoading());
    try {
      final records = await scrapRegrindRepository.getReportWritingEfficiency(
        operatorId: event.operatorId,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      emit(ScrapWritingEfficiencyLoaded(records));
    } catch (e) {
      emit(ScrapRegrindError(e.toString()));
    }
  }

  // ── Scrap Quality ──

  Future<void> _onLoadQualityReports(
    LoadScrapQualityReports event,
    Emitter<ScrapRegrindState> emit,
  ) async {
    emit(ScrapRegrindLoading());
    try {
      final reports = await scrapRegrindRepository.getScrapQualityReports(
        machineNumber: event.machineNumber,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      emit(ScrapQualityReportsLoaded(reports));
    } catch (e) {
      emit(ScrapRegrindError(e.toString()));
    }
  }

  Future<void> _onSubmitQualityReport(
    SubmitScrapQualityReport event,
    Emitter<ScrapRegrindState> emit,
  ) async {
    emit(ScrapRegrindSubmitting());
    try {
      final existing = await scrapRegrindRepository.getScrapQualityReports(
        machineNumber: event.report.machineNumber,
        startDate: event.report.date,
        endDate: event.report.date,
      );
      if (existing.any(
        (r) =>
            r.shift == event.report.shift && r.product == event.report.product,
      )) {
        emit(
          ScrapRegrindError(
            'A quality report already exists for ${event.report.machineNumber} — ${event.report.shift} — ${event.report.product} on this date',
          ),
        );
        return;
      }
      await scrapRegrindRepository.submitScrapQualityReport(event.report);
      emit(ScrapRegrindSubmitted('Scrap quality report submitted'));
    } catch (e) {
      emit(ScrapRegrindError(e.toString()));
    }
  }

  // ── Salary ──

  Future<void> _onLoadSalaryCalculation(
    LoadScrapSalaryCalculation event,
    Emitter<ScrapRegrindState> emit,
  ) async {
    emit(ScrapRegrindLoading());
    try {
      final calculation = await scrapRegrindRepository.calculateSalary(
        event.operatorId,
        event.year,
        event.month,
      );
      emit(ScrapSalaryCalculationLoaded(calculation));
    } catch (e) {
      emit(ScrapRegrindError(e.toString()));
    }
  }
}
