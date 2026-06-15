import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:factory_app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:factory_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../../helpers/test_factories.dart';

class MockDashboardRepository extends Mock implements DashboardRepository {}

void main() {
  late MockDashboardRepository mockRepo;

  setUp(() {
    mockRepo = MockDashboardRepository();
  });

  group('Dashboard BLoC', () {
    blocTest<DashboardBloc, DashboardState>(
      'emits [Loading, Loaded] on construction via auto-load',
      build: () {
        when(
          () => mockRepo.getDashboardSummary(),
        ).thenAnswer((_) async => TestFactories.fakeDashboardSummary());
        return DashboardBloc(mockRepo);
      },
      expect: () => [isA<DashboardLoading>(), isA<DashboardLoaded>()],
      verify: (bloc) {
        final state = bloc.state as DashboardLoaded;
        expect(state.summary.pendingApprovals, 3);
        expect(state.summary.todayFrameWeight, 1200.0);
      },
    );

    blocTest<DashboardBloc, DashboardState>(
      'emits [Loading, Error] when load fails',
      build: () {
        when(
          () => mockRepo.getDashboardSummary(),
        ).thenThrow(Exception('Network error'));
        return DashboardBloc(mockRepo);
      },
      expect: () => [isA<DashboardLoading>(), isA<DashboardError>()],
    );

    blocTest<DashboardBloc, DashboardState>(
      'emits [DashboardLoaded] on RefreshDashboard after auto-load',
      build: () {
        when(() => mockRepo.getDashboardSummary()).thenAnswer(
          (_) async => TestFactories.fakeDashboardSummary(pendingApprovals: 5),
        );
        return DashboardBloc(mockRepo);
      },
      act: (bloc) => bloc.add(RefreshDashboard()),
      expect: () => [isA<DashboardLoading>(), isA<DashboardLoaded>()],
      verify: (bloc) {
        final state = bloc.state as DashboardLoaded;
        expect(state.summary.pendingApprovals, 5);
      },
    );

    blocTest<DashboardBloc, DashboardState>(
      'summary cards contain correct data',
      build: () {
        when(() => mockRepo.getDashboardSummary()).thenAnswer(
          (_) async => TestFactories.fakeDashboardSummary(
            totalOperators: 10,
            activeOperators: 8,
            avgFrameEfficiency: 85.5,
            avgSheetEfficiency: 90.2,
          ),
        );
        return DashboardBloc(mockRepo);
      },
      expect: () => [isA<DashboardLoading>(), isA<DashboardLoaded>()],
      verify: (bloc) {
        final state = bloc.state as DashboardLoaded;
        expect(state.summary.totalOperators, 10);
        expect(state.summary.activeOperators, 8);
        expect(state.summary.avgFrameEfficiency, 85.5);
        expect(state.summary.avgSheetEfficiency, 90.2);
      },
    );

    blocTest<DashboardBloc, DashboardState>(
      'weekly production data available in loaded state',
      build: () {
        when(
          () => mockRepo.getDashboardSummary(),
        ).thenAnswer((_) async => TestFactories.fakeDashboardSummary());
        return DashboardBloc(mockRepo);
      },
      expect: () => [isA<DashboardLoading>(), isA<DashboardLoaded>()],
      verify: (bloc) {
        final state = bloc.state as DashboardLoaded;
        expect(state.summary.weeklyFrameProduction.length, 7);
        expect(state.summary.weeklySheetProduction.length, 7);
      },
    );

    blocTest<DashboardBloc, DashboardState>(
      'RefreshDashboard emits Error if refresh fails',
      build: () {
        when(
          () => mockRepo.getDashboardSummary(),
        ).thenThrow(Exception('Timeout'));
        return DashboardBloc(mockRepo);
      },
      act: (bloc) => bloc.add(RefreshDashboard()),
      expect: () => [isA<DashboardLoading>(), isA<DashboardError>()],
    );
  });
}
