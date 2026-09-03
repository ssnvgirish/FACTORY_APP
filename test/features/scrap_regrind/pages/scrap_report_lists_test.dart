import 'package:factory_app/core/constants/app_constants.dart';
import 'package:factory_app/core/di/injection.dart';
import 'package:factory_app/core/services/dropdown_config_provider.dart';
import 'package:factory_app/core/widgets/common_widgets.dart';
import 'package:factory_app/features/admin/domain/repositories/admin_repository.dart';
import 'package:factory_app/features/scrap_regrind/domain/entities/scrap_regrind_entities.dart';
import 'package:factory_app/features/scrap_regrind/domain/repositories/scrap_regrind_repository.dart';
import 'package:factory_app/features/scrap_regrind/presentation/bloc/scrap_regrind_bloc.dart';
import 'package:factory_app/features/scrap_regrind/presentation/pages/scrap_cleaning_report_list_page.dart';
import 'package:factory_app/features/scrap_regrind/presentation/pages/scrap_health_report_list_page.dart';
import 'package:factory_app/features/scrap_regrind/presentation/pages/scrap_production_details_list_page.dart';
import 'package:factory_app/features/scrap_regrind/presentation/pages/scrap_quality_report_list_page.dart';
import 'package:factory_app/features/scrap_regrind/presentation/pages/scrap_tools_count_list_page.dart';
import 'package:factory_app/features/scrap_regrind/presentation/pages/scrap_weight_report_list_page.dart';
import 'package:factory_app/features/scrap_regrind/presentation/pages/scrap_writing_efficiency_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAdminRepository extends Mock implements AdminRepository {}

class MockScrapRegrindRepository extends Mock
    implements ScrapRegrindRepository {}

void main() {
  const machineNumber = AppConstants.crusherMachine1;
  final startDate = DateTime(2026, 8, 1);
  final endDate = DateTime(2026, 8, 15);

  late MockScrapRegrindRepository scrapRepository;

  setUp(() {
    scrapRepository = MockScrapRegrindRepository();
    sl.registerSingleton(
      DropdownConfigProvider(adminRepository: MockAdminRepository()),
    );
  });

  tearDown(() async {
    await sl.reset();
  });

  testWidgets('cleaning reports load the active machine and date range', (
    tester,
  ) async {
    when(
      () => scrapRepository.getCleaningReports(
        machineNumber: any(named: 'machineNumber'),
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
      ),
    ).thenAnswer((_) async => []);

    await _pumpPage(
      tester,
      scrapRepository,
      const ScrapCleaningReportListPage(),
    );
    await _selectQuery(tester, machineNumber, startDate, endDate);

    verify(
      () => scrapRepository.getCleaningReports(
        machineNumber: machineNumber,
        startDate: startDate,
        endDate: endDate,
      ),
    ).called(1);
  });

  testWidgets('tools count loads the active machine and date range', (
    tester,
  ) async {
    when(
      () => scrapRepository.getToolsCountReports(
        machineNumber: any(named: 'machineNumber'),
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
      ),
    ).thenAnswer((_) async => []);

    await _pumpPage(tester, scrapRepository, const ScrapToolsCountListPage());
    await _selectQuery(tester, machineNumber, startDate, endDate);

    verify(
      () => scrapRepository.getToolsCountReports(
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
      () => scrapRepository.getMachineHealthReports(
        machineNumber: any(named: 'machineNumber'),
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
      ),
    ).thenAnswer((_) async => []);

    await _pumpPage(tester, scrapRepository, const ScrapHealthReportListPage());
    await _selectQuery(tester, machineNumber, startDate, endDate);

    verify(
      () => scrapRepository.getMachineHealthReports(
        machineNumber: machineNumber,
        startDate: startDate,
        endDate: endDate,
      ),
    ).called(1);
  });

  testWidgets('production details loads the active machine and date range', (
    tester,
  ) async {
    when(
      () => scrapRepository.getProductionDetailsReports(
        machineNumber: any(named: 'machineNumber'),
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
      ),
    ).thenAnswer((_) async => []);

    await _pumpPage(
      tester,
      scrapRepository,
      const ScrapProductionDetailsListPage(),
    );
    await _selectQuery(tester, machineNumber, startDate, endDate);

    verify(
      () => scrapRepository.getProductionDetailsReports(
        machineNumber: machineNumber,
        startDate: startDate,
        endDate: endDate,
      ),
    ).called(1);
  });

  testWidgets('production weight loads the active machine and date range', (
    tester,
  ) async {
    when(
      () => scrapRepository.getProductionWeightReports(
        machineNumber: any(named: 'machineNumber'),
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
      ),
    ).thenAnswer((_) async => []);

    await _pumpPage(tester, scrapRepository, const ScrapWeightReportListPage());
    await _selectQuery(tester, machineNumber, startDate, endDate);

    verify(
      () => scrapRepository.getProductionWeightReports(
        machineNumber: machineNumber,
        startDate: startDate,
        endDate: endDate,
      ),
    ).called(1);
  });

  testWidgets('quality reports load the active machine and date range', (
    tester,
  ) async {
    when(
      () => scrapRepository.getScrapQualityReports(
        machineNumber: any(named: 'machineNumber'),
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
      ),
    ).thenAnswer((_) async => []);

    await _pumpPage(
      tester,
      scrapRepository,
      const ScrapQualityReportListPage(),
    );
    await _selectQuery(tester, machineNumber, startDate, endDate);

    verify(
      () => scrapRepository.getScrapQualityReports(
        machineNumber: machineNumber,
        startDate: startDate,
        endDate: endDate,
      ),
    ).called(1);
  });

  testWidgets(
    'writing efficiency loads dates only and filters records by machine',
    (tester) async {
      final records = [
        ScrapReportWritingEfficiency(
          date: DateTime(2026, 8, 10),
          machineNumber: AppConstants.crusherMachine1,
          shift: 'Day Shift',
          shiftEndTime: DateTime(2026, 8, 10, 21, 0),
          score: 5,
          operatorId: 'op-1',
        ),
        ScrapReportWritingEfficiency(
          date: DateTime(2026, 8, 11),
          machineNumber: AppConstants.crusherMachine2,
          shift: 'Day Shift',
          shiftEndTime: DateTime(2026, 8, 11, 21, 0),
          score: 4,
          operatorId: 'op-2',
        ),
      ];
      when(
        () => scrapRepository.getReportWritingEfficiency(
          operatorId: any(named: 'operatorId'),
          startDate: any(named: 'startDate'),
          endDate: any(named: 'endDate'),
        ),
      ).thenAnswer((_) async => records);

      await _pumpPage(
        tester,
        scrapRepository,
        const ScrapWritingEfficiencyPage(),
      );
      await _selectDate(tester, 'From Date', startDate);
      await _selectDate(tester, 'To Date', endDate);

      expect(find.text(AppConstants.crusherMachine1), findsWidgets);
      expect(find.text(AppConstants.crusherMachine2), findsWidgets);

      await tester.tap(find.text('All machines'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(machineNumber).last);
      await tester.pumpAndSettle();

      verify(
        () => scrapRepository.getReportWritingEfficiency(
          operatorId: any(named: 'operatorId'),
          startDate: startDate,
          endDate: endDate,
        ),
      ).called(1);
      expect(find.byType(ReportCard), findsOneWidget);
      expect(find.textContaining('10 Aug 2026'), findsOneWidget);
      expect(find.textContaining('11 Aug 2026'), findsNothing);
    },
  );
}

Future<void> _pumpPage(
  WidgetTester tester,
  ScrapRegrindRepository scrapRepository,
  Widget page,
) async {
  final bloc = ScrapRegrindBloc(scrapRegrindRepository: scrapRepository);
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
