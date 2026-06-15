import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:factory_app/core/constants/app_constants.dart';
import 'package:factory_app/features/frames/presentation/bloc/frame_reports_bloc.dart';
import 'package:factory_app/features/frames/domain/repositories/frame_repository.dart';
import '../../../helpers/test_factories.dart';

class MockFrameRepository extends Mock implements FrameRepository {}

const _testTargets = AppConstants.defaultFrameTargets;

void main() {
  late MockFrameRepository mockRepo;

  setUp(() {
    mockRepo = MockFrameRepository();
  });

  setUpAll(() {
    registerFallbackValue(TestFactories.fakeFrameProductionReport());
    registerFallbackValue(TestFactories.fakeMachineCleaningReport());
    registerFallbackValue(TestFactories.fakeMachineHealthReport());
    registerFallbackValue(TestFactories.fakeFrameWeightReport());
    registerFallbackValue(TestFactories.fakeFramePackingReport());
    registerFallbackValue(TestFactories.fakeCustomerRejection());
  });

  group('FrameReportsBloc — Production Details', () {
    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Loading, Loaded] when LoadProductionDetailsReports succeeds',
      build: () {
        when(
          () => mockRepo.getProductionDetailsReports(
            machineNumber: any(named: 'machineNumber'),
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => [TestFactories.fakeFrameProductionReport()]);
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(
        LoadProductionDetailsReports(machineNumber: 'Frame Machine 1'),
      ),
      expect: () => [
        isA<FrameReportsLoading>(),
        isA<ProductionDetailsReportsLoaded>(),
      ],
    );

    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Loading, Error] when repository throws',
      build: () {
        when(
          () => mockRepo.getProductionDetailsReports(
            machineNumber: any(named: 'machineNumber'),
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenThrow(Exception('Network error'));
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(
        LoadProductionDetailsReports(machineNumber: 'Frame Machine 1'),
      ),
      expect: () => [isA<FrameReportsLoading>(), isA<FrameReportsError>()],
    );

    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Submitting, Submitted] on SubmitProductionDetailsReport',
      build: () {
        when(
          () => mockRepo.getProductionDetailsReport(any(), any(), any()),
        ).thenAnswer((_) async => null);
        when(
          () => mockRepo.submitProductionDetailsReport(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockRepo.submitProductionWeightReport(any()),
        ).thenAnswer((_) async {});
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(
        SubmitProductionDetailsReport(
          TestFactories.fakeFrameProductionReport(),
        ),
      ),
      expect: () => [
        isA<FrameReportsSubmitting>(),
        isA<FrameReportsSubmitted>(),
      ],
      verify: (_) {
        verify(() => mockRepo.submitProductionWeightReport(any())).called(1);
      },
    );

    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Submitting, Error] when submit fails',
      build: () {
        when(
          () => mockRepo.getProductionDetailsReport(any(), any(), any()),
        ).thenAnswer((_) async => null);
        when(
          () => mockRepo.submitProductionDetailsReport(any()),
        ).thenThrow(Exception('Submit failed'));
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(
        SubmitProductionDetailsReport(
          TestFactories.fakeFrameProductionReport(),
        ),
      ),
      expect: () => [isA<FrameReportsSubmitting>(), isA<FrameReportsError>()],
    );

    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Loading, ProductionDetailsForShiftLoaded] when loading for specific shift',
      build: () {
        when(
          () => mockRepo.getProductionDetailsReport(any(), any(), any()),
        ).thenAnswer((_) async => TestFactories.fakeFrameProductionReport());
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(
        LoadProductionDetailsForShift(
          machineNumber: 'Frame Machine 1',
          date: DateTime(2026, 3, 15),
          shift: 'Day Shift',
        ),
      ),
      expect: () => [
        isA<FrameReportsLoading>(),
        isA<ProductionDetailsForShiftLoaded>(),
      ],
    );

    blocTest<FrameReportsBloc, FrameReportsState>(
      'loaded state contains null when no report exists for shift',
      build: () {
        when(
          () => mockRepo.getProductionDetailsReport(any(), any(), any()),
        ).thenAnswer((_) async => null);
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(
        LoadProductionDetailsForShift(
          machineNumber: 'Frame Machine 1',
          date: DateTime(2026, 3, 15),
          shift: 'Day Shift',
        ),
      ),
      expect: () => [
        isA<FrameReportsLoading>(),
        isA<ProductionDetailsForShiftLoaded>(),
      ],
      verify: (bloc) {
        final state = bloc.state as ProductionDetailsForShiftLoaded;
        expect(state.report, isNull);
      },
    );
  });

  group('FrameReportsBloc — Machine Cleaning', () {
    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Loading, MachineCleaningReportsLoaded] on load',
      build: () {
        when(
          () => mockRepo.getMachineCleaningReports(
            machineNumber: any(named: 'machineNumber'),
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => [TestFactories.fakeMachineCleaningReport()]);
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(LoadMachineCleaningReports()),
      expect: () => [
        isA<FrameReportsLoading>(),
        isA<MachineCleaningReportsLoaded>(),
      ],
    );

    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Submitting, Submitted] on submit cleaning report',
      build: () {
        when(
          () => mockRepo.getMachineCleaningReports(
            machineNumber: any(named: 'machineNumber'),
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => []);
        when(
          () => mockRepo.submitMachineCleaningReport(any()),
        ).thenAnswer((_) async {});
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(
        SubmitMachineCleaningReport(TestFactories.fakeMachineCleaningReport()),
      ),
      expect: () => [
        isA<FrameReportsSubmitting>(),
        isA<FrameReportsSubmitted>(),
      ],
    );
  });

  group('FrameReportsBloc — Tools Count', () {
    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Loading, ToolsCountReportsLoaded] on load',
      build: () {
        when(
          () => mockRepo.getToolsCountReports(
            machineNumber: any(named: 'machineNumber'),
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => [TestFactories.fakeToolsCountReport()]);
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(LoadToolsCountReports()),
      expect: () => [
        isA<FrameReportsLoading>(),
        isA<ToolsCountReportsLoaded>(),
      ],
    );
  });

  group('FrameReportsBloc — Machine Health', () {
    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Loading, MachineHealthReportsLoaded] on load',
      build: () {
        when(
          () => mockRepo.getMachineHealthReports(
            machineNumber: any(named: 'machineNumber'),
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => [TestFactories.fakeMachineHealthReport()]);
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(LoadMachineHealthReports()),
      expect: () => [
        isA<FrameReportsLoading>(),
        isA<MachineHealthReportsLoaded>(),
      ],
    );

    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Submitting, Submitted] on submit machine health report',
      build: () {
        when(
          () => mockRepo.getMachineHealthReports(
            machineNumber: any(named: 'machineNumber'),
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => []);
        when(
          () => mockRepo.submitMachineHealthReport(any()),
        ).thenAnswer((_) async {});
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(
        SubmitMachineHealthReport(TestFactories.fakeMachineHealthReport()),
      ),
      expect: () => [
        isA<FrameReportsSubmitting>(),
        isA<FrameReportsSubmitted>(),
      ],
    );

    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Loading, PendingApprovalsLoaded] on LoadPendingApprovals',
      build: () {
        when(
          () => mockRepo.getPendingApprovals(),
        ).thenAnswer((_) async => [TestFactories.fakeMachineHealthReport()]);
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(LoadPendingApprovals()),
      expect: () => [isA<FrameReportsLoading>(), isA<PendingApprovalsLoaded>()],
    );
  });

  group('FrameReportsBloc — Production Weight', () {
    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Loading, ProductionWeightReportsLoaded] on load',
      build: () {
        when(
          () => mockRepo.getProductionWeightReports(
            machineNumber: any(named: 'machineNumber'),
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => [TestFactories.fakeFrameWeightReport()]);
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(LoadProductionWeightReports()),
      expect: () => [
        isA<FrameReportsLoading>(),
        isA<ProductionWeightReportsLoaded>(),
      ],
    );

    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Submitting, Submitted] on submit weight report',
      build: () {
        when(
          () => mockRepo.submitProductionWeightReport(any()),
        ).thenAnswer((_) async {});
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(
        SubmitProductionWeightReport(TestFactories.fakeFrameWeightReport()),
      ),
      expect: () => [
        isA<FrameReportsSubmitting>(),
        isA<FrameReportsSubmitted>(),
      ],
    );
  });

  group('FrameReportsBloc — Shift Packing', () {
    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Loading, ShiftPackingReportsLoaded] on load',
      build: () {
        when(
          () => mockRepo.getShiftPackingReports(
            machineNumber: any(named: 'machineNumber'),
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => [TestFactories.fakeFramePackingReport()]);
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(LoadShiftPackingReports()),
      expect: () => [
        isA<FrameReportsLoading>(),
        isA<ShiftPackingReportsLoaded>(),
      ],
    );

    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Submitting, Submitted] on submit packing report',
      build: () {
        when(
          () => mockRepo.getShiftPackingReports(
            machineNumber: any(named: 'machineNumber'),
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => []);
        when(
          () => mockRepo.submitShiftPackingReport(any()),
        ).thenAnswer((_) async {});
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(
        SubmitShiftPackingReport(TestFactories.fakeFramePackingReport()),
      ),
      expect: () => [
        isA<FrameReportsSubmitting>(),
        isA<FrameReportsSubmitted>(),
      ],
    );
  });

  group('FrameReportsBloc — Customer Rejection', () {
    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Loading, CustomerRejectionReportsLoaded] on load',
      build: () {
        when(
          () => mockRepo.getCustomerRejectionReports(
            machineNumber: any(named: 'machineNumber'),
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => [TestFactories.fakeCustomerRejection()]);
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(LoadCustomerRejectionReports()),
      expect: () => [
        isA<FrameReportsLoading>(),
        isA<CustomerRejectionReportsLoaded>(),
      ],
    );

    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Submitting, Submitted] on submit customer rejection',
      build: () {
        when(
          () => mockRepo.getCustomerRejectionReports(
            machineNumber: any(named: 'machineNumber'),
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer((_) async => []);
        when(
          () => mockRepo.submitCustomerRejectionReport(any()),
        ).thenAnswer((_) async {});
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(
        SubmitCustomerRejectionReport(TestFactories.fakeCustomerRejection()),
      ),
      expect: () => [
        isA<FrameReportsSubmitting>(),
        isA<FrameReportsSubmitted>(),
      ],
    );
  });
}
