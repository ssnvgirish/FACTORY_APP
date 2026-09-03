# Report Date-Range Filters Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Give every Frames, Sheets, and Scrap report list explicit inclusive From Date and To Date filters that default to the last seven days.

**Architecture:** Extend `ReportListPageShell` into the single owner of optional machine selection, date-range state, validation, and query emission. Existing shell consumers keep their bloc contracts, while custom report pages migrate into the shell and remove their own initial-load and previous-week pagination logic.

**Tech Stack:** Flutter, Dart, flutter_bloc, flutter_test, intl

## Global Constraints

- Scope is report-list screens under Frames, Sheets, and Scrap only.
- Calendar/monthly, salary, dashboard report-builder/results, and pending-approval screens remain unchanged.
- The range is inclusive and defaults to the last seven calendar days through today.
- Existing machine filters remain; lists without a machine-capable event may filter loaded records client-side.
- Invalid ranges display an inline error and do not emit a bloc query.
- Pull-to-refresh uses the current valid range.
- Server-side previous-week loading is removed; `PaginatedListView` keeps local pagination.
- Preserve all existing cards, details, delete actions, FABs, and explicit retry/error UI.

---

### Task 1: Shared date-range shell

**Files:**
- Modify: `lib/core/widgets/report_list_page_shell.dart`
- Create: `test/core/widgets/report_list_page_shell_test.dart`

**Interfaces:**
- Consumes: `ReportWeekRange.initial({DateTime? now, int days})`
- Produces: `ReportListPageShell({required title, machines = const [], floatingActionButton, required onQueryChanged, required bodyBuilder})`
- Produces: valid `ReportListQuery(machineNumber, startDate, endDate)` values only

- [ ] **Step 1: Write failing widget tests for defaults and optional machine UI**

Create tests that capture emitted queries from a shell:

```dart
testWidgets('defaults to the last seven days and hides an empty machine filter',
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
});

testWidgets('shows the machine filter when machines are supplied',
    (tester) async {
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
```

- [ ] **Step 2: Write failing widget tests for date changes and invalid ranges**

Use the date-picker dialog to select an end date before the current From date.
Assert that the shell displays `To Date cannot be before From Date`, emits no
second query, and continues passing the last valid query to `bodyBuilder`.
Then select a valid endpoint and assert a second inclusive query is emitted.

```dart
expect(find.text('To Date cannot be before From Date'), findsOneWidget);
expect(queries, hasLength(1));
expect(lastBuiltQuery, queries.single);
```

- [ ] **Step 3: Run the shell tests and verify they fail**

Run:

```bash
flutter test test/core/widgets/report_list_page_shell_test.dart
```

Expected: failures because `machines` is required and the shell still renders
Month/Week controls.

- [ ] **Step 4: Replace month/week state with From/To state**

In `ReportListPageShell`, make machines optional:

```dart
final List<String> machines;

const ReportListPageShell({
  super.key,
  required this.title,
  this.machines = const [],
  required this.onQueryChanged,
  required this.bodyBuilder,
  this.floatingActionButton,
});
```

Initialize date state and retain the last valid query:

```dart
late DateTime _fromDate;
late DateTime _toDate;
late ReportListQuery _activeQuery;

@override
void initState() {
  super.initState();
  final range = ReportWeekRange.initial();
  _fromDate = range.start;
  _toDate = range.end;
  _activeQuery = _buildQuery();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (mounted) widget.onQueryChanged(_activeQuery);
  });
}

bool get _isValidRange => !_toDate.isBefore(_fromDate);

ReportListQuery _buildQuery() => ReportListQuery(
  machineNumber: _machine,
  startDate: _fromDate,
  endDate: _toDate,
);

void _updateQueryIfValid() {
  if (!_isValidRange) return;
  _activeQuery = _buildQuery();
  widget.onQueryChanged(_activeQuery);
}
```

Replace Month/Week controls with optional Machine plus two `InkWell` date
fields. Format values as `dd MMM yyyy`. Each picker uses `firstDate:
DateTime(2020)` and `lastDate: DateTime.now()`. Date callbacks update their
endpoint inside `setState`, update `_activeQuery` only when valid, then emit
outside `setState`.

Render this below the date row when invalid:

```dart
if (!_isValidRange)
  const Padding(
    padding: EdgeInsets.only(top: 6),
    child: Text(
      'To Date cannot be before From Date',
      style: TextStyle(color: AppTheme.errorRed),
    ),
  ),
```

Pass `_activeQuery`, not the possibly invalid draft endpoints, to:

```dart
Expanded(child: widget.bodyBuilder(context, _activeQuery))
```

- [ ] **Step 5: Run shell tests and static analysis**

Run:

```bash
flutter test test/core/widgets/report_list_page_shell_test.dart
flutter analyze lib/core/widgets/report_list_page_shell.dart test/core/widgets/report_list_page_shell_test.dart
```

Expected: all tests pass and no analyzer issues.

- [ ] **Step 6: Commit the shared shell**

```bash
git add lib/core/widgets/report_list_page_shell.dart test/core/widgets/report_list_page_shell_test.dart
git commit -m "feat: add shared report date range filters"
```

---

### Task 2: Remove out-of-range loading from existing shell consumers

**Files:**
- Modify: `lib/features/frames/presentation/pages/frame_cleaning_report_list_page.dart`
- Modify: `lib/features/frames/presentation/pages/frame_production_details_list_page.dart`
- Modify: `lib/features/frames/presentation/pages/frame_writing_efficiency_page.dart`
- Modify: `lib/features/frames/presentation/pages/frame_packing_report_list_page.dart`
- Modify: `lib/features/frames/presentation/pages/frame_weight_report_page.dart`
- Modify: `lib/features/sheets/presentation/pages/sheet_cleaning_report_list_page.dart`
- Modify: `lib/features/sheets/presentation/pages/sheet_production_details_list_page.dart`
- Modify: `lib/features/sheets/presentation/pages/sheet_writing_efficiency_page.dart`
- Modify: `lib/features/sheets/presentation/pages/sheet_packing_report_list_page.dart`
- Modify: `lib/features/sheets/presentation/pages/sheet_running_feet_page.dart`

**Interfaces:**
- Consumes: valid `ReportListQuery` from Task 1
- Produces: list queries constrained exactly to `query.startDate` and `query.endDate`

- [ ] **Step 1: Add a regression assertion for local-only pagination**

Extend `test/core/widgets/report_list_page_shell_test.dart` with a body builder
that renders:

```dart
PaginatedListView<int>(
  items: const [1, 2, 3],
  emptyMessage: 'Empty',
  itemBuilder: (_, value, __) => Text('$value'),
)
```

Assert that no server-loading callback is required and local items render.

- [ ] **Step 2: Remove previous-week loading from all ten pages**

For every listed file:

- Remove `hasMore`, `isLoadingMore`, and `onLoadMore` from
  `PaginatedListView`.
- Remove the `ReportWeekRange.previousWeek(...)` block.
- Remove the `report_week_range.dart` import when no longer used.
- Keep `onRefresh`, dispatching the existing load event with
  `query.machineNumber`, `query.startDate`, and `query.endDate`.

The resulting list shape must be:

```dart
return PaginatedListView(
  items: state.reports,
  onRefresh: () async {
    context.read<FrameReportsBloc>().add(
      LoadProductionWeightReports(
        machineNumber: query.machineNumber,
        startDate: query.startDate,
        endDate: query.endDate,
      ),
    );
  },
  emptyMessage: 'No production weight reports yet',
  itemBuilder: (context, report, index) {
    // Preserve the existing card unchanged.
  },
);
```

Writing-efficiency pages keep their existing client-side machine filtering,
but remove server previous-week loading.

- [ ] **Step 3: Format, analyze, and test**

Run:

```bash
dart format lib/features/frames/presentation/pages lib/features/sheets/presentation/pages
flutter analyze lib/features/frames/presentation/pages lib/features/sheets/presentation/pages
flutter test test/core/widgets/report_list_page_shell_test.dart test/features/frames
```

Expected: no analyzer issues and tests pass.

- [ ] **Step 4: Commit existing consumer updates**

```bash
git add lib/features/frames/presentation/pages lib/features/sheets/presentation/pages
git commit -m "refactor: constrain report lists to selected dates"
```

---

### Task 3: Migrate remaining Frames report lists

**Files:**
- Modify: `lib/features/frames/presentation/pages/frame_tools_count_list_page.dart`
- Modify: `lib/features/frames/presentation/pages/frame_health_report_list_page.dart`
- Modify: `lib/features/frames/presentation/pages/frame_customer_rejection_list_page.dart`

**Interfaces:**
- Consumes: `ReportListPageShell` from Task 1
- Produces: filtered `LoadToolsCountReports`, `LoadMachineHealthReports`, and `LoadCustomerRejectionReports`

- [ ] **Step 1: Add page-level event tests**

Create or extend Frames widget/bloc tests to verify each event receives:

```dart
machineNumber: query.machineNumber,
startDate: query.startDate,
endDate: query.endDate,
```

Use a fixed query in the test:

```dart
final query = ReportListQuery(
  machineNumber: 'Frame Machine 1',
  startDate: DateTime(2026, 8, 1),
  endDate: DateTime(2026, 8, 15),
);
```

- [ ] **Step 2: Wrap Tools Count with the shared shell**

Add imports for `dropdown_config_provider.dart` and
`report_list_page_shell.dart`; remove `report_week_range.dart`.

Replace its Scaffold and post-frame load with:

```dart
return ReportListPageShell(
  title: 'Tools Count Reports',
  machines: ddp.frameMachines,
  floatingActionButton: FloatingActionButton(
    onPressed: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FrameToolsCountFormPage()),
    ),
    child: const Icon(Icons.add),
  ),
  onQueryChanged: (q) => context.read<FrameReportsBloc>().add(
    LoadToolsCountReports(
      machineNumber: q.machineNumber,
      startDate: q.startDate,
      endDate: q.endDate,
    ),
  ),
  bodyBuilder: (context, query) => BlocBuilder<FrameReportsBloc, FrameReportsState>(
    builder: (context, state) {
      // Preserve loading and loaded-state card UI.
      // Refresh with this query and omit server onLoadMore.
    },
  ),
);
```

- [ ] **Step 3: Wrap Machine Health with the shared shell**

Use `machines: ddp.frameMachines`, preserve
`FrameHealthReportFormPage`, maintenance sections, delete behavior, and detail
navigation. Dispatch `LoadMachineHealthReports` with machine and both dates.

- [ ] **Step 4: Wrap Customer Rejection with the shared shell**

Use `machines: ddp.frameMachines`, preserve
`FrameCustomerRejectionFormPage`, cards, details, and error panel. Change Retry
to:

```dart
onPressed: () => context.read<FrameReportsBloc>().add(
  LoadCustomerRejectionReports(
    machineNumber: query.machineNumber,
    startDate: query.startDate,
    endDate: query.endDate,
  ),
),
```

- [ ] **Step 5: Run Frames tests and analyzer**

Run:

```bash
flutter analyze lib/features/frames/presentation/pages
flutter test test/features/frames
```

Expected: no analyzer issues and all Frames tests pass.

- [ ] **Step 6: Commit Frames migration**

```bash
git add lib/features/frames/presentation/pages test/features/frames
git commit -m "feat: add date filters to frame report lists"
```

---

### Task 4: Migrate remaining Sheets report lists

**Files:**
- Modify: `lib/features/sheets/presentation/pages/sheet_tools_count_list_page.dart`
- Modify: `lib/features/sheets/presentation/pages/sheet_health_report_list_page.dart`
- Modify: `lib/features/sheets/presentation/pages/sheet_customer_rejection_list_page.dart`

**Interfaces:**
- Consumes: `ReportListPageShell` from Task 1
- Produces: filtered `LoadSheetToolsCountReports`, `LoadSheetHealthReports`, and `LoadSheetCustomerRejectionReports`

- [ ] **Step 1: Add page-level event tests**

Verify the three events preserve the selected machine and inclusive dates:

```dart
expect(event.machineNumber, 'Sheet Machine 1');
expect(event.startDate, DateTime(2026, 8, 1));
expect(event.endDate, DateTime(2026, 8, 15));
```

- [ ] **Step 2: Migrate Sheet Tools Count**

Wrap with `ReportListPageShell`, set `machines: ddp.sheetMachines`, preserve the
FAB destination `SheetToolsCountPage(machineId: '')`, and dispatch:

```dart
LoadSheetToolsCountReports(
  machineNumber: q.machineNumber,
  startDate: q.startDate,
  endDate: q.endDate,
)
```

Refresh with the current query and remove previous-week loading.

- [ ] **Step 3: Migrate Sheet Health**

Wrap with the shared shell, use `ddp.sheetMachines`, preserve
`SheetHealthReportPage(machineId: '')`, existing cards/details/delete behavior,
and dispatch `LoadSheetHealthReports` with machine and dates.

- [ ] **Step 4: Migrate Sheet Customer Rejection**

Wrap with the shared shell, use `ddp.sheetMachines`, preserve
`SheetCustomerRejectionPage(machineId: '')`, cards/details, and explicit error
panel. Retry must dispatch:

```dart
LoadSheetCustomerRejectionReports(
  machineNumber: query.machineNumber,
  startDate: query.startDate,
  endDate: query.endDate,
)
```

- [ ] **Step 5: Run Sheets tests and analyzer**

Run:

```bash
flutter analyze lib/features/sheets/presentation/pages
flutter test test/features/sheets
```

Expected: no analyzer issues and all Sheets tests pass.

- [ ] **Step 6: Commit Sheets migration**

```bash
git add lib/features/sheets/presentation/pages test/features/sheets
git commit -m "feat: add date filters to sheet report lists"
```

---

### Task 5: Migrate Scrap report lists

**Files:**
- Modify: `lib/features/scrap_regrind/presentation/pages/scrap_cleaning_report_list_page.dart`
- Modify: `lib/features/scrap_regrind/presentation/pages/scrap_tools_count_list_page.dart`
- Modify: `lib/features/scrap_regrind/presentation/pages/scrap_health_report_list_page.dart`
- Modify: `lib/features/scrap_regrind/presentation/pages/scrap_production_details_list_page.dart`
- Modify: `lib/features/scrap_regrind/presentation/pages/scrap_weight_report_list_page.dart`
- Modify: `lib/features/scrap_regrind/presentation/pages/scrap_writing_efficiency_page.dart`
- Modify: `lib/features/scrap_regrind/presentation/pages/scrap_quality_report_list_page.dart`

**Interfaces:**
- Consumes: `ReportListPageShell` from Task 1
- Produces: filtered Scrap bloc load events for all seven lists

- [ ] **Step 1: Add Scrap event-filter tests**

Verify machine/date propagation for:

```dart
LoadScrapCleaningReports(...)
LoadScrapToolsCountReports(...)
LoadScrapHealthReports(...)
LoadScrapProductionDetailsReports(...)
LoadScrapProductionWeightReports(...)
LoadScrapQualityReports(...)
```

For writing efficiency, verify `LoadScrapWritingEfficiency` receives both dates
and that records are filtered client-side by `query.machineNumber`.

- [ ] **Step 2: Migrate the six machine-capable Scrap lists**

For Cleaning, Tools Count, Health, Production Details, Production Weight, and
Quality:

- Wrap in `ReportListPageShell`.
- Use `machines: ddp.scrapMachines`.
- Dispatch each existing load event with `machineNumber`, `startDate`, and
  `endDate`.
- Refresh with the active query.
- Remove post-frame auto-load and previous-week loading.
- Preserve each existing FAB; Production Weight remains without a FAB.
- Preserve line-item detail sections and all delete actions.

Example:

```dart
onQueryChanged: (q) => context.read<ScrapRegrindBloc>().add(
  LoadScrapProductionWeightReports(
    machineNumber: q.machineNumber,
    startDate: q.startDate,
    endDate: q.endDate,
  ),
),
```

- [ ] **Step 3: Migrate Scrap Writing Efficiency**

Wrap with the shared shell and `machines: ddp.scrapMachines`. Dispatch dates
only because the event exposes `operatorId`, not `machineNumber`:

```dart
onQueryChanged: (q) => context.read<ScrapRegrindBloc>().add(
  LoadScrapWritingEfficiency(
    startDate: q.startDate,
    endDate: q.endDate,
  ),
),
```

Before constructing `PaginatedListView`, filter records:

```dart
final records = query.machineNumber == null
    ? state.records
    : state.records
          .where((record) => record.machineNumber == query.machineNumber)
          .toList();
```

Keep no FAB and preserve current delete-only cards.

- [ ] **Step 4: Run Scrap tests and analyzer**

Run:

```bash
flutter analyze lib/features/scrap_regrind/presentation/pages
flutter test test/features/scrap_regrind test/integration/frame_machine_operator_flow_test.dart
```

If `test/features/scrap_regrind` does not exist, run the integration test plus
the new Scrap event-filter test file directly.

Expected: no analyzer issues and all available local tests pass.

- [ ] **Step 5: Commit Scrap migration**

```bash
git add lib/features/scrap_regrind/presentation/pages test
git commit -m "feat: add date filters to scrap report lists"
```

---

### Task 6: Cross-feature verification

**Files:**
- Verify: all files changed in Tasks 1–5

**Interfaces:**
- Consumes: completed date-range shell and all migrated report lists
- Produces: analyzed, formatted, regression-tested implementation

- [ ] **Step 1: Confirm no report list still uses week/month filtering**

Run:

```bash
rg "weekOfMonth|weeksInMonth|previousWeek|initialDay|previousDay" lib/features/*/presentation/pages
```

Expected: matches only in intentionally excluded calendar/monthly pages, with
no matches in the 23 report-list files.

- [ ] **Step 2: Confirm all scoped lists use the shared shell**

Run:

```bash
rg -l "ReportListPageShell" lib/features/frames/presentation/pages lib/features/sheets/presentation/pages lib/features/scrap_regrind/presentation/pages
```

Expected: all 23 scoped report-list files are present.

- [ ] **Step 3: Format and analyze**

Run:

```bash
dart format lib test
flutter analyze
```

Expected: no new analyzer errors.

- [ ] **Step 4: Run the full local test suite**

Run:

```bash
flutter test
```

Expected: unit and widget tests pass. The known Firebase-backed
`seed_database_test.dart` and `migrate_master_tables_test.dart` may fail during
`setUpAll` without a Firebase host connection; verify no additional failures.

- [ ] **Step 5: Review the final diff**

Run:

```bash
git diff --check
git status --short
git diff --stat
```

Expected: no whitespace errors; only scoped implementation/test files plus the
user's pre-existing Android and lockfile changes remain.

- [ ] **Step 6: Commit verification fixes if needed**

```bash
git add lib test
git commit -m "test: verify report date range filters"
```

Skip this commit if verification requires no corrections.
