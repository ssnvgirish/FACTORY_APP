import 'package:factory_app/core/di/injection.dart';
import 'package:factory_app/core/services/dropdown_config_provider.dart';
import 'package:factory_app/features/admin/domain/repositories/admin_repository.dart';
import 'package:factory_app/features/frames/domain/repositories/frame_repository.dart';
import 'package:factory_app/features/frames/presentation/bloc/frame_reports_bloc.dart';
import 'package:factory_app/features/frames/presentation/pages/frame_writing_efficiency_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/test_factories.dart';

class MockAdminRepository extends Mock implements AdminRepository {}

class MockFrameRepository extends Mock implements FrameRepository {}

void main() {
  late MockFrameRepository frameRepository;

  setUp(() {
    frameRepository = MockFrameRepository();
    sl.registerSingleton(
      DropdownConfigProvider(adminRepository: MockAdminRepository()),
    );
  });

  tearDown(() async {
    await sl.reset();
  });

  testWidgets('exhausting local items does not offer server loading', (
    tester,
  ) async {
    final records = List.generate(
      11,
      (index) => TestFactories.fakeReportWritingRecord(
        date: DateTime(2026, 3, index + 1),
        machineNumber: 'Frame Machine 1',
        operatorId: 'operator-$index',
      ),
    );
    when(
      () => frameRepository.getReportWritingEfficiency(
        operatorId: any(named: 'operatorId'),
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
      ),
    ).thenAnswer((_) async => records);
    final bloc = FrameReportsBloc(
      frameRepository: frameRepository,
      frameTargets: const {},
    );
    addTearDown(bloc.close);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: bloc,
          child: const FrameWritingEfficiencyPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Load More (1)'),
      300,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('Load More (1)'), findsOneWidget);
    await tester.tap(find.text('Load More (1)'));
    await tester.pump();
    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pump();

    expect(find.text('Load More'), findsNothing);
    verify(
      () => frameRepository.getReportWritingEfficiency(
        operatorId: any(named: 'operatorId'),
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
      ),
    ).called(1);
  });
}
