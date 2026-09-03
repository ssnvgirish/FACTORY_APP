import 'package:factory_app/core/utils/report_week_range.dart';
import 'package:factory_app/core/widgets/report_list_page_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'defaults to the last seven days and hides an empty machine filter',
    (tester) async {
      final queries = <ReportListQuery>[];
      final today = ReportWeekRange.dateOnly(DateTime.now());

      await tester.pumpWidget(
        MaterialApp(
          home: ReportListPageShell(
            title: 'Reports',
            onQueryChanged: queries.add,
            bodyBuilder: (_, query) => const SizedBox(),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('From Date'), findsOneWidget);
      expect(find.text('To Date'), findsOneWidget);
      expect(find.text('Machine'), findsNothing);
      expect(queries, hasLength(1));
      expect(queries.single.startDate, today.subtract(const Duration(days: 6)));
      expect(queries.single.endDate, today);
    },
  );

  testWidgets('shows the machine filter when machines are supplied', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ReportListPageShell(
          title: 'Reports',
          machines: const ['Machine 1'],
          onQueryChanged: (_) {},
          bodyBuilder: (_, query) => const SizedBox(),
        ),
      ),
    );

    expect(find.text('Machine'), findsOneWidget);
    expect(find.text('All machines'), findsOneWidget);
  });

  testWidgets(
    'retains the last valid query until an invalid end date is corrected',
    (tester) async {
      final queries = <ReportListQuery>[];
      ReportListQuery? lastBuiltQuery;
      final today = ReportWeekRange.dateOnly(DateTime.now());
      final invalidEnd = today.subtract(const Duration(days: 7));
      final validEnd = today.subtract(const Duration(days: 5));

      await tester.pumpWidget(
        MaterialApp(
          home: ReportListPageShell(
            title: 'Reports',
            onQueryChanged: queries.add,
            bodyBuilder: (_, query) {
              lastBuiltQuery = query;
              return const SizedBox();
            },
          ),
        ),
      );
      await tester.pump();

      await _selectDate(tester, 'To Date', invalidEnd);

      expect(find.text('To Date cannot be before From Date'), findsOneWidget);
      expect(queries, hasLength(1));
      expect(lastBuiltQuery, same(queries.single));

      await _selectDate(tester, 'To Date', validEnd);

      expect(find.text('To Date cannot be before From Date'), findsNothing);
      expect(queries, hasLength(2));
      expect(queries.last.startDate, today.subtract(const Duration(days: 6)));
      expect(queries.last.endDate, validEnd);
      expect(lastBuiltQuery, same(queries.last));
    },
  );

  testWidgets(
    'retains the last valid query until an invalid start date is corrected',
    (tester) async {
      final queries = <ReportListQuery>[];
      ReportListQuery? lastBuiltQuery;
      final today = ReportWeekRange.dateOnly(DateTime.now());
      final validEnd = today.subtract(const Duration(days: 5));
      final invalidStart = today.subtract(const Duration(days: 4));
      final validStart = today.subtract(const Duration(days: 6));

      await tester.pumpWidget(
        MaterialApp(
          home: ReportListPageShell(
            title: 'Reports',
            onQueryChanged: queries.add,
            bodyBuilder: (_, query) {
              lastBuiltQuery = query;
              return const SizedBox();
            },
          ),
        ),
      );
      await tester.pump();

      await _selectDate(tester, 'To Date', validEnd);
      expect(queries, hasLength(2));
      expect(queries.last.endDate, validEnd);
      expect(lastBuiltQuery, same(queries.last));

      await _selectDate(tester, 'From Date', invalidStart);

      expect(find.text('To Date cannot be before From Date'), findsOneWidget);
      expect(queries, hasLength(2));
      expect(lastBuiltQuery, same(queries.last));

      await _selectDate(tester, 'From Date', validStart);

      expect(find.text('To Date cannot be before From Date'), findsNothing);
      expect(queries, hasLength(3));
      expect(queries.last.startDate, validStart);
      expect(queries.last.endDate, validEnd);
      expect(lastBuiltQuery, same(queries.last));
    },
  );
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
