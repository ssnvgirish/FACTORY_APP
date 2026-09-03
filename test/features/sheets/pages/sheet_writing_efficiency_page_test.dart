import 'package:factory_app/core/constants/app_constants.dart';
import 'package:factory_app/core/di/injection.dart';
import 'package:factory_app/core/services/dropdown_config_provider.dart';
import 'package:factory_app/core/widgets/common_widgets.dart';
import 'package:factory_app/features/admin/domain/repositories/admin_repository.dart';
import 'package:factory_app/features/sheets/domain/repositories/sheet_repository.dart';
import 'package:factory_app/features/sheets/presentation/bloc/sheet_reports_bloc.dart';
import 'package:factory_app/features/sheets/presentation/pages/sheet_writing_efficiency_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/test_factories.dart';

class MockAdminRepository extends Mock implements AdminRepository {}

class MockSheetRepository extends Mock implements SheetRepository {}

void main() {
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

  testWidgets('writing efficiency does not reload for machine-only changes', (
    tester,
  ) async {
    final records = [
      TestFactories.fakeReportWritingRecord(
        date: DateTime(2026, 8, 10),
        machineNumber: AppConstants.sheetMachine3,
        operatorId: 'operator-1',
      ),
      TestFactories.fakeReportWritingRecord(
        date: DateTime(2026, 8, 11),
        machineNumber: AppConstants.sheetMachine4,
        operatorId: 'operator-2',
      ),
    ];
    final startDate = DateTime(2026, 8, 1);
    final endDate = DateTime(2026, 8, 15);
    when(
      () => sheetRepository.getReportWritingEfficiency(
        operatorId: any(named: 'operatorId'),
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
      ),
    ).thenAnswer((_) async => records);
    final bloc = SheetReportsBloc(
      sheetRepository: sheetRepository,
      sheetTargets: const {},
    );
    addTearDown(bloc.close);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: bloc,
          child: const SheetWritingEfficiencyPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await _selectDate(tester, 'From Date', startDate);
    await _selectDate(tester, 'To Date', endDate);
    await tester.tap(find.text('All machines'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppConstants.sheetMachine3).last);
    await tester.pumpAndSettle();

    verify(
      () => sheetRepository.getReportWritingEfficiency(
        operatorId: any(named: 'operatorId'),
        startDate: startDate,
        endDate: endDate,
      ),
    ).called(1);
    expect(find.byType(ReportCard), findsOneWidget);
    expect(find.textContaining('10 Aug 2026'), findsOneWidget);
    expect(find.textContaining('11 Aug 2026'), findsNothing);
  });
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
