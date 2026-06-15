import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:factory_app/features/salary/presentation/bloc/salary_bloc.dart';
import 'package:factory_app/features/salary/domain/repositories/salary_repository.dart';
import '../../../helpers/test_factories.dart';

class MockSalaryRepository extends Mock implements SalaryRepository {}

void main() {
  late MockSalaryRepository mockRepo;

  setUp(() {
    mockRepo = MockSalaryRepository();
  });

  setUpAll(() {
    registerFallbackValue(TestFactories.fakeSalaryCalculation());
  });

  group('SalaryBloc — CalculateSalary', () {
    blocTest<SalaryBloc, SalaryState>(
      'emits [Loading, SalaryCalculated] on success',
      build: () {
        when(
          () => mockRepo.calculateSalary(any(), any(), any()),
        ).thenAnswer((_) async => TestFactories.fakeSalaryCalculation());
        return SalaryBloc(salaryRepository: mockRepo);
      },
      act: (bloc) =>
          bloc.add(CalculateSalary(operatorId: 'op-1', year: 2026, month: 3)),
      expect: () => [isA<SalaryLoading>(), isA<SalaryCalculated>()],
      verify: (bloc) {
        final state = bloc.state as SalaryCalculated;
        expect(state.calculation.multiplier, 0.765);
        expect(state.calculation.calculatedSalary, 38250);
      },
    );

    blocTest<SalaryBloc, SalaryState>(
      'emits [Loading, Error] when calculation fails',
      build: () {
        when(
          () => mockRepo.calculateSalary(any(), any(), any()),
        ).thenThrow(Exception('Missing data'));
        return SalaryBloc(salaryRepository: mockRepo);
      },
      act: (bloc) =>
          bloc.add(CalculateSalary(operatorId: 'op-1', year: 2026, month: 3)),
      expect: () => [isA<SalaryLoading>(), isA<SalaryError>()],
    );
  });

  group('SalaryBloc — LoadSavedCalculation', () {
    blocTest<SalaryBloc, SalaryState>(
      'emits [Loading, SalaryCalculated] when saved calc exists',
      build: () {
        when(
          () => mockRepo.getSavedCalculation(any(), any(), any()),
        ).thenAnswer((_) async => TestFactories.fakeSalaryCalculation());
        return SalaryBloc(salaryRepository: mockRepo);
      },
      act: (bloc) => bloc.add(
        LoadSavedCalculation(operatorId: 'op-1', year: 2026, month: 3),
      ),
      expect: () => [isA<SalaryLoading>(), isA<SalaryCalculated>()],
    );

    blocTest<SalaryBloc, SalaryState>(
      'emits [Loading, Error] when no saved calc',
      build: () {
        when(
          () => mockRepo.getSavedCalculation(any(), any(), any()),
        ).thenAnswer((_) async => null);
        return SalaryBloc(salaryRepository: mockRepo);
      },
      act: (bloc) => bloc.add(
        LoadSavedCalculation(operatorId: 'op-1', year: 2026, month: 3),
      ),
      expect: () => [isA<SalaryLoading>(), isA<SalaryError>()],
    );
  });

  group('SalaryBloc — SaveSalaryCalculation', () {
    blocTest<SalaryBloc, SalaryState>(
      'emits [SalarySaved] on success',
      build: () {
        when(
          () => mockRepo.saveSalaryCalculation(any()),
        ).thenAnswer((_) async {});
        return SalaryBloc(salaryRepository: mockRepo);
      },
      act: (bloc) => bloc.add(
        SaveSalaryCalculation(TestFactories.fakeSalaryCalculation()),
      ),
      expect: () => [isA<SalarySaved>()],
    );

    blocTest<SalaryBloc, SalaryState>(
      'emits [Error] when save fails',
      build: () {
        when(
          () => mockRepo.saveSalaryCalculation(any()),
        ).thenThrow(Exception('Save failed'));
        return SalaryBloc(salaryRepository: mockRepo);
      },
      act: (bloc) => bloc.add(
        SaveSalaryCalculation(TestFactories.fakeSalaryCalculation()),
      ),
      expect: () => [isA<SalaryError>()],
    );
  });

  group('SalaryBloc — LoadMonthlyCalculations', () {
    blocTest<SalaryBloc, SalaryState>(
      'emits [Loading, SalaryMonthlyLoaded] on success',
      build: () {
        when(() => mockRepo.getCalculationsForMonth(any(), any())).thenAnswer(
          (_) async => [
            TestFactories.fakeSalaryCalculation(),
            TestFactories.fakeSalaryCalculation(operatorId: 'op-2'),
          ],
        );
        return SalaryBloc(salaryRepository: mockRepo);
      },
      act: (bloc) => bloc.add(LoadMonthlyCalculations(year: 2026, month: 3)),
      expect: () => [isA<SalaryLoading>(), isA<SalaryMonthlyLoaded>()],
      verify: (bloc) {
        final state = bloc.state as SalaryMonthlyLoaded;
        expect(state.calculations.length, 2);
      },
    );

    blocTest<SalaryBloc, SalaryState>(
      'emits [Loading, Error] on failure',
      build: () {
        when(
          () => mockRepo.getCalculationsForMonth(any(), any()),
        ).thenThrow(Exception('DB error'));
        return SalaryBloc(salaryRepository: mockRepo);
      },
      act: (bloc) => bloc.add(LoadMonthlyCalculations(year: 2026, month: 3)),
      expect: () => [isA<SalaryLoading>(), isA<SalaryError>()],
    );
  });
}
