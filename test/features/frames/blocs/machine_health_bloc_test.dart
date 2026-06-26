import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:factory_app/core/constants/app_constants.dart';
import 'package:factory_app/features/frames/presentation/bloc/frame_reports_bloc.dart';
import 'package:factory_app/features/frames/domain/repositories/frame_repository.dart';
import '../../../helpers/test_factories.dart';

class MockFrameRepository extends Mock implements FrameRepository {}

Map<String, double> _nestedToFlat(Map<String, Map<String, double>> nested) {
  final flat = <String, double>{};
  for (final outer in nested.entries) {
    for (final inner in outer.value.entries) {
      flat['${outer.key}|${inner.key}'] = inner.value;
    }
  }
  return flat;
}

final _testTargets = _nestedToFlat(AppConstants.defaultFrameTargets);

void main() {
  late MockFrameRepository mockRepo;

  setUp(() {
    mockRepo = MockFrameRepository();
  });

  setUpAll(() {
    registerFallbackValue(TestFactories.fakeMachineHealthReport());
  });

  group('Machine Health BLoC — Load Reports', () {
    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Loading, MachineHealthReportsLoaded] on success',
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
      act: (bloc) =>
          bloc.add(LoadMachineHealthReports(machineNumber: 'Frame Machine 1')),
      expect: () => [
        isA<FrameReportsLoading>(),
        isA<MachineHealthReportsLoaded>(),
      ],
    );

    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Loading, Error] on failure',
      build: () {
        when(
          () => mockRepo.getMachineHealthReports(
            machineNumber: any(named: 'machineNumber'),
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenThrow(Exception('Failed'));
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(LoadMachineHealthReports()),
      expect: () => [isA<FrameReportsLoading>(), isA<FrameReportsError>()],
    );
  });

  group('Machine Health BLoC — Submit', () {
    blocTest<FrameReportsBloc, FrameReportsState>(
      'emits [Submitting, Submitted] on success',
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
      'emits [Submitting, Error] on submit failure',
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
        ).thenThrow(Exception('Permission denied'));
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(
        SubmitMachineHealthReport(TestFactories.fakeMachineHealthReport()),
      ),
      expect: () => [isA<FrameReportsSubmitting>(), isA<FrameReportsError>()],
    );
  });

  group('Machine Health BLoC — Approvals', () {
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
      verify: (bloc) {
        final state = bloc.state as PendingApprovalsLoaded;
        expect(state.reports.length, 1);
      },
    );

    blocTest<FrameReportsBloc, FrameReportsState>(
      'pending approvals empty when no reports pending',
      build: () {
        when(() => mockRepo.getPendingApprovals()).thenAnswer((_) async => []);
        return FrameReportsBloc(
          frameRepository: mockRepo,
          frameTargets: _testTargets,
        );
      },
      act: (bloc) => bloc.add(LoadPendingApprovals()),
      expect: () => [isA<FrameReportsLoading>(), isA<PendingApprovalsLoaded>()],
      verify: (bloc) {
        final state = bloc.state as PendingApprovalsLoaded;
        expect(state.reports, isEmpty);
      },
    );
  });
}
