# Report Date-Range Filters

## Scope

Replace existing week/month filters and unfiltered rolling report lists with
explicit From Date and To Date controls across all Frames, Sheets, and Scrap
report-list screens.

The following remain unchanged:

- Calendar and monthly report screens
- Salary screens
- Dashboard report builder and results
- Pending approvals

## Behavior

- Each report list defaults to the last seven calendar days through today,
  inclusive.
- Every report list displays From Date and To Date controls.
- Lists that already support machine filtering retain that filter.
- Selecting either date reloads the list for exactly the selected inclusive
  range.
- Pull-to-refresh reloads the currently selected range.
- A To date earlier than From is invalid. The filter displays an inline error
  and does not dispatch a query.
- Server-side previous-week loading is removed because it would fetch records
  outside the selected range. Existing local pagination remains available for
  long result sets.

## Architecture

Introduce a reusable report-list filter shell that owns:

- From and To date state
- The last-seven-days default
- Date-picker presentation
- Range validation
- Optional machine selection
- Emission of a `ReportListQuery`

Extend the existing `ReportListPageShell` rather than introducing parallel
filter implementations. Make machine filtering optional so report lists that
do not need it can use the same shell.

Migrate the custom Frames, Sheets, and Scrap list pages to the shared shell.
Their blocs and repositories already accept `startDate` and `endDate`, so the
data contracts do not need to change.

## Data Flow

1. The shell initializes From and To to the last seven days through today.
2. After the first frame, it emits a valid `ReportListQuery`.
3. The report page maps the query to its existing bloc load event.
4. The bloc passes the inclusive dates to its existing repository method.
5. Date or machine changes emit a replacement query and replace displayed
   results.
6. Refresh dispatches the same current query.

## Error Handling

- Invalid ranges remain visible with an inline message.
- No bloc event is emitted until the range is valid.
- Existing bloc loading, empty, and error states remain unchanged.
- Date pickers constrain selection to valid calendar dates but do not silently
  rewrite the user's opposite endpoint.

## Testing

Add shared-shell widget tests covering:

- Default From and To values
- Initial query emission
- From-date changes
- To-date changes
- Rejection of To-before-From
- Optional machine filter behavior

Update representative report-list tests to verify selected dates reach bloc
events. Run static analysis and the existing unit/widget test suite. Firebase
integration tests may continue to require their external test environment.
