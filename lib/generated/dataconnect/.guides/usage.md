# Basic Usage

```dart
DefaultConnector.instance.CreateFrameCleaningReport(createFrameCleaningReportVariables).execute();
DefaultConnector.instance.ListFrameCleaningReports(listFrameCleaningReportsVariables).execute();
DefaultConnector.instance.CreateFrameToolsCountReport(createFrameToolsCountReportVariables).execute();
DefaultConnector.instance.ListFrameToolsCountReports(listFrameToolsCountReportsVariables).execute();
DefaultConnector.instance.CreateFrameHealthReport(createFrameHealthReportVariables).execute();
DefaultConnector.instance.CreateFrameMaintenanceEntry(createFrameMaintenanceEntryVariables).execute();
DefaultConnector.instance.ListFrameHealthReports(listFrameHealthReportsVariables).execute();
DefaultConnector.instance.CreateFrameProductionDetailsReport(createFrameProductionDetailsReportVariables).execute();
DefaultConnector.instance.CreateFrameProductionLineItem(createFrameProductionLineItemVariables).execute();
DefaultConnector.instance.ListFrameProductionDetailsReports(listFrameProductionDetailsReportsVariables).execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await DefaultConnector.instance.ListSheetCustomerRejectionReports({ ... })
.machineNumber(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

