import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/calculations.dart';
import '../../domain/entities/frame_entities.dart';
import '../../domain/repositories/frame_repository.dart';
import '../../../../core/utils/report_list_pagination.dart';

// ═══════════════════════════════════════
// EVENTS
// ═══════════════════════════════════════

abstract class FrameReportsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Machine Cleaning
class LoadMachineCleaningReports extends FrameReportsEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool append;
  LoadMachineCleaningReports({
    this.machineNumber,
    this.startDate,
    this.endDate,
    this.append = false,
  });
}

class SubmitMachineCleaningReport extends FrameReportsEvent {
  final MachineCleaningReport report;
  SubmitMachineCleaningReport(this.report);
}

// Tools Count
class LoadToolsCountReports extends FrameReportsEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool append;
  LoadToolsCountReports({
    this.machineNumber,
    this.startDate,
    this.endDate,
    this.append = false,
  });
}

class SubmitToolsCountReport extends FrameReportsEvent {
  final ToolsCountReport report;
  SubmitToolsCountReport(this.report);
}

// Machine Health
class LoadMachineHealthReports extends FrameReportsEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool append;
  LoadMachineHealthReports({
    this.machineNumber,
    this.startDate,
    this.endDate,
    this.append = false,
  });
}

class SubmitMachineHealthReport extends FrameReportsEvent {
  final MachineHealthReport report;
  SubmitMachineHealthReport(this.report);
}

class LoadPendingApprovals extends FrameReportsEvent {}

// Production Details
class LoadProductionDetailsReports extends FrameReportsEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool append;
  LoadProductionDetailsReports({
    this.machineNumber,
    this.startDate,
    this.endDate,
    this.append = false,
  });
}

class SubmitProductionDetailsReport extends FrameReportsEvent {
  final FrameProductionDetailsReport report;
  SubmitProductionDetailsReport(this.report);
}

class LoadProductionDetailsForShift extends FrameReportsEvent {
  final String machineNumber;
  final DateTime date;
  final String shift;
  LoadProductionDetailsForShift({
    required this.machineNumber,
    required this.date,
    required this.shift,
  });
}

// Production Weight
class LoadProductionWeightReports extends FrameReportsEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool append;
  LoadProductionWeightReports({
    this.machineNumber,
    this.startDate,
    this.endDate,
    this.append = false,
  });
}

class SubmitProductionWeightReport extends FrameReportsEvent {
  final FrameProductionWeightReport report;
  SubmitProductionWeightReport(this.report);
}

// Shift Packing
class LoadShiftPackingReports extends FrameReportsEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool append;
  LoadShiftPackingReports({
    this.machineNumber,
    this.startDate,
    this.endDate,
    this.append = false,
  });
}

class SubmitShiftPackingReport extends FrameReportsEvent {
  final FrameShiftPackingReport report;
  SubmitShiftPackingReport(this.report);
}

// Customer Rejection
class LoadCustomerRejectionReports extends FrameReportsEvent {
  final String? machineNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool append;
  LoadCustomerRejectionReports({
    this.machineNumber,
    this.startDate,
    this.endDate,
    this.append = false,
  });
}

class SubmitCustomerRejectionReport extends FrameReportsEvent {
  final FrameCustomerRejectionReport report;
  SubmitCustomerRejectionReport(this.report);
}

// Writing Efficiency
class LoadFrameWritingEfficiency extends FrameReportsEvent {
  final String? operatorId;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool append;
  LoadFrameWritingEfficiency({
    this.operatorId,
    this.startDate,
    this.endDate,
    this.append = false,
  });
}

// ═══════════════════════════════════════
// STATES
// ═══════════════════════════════════════

abstract class FrameReportsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FrameReportsInitial extends FrameReportsState {}

class FrameReportsLoading extends FrameReportsState {}

class FrameReportsSubmitting extends FrameReportsState {}

class FrameReportsSubmitted extends FrameReportsState {
  final String message;
  FrameReportsSubmitted([this.message = 'Report submitted successfully']);
  @override
  List<Object?> get props => [message];
}

class FrameReportsError extends FrameReportsState {
  final String message;
  FrameReportsError(this.message);
  @override
  List<Object?> get props => [message];
}

class MachineCleaningReportsLoaded extends FrameReportsState {
  final List<MachineCleaningReport> reports;
  final bool hasMore;
  final bool isLoadingMore;
  final DateTime? oldestLoadedStart;
  MachineCleaningReportsLoaded(
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

class ToolsCountReportsLoaded extends FrameReportsState {
  final List<ToolsCountReport> reports;
  final bool hasMore;
  final bool isLoadingMore;
  final DateTime? oldestLoadedStart;
  ToolsCountReportsLoaded(
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

class MachineHealthReportsLoaded extends FrameReportsState {
  final List<MachineHealthReport> reports;
  final bool hasMore;
  final bool isLoadingMore;
  final DateTime? oldestLoadedStart;
  MachineHealthReportsLoaded(
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

class PendingApprovalsLoaded extends FrameReportsState {
  final List<MachineHealthReport> reports;
  PendingApprovalsLoaded(this.reports);
  @override
  List<Object?> get props => [reports];
}

class ProductionDetailsReportsLoaded extends FrameReportsState {
  final List<FrameProductionDetailsReport> reports;
  final bool hasMore;
  final bool isLoadingMore;
  final DateTime? oldestLoadedStart;
  ProductionDetailsReportsLoaded(
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

class ProductionDetailsForShiftLoaded extends FrameReportsState {
  final FrameProductionDetailsReport? report;
  ProductionDetailsForShiftLoaded(this.report);
  @override
  List<Object?> get props => [report];
}

class ProductionWeightReportsLoaded extends FrameReportsState {
  final List<FrameProductionWeightReport> reports;
  final bool hasMore;
  final bool isLoadingMore;
  final DateTime? oldestLoadedStart;
  ProductionWeightReportsLoaded(
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

class ShiftPackingReportsLoaded extends FrameReportsState {
  final List<FrameShiftPackingReport> reports;
  final bool hasMore;
  final bool isLoadingMore;
  final DateTime? oldestLoadedStart;
  ShiftPackingReportsLoaded(
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

class CustomerRejectionReportsLoaded extends FrameReportsState {
  final List<FrameCustomerRejectionReport> reports;
  final bool hasMore;
  final bool isLoadingMore;
  final DateTime? oldestLoadedStart;
  CustomerRejectionReportsLoaded(
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

class FrameWritingEfficiencyLoaded extends FrameReportsState {
  final List<ReportWritingEfficiencyRecord> records;
  final bool hasMore;
  final bool isLoadingMore;
  final DateTime? oldestLoadedStart;
  FrameWritingEfficiencyLoaded(
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

class FrameReportsBloc extends Bloc<FrameReportsEvent, FrameReportsState> {
  final FrameRepository frameRepository;
  final Map<String, double> frameTargets;

  FrameReportsBloc({required this.frameRepository, required this.frameTargets})
    : super(FrameReportsInitial()) {
    on<LoadMachineCleaningReports>(_onLoadCleaningReports);
    on<SubmitMachineCleaningReport>(_onSubmitCleaningReport);
    on<LoadToolsCountReports>(_onLoadToolsReports);
    on<SubmitToolsCountReport>(_onSubmitToolsReport);
    on<LoadMachineHealthReports>(_onLoadHealthReports);
    on<SubmitMachineHealthReport>(_onSubmitHealthReport);
    on<LoadPendingApprovals>(_onLoadPendingApprovals);
    on<LoadProductionDetailsReports>(_onLoadProductionDetails);
    on<SubmitProductionDetailsReport>(_onSubmitProductionDetails);
    on<LoadProductionDetailsForShift>(_onLoadProductionDetailsForShift);
    on<LoadProductionWeightReports>(_onLoadWeightReports);
    on<SubmitProductionWeightReport>(_onSubmitWeightReport);
    on<LoadShiftPackingReports>(_onLoadPackingReports);
    on<SubmitShiftPackingReport>(_onSubmitPackingReport);
    on<LoadCustomerRejectionReports>(_onLoadCustomerRejection);
    on<SubmitCustomerRejectionReport>(_onSubmitCustomerRejection);
    on<LoadFrameWritingEfficiency>(_onLoadWritingEfficiency);
  }

  Future<void> _onLoadCleaningReports(
    LoadMachineCleaningReports event,
    Emitter<FrameReportsState> emit,
  ) async {
    final previous = state is MachineCleaningReportsLoaded
        ? state as MachineCleaningReportsLoaded
        : null;
    if (event.append && previous != null) {
      emit(
        MachineCleaningReportsLoaded(
          previous.reports,
          hasMore: previous.hasMore,
          isLoadingMore: true,
          oldestLoadedStart: previous.oldestLoadedStart,
        ),
      );
    } else {
      emit(FrameReportsLoading());
    }
    try {
      final reports = await frameRepository.getMachineCleaningReports(
        machineNumber: event.machineNumber,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      final merged = mergeReportPage(
        append: event.append && previous != null,
        existing: previous?.reports,
        fetched: reports,
        requestStart: event.startDate,
        previousOldestStart: previous?.oldestLoadedStart,
      );
      emit(
        MachineCleaningReportsLoaded(
          merged.items,
          hasMore: merged.hasMore,
          oldestLoadedStart: merged.oldestLoadedStart,
        ),
      );
    } catch (e) {
      emit(FrameReportsError(e.toString()));
    }
  }

  Future<void> _onSubmitCleaningReport(
    SubmitMachineCleaningReport event,
    Emitter<FrameReportsState> emit,
  ) async {
    emit(FrameReportsSubmitting());
    try {
      // Check for duplicate: same date + machine
      final existing = await frameRepository.getMachineCleaningReports(
        machineNumber: event.report.machineNumber,
        startDate: event.report.date,
        endDate: event.report.date,
      );
      if (existing.isNotEmpty) {
        emit(
          FrameReportsError(
            'A cleaning report already exists for ${event.report.machineNumber} on this date',
          ),
        );
        return;
      }
      await frameRepository.submitMachineCleaningReport(event.report);
      emit(FrameReportsSubmitted('Machine Cleaning Report submitted'));
    } catch (e) {
      emit(FrameReportsError(e.toString()));
    }
  }

  Future<void> _onLoadToolsReports(
    LoadToolsCountReports event,
    Emitter<FrameReportsState> emit,
  ) async {
    final previous = state is ToolsCountReportsLoaded
        ? state as ToolsCountReportsLoaded
        : null;
    if (event.append && previous != null) {
      emit(
        ToolsCountReportsLoaded(
          previous.reports,
          hasMore: previous.hasMore,
          isLoadingMore: true,
          oldestLoadedStart: previous.oldestLoadedStart,
        ),
      );
    } else {
      emit(FrameReportsLoading());
    }
    try {
      final reports = await frameRepository.getToolsCountReports(
        machineNumber: event.machineNumber,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      final merged = mergeReportPage(
        append: event.append && previous != null,
        existing: previous?.reports,
        fetched: reports,
        requestStart: event.startDate,
        previousOldestStart: previous?.oldestLoadedStart,
      );
      emit(
        ToolsCountReportsLoaded(
          merged.items,
          hasMore: merged.hasMore,
          oldestLoadedStart: merged.oldestLoadedStart,
        ),
      );
    } catch (e) {
      emit(FrameReportsError(e.toString()));
    }
  }

  Future<void> _onSubmitToolsReport(
    SubmitToolsCountReport event,
    Emitter<FrameReportsState> emit,
  ) async {
    emit(FrameReportsSubmitting());
    try {
      final existing = await frameRepository.getToolsCountReports(
        machineNumber: event.report.machineNumber,
        startDate: event.report.date,
        endDate: event.report.date,
      );
      if (existing.isNotEmpty) {
        emit(
          FrameReportsError(
            'A tools count report already exists for ${event.report.machineNumber} on this date',
          ),
        );
        return;
      }
      await frameRepository.submitToolsCountReport(event.report);
      emit(FrameReportsSubmitted('Tools Count Report submitted'));
    } catch (e) {
      emit(FrameReportsError(e.toString()));
    }
  }

  Future<void> _onLoadHealthReports(
    LoadMachineHealthReports event,
    Emitter<FrameReportsState> emit,
  ) async {
    final previous = state is MachineHealthReportsLoaded
        ? state as MachineHealthReportsLoaded
        : null;
    if (event.append && previous != null) {
      emit(
        MachineHealthReportsLoaded(
          previous.reports,
          hasMore: previous.hasMore,
          isLoadingMore: true,
          oldestLoadedStart: previous.oldestLoadedStart,
        ),
      );
    } else {
      emit(FrameReportsLoading());
    }
    try {
      final reports = await frameRepository.getMachineHealthReports(
        machineNumber: event.machineNumber,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      final merged = mergeReportPage(
        append: event.append && previous != null,
        existing: previous?.reports,
        fetched: reports,
        requestStart: event.startDate,
        previousOldestStart: previous?.oldestLoadedStart,
      );
      emit(
        MachineHealthReportsLoaded(
          merged.items,
          hasMore: merged.hasMore,
          oldestLoadedStart: merged.oldestLoadedStart,
        ),
      );
    } catch (e) {
      emit(FrameReportsError(e.toString()));
    }
  }

  Future<void> _onSubmitHealthReport(
    SubmitMachineHealthReport event,
    Emitter<FrameReportsState> emit,
  ) async {
    emit(FrameReportsSubmitting());
    try {
      final existing = await frameRepository.getMachineHealthReports(
        machineNumber: event.report.machineNumber,
        startDate: event.report.date,
        endDate: event.report.date,
      );
      if (existing.any((r) => r.shift == event.report.shift)) {
        emit(
          FrameReportsError(
            'A health report already exists for ${event.report.machineNumber} — ${event.report.shift} on this date',
          ),
        );
        return;
      }
      await frameRepository.submitMachineHealthReport(event.report);
      emit(FrameReportsSubmitted('Machine Health Report submitted'));
    } catch (e) {
      emit(FrameReportsError(e.toString()));
    }
  }

  Future<void> _onLoadPendingApprovals(
    LoadPendingApprovals event,
    Emitter<FrameReportsState> emit,
  ) async {
    emit(FrameReportsLoading());
    try {
      final reports = await frameRepository.getPendingApprovals();
      emit(PendingApprovalsLoaded(reports));
    } catch (e) {
      emit(FrameReportsError(e.toString()));
    }
  }

  Future<void> _onLoadProductionDetails(
    LoadProductionDetailsReports event,
    Emitter<FrameReportsState> emit,
  ) async {
    final previous = state is ProductionDetailsReportsLoaded
        ? state as ProductionDetailsReportsLoaded
        : null;
    if (event.append && previous != null) {
      emit(
        ProductionDetailsReportsLoaded(
          previous.reports,
          hasMore: previous.hasMore,
          isLoadingMore: true,
          oldestLoadedStart: previous.oldestLoadedStart,
        ),
      );
    } else {
      emit(FrameReportsLoading());
    }
    try {
      final reports = await frameRepository.getProductionDetailsReports(
        machineNumber: event.machineNumber,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      final merged = mergeReportPage(
        append: event.append && previous != null,
        existing: previous?.reports,
        fetched: reports,
        requestStart: event.startDate,
        previousOldestStart: previous?.oldestLoadedStart,
      );
      emit(
        ProductionDetailsReportsLoaded(
          merged.items,
          hasMore: merged.hasMore,
          oldestLoadedStart: merged.oldestLoadedStart,
        ),
      );
    } catch (e) {
      emit(FrameReportsError(e.toString()));
    }
  }

  Future<void> _onSubmitProductionDetails(
    SubmitProductionDetailsReport event,
    Emitter<FrameReportsState> emit,
  ) async {
    emit(FrameReportsSubmitting());
    try {
      final existing = await frameRepository.getProductionDetailsReport(
        event.report.machineNumber,
        event.report.date,
        event.report.shift,
      );
      if (existing != null) {
        emit(
          FrameReportsError(
            'Production details already exist for ${event.report.machineNumber} — ${event.report.shift} on this date',
          ),
        );
        return;
      }
      await frameRepository.submitProductionDetailsReport(event.report);

      // Auto-generate production weight report from the submitted details
      await _generateWeightReport(event.report);

      emit(FrameReportsSubmitted('Production Details Report submitted'));
    } catch (e) {
      emit(FrameReportsError(e.toString()));
    }
  }

  /// Computes and persists a [FrameProductionWeightReport] derived from the
  /// production details that were just submitted.
  Future<void> _generateWeightReport(
    FrameProductionDetailsReport report,
  ) async {
    final productionWeight = report.totalWeight;
    if (productionWeight == 0) return;

    // Build time-segments from line items grouped by section and density.
    // Each section+density combination's share of the 12-hour shift is
    // proportional to its weight contribution.
    const shiftHours = 12.0;
    final sectionDensityWeights = <String, double>{}; // key = "section|density"
    for (final li in report.lineItems) {
      final key = '${li.section}|${li.density}';
      sectionDensityWeights[key] =
          (sectionDensityWeights[key] ?? 0) + li.totalWeight;
    }

    final lineItemsTotal = report.lineItems.fold<double>(
      0,
      (s, li) => s + li.totalWeight,
    );
    if (lineItemsTotal == 0) return;

    final segments = sectionDensityWeights.entries.map((e) {
      final parts = e.key.split('|');
      return <String, dynamic>{
        'section': parts[0],
        'density': parts.length > 1 ? parts[1] : '',
        'durationHours': (e.value / lineItemsTotal) * shiftHours,
      };
    }).toList();

    final targetWeight = Calculations.calculateTargetWeight(
      segments: segments,
      targetPerHour: frameTargets,
    );
    if (targetWeight == 0) return;

    // Frame health reports track ratings only, not maintenance duration,
    // so maintenance weight credit is zero.
    const maintenanceWeight = 0.0;
    final totalProductionWeight = productionWeight + maintenanceWeight;
    final efficiency = Calculations.productionEfficiency(
      totalProductionWeight,
      targetWeight,
    );

    await frameRepository.submitProductionWeightReport(
      FrameProductionWeightReport(
        date: report.date,
        machineNumber: report.machineNumber,
        shift: report.shift,
        productionWeight: productionWeight,
        maintenanceWeight: maintenanceWeight,
        totalProductionWeight: totalProductionWeight,
        targetWeight: targetWeight,
        efficiencyPercentage: efficiency,
        createdBy: report.createdBy,
      ),
    );
  }

  Future<void> _onLoadProductionDetailsForShift(
    LoadProductionDetailsForShift event,
    Emitter<FrameReportsState> emit,
  ) async {
    emit(FrameReportsLoading());
    try {
      final report = await frameRepository.getProductionDetailsReport(
        event.machineNumber,
        event.date,
        event.shift,
      );
      emit(ProductionDetailsForShiftLoaded(report));
    } catch (e) {
      emit(FrameReportsError(e.toString()));
    }
  }

  Future<void> _onLoadWeightReports(
    LoadProductionWeightReports event,
    Emitter<FrameReportsState> emit,
  ) async {
    final previous = state is ProductionWeightReportsLoaded
        ? state as ProductionWeightReportsLoaded
        : null;
    if (event.append && previous != null) {
      emit(
        ProductionWeightReportsLoaded(
          previous.reports,
          hasMore: previous.hasMore,
          isLoadingMore: true,
          oldestLoadedStart: previous.oldestLoadedStart,
        ),
      );
    } else {
      emit(FrameReportsLoading());
    }
    try {
      final reports = await frameRepository.getProductionWeightReports(
        machineNumber: event.machineNumber,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      final merged = mergeReportPage(
        append: event.append && previous != null,
        existing: previous?.reports,
        fetched: reports,
        requestStart: event.startDate,
        previousOldestStart: previous?.oldestLoadedStart,
      );
      emit(
        ProductionWeightReportsLoaded(
          merged.items,
          hasMore: merged.hasMore,
          oldestLoadedStart: merged.oldestLoadedStart,
        ),
      );
    } catch (e) {
      emit(FrameReportsError(e.toString()));
    }
  }

  Future<void> _onSubmitWeightReport(
    SubmitProductionWeightReport event,
    Emitter<FrameReportsState> emit,
  ) async {
    emit(FrameReportsSubmitting());
    try {
      await frameRepository.submitProductionWeightReport(event.report);
      emit(FrameReportsSubmitted('Production Weight Report submitted'));
    } catch (e) {
      emit(FrameReportsError(e.toString()));
    }
  }

  Future<void> _onLoadPackingReports(
    LoadShiftPackingReports event,
    Emitter<FrameReportsState> emit,
  ) async {
    final previous = state is ShiftPackingReportsLoaded
        ? state as ShiftPackingReportsLoaded
        : null;
    if (event.append && previous != null) {
      emit(
        ShiftPackingReportsLoaded(
          previous.reports,
          hasMore: previous.hasMore,
          isLoadingMore: true,
          oldestLoadedStart: previous.oldestLoadedStart,
        ),
      );
    } else {
      emit(FrameReportsLoading());
    }
    try {
      final reports = await frameRepository.getShiftPackingReports(
        machineNumber: event.machineNumber,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      final merged = mergeReportPage(
        append: event.append && previous != null,
        existing: previous?.reports,
        fetched: reports,
        requestStart: event.startDate,
        previousOldestStart: previous?.oldestLoadedStart,
      );
      emit(
        ShiftPackingReportsLoaded(
          merged.items,
          hasMore: merged.hasMore,
          oldestLoadedStart: merged.oldestLoadedStart,
        ),
      );
    } catch (e) {
      emit(FrameReportsError(e.toString()));
    }
  }

  Future<void> _onSubmitPackingReport(
    SubmitShiftPackingReport event,
    Emitter<FrameReportsState> emit,
  ) async {
    emit(FrameReportsSubmitting());
    try {
      final existing = await frameRepository.getShiftPackingReports(
        machineNumber: event.report.machineNumber,
        startDate: event.report.date,
        endDate: event.report.date,
      );
      if (existing.any((r) => r.shift == event.report.shift)) {
        emit(
          FrameReportsError(
            'A packing report already exists for ${event.report.machineNumber} — ${event.report.shift} on this date',
          ),
        );
        return;
      }
      await frameRepository.submitShiftPackingReport(event.report);
      emit(FrameReportsSubmitted('Shift Packing Report submitted'));
    } catch (e) {
      emit(FrameReportsError(e.toString()));
    }
  }

  Future<void> _onLoadCustomerRejection(
    LoadCustomerRejectionReports event,
    Emitter<FrameReportsState> emit,
  ) async {
    final previous = state is CustomerRejectionReportsLoaded
        ? state as CustomerRejectionReportsLoaded
        : null;
    if (event.append && previous != null) {
      emit(
        CustomerRejectionReportsLoaded(
          previous.reports,
          hasMore: previous.hasMore,
          isLoadingMore: true,
          oldestLoadedStart: previous.oldestLoadedStart,
        ),
      );
    } else {
      emit(FrameReportsLoading());
    }
    try {
      final reports = await frameRepository.getCustomerRejectionReports(
        machineNumber: event.machineNumber,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      final merged = mergeReportPage(
        append: event.append && previous != null,
        existing: previous?.reports,
        fetched: reports,
        requestStart: event.startDate,
        previousOldestStart: previous?.oldestLoadedStart,
      );
      emit(
        CustomerRejectionReportsLoaded(
          merged.items,
          hasMore: merged.hasMore,
          oldestLoadedStart: merged.oldestLoadedStart,
        ),
      );
    } catch (e) {
      emit(FrameReportsError(e.toString()));
    }
  }

  Future<void> _onSubmitCustomerRejection(
    SubmitCustomerRejectionReport event,
    Emitter<FrameReportsState> emit,
  ) async {
    emit(FrameReportsSubmitting());
    try {
      final existing = await frameRepository.getCustomerRejectionReports(
        machineNumber: event.report.machineNumber,
        startDate: event.report.originalProductionDate,
        endDate: event.report.originalProductionDate,
      );
      if (existing.any((r) => r.shift == event.report.shift)) {
        emit(
          FrameReportsError(
            'A customer rejection report already exists for ${event.report.machineNumber} — ${event.report.shift} on this date',
          ),
        );
        return;
      }
      await frameRepository.submitCustomerRejectionReport(event.report);
      emit(FrameReportsSubmitted('Customer Rejection Report submitted'));
    } catch (e) {
      emit(FrameReportsError(e.toString()));
    }
  }

  Future<void> _onLoadWritingEfficiency(
    LoadFrameWritingEfficiency event,
    Emitter<FrameReportsState> emit,
  ) async {
    final previous = state is FrameWritingEfficiencyLoaded
        ? state as FrameWritingEfficiencyLoaded
        : null;
    if (event.append && previous != null) {
      emit(
        FrameWritingEfficiencyLoaded(
          previous.records,
          hasMore: previous.hasMore,
          isLoadingMore: true,
          oldestLoadedStart: previous.oldestLoadedStart,
        ),
      );
    } else {
      emit(FrameReportsLoading());
    }
    try {
      final records = await frameRepository.getReportWritingEfficiency(
        operatorId: event.operatorId,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      final merged = mergeReportPage(
        append: event.append && previous != null,
        existing: previous?.records,
        fetched: records,
        requestStart: event.startDate,
        previousOldestStart: previous?.oldestLoadedStart,
      );
      emit(
        FrameWritingEfficiencyLoaded(
          merged.items,
          hasMore: merged.hasMore,
          oldestLoadedStart: merged.oldestLoadedStart,
        ),
      );
    } catch (e) {
      emit(FrameReportsError(e.toString()));
    }
  }
}
