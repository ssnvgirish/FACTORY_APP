import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/salary_entities.dart';
import '../../domain/repositories/salary_repository.dart';

// Events
abstract class SalaryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CalculateSalary extends SalaryEvent {
  final String operatorId;
  final int year;
  final int month;
  CalculateSalary({
    required this.operatorId,
    required this.year,
    required this.month,
  });
  @override
  List<Object?> get props => [operatorId, year, month];
}

class LoadSavedCalculation extends SalaryEvent {
  final String operatorId;
  final int year;
  final int month;
  LoadSavedCalculation({
    required this.operatorId,
    required this.year,
    required this.month,
  });
}

class SaveSalaryCalculation extends SalaryEvent {
  final SalaryCalculation calculation;
  SaveSalaryCalculation(this.calculation);
}

class LoadMonthlyCalculations extends SalaryEvent {
  final int year;
  final int month;
  LoadMonthlyCalculations({required this.year, required this.month});
}

// States
abstract class SalaryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SalaryInitial extends SalaryState {}

class SalaryLoading extends SalaryState {}

class SalaryCalculated extends SalaryState {
  final SalaryCalculation calculation;
  SalaryCalculated(this.calculation);
  @override
  List<Object?> get props => [calculation];
}

class SalarySaved extends SalaryState {}

class SalaryMonthlyLoaded extends SalaryState {
  final List<SalaryCalculation> calculations;
  SalaryMonthlyLoaded(this.calculations);
  @override
  List<Object?> get props => [calculations];
}

class SalaryError extends SalaryState {
  final String message;
  SalaryError(this.message);
  @override
  List<Object?> get props => [message];
}

// Bloc
class SalaryBloc extends Bloc<SalaryEvent, SalaryState> {
  final SalaryRepository salaryRepository;

  SalaryBloc({required this.salaryRepository}) : super(SalaryInitial()) {
    on<CalculateSalary>((event, emit) async {
      emit(SalaryLoading());
      try {
        final calc = await salaryRepository.calculateSalary(
          event.operatorId,
          event.year,
          event.month,
        );
        emit(SalaryCalculated(calc));
      } catch (e) {
        emit(SalaryError(e.toString()));
      }
    });

    on<LoadSavedCalculation>((event, emit) async {
      emit(SalaryLoading());
      try {
        final calc = await salaryRepository.getSavedCalculation(
          event.operatorId,
          event.year,
          event.month,
        );
        if (calc != null) {
          emit(SalaryCalculated(calc));
        } else {
          emit(SalaryError('No saved calculation found'));
        }
      } catch (e) {
        emit(SalaryError(e.toString()));
      }
    });

    on<SaveSalaryCalculation>((event, emit) async {
      try {
        await salaryRepository.saveSalaryCalculation(event.calculation);
        emit(SalarySaved());
      } catch (e) {
        emit(SalaryError(e.toString()));
      }
    });

    on<LoadMonthlyCalculations>((event, emit) async {
      emit(SalaryLoading());
      try {
        final calcs = await salaryRepository.getCalculationsForMonth(
          event.year,
          event.month,
        );
        emit(SalaryMonthlyLoaded(calcs));
      } catch (e) {
        emit(SalaryError(e.toString()));
      }
    });
  }
}
