import 'package:factory_app/core/di/injection.dart';
import 'package:factory_app/core/services/dropdown_config_provider.dart';
import 'package:factory_app/features/admin/domain/repositories/admin_repository.dart';
import 'package:factory_app/features/frames/domain/repositories/frame_repository.dart';
import 'package:factory_app/features/frames/presentation/bloc/frame_reports_bloc.dart';
import 'package:factory_app/features/frames/presentation/pages/frame_customer_rejection_list_page.dart';
import 'package:factory_app/features/frames/presentation/pages/frame_health_report_list_page.dart';
import 'package:factory_app/features/frames/presentation/pages/frame_tools_count_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAdminRepository extends Mock implements AdminRepository {}

class MockFrameRepository extends Mock implements FrameRepository {}

void main() {
  const machineNumber = 'Frame Machine 1';
  final startDate = DateTime(2026, 8, 1);
  final endDate = DateTime(2026, 8, 15);

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

  testWidgets('tools count loads the active machine and date range', (
    tester,
  ) async {
    when(
      () => frameRepository.getToolsCountReports(
        machineNumber: any(named: 'machineNumber'),
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
      ),
    ).thenAnswer((_) async => []);

    await _pumpPage(tester, frameRepository, const FrameToolsCountListPage());
    await _selectQuery(tester, machineNumber, startDate, endDate);

    verify(
      () => frameRepository.getToolsCountReports(
        machineNumber: machineNumber,
        startDate: startDate,
        endDate: endDate,
      ),
    ).called(1);
  });

  testWidgets('machine health loads the active machine and date range', (
    tester,
  ) async {
    when(
      () => frameRepository.getMachineHealthReports(
        machineNumber: any(named: 'machineNumber'),
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
      ),
    ).thenAnswer((_) async => []);

    await _pumpPage(tester, frameRepository, const FrameHealthReportListPage());
    await _selectQuery(tester, machineNumber, startDate, endDate);

    verify(
      () => frameRepository.getMachineHealthReports(
        machineNumber: machineNumber,
        startDate: startDate,
        endDate: endDate,
      ),
    ).called(1);
  });

  testWidgets(
    'customer rejection loads and retries with the active machine and date range',
    (tester) async {
      when(
        () => frameRepository.getCustomerRejectionReports(
          machineNumber: any(named: 'machineNumber'),
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
        ),
      ).thenAnswer((invocation) async {
        final machine = invocation.namedArguments[#machineNumber] as String?;
        final start = invocation.namedArguments[#startDate] as DateTime?;
        final end = invocation.namedArguments[#endDate] as DateTime?;
        if (machine == machineNumber && start == startDate && end == endDate) {
          throw Exception('load failed');
        }
        return [];
      });

      await _pumpPage(
        tester,
        frameRepository,
        const FrameCustomerRejectionListPage(),
      );
      await _selectQuery(tester, machineNumber, startDate, endDate);

      expect(find.text('Retry'), findsOneWidget);
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();

      verify(
        () => frameRepository.getCustomerRejectionReports(
          machineNumber: machineNumber,
          startDate: startDate,
          endDate: endDate,
        ),
      ).called(2);
    },
  );
}

Future<void> _pumpPage(
  WidgetTester tester,
  FrameRepository frameRepository,
  Widget page,
) async {
  final bloc = FrameReportsBloc(
    frameRepository: frameRepository,
    frameTargets: const {},
  );
  addTearDown(bloc.close);

  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider.value(value: bloc, child: page),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _selectQuery(
  WidgetTester tester,
  String machineNumber,
  DateTime startDate,
  DateTime endDate,
) async {
  await _selectDate(tester, 'From Date', startDate);
  await _selectDate(tester, 'To Date', endDate);
  await tester.tap(find.text('All machines'));
  await tester.pumpAndSettle();
  await tester.tap(find.text(machineNumber).last);
  await tester.pumpAndSettle();
}

Future<void> _selectDate(
  WidgetTester tester,
  String fieldLabel,
  DateTime date,
) async {
  final field = find.ancestor(
    of: find.text(fieldLabel),
    matching: find.byType(InkWell),
  );
  await tester.tap(field);
  await tester.pumpAndSettle();

  final calendar = tester.widget<CalendarDatePicker>(
    find.byType(CalendarDatePicker),
  );
  calendar.onDateChanged(date);
  await tester.pump();
  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();
}
