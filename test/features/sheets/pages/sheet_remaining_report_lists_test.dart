import 'package:factory_app/core/constants/app_constants.dart';
import 'package:factory_app/core/di/injection.dart';
import 'package:factory_app/core/services/dropdown_config_provider.dart';
import 'package:factory_app/features/admin/domain/repositories/admin_repository.dart';
import 'package:factory_app/features/sheets/domain/repositories/sheet_repository.dart';
import 'package:factory_app/features/sheets/presentation/bloc/sheet_reports_bloc.dart';
import 'package:factory_app/features/sheets/presentation/pages/sheet_customer_rejection_list_page.dart';
import 'package:factory_app/features/sheets/presentation/pages/sheet_health_report_list_page.dart';
import 'package:factory_app/features/sheets/presentation/pages/sheet_tools_count_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAdminRepository extends Mock implements AdminRepository {}

class MockSheetRepository extends Mock implements SheetRepository {}

void main() {
  const machineNumber = AppConstants.sheetMachine3;
  final startDate = DateTime(2026, 8, 1);
  final endDate = DateTime(2026, 8, 15);

  late MockSheetRepository sheetRepository;

  setUp(() {
    sheetRepository = MockSheetRepository();
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
      () => sheetRepository.getToolsCountReports(
        machineNumber: any(named: 'machineNumber'),
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
      ),
    ).thenAnswer((_) async => []);

    await _pumpPage(tester, sheetRepository, const SheetToolsCountListPage());
    await _selectQuery(tester, machineNumber, startDate, endDate);

    verify(
      () => sheetRepository.getToolsCountReports(
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
      () => sheetRepository.getMachineHealthReports(
        machineNumber: any(named: 'machineNumber'),
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
      ),
    ).thenAnswer((_) async => []);

    await _pumpPage(
      tester,
      sheetRepository,
      const SheetHealthReportListPage(),
    );
    await _selectQuery(tester, machineNumber, startDate, endDate);

    verify(
      () => sheetRepository.getMachineHealthReports(
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
        () => sheetRepository.getCustomerRejectionReports(
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
        sheetRepository,
        const SheetCustomerRejectionListPage(),
      );
      await _selectQuery(tester, machineNumber, startDate, endDate);

      expect(find.text('Retry'), findsOneWidget);
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();

      verify(
        () => sheetRepository.getCustomerRejectionReports(
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
  SheetRepository sheetRepository,
  Widget page,
) async {
  final bloc = SheetReportsBloc(
    sheetRepository: sheetRepository,
    sheetTargets: const {},
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
