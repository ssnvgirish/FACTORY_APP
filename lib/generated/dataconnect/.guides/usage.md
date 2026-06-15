# Basic Usage

```dart
DefaultConnector.instance.ListMasterMachines().execute();
DefaultConnector.instance.InsertMasterMachine(insertMasterMachineVariables).execute();
DefaultConnector.instance.UpdateMasterMachine(updateMasterMachineVariables).execute();
DefaultConnector.instance.DeleteMasterMachine(deleteMasterMachineVariables).execute();
DefaultConnector.instance.ListMasterShifts().execute();
DefaultConnector.instance.InsertMasterShift(insertMasterShiftVariables).execute();
DefaultConnector.instance.UpdateMasterShift(updateMasterShiftVariables).execute();
DefaultConnector.instance.DeleteMasterShift(deleteMasterShiftVariables).execute();
DefaultConnector.instance.ListMasterRoles().execute();
DefaultConnector.instance.InsertMasterRole(insertMasterRoleVariables).execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await DefaultConnector.instance.ListFrameCustomerRejectionReports({ ... })
.machineNumber(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

