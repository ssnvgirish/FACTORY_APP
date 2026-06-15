# factory_app SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
DefaultConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### ListMasterMachines
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listMasterMachines().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMasterMachinesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listMasterMachines();
ListMasterMachinesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listMasterMachines().ref();
ref.execute();

ref.subscribe(...);
```


### ListMasterShifts
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listMasterShifts().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMasterShiftsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listMasterShifts();
ListMasterShiftsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listMasterShifts().ref();
ref.execute();

ref.subscribe(...);
```


### ListMasterRoles
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listMasterRoles().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMasterRolesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listMasterRoles();
ListMasterRolesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listMasterRoles().ref();
ref.execute();

ref.subscribe(...);
```


### ListMasterFrameSections
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listMasterFrameSections().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMasterFrameSectionsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listMasterFrameSections();
ListMasterFrameSectionsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listMasterFrameSections().ref();
ref.execute();

ref.subscribe(...);
```


### ListMasterFrameDensities
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listMasterFrameDensities().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMasterFrameDensitiesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listMasterFrameDensities();
ListMasterFrameDensitiesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listMasterFrameDensities().ref();
ref.execute();

ref.subscribe(...);
```


### ListMasterFrameColors
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listMasterFrameColors().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMasterFrameColorsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listMasterFrameColors();
ListMasterFrameColorsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listMasterFrameColors().ref();
ref.execute();

ref.subscribe(...);
```


### ListMasterSheetThicknesses
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listMasterSheetThicknesses().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMasterSheetThicknessesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listMasterSheetThicknesses();
ListMasterSheetThicknessesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listMasterSheetThicknesses().ref();
ref.execute();

ref.subscribe(...);
```


### ListMasterSheetDensities
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listMasterSheetDensities().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMasterSheetDensitiesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listMasterSheetDensities();
ListMasterSheetDensitiesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listMasterSheetDensities().ref();
ref.execute();

ref.subscribe(...);
```


### ListMasterSheetColors
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listMasterSheetColors().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMasterSheetColorsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listMasterSheetColors();
ListMasterSheetColorsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listMasterSheetColors().ref();
ref.execute();

ref.subscribe(...);
```


### ListMasterMaintenanceItems
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listMasterMaintenanceItems().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMasterMaintenanceItemsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listMasterMaintenanceItems();
ListMasterMaintenanceItemsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listMasterMaintenanceItems().ref();
ref.execute();

ref.subscribe(...);
```


### ListMasterScrapProducts
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listMasterScrapProducts().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMasterScrapProductsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listMasterScrapProducts();
ListMasterScrapProductsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listMasterScrapProducts().ref();
ref.execute();

ref.subscribe(...);
```


### ListMasterFrameWeights
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listMasterFrameWeights().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMasterFrameWeightsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listMasterFrameWeights();
ListMasterFrameWeightsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listMasterFrameWeights().ref();
ref.execute();

ref.subscribe(...);
```


### ListMasterSheetWeights
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listMasterSheetWeights().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMasterSheetWeightsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listMasterSheetWeights();
ListMasterSheetWeightsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listMasterSheetWeights().ref();
ref.execute();

ref.subscribe(...);
```


### ListMasterFrameTargets
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listMasterFrameTargets().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMasterFrameTargetsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listMasterFrameTargets();
ListMasterFrameTargetsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listMasterFrameTargets().ref();
ref.execute();

ref.subscribe(...);
```


### ListMasterSheetTargets
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listMasterSheetTargets().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMasterSheetTargetsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listMasterSheetTargets();
ListMasterSheetTargetsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listMasterSheetTargets().ref();
ref.execute();

ref.subscribe(...);
```


### ListMasterSalaryWeightages
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listMasterSalaryWeightages().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMasterSalaryWeightagesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listMasterSalaryWeightages();
ListMasterSalaryWeightagesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listMasterSalaryWeightages().ref();
ref.execute();

ref.subscribe(...);
```


### ListMasterScrapTargets
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listMasterScrapTargets().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMasterScrapTargetsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listMasterScrapTargets();
ListMasterScrapTargetsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listMasterScrapTargets().ref();
ref.execute();

ref.subscribe(...);
```


### GetUserByPhone
#### Required Arguments
```dart
String phone = ...;
DefaultConnector.instance.getUserByPhone(
  phone: phone,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetUserByPhoneData, GetUserByPhoneVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getUserByPhone(
  phone: phone,
);
GetUserByPhoneData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String phone = ...;

final ref = DefaultConnector.instance.getUserByPhone(
  phone: phone,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetUserById
#### Required Arguments
```dart
GetUserByIdVariablesId id = ...;
DefaultConnector.instance.getUserById(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetUserByIdData, GetUserByIdVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getUserById(
  id: id,
);
GetUserByIdData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
GetUserByIdVariablesId id = ...;

final ref = DefaultConnector.instance.getUserById(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListAllUsers
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listAllUsers().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListAllUsersData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listAllUsers();
ListAllUsersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listAllUsers().ref();
ref.execute();

ref.subscribe(...);
```


### GetSalaryCalculation
#### Required Arguments
```dart
String operatorId = ...;
int year = ...;
int month = ...;
DefaultConnector.instance.getSalaryCalculation(
  operatorId: operatorId,
  year: year,
  month: month,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetSalaryCalculationData, GetSalaryCalculationVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getSalaryCalculation(
  operatorId: operatorId,
  year: year,
  month: month,
);
GetSalaryCalculationData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String operatorId = ...;
int year = ...;
int month = ...;

final ref = DefaultConnector.instance.getSalaryCalculation(
  operatorId: operatorId,
  year: year,
  month: month,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListSalaryCalculations
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listSalaryCalculations().execute();
```

#### Optional Arguments
We return a builder for each query. For ListSalaryCalculations, we created `ListSalaryCalculationsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListSalaryCalculationsVariablesBuilder {
  ...
 
  ListSalaryCalculationsVariablesBuilder operatorId(String? t) {
   _operatorId.value = t;
   return this;
  }
  ListSalaryCalculationsVariablesBuilder year(int? t) {
   _year.value = t;
   return this;
  }
  ListSalaryCalculationsVariablesBuilder month(int? t) {
   _month.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listSalaryCalculations()
.operatorId(operatorId)
.year(year)
.month(month)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListSalaryCalculationsData, ListSalaryCalculationsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listSalaryCalculations();
ListSalaryCalculationsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listSalaryCalculations().ref();
ref.execute();

ref.subscribe(...);
```


### ListAllSalaryCalculationsForMonth
#### Required Arguments
```dart
int year = ...;
int month = ...;
DefaultConnector.instance.listAllSalaryCalculationsForMonth(
  year: year,
  month: month,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListAllSalaryCalculationsForMonthData, ListAllSalaryCalculationsForMonthVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listAllSalaryCalculationsForMonth(
  year: year,
  month: month,
);
ListAllSalaryCalculationsForMonthData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
int year = ...;
int month = ...;

final ref = DefaultConnector.instance.listAllSalaryCalculationsForMonth(
  year: year,
  month: month,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListScrapCleaningReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listScrapCleaningReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListScrapCleaningReports, we created `ListScrapCleaningReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListScrapCleaningReportsVariablesBuilder {
  ...
 
  ListScrapCleaningReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListScrapCleaningReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListScrapCleaningReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listScrapCleaningReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListScrapCleaningReportsData, ListScrapCleaningReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listScrapCleaningReports();
ListScrapCleaningReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listScrapCleaningReports().ref();
ref.execute();

ref.subscribe(...);
```


### ListScrapToolsCountReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listScrapToolsCountReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListScrapToolsCountReports, we created `ListScrapToolsCountReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListScrapToolsCountReportsVariablesBuilder {
  ...
 
  ListScrapToolsCountReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListScrapToolsCountReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListScrapToolsCountReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listScrapToolsCountReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListScrapToolsCountReportsData, ListScrapToolsCountReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listScrapToolsCountReports();
ListScrapToolsCountReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listScrapToolsCountReports().ref();
ref.execute();

ref.subscribe(...);
```


### ListScrapMachineHealthReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listScrapMachineHealthReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListScrapMachineHealthReports, we created `ListScrapMachineHealthReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListScrapMachineHealthReportsVariablesBuilder {
  ...
 
  ListScrapMachineHealthReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListScrapMachineHealthReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListScrapMachineHealthReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listScrapMachineHealthReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListScrapMachineHealthReportsData, ListScrapMachineHealthReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listScrapMachineHealthReports();
ListScrapMachineHealthReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listScrapMachineHealthReports().ref();
ref.execute();

ref.subscribe(...);
```


### ListScrapProductionDetailsReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listScrapProductionDetailsReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListScrapProductionDetailsReports, we created `ListScrapProductionDetailsReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListScrapProductionDetailsReportsVariablesBuilder {
  ...
 
  ListScrapProductionDetailsReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListScrapProductionDetailsReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListScrapProductionDetailsReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listScrapProductionDetailsReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListScrapProductionDetailsReportsData, ListScrapProductionDetailsReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listScrapProductionDetailsReports();
ListScrapProductionDetailsReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listScrapProductionDetailsReports().ref();
ref.execute();

ref.subscribe(...);
```


### GetScrapProductionDetailsReport
#### Required Arguments
```dart
String machineNumber = ...;
DateTime date = ...;
String shift = ...;
DefaultConnector.instance.getScrapProductionDetailsReport(
  machineNumber: machineNumber,
  date: date,
  shift: shift,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetScrapProductionDetailsReportData, GetScrapProductionDetailsReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getScrapProductionDetailsReport(
  machineNumber: machineNumber,
  date: date,
  shift: shift,
);
GetScrapProductionDetailsReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String machineNumber = ...;
DateTime date = ...;
String shift = ...;

final ref = DefaultConnector.instance.getScrapProductionDetailsReport(
  machineNumber: machineNumber,
  date: date,
  shift: shift,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListScrapProductionWeightReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listScrapProductionWeightReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListScrapProductionWeightReports, we created `ListScrapProductionWeightReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListScrapProductionWeightReportsVariablesBuilder {
  ...
 
  ListScrapProductionWeightReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListScrapProductionWeightReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListScrapProductionWeightReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listScrapProductionWeightReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListScrapProductionWeightReportsData, ListScrapProductionWeightReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listScrapProductionWeightReports();
ListScrapProductionWeightReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listScrapProductionWeightReports().ref();
ref.execute();

ref.subscribe(...);
```


### ListScrapReportWritingEfficiency
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listScrapReportWritingEfficiency().execute();
```

#### Optional Arguments
We return a builder for each query. For ListScrapReportWritingEfficiency, we created `ListScrapReportWritingEfficiencyBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListScrapReportWritingEfficiencyVariablesBuilder {
  ...
 
  ListScrapReportWritingEfficiencyVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListScrapReportWritingEfficiencyVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListScrapReportWritingEfficiencyVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listScrapReportWritingEfficiency()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListScrapReportWritingEfficiencyData, ListScrapReportWritingEfficiencyVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listScrapReportWritingEfficiency();
ListScrapReportWritingEfficiencyData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listScrapReportWritingEfficiency().ref();
ref.execute();

ref.subscribe(...);
```


### ListScrapQualityReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listScrapQualityReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListScrapQualityReports, we created `ListScrapQualityReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListScrapQualityReportsVariablesBuilder {
  ...
 
  ListScrapQualityReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListScrapQualityReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListScrapQualityReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listScrapQualityReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListScrapQualityReportsData, ListScrapQualityReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listScrapQualityReports();
ListScrapQualityReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listScrapQualityReports().ref();
ref.execute();

ref.subscribe(...);
```


### GetScrapSalaryCalculation
#### Required Arguments
```dart
String operatorId = ...;
int year = ...;
int month = ...;
DefaultConnector.instance.getScrapSalaryCalculation(
  operatorId: operatorId,
  year: year,
  month: month,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetScrapSalaryCalculationData, GetScrapSalaryCalculationVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getScrapSalaryCalculation(
  operatorId: operatorId,
  year: year,
  month: month,
);
GetScrapSalaryCalculationData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String operatorId = ...;
int year = ...;
int month = ...;

final ref = DefaultConnector.instance.getScrapSalaryCalculation(
  operatorId: operatorId,
  year: year,
  month: month,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetScrapSalaryWeightages
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.getScrapSalaryWeightages().execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetScrapSalaryWeightagesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getScrapSalaryWeightages();
GetScrapSalaryWeightagesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.getScrapSalaryWeightages().ref();
ref.execute();

ref.subscribe(...);
```


### GetScrapMonthlyAggregates
#### Required Arguments
```dart
String machineNumber = ...;
DateTime startDate = ...;
DateTime endDate = ...;
DefaultConnector.instance.getScrapMonthlyAggregates(
  machineNumber: machineNumber,
  startDate: startDate,
  endDate: endDate,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetScrapMonthlyAggregatesData, GetScrapMonthlyAggregatesVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getScrapMonthlyAggregates(
  machineNumber: machineNumber,
  startDate: startDate,
  endDate: endDate,
);
GetScrapMonthlyAggregatesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String machineNumber = ...;
DateTime startDate = ...;
DateTime endDate = ...;

final ref = DefaultConnector.instance.getScrapMonthlyAggregates(
  machineNumber: machineNumber,
  startDate: startDate,
  endDate: endDate,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListSheetCleaningReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listSheetCleaningReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListSheetCleaningReports, we created `ListSheetCleaningReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListSheetCleaningReportsVariablesBuilder {
  ...
 
  ListSheetCleaningReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListSheetCleaningReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListSheetCleaningReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listSheetCleaningReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListSheetCleaningReportsData, ListSheetCleaningReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listSheetCleaningReports();
ListSheetCleaningReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listSheetCleaningReports().ref();
ref.execute();

ref.subscribe(...);
```


### ListSheetToolsCountReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listSheetToolsCountReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListSheetToolsCountReports, we created `ListSheetToolsCountReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListSheetToolsCountReportsVariablesBuilder {
  ...
 
  ListSheetToolsCountReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListSheetToolsCountReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListSheetToolsCountReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listSheetToolsCountReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListSheetToolsCountReportsData, ListSheetToolsCountReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listSheetToolsCountReports();
ListSheetToolsCountReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listSheetToolsCountReports().ref();
ref.execute();

ref.subscribe(...);
```


### ListSheetHealthReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listSheetHealthReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListSheetHealthReports, we created `ListSheetHealthReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListSheetHealthReportsVariablesBuilder {
  ...
 
  ListSheetHealthReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListSheetHealthReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListSheetHealthReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listSheetHealthReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListSheetHealthReportsData, ListSheetHealthReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listSheetHealthReports();
ListSheetHealthReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listSheetHealthReports().ref();
ref.execute();

ref.subscribe(...);
```


### ListSheetProductionDetailsReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listSheetProductionDetailsReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListSheetProductionDetailsReports, we created `ListSheetProductionDetailsReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListSheetProductionDetailsReportsVariablesBuilder {
  ...
 
  ListSheetProductionDetailsReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListSheetProductionDetailsReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListSheetProductionDetailsReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listSheetProductionDetailsReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListSheetProductionDetailsReportsData, ListSheetProductionDetailsReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listSheetProductionDetailsReports();
ListSheetProductionDetailsReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listSheetProductionDetailsReports().ref();
ref.execute();

ref.subscribe(...);
```


### GetSheetProductionDetailsReport
#### Required Arguments
```dart
String machineNumber = ...;
DateTime date = ...;
String shift = ...;
DefaultConnector.instance.getSheetProductionDetailsReport(
  machineNumber: machineNumber,
  date: date,
  shift: shift,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetSheetProductionDetailsReportData, GetSheetProductionDetailsReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getSheetProductionDetailsReport(
  machineNumber: machineNumber,
  date: date,
  shift: shift,
);
GetSheetProductionDetailsReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String machineNumber = ...;
DateTime date = ...;
String shift = ...;

final ref = DefaultConnector.instance.getSheetProductionDetailsReport(
  machineNumber: machineNumber,
  date: date,
  shift: shift,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListSheetRunningFeetReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listSheetRunningFeetReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListSheetRunningFeetReports, we created `ListSheetRunningFeetReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListSheetRunningFeetReportsVariablesBuilder {
  ...
 
  ListSheetRunningFeetReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListSheetRunningFeetReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListSheetRunningFeetReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listSheetRunningFeetReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListSheetRunningFeetReportsData, ListSheetRunningFeetReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listSheetRunningFeetReports();
ListSheetRunningFeetReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listSheetRunningFeetReports().ref();
ref.execute();

ref.subscribe(...);
```


### ListSheetShiftPackingReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listSheetShiftPackingReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListSheetShiftPackingReports, we created `ListSheetShiftPackingReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListSheetShiftPackingReportsVariablesBuilder {
  ...
 
  ListSheetShiftPackingReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListSheetShiftPackingReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListSheetShiftPackingReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listSheetShiftPackingReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListSheetShiftPackingReportsData, ListSheetShiftPackingReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listSheetShiftPackingReports();
ListSheetShiftPackingReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listSheetShiftPackingReports().ref();
ref.execute();

ref.subscribe(...);
```


### ListSheetWritingEfficiency
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listSheetWritingEfficiency().execute();
```

#### Optional Arguments
We return a builder for each query. For ListSheetWritingEfficiency, we created `ListSheetWritingEfficiencyBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListSheetWritingEfficiencyVariablesBuilder {
  ...
 
  ListSheetWritingEfficiencyVariablesBuilder operatorId(String? t) {
   _operatorId.value = t;
   return this;
  }
  ListSheetWritingEfficiencyVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListSheetWritingEfficiencyVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listSheetWritingEfficiency()
.operatorId(operatorId)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListSheetWritingEfficiencyData, ListSheetWritingEfficiencyVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listSheetWritingEfficiency();
ListSheetWritingEfficiencyData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listSheetWritingEfficiency().ref();
ref.execute();

ref.subscribe(...);
```


### ListSheetCustomerRejectionReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listSheetCustomerRejectionReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListSheetCustomerRejectionReports, we created `ListSheetCustomerRejectionReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListSheetCustomerRejectionReportsVariablesBuilder {
  ...
 
  ListSheetCustomerRejectionReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListSheetCustomerRejectionReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListSheetCustomerRejectionReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listSheetCustomerRejectionReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListSheetCustomerRejectionReportsData, ListSheetCustomerRejectionReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listSheetCustomerRejectionReports();
ListSheetCustomerRejectionReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listSheetCustomerRejectionReports().ref();
ref.execute();

ref.subscribe(...);
```


### ListFrameCleaningReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listFrameCleaningReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListFrameCleaningReports, we created `ListFrameCleaningReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListFrameCleaningReportsVariablesBuilder {
  ...
 
  ListFrameCleaningReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListFrameCleaningReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListFrameCleaningReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listFrameCleaningReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListFrameCleaningReportsData, ListFrameCleaningReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listFrameCleaningReports();
ListFrameCleaningReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listFrameCleaningReports().ref();
ref.execute();

ref.subscribe(...);
```


### ListFrameToolsCountReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listFrameToolsCountReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListFrameToolsCountReports, we created `ListFrameToolsCountReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListFrameToolsCountReportsVariablesBuilder {
  ...
 
  ListFrameToolsCountReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListFrameToolsCountReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListFrameToolsCountReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listFrameToolsCountReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListFrameToolsCountReportsData, ListFrameToolsCountReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listFrameToolsCountReports();
ListFrameToolsCountReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listFrameToolsCountReports().ref();
ref.execute();

ref.subscribe(...);
```


### ListFrameHealthReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listFrameHealthReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListFrameHealthReports, we created `ListFrameHealthReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListFrameHealthReportsVariablesBuilder {
  ...
 
  ListFrameHealthReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListFrameHealthReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListFrameHealthReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listFrameHealthReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListFrameHealthReportsData, ListFrameHealthReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listFrameHealthReports();
ListFrameHealthReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listFrameHealthReports().ref();
ref.execute();

ref.subscribe(...);
```


### ListFrameProductionDetailsReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listFrameProductionDetailsReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListFrameProductionDetailsReports, we created `ListFrameProductionDetailsReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListFrameProductionDetailsReportsVariablesBuilder {
  ...
 
  ListFrameProductionDetailsReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListFrameProductionDetailsReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListFrameProductionDetailsReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listFrameProductionDetailsReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListFrameProductionDetailsReportsData, ListFrameProductionDetailsReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listFrameProductionDetailsReports();
ListFrameProductionDetailsReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listFrameProductionDetailsReports().ref();
ref.execute();

ref.subscribe(...);
```


### GetFrameProductionDetailsReport
#### Required Arguments
```dart
String machineNumber = ...;
DateTime date = ...;
String shift = ...;
DefaultConnector.instance.getFrameProductionDetailsReport(
  machineNumber: machineNumber,
  date: date,
  shift: shift,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetFrameProductionDetailsReportData, GetFrameProductionDetailsReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.getFrameProductionDetailsReport(
  machineNumber: machineNumber,
  date: date,
  shift: shift,
);
GetFrameProductionDetailsReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String machineNumber = ...;
DateTime date = ...;
String shift = ...;

final ref = DefaultConnector.instance.getFrameProductionDetailsReport(
  machineNumber: machineNumber,
  date: date,
  shift: shift,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListFrameProductionWeightReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listFrameProductionWeightReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListFrameProductionWeightReports, we created `ListFrameProductionWeightReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListFrameProductionWeightReportsVariablesBuilder {
  ...
 
  ListFrameProductionWeightReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListFrameProductionWeightReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListFrameProductionWeightReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listFrameProductionWeightReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListFrameProductionWeightReportsData, ListFrameProductionWeightReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listFrameProductionWeightReports();
ListFrameProductionWeightReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listFrameProductionWeightReports().ref();
ref.execute();

ref.subscribe(...);
```


### ListFrameShiftPackingReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listFrameShiftPackingReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListFrameShiftPackingReports, we created `ListFrameShiftPackingReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListFrameShiftPackingReportsVariablesBuilder {
  ...
 
  ListFrameShiftPackingReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListFrameShiftPackingReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListFrameShiftPackingReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listFrameShiftPackingReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListFrameShiftPackingReportsData, ListFrameShiftPackingReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listFrameShiftPackingReports();
ListFrameShiftPackingReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listFrameShiftPackingReports().ref();
ref.execute();

ref.subscribe(...);
```


### ListFrameWritingEfficiency
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listFrameWritingEfficiency().execute();
```

#### Optional Arguments
We return a builder for each query. For ListFrameWritingEfficiency, we created `ListFrameWritingEfficiencyBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListFrameWritingEfficiencyVariablesBuilder {
  ...
 
  ListFrameWritingEfficiencyVariablesBuilder operatorId(String? t) {
   _operatorId.value = t;
   return this;
  }
  ListFrameWritingEfficiencyVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListFrameWritingEfficiencyVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listFrameWritingEfficiency()
.operatorId(operatorId)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListFrameWritingEfficiencyData, ListFrameWritingEfficiencyVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listFrameWritingEfficiency();
ListFrameWritingEfficiencyData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listFrameWritingEfficiency().ref();
ref.execute();

ref.subscribe(...);
```


### ListFrameCustomerRejectionReports
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.listFrameCustomerRejectionReports().execute();
```

#### Optional Arguments
We return a builder for each query. For ListFrameCustomerRejectionReports, we created `ListFrameCustomerRejectionReportsBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ListFrameCustomerRejectionReportsVariablesBuilder {
  ...
 
  ListFrameCustomerRejectionReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListFrameCustomerRejectionReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListFrameCustomerRejectionReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.listFrameCustomerRejectionReports()
.machineNumber(machineNumber)
.startDate(startDate)
.endDate(endDate)
.execute();
```

#### Return Type
`execute()` returns a `QueryResult<ListFrameCustomerRejectionReportsData, ListFrameCustomerRejectionReportsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await DefaultConnector.instance.listFrameCustomerRejectionReports();
ListFrameCustomerRejectionReportsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.listFrameCustomerRejectionReports().ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### InsertMasterMachine
#### Required Arguments
```dart
String name = ...;
String type = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.insertMasterMachine(
  name: name,
  type: type,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InsertMasterMachineData, InsertMasterMachineVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.insertMasterMachine(
  name: name,
  type: type,
  sortOrder: sortOrder,
  isActive: isActive,
);
InsertMasterMachineData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
String type = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.insertMasterMachine(
  name: name,
  type: type,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### UpdateMasterMachine
#### Required Arguments
```dart
UpdateMasterMachineVariablesId id = ...;
String name = ...;
String type = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.updateMasterMachine(
  id: id,
  name: name,
  type: type,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateMasterMachineData, UpdateMasterMachineVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateMasterMachine(
  id: id,
  name: name,
  type: type,
  sortOrder: sortOrder,
  isActive: isActive,
);
UpdateMasterMachineData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateMasterMachineVariablesId id = ...;
String name = ...;
String type = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.updateMasterMachine(
  id: id,
  name: name,
  type: type,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### DeleteMasterMachine
#### Required Arguments
```dart
DeleteMasterMachineVariablesId id = ...;
DefaultConnector.instance.deleteMasterMachine(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMasterMachineData, DeleteMasterMachineVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteMasterMachine(
  id: id,
);
DeleteMasterMachineData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DeleteMasterMachineVariablesId id = ...;

final ref = DefaultConnector.instance.deleteMasterMachine(
  id: id,
).ref();
ref.execute();
```


### InsertMasterShift
#### Required Arguments
```dart
String name = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.insertMasterShift(
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InsertMasterShiftData, InsertMasterShiftVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.insertMasterShift(
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
);
InsertMasterShiftData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.insertMasterShift(
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### UpdateMasterShift
#### Required Arguments
```dart
UpdateMasterShiftVariablesId id = ...;
String name = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.updateMasterShift(
  id: id,
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateMasterShiftData, UpdateMasterShiftVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateMasterShift(
  id: id,
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
);
UpdateMasterShiftData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateMasterShiftVariablesId id = ...;
String name = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.updateMasterShift(
  id: id,
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### DeleteMasterShift
#### Required Arguments
```dart
DeleteMasterShiftVariablesId id = ...;
DefaultConnector.instance.deleteMasterShift(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMasterShiftData, DeleteMasterShiftVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteMasterShift(
  id: id,
);
DeleteMasterShiftData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DeleteMasterShiftVariablesId id = ...;

final ref = DefaultConnector.instance.deleteMasterShift(
  id: id,
).ref();
ref.execute();
```


### InsertMasterRole
#### Required Arguments
```dart
String code = ...;
String displayName = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.insertMasterRole(
  code: code,
  displayName: displayName,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InsertMasterRoleData, InsertMasterRoleVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.insertMasterRole(
  code: code,
  displayName: displayName,
  sortOrder: sortOrder,
  isActive: isActive,
);
InsertMasterRoleData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String code = ...;
String displayName = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.insertMasterRole(
  code: code,
  displayName: displayName,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### UpdateMasterRole
#### Required Arguments
```dart
UpdateMasterRoleVariablesId id = ...;
String code = ...;
String displayName = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.updateMasterRole(
  id: id,
  code: code,
  displayName: displayName,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateMasterRoleData, UpdateMasterRoleVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateMasterRole(
  id: id,
  code: code,
  displayName: displayName,
  sortOrder: sortOrder,
  isActive: isActive,
);
UpdateMasterRoleData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateMasterRoleVariablesId id = ...;
String code = ...;
String displayName = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.updateMasterRole(
  id: id,
  code: code,
  displayName: displayName,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### DeleteMasterRole
#### Required Arguments
```dart
DeleteMasterRoleVariablesId id = ...;
DefaultConnector.instance.deleteMasterRole(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMasterRoleData, DeleteMasterRoleVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteMasterRole(
  id: id,
);
DeleteMasterRoleData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DeleteMasterRoleVariablesId id = ...;

final ref = DefaultConnector.instance.deleteMasterRole(
  id: id,
).ref();
ref.execute();
```


### InsertMasterFrameSection
#### Required Arguments
```dart
String name = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.insertMasterFrameSection(
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InsertMasterFrameSectionData, InsertMasterFrameSectionVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.insertMasterFrameSection(
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
);
InsertMasterFrameSectionData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.insertMasterFrameSection(
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### UpdateMasterFrameSection
#### Required Arguments
```dart
UpdateMasterFrameSectionVariablesId id = ...;
String name = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.updateMasterFrameSection(
  id: id,
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateMasterFrameSectionData, UpdateMasterFrameSectionVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateMasterFrameSection(
  id: id,
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
);
UpdateMasterFrameSectionData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateMasterFrameSectionVariablesId id = ...;
String name = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.updateMasterFrameSection(
  id: id,
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### DeleteMasterFrameSection
#### Required Arguments
```dart
DeleteMasterFrameSectionVariablesId id = ...;
DefaultConnector.instance.deleteMasterFrameSection(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMasterFrameSectionData, DeleteMasterFrameSectionVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteMasterFrameSection(
  id: id,
);
DeleteMasterFrameSectionData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DeleteMasterFrameSectionVariablesId id = ...;

final ref = DefaultConnector.instance.deleteMasterFrameSection(
  id: id,
).ref();
ref.execute();
```


### InsertMasterFrameDensity
#### Required Arguments
```dart
String value = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.insertMasterFrameDensity(
  value: value,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InsertMasterFrameDensityData, InsertMasterFrameDensityVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.insertMasterFrameDensity(
  value: value,
  sortOrder: sortOrder,
  isActive: isActive,
);
InsertMasterFrameDensityData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String value = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.insertMasterFrameDensity(
  value: value,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### UpdateMasterFrameDensity
#### Required Arguments
```dart
UpdateMasterFrameDensityVariablesId id = ...;
String value = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.updateMasterFrameDensity(
  id: id,
  value: value,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateMasterFrameDensityData, UpdateMasterFrameDensityVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateMasterFrameDensity(
  id: id,
  value: value,
  sortOrder: sortOrder,
  isActive: isActive,
);
UpdateMasterFrameDensityData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateMasterFrameDensityVariablesId id = ...;
String value = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.updateMasterFrameDensity(
  id: id,
  value: value,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### DeleteMasterFrameDensity
#### Required Arguments
```dart
DeleteMasterFrameDensityVariablesId id = ...;
DefaultConnector.instance.deleteMasterFrameDensity(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMasterFrameDensityData, DeleteMasterFrameDensityVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteMasterFrameDensity(
  id: id,
);
DeleteMasterFrameDensityData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DeleteMasterFrameDensityVariablesId id = ...;

final ref = DefaultConnector.instance.deleteMasterFrameDensity(
  id: id,
).ref();
ref.execute();
```


### InsertMasterFrameColor
#### Required Arguments
```dart
String name = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.insertMasterFrameColor(
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InsertMasterFrameColorData, InsertMasterFrameColorVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.insertMasterFrameColor(
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
);
InsertMasterFrameColorData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.insertMasterFrameColor(
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### UpdateMasterFrameColor
#### Required Arguments
```dart
UpdateMasterFrameColorVariablesId id = ...;
String name = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.updateMasterFrameColor(
  id: id,
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateMasterFrameColorData, UpdateMasterFrameColorVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateMasterFrameColor(
  id: id,
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
);
UpdateMasterFrameColorData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateMasterFrameColorVariablesId id = ...;
String name = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.updateMasterFrameColor(
  id: id,
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### DeleteMasterFrameColor
#### Required Arguments
```dart
DeleteMasterFrameColorVariablesId id = ...;
DefaultConnector.instance.deleteMasterFrameColor(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMasterFrameColorData, DeleteMasterFrameColorVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteMasterFrameColor(
  id: id,
);
DeleteMasterFrameColorData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DeleteMasterFrameColorVariablesId id = ...;

final ref = DefaultConnector.instance.deleteMasterFrameColor(
  id: id,
).ref();
ref.execute();
```


### InsertMasterSheetThickness
#### Required Arguments
```dart
String value = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.insertMasterSheetThickness(
  value: value,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InsertMasterSheetThicknessData, InsertMasterSheetThicknessVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.insertMasterSheetThickness(
  value: value,
  sortOrder: sortOrder,
  isActive: isActive,
);
InsertMasterSheetThicknessData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String value = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.insertMasterSheetThickness(
  value: value,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### UpdateMasterSheetThickness
#### Required Arguments
```dart
UpdateMasterSheetThicknessVariablesId id = ...;
String value = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.updateMasterSheetThickness(
  id: id,
  value: value,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateMasterSheetThicknessData, UpdateMasterSheetThicknessVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateMasterSheetThickness(
  id: id,
  value: value,
  sortOrder: sortOrder,
  isActive: isActive,
);
UpdateMasterSheetThicknessData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateMasterSheetThicknessVariablesId id = ...;
String value = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.updateMasterSheetThickness(
  id: id,
  value: value,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### DeleteMasterSheetThickness
#### Required Arguments
```dart
DeleteMasterSheetThicknessVariablesId id = ...;
DefaultConnector.instance.deleteMasterSheetThickness(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMasterSheetThicknessData, DeleteMasterSheetThicknessVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteMasterSheetThickness(
  id: id,
);
DeleteMasterSheetThicknessData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DeleteMasterSheetThicknessVariablesId id = ...;

final ref = DefaultConnector.instance.deleteMasterSheetThickness(
  id: id,
).ref();
ref.execute();
```


### InsertMasterSheetDensity
#### Required Arguments
```dart
String value = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.insertMasterSheetDensity(
  value: value,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InsertMasterSheetDensityData, InsertMasterSheetDensityVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.insertMasterSheetDensity(
  value: value,
  sortOrder: sortOrder,
  isActive: isActive,
);
InsertMasterSheetDensityData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String value = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.insertMasterSheetDensity(
  value: value,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### UpdateMasterSheetDensity
#### Required Arguments
```dart
UpdateMasterSheetDensityVariablesId id = ...;
String value = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.updateMasterSheetDensity(
  id: id,
  value: value,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateMasterSheetDensityData, UpdateMasterSheetDensityVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateMasterSheetDensity(
  id: id,
  value: value,
  sortOrder: sortOrder,
  isActive: isActive,
);
UpdateMasterSheetDensityData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateMasterSheetDensityVariablesId id = ...;
String value = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.updateMasterSheetDensity(
  id: id,
  value: value,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### DeleteMasterSheetDensity
#### Required Arguments
```dart
DeleteMasterSheetDensityVariablesId id = ...;
DefaultConnector.instance.deleteMasterSheetDensity(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMasterSheetDensityData, DeleteMasterSheetDensityVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteMasterSheetDensity(
  id: id,
);
DeleteMasterSheetDensityData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DeleteMasterSheetDensityVariablesId id = ...;

final ref = DefaultConnector.instance.deleteMasterSheetDensity(
  id: id,
).ref();
ref.execute();
```


### InsertMasterSheetColor
#### Required Arguments
```dart
String name = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.insertMasterSheetColor(
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InsertMasterSheetColorData, InsertMasterSheetColorVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.insertMasterSheetColor(
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
);
InsertMasterSheetColorData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.insertMasterSheetColor(
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### UpdateMasterSheetColor
#### Required Arguments
```dart
UpdateMasterSheetColorVariablesId id = ...;
String name = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.updateMasterSheetColor(
  id: id,
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateMasterSheetColorData, UpdateMasterSheetColorVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateMasterSheetColor(
  id: id,
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
);
UpdateMasterSheetColorData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateMasterSheetColorVariablesId id = ...;
String name = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.updateMasterSheetColor(
  id: id,
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### DeleteMasterSheetColor
#### Required Arguments
```dart
DeleteMasterSheetColorVariablesId id = ...;
DefaultConnector.instance.deleteMasterSheetColor(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMasterSheetColorData, DeleteMasterSheetColorVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteMasterSheetColor(
  id: id,
);
DeleteMasterSheetColorData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DeleteMasterSheetColorVariablesId id = ...;

final ref = DefaultConnector.instance.deleteMasterSheetColor(
  id: id,
).ref();
ref.execute();
```


### InsertMasterMaintenanceItem
#### Required Arguments
```dart
String name = ...;
String category = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.insertMasterMaintenanceItem(
  name: name,
  category: category,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InsertMasterMaintenanceItemData, InsertMasterMaintenanceItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.insertMasterMaintenanceItem(
  name: name,
  category: category,
  sortOrder: sortOrder,
  isActive: isActive,
);
InsertMasterMaintenanceItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
String category = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.insertMasterMaintenanceItem(
  name: name,
  category: category,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### UpdateMasterMaintenanceItem
#### Required Arguments
```dart
UpdateMasterMaintenanceItemVariablesId id = ...;
String name = ...;
String category = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.updateMasterMaintenanceItem(
  id: id,
  name: name,
  category: category,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateMasterMaintenanceItemData, UpdateMasterMaintenanceItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateMasterMaintenanceItem(
  id: id,
  name: name,
  category: category,
  sortOrder: sortOrder,
  isActive: isActive,
);
UpdateMasterMaintenanceItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateMasterMaintenanceItemVariablesId id = ...;
String name = ...;
String category = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.updateMasterMaintenanceItem(
  id: id,
  name: name,
  category: category,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### DeleteMasterMaintenanceItem
#### Required Arguments
```dart
DeleteMasterMaintenanceItemVariablesId id = ...;
DefaultConnector.instance.deleteMasterMaintenanceItem(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMasterMaintenanceItemData, DeleteMasterMaintenanceItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteMasterMaintenanceItem(
  id: id,
);
DeleteMasterMaintenanceItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DeleteMasterMaintenanceItemVariablesId id = ...;

final ref = DefaultConnector.instance.deleteMasterMaintenanceItem(
  id: id,
).ref();
ref.execute();
```


### InsertMasterScrapProduct
#### Required Arguments
```dart
String name = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.insertMasterScrapProduct(
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InsertMasterScrapProductData, InsertMasterScrapProductVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.insertMasterScrapProduct(
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
);
InsertMasterScrapProductData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.insertMasterScrapProduct(
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### UpdateMasterScrapProduct
#### Required Arguments
```dart
UpdateMasterScrapProductVariablesId id = ...;
String name = ...;
int sortOrder = ...;
bool isActive = ...;
DefaultConnector.instance.updateMasterScrapProduct(
  id: id,
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateMasterScrapProductData, UpdateMasterScrapProductVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateMasterScrapProduct(
  id: id,
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
);
UpdateMasterScrapProductData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateMasterScrapProductVariablesId id = ...;
String name = ...;
int sortOrder = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.updateMasterScrapProduct(
  id: id,
  name: name,
  sortOrder: sortOrder,
  isActive: isActive,
).ref();
ref.execute();
```


### DeleteMasterScrapProduct
#### Required Arguments
```dart
DeleteMasterScrapProductVariablesId id = ...;
DefaultConnector.instance.deleteMasterScrapProduct(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMasterScrapProductData, DeleteMasterScrapProductVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteMasterScrapProduct(
  id: id,
);
DeleteMasterScrapProductData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DeleteMasterScrapProductVariablesId id = ...;

final ref = DefaultConnector.instance.deleteMasterScrapProduct(
  id: id,
).ref();
ref.execute();
```


### InsertMasterFrameWeight
#### Required Arguments
```dart
String section = ...;
String density = ...;
double weightPerFoot = ...;
DefaultConnector.instance.insertMasterFrameWeight(
  section: section,
  density: density,
  weightPerFoot: weightPerFoot,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InsertMasterFrameWeightData, InsertMasterFrameWeightVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.insertMasterFrameWeight(
  section: section,
  density: density,
  weightPerFoot: weightPerFoot,
);
InsertMasterFrameWeightData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String section = ...;
String density = ...;
double weightPerFoot = ...;

final ref = DefaultConnector.instance.insertMasterFrameWeight(
  section: section,
  density: density,
  weightPerFoot: weightPerFoot,
).ref();
ref.execute();
```


### UpdateMasterFrameWeight
#### Required Arguments
```dart
UpdateMasterFrameWeightVariablesId id = ...;
String section = ...;
String density = ...;
double weightPerFoot = ...;
DefaultConnector.instance.updateMasterFrameWeight(
  id: id,
  section: section,
  density: density,
  weightPerFoot: weightPerFoot,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateMasterFrameWeightData, UpdateMasterFrameWeightVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateMasterFrameWeight(
  id: id,
  section: section,
  density: density,
  weightPerFoot: weightPerFoot,
);
UpdateMasterFrameWeightData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateMasterFrameWeightVariablesId id = ...;
String section = ...;
String density = ...;
double weightPerFoot = ...;

final ref = DefaultConnector.instance.updateMasterFrameWeight(
  id: id,
  section: section,
  density: density,
  weightPerFoot: weightPerFoot,
).ref();
ref.execute();
```


### DeleteMasterFrameWeight
#### Required Arguments
```dart
DeleteMasterFrameWeightVariablesId id = ...;
DefaultConnector.instance.deleteMasterFrameWeight(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMasterFrameWeightData, DeleteMasterFrameWeightVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteMasterFrameWeight(
  id: id,
);
DeleteMasterFrameWeightData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DeleteMasterFrameWeightVariablesId id = ...;

final ref = DefaultConnector.instance.deleteMasterFrameWeight(
  id: id,
).ref();
ref.execute();
```


### InsertMasterSheetWeight
#### Required Arguments
```dart
String thickness = ...;
String density = ...;
double weightPerSqft = ...;
DefaultConnector.instance.insertMasterSheetWeight(
  thickness: thickness,
  density: density,
  weightPerSqft: weightPerSqft,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InsertMasterSheetWeightData, InsertMasterSheetWeightVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.insertMasterSheetWeight(
  thickness: thickness,
  density: density,
  weightPerSqft: weightPerSqft,
);
InsertMasterSheetWeightData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String thickness = ...;
String density = ...;
double weightPerSqft = ...;

final ref = DefaultConnector.instance.insertMasterSheetWeight(
  thickness: thickness,
  density: density,
  weightPerSqft: weightPerSqft,
).ref();
ref.execute();
```


### UpdateMasterSheetWeight
#### Required Arguments
```dart
UpdateMasterSheetWeightVariablesId id = ...;
String thickness = ...;
String density = ...;
double weightPerSqft = ...;
DefaultConnector.instance.updateMasterSheetWeight(
  id: id,
  thickness: thickness,
  density: density,
  weightPerSqft: weightPerSqft,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateMasterSheetWeightData, UpdateMasterSheetWeightVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateMasterSheetWeight(
  id: id,
  thickness: thickness,
  density: density,
  weightPerSqft: weightPerSqft,
);
UpdateMasterSheetWeightData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateMasterSheetWeightVariablesId id = ...;
String thickness = ...;
String density = ...;
double weightPerSqft = ...;

final ref = DefaultConnector.instance.updateMasterSheetWeight(
  id: id,
  thickness: thickness,
  density: density,
  weightPerSqft: weightPerSqft,
).ref();
ref.execute();
```


### DeleteMasterSheetWeight
#### Required Arguments
```dart
DeleteMasterSheetWeightVariablesId id = ...;
DefaultConnector.instance.deleteMasterSheetWeight(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMasterSheetWeightData, DeleteMasterSheetWeightVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteMasterSheetWeight(
  id: id,
);
DeleteMasterSheetWeightData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DeleteMasterSheetWeightVariablesId id = ...;

final ref = DefaultConnector.instance.deleteMasterSheetWeight(
  id: id,
).ref();
ref.execute();
```


### InsertMasterFrameTarget
#### Required Arguments
```dart
String section = ...;
double targetKgPerHour = ...;
DefaultConnector.instance.insertMasterFrameTarget(
  section: section,
  targetKgPerHour: targetKgPerHour,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InsertMasterFrameTargetData, InsertMasterFrameTargetVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.insertMasterFrameTarget(
  section: section,
  targetKgPerHour: targetKgPerHour,
);
InsertMasterFrameTargetData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String section = ...;
double targetKgPerHour = ...;

final ref = DefaultConnector.instance.insertMasterFrameTarget(
  section: section,
  targetKgPerHour: targetKgPerHour,
).ref();
ref.execute();
```


### UpdateMasterFrameTarget
#### Required Arguments
```dart
UpdateMasterFrameTargetVariablesId id = ...;
String section = ...;
double targetKgPerHour = ...;
DefaultConnector.instance.updateMasterFrameTarget(
  id: id,
  section: section,
  targetKgPerHour: targetKgPerHour,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateMasterFrameTargetData, UpdateMasterFrameTargetVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateMasterFrameTarget(
  id: id,
  section: section,
  targetKgPerHour: targetKgPerHour,
);
UpdateMasterFrameTargetData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateMasterFrameTargetVariablesId id = ...;
String section = ...;
double targetKgPerHour = ...;

final ref = DefaultConnector.instance.updateMasterFrameTarget(
  id: id,
  section: section,
  targetKgPerHour: targetKgPerHour,
).ref();
ref.execute();
```


### DeleteMasterFrameTarget
#### Required Arguments
```dart
DeleteMasterFrameTargetVariablesId id = ...;
DefaultConnector.instance.deleteMasterFrameTarget(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMasterFrameTargetData, DeleteMasterFrameTargetVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteMasterFrameTarget(
  id: id,
);
DeleteMasterFrameTargetData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DeleteMasterFrameTargetVariablesId id = ...;

final ref = DefaultConnector.instance.deleteMasterFrameTarget(
  id: id,
).ref();
ref.execute();
```


### InsertMasterSheetTarget
#### Required Arguments
```dart
String thickness = ...;
double targetFeetPerHour = ...;
DefaultConnector.instance.insertMasterSheetTarget(
  thickness: thickness,
  targetFeetPerHour: targetFeetPerHour,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InsertMasterSheetTargetData, InsertMasterSheetTargetVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.insertMasterSheetTarget(
  thickness: thickness,
  targetFeetPerHour: targetFeetPerHour,
);
InsertMasterSheetTargetData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String thickness = ...;
double targetFeetPerHour = ...;

final ref = DefaultConnector.instance.insertMasterSheetTarget(
  thickness: thickness,
  targetFeetPerHour: targetFeetPerHour,
).ref();
ref.execute();
```


### UpdateMasterSheetTarget
#### Required Arguments
```dart
UpdateMasterSheetTargetVariablesId id = ...;
String thickness = ...;
double targetFeetPerHour = ...;
DefaultConnector.instance.updateMasterSheetTarget(
  id: id,
  thickness: thickness,
  targetFeetPerHour: targetFeetPerHour,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateMasterSheetTargetData, UpdateMasterSheetTargetVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateMasterSheetTarget(
  id: id,
  thickness: thickness,
  targetFeetPerHour: targetFeetPerHour,
);
UpdateMasterSheetTargetData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateMasterSheetTargetVariablesId id = ...;
String thickness = ...;
double targetFeetPerHour = ...;

final ref = DefaultConnector.instance.updateMasterSheetTarget(
  id: id,
  thickness: thickness,
  targetFeetPerHour: targetFeetPerHour,
).ref();
ref.execute();
```


### DeleteMasterSheetTarget
#### Required Arguments
```dart
DeleteMasterSheetTargetVariablesId id = ...;
DefaultConnector.instance.deleteMasterSheetTarget(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMasterSheetTargetData, DeleteMasterSheetTargetVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteMasterSheetTarget(
  id: id,
);
DeleteMasterSheetTargetData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DeleteMasterSheetTargetVariablesId id = ...;

final ref = DefaultConnector.instance.deleteMasterSheetTarget(
  id: id,
).ref();
ref.execute();
```


### InsertMasterSalaryWeightage
#### Required Arguments
```dart
String variable = ...;
String label = ...;
String category = ...;
double percentage = ...;
DefaultConnector.instance.insertMasterSalaryWeightage(
  variable: variable,
  label: label,
  category: category,
  percentage: percentage,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InsertMasterSalaryWeightageData, InsertMasterSalaryWeightageVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.insertMasterSalaryWeightage(
  variable: variable,
  label: label,
  category: category,
  percentage: percentage,
);
InsertMasterSalaryWeightageData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String variable = ...;
String label = ...;
String category = ...;
double percentage = ...;

final ref = DefaultConnector.instance.insertMasterSalaryWeightage(
  variable: variable,
  label: label,
  category: category,
  percentage: percentage,
).ref();
ref.execute();
```


### UpdateMasterSalaryWeightage
#### Required Arguments
```dart
UpdateMasterSalaryWeightageVariablesId id = ...;
String variable = ...;
String label = ...;
String category = ...;
double percentage = ...;
DefaultConnector.instance.updateMasterSalaryWeightage(
  id: id,
  variable: variable,
  label: label,
  category: category,
  percentage: percentage,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateMasterSalaryWeightageData, UpdateMasterSalaryWeightageVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateMasterSalaryWeightage(
  id: id,
  variable: variable,
  label: label,
  category: category,
  percentage: percentage,
);
UpdateMasterSalaryWeightageData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateMasterSalaryWeightageVariablesId id = ...;
String variable = ...;
String label = ...;
String category = ...;
double percentage = ...;

final ref = DefaultConnector.instance.updateMasterSalaryWeightage(
  id: id,
  variable: variable,
  label: label,
  category: category,
  percentage: percentage,
).ref();
ref.execute();
```


### DeleteMasterSalaryWeightage
#### Required Arguments
```dart
DeleteMasterSalaryWeightageVariablesId id = ...;
DefaultConnector.instance.deleteMasterSalaryWeightage(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMasterSalaryWeightageData, DeleteMasterSalaryWeightageVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteMasterSalaryWeightage(
  id: id,
);
DeleteMasterSalaryWeightageData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DeleteMasterSalaryWeightageVariablesId id = ...;

final ref = DefaultConnector.instance.deleteMasterSalaryWeightage(
  id: id,
).ref();
ref.execute();
```


### InsertMasterScrapTarget
#### Required Arguments
```dart
String product = ...;
double targetKgPerHour = ...;
DefaultConnector.instance.insertMasterScrapTarget(
  product: product,
  targetKgPerHour: targetKgPerHour,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<InsertMasterScrapTargetData, InsertMasterScrapTargetVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.insertMasterScrapTarget(
  product: product,
  targetKgPerHour: targetKgPerHour,
);
InsertMasterScrapTargetData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String product = ...;
double targetKgPerHour = ...;

final ref = DefaultConnector.instance.insertMasterScrapTarget(
  product: product,
  targetKgPerHour: targetKgPerHour,
).ref();
ref.execute();
```


### UpdateMasterScrapTarget
#### Required Arguments
```dart
UpdateMasterScrapTargetVariablesId id = ...;
String product = ...;
double targetKgPerHour = ...;
DefaultConnector.instance.updateMasterScrapTarget(
  id: id,
  product: product,
  targetKgPerHour: targetKgPerHour,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateMasterScrapTargetData, UpdateMasterScrapTargetVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateMasterScrapTarget(
  id: id,
  product: product,
  targetKgPerHour: targetKgPerHour,
);
UpdateMasterScrapTargetData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateMasterScrapTargetVariablesId id = ...;
String product = ...;
double targetKgPerHour = ...;

final ref = DefaultConnector.instance.updateMasterScrapTarget(
  id: id,
  product: product,
  targetKgPerHour: targetKgPerHour,
).ref();
ref.execute();
```


### DeleteMasterScrapTarget
#### Required Arguments
```dart
DeleteMasterScrapTargetVariablesId id = ...;
DefaultConnector.instance.deleteMasterScrapTarget(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteMasterScrapTargetData, DeleteMasterScrapTargetVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.deleteMasterScrapTarget(
  id: id,
);
DeleteMasterScrapTargetData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DeleteMasterScrapTargetVariablesId id = ...;

final ref = DefaultConnector.instance.deleteMasterScrapTarget(
  id: id,
).ref();
ref.execute();
```


### CreateUser
#### Required Arguments
```dart
String uid = ...;
String name = ...;
String phone = ...;
String password = ...;
String email = ...;
String roles = ...;
String assignedMachines = ...;
double fixedSalary = ...;
bool isActive = ...;
DefaultConnector.instance.createUser(
  uid: uid,
  name: name,
  phone: phone,
  password: password,
  email: email,
  roles: roles,
  assignedMachines: assignedMachines,
  fixedSalary: fixedSalary,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateUserData, CreateUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createUser(
  uid: uid,
  name: name,
  phone: phone,
  password: password,
  email: email,
  roles: roles,
  assignedMachines: assignedMachines,
  fixedSalary: fixedSalary,
  isActive: isActive,
);
CreateUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String uid = ...;
String name = ...;
String phone = ...;
String password = ...;
String email = ...;
String roles = ...;
String assignedMachines = ...;
double fixedSalary = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.createUser(
  uid: uid,
  name: name,
  phone: phone,
  password: password,
  email: email,
  roles: roles,
  assignedMachines: assignedMachines,
  fixedSalary: fixedSalary,
  isActive: isActive,
).ref();
ref.execute();
```


### UpdateUser
#### Required Arguments
```dart
UpdateUserVariablesId id = ...;
String name = ...;
String phone = ...;
String roles = ...;
String assignedMachines = ...;
double fixedSalary = ...;
bool isActive = ...;
DefaultConnector.instance.updateUser(
  id: id,
  name: name,
  phone: phone,
  roles: roles,
  assignedMachines: assignedMachines,
  fixedSalary: fixedSalary,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateUserData, UpdateUserVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateUser(
  id: id,
  name: name,
  phone: phone,
  roles: roles,
  assignedMachines: assignedMachines,
  fixedSalary: fixedSalary,
  isActive: isActive,
);
UpdateUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateUserVariablesId id = ...;
String name = ...;
String phone = ...;
String roles = ...;
String assignedMachines = ...;
double fixedSalary = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.updateUser(
  id: id,
  name: name,
  phone: phone,
  roles: roles,
  assignedMachines: assignedMachines,
  fixedSalary: fixedSalary,
  isActive: isActive,
).ref();
ref.execute();
```


### ToggleUserActive
#### Required Arguments
```dart
ToggleUserActiveVariablesId id = ...;
bool isActive = ...;
DefaultConnector.instance.toggleUserActive(
  id: id,
  isActive: isActive,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<ToggleUserActiveData, ToggleUserActiveVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.toggleUserActive(
  id: id,
  isActive: isActive,
);
ToggleUserActiveData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
ToggleUserActiveVariablesId id = ...;
bool isActive = ...;

final ref = DefaultConnector.instance.toggleUserActive(
  id: id,
  isActive: isActive,
).ref();
ref.execute();
```


### CreateSalaryCalculation
#### Required Arguments
```dart
String operatorId = ...;
String operatorName = ...;
int year = ...;
int month = ...;
double a = ...;
double b = ...;
double c = ...;
double d = ...;
double e = ...;
double f = ...;
double wA = ...;
double wB = ...;
double wC = ...;
double wD = ...;
double wE = ...;
double wF = ...;
double multiplier = ...;
double fixedSalary = ...;
double calculatedSalary = ...;
DefaultConnector.instance.createSalaryCalculation(
  operatorId: operatorId,
  operatorName: operatorName,
  year: year,
  month: month,
  a: a,
  b: b,
  c: c,
  d: d,
  e: e,
  f: f,
  wA: wA,
  wB: wB,
  wC: wC,
  wD: wD,
  wE: wE,
  wF: wF,
  multiplier: multiplier,
  fixedSalary: fixedSalary,
  calculatedSalary: calculatedSalary,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateSalaryCalculationData, CreateSalaryCalculationVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createSalaryCalculation(
  operatorId: operatorId,
  operatorName: operatorName,
  year: year,
  month: month,
  a: a,
  b: b,
  c: c,
  d: d,
  e: e,
  f: f,
  wA: wA,
  wB: wB,
  wC: wC,
  wD: wD,
  wE: wE,
  wF: wF,
  multiplier: multiplier,
  fixedSalary: fixedSalary,
  calculatedSalary: calculatedSalary,
);
CreateSalaryCalculationData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String operatorId = ...;
String operatorName = ...;
int year = ...;
int month = ...;
double a = ...;
double b = ...;
double c = ...;
double d = ...;
double e = ...;
double f = ...;
double wA = ...;
double wB = ...;
double wC = ...;
double wD = ...;
double wE = ...;
double wF = ...;
double multiplier = ...;
double fixedSalary = ...;
double calculatedSalary = ...;

final ref = DefaultConnector.instance.createSalaryCalculation(
  operatorId: operatorId,
  operatorName: operatorName,
  year: year,
  month: month,
  a: a,
  b: b,
  c: c,
  d: d,
  e: e,
  f: f,
  wA: wA,
  wB: wB,
  wC: wC,
  wD: wD,
  wE: wE,
  wF: wF,
  multiplier: multiplier,
  fixedSalary: fixedSalary,
  calculatedSalary: calculatedSalary,
).ref();
ref.execute();
```


### UpdateSalaryCalculation
#### Required Arguments
```dart
UpdateSalaryCalculationVariablesId id = ...;
String operatorId = ...;
String operatorName = ...;
int year = ...;
int month = ...;
double a = ...;
double b = ...;
double c = ...;
double d = ...;
double e = ...;
double f = ...;
double wA = ...;
double wB = ...;
double wC = ...;
double wD = ...;
double wE = ...;
double wF = ...;
double multiplier = ...;
double fixedSalary = ...;
double calculatedSalary = ...;
DefaultConnector.instance.updateSalaryCalculation(
  id: id,
  operatorId: operatorId,
  operatorName: operatorName,
  year: year,
  month: month,
  a: a,
  b: b,
  c: c,
  d: d,
  e: e,
  f: f,
  wA: wA,
  wB: wB,
  wC: wC,
  wD: wD,
  wE: wE,
  wF: wF,
  multiplier: multiplier,
  fixedSalary: fixedSalary,
  calculatedSalary: calculatedSalary,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateSalaryCalculationData, UpdateSalaryCalculationVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.updateSalaryCalculation(
  id: id,
  operatorId: operatorId,
  operatorName: operatorName,
  year: year,
  month: month,
  a: a,
  b: b,
  c: c,
  d: d,
  e: e,
  f: f,
  wA: wA,
  wB: wB,
  wC: wC,
  wD: wD,
  wE: wE,
  wF: wF,
  multiplier: multiplier,
  fixedSalary: fixedSalary,
  calculatedSalary: calculatedSalary,
);
UpdateSalaryCalculationData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
UpdateSalaryCalculationVariablesId id = ...;
String operatorId = ...;
String operatorName = ...;
int year = ...;
int month = ...;
double a = ...;
double b = ...;
double c = ...;
double d = ...;
double e = ...;
double f = ...;
double wA = ...;
double wB = ...;
double wC = ...;
double wD = ...;
double wE = ...;
double wF = ...;
double multiplier = ...;
double fixedSalary = ...;
double calculatedSalary = ...;

final ref = DefaultConnector.instance.updateSalaryCalculation(
  id: id,
  operatorId: operatorId,
  operatorName: operatorName,
  year: year,
  month: month,
  a: a,
  b: b,
  c: c,
  d: d,
  e: e,
  f: f,
  wA: wA,
  wB: wB,
  wC: wC,
  wD: wD,
  wE: wE,
  wF: wF,
  multiplier: multiplier,
  fixedSalary: fixedSalary,
  calculatedSalary: calculatedSalary,
).ref();
ref.execute();
```


### CreateScrapCleaningReport
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
int machineCondition = ...;
int groundCondition = ...;
int totalScore = ...;
double percentage = ...;
String createdBy = ...;
DefaultConnector.instance.createScrapCleaningReport(
  date: date,
  machineNumber: machineNumber,
  machineCondition: machineCondition,
  groundCondition: groundCondition,
  totalScore: totalScore,
  percentage: percentage,
  createdBy: createdBy,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateScrapCleaningReportData, CreateScrapCleaningReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createScrapCleaningReport(
  date: date,
  machineNumber: machineNumber,
  machineCondition: machineCondition,
  groundCondition: groundCondition,
  totalScore: totalScore,
  percentage: percentage,
  createdBy: createdBy,
);
CreateScrapCleaningReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
int machineCondition = ...;
int groundCondition = ...;
int totalScore = ...;
double percentage = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createScrapCleaningReport(
  date: date,
  machineNumber: machineNumber,
  machineCondition: machineCondition,
  groundCondition: groundCondition,
  totalScore: totalScore,
  percentage: percentage,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateScrapToolsCountReport
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
int totalToolsGiven = ...;
int totalToolsAvailable = ...;
double percentageAvailable = ...;
String createdBy = ...;
DefaultConnector.instance.createScrapToolsCountReport(
  date: date,
  machineNumber: machineNumber,
  totalToolsGiven: totalToolsGiven,
  totalToolsAvailable: totalToolsAvailable,
  percentageAvailable: percentageAvailable,
  createdBy: createdBy,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateScrapToolsCountReportData, CreateScrapToolsCountReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createScrapToolsCountReport(
  date: date,
  machineNumber: machineNumber,
  totalToolsGiven: totalToolsGiven,
  totalToolsAvailable: totalToolsAvailable,
  percentageAvailable: percentageAvailable,
  createdBy: createdBy,
);
CreateScrapToolsCountReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
int totalToolsGiven = ...;
int totalToolsAvailable = ...;
double percentageAvailable = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createScrapToolsCountReport(
  date: date,
  machineNumber: machineNumber,
  totalToolsGiven: totalToolsGiven,
  totalToolsAvailable: totalToolsAvailable,
  percentageAvailable: percentageAvailable,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateScrapMachineHealthReport
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
double totalMaintenanceDurationHours = ...;
String createdBy = ...;
DefaultConnector.instance.createScrapMachineHealthReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalMaintenanceDurationHours: totalMaintenanceDurationHours,
  createdBy: createdBy,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateScrapMachineHealthReport, we created `CreateScrapMachineHealthReportBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateScrapMachineHealthReportVariablesBuilder {
  ...
   CreateScrapMachineHealthReportVariablesBuilder submittedAt(Timestamp? t) {
   _submittedAt.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.createScrapMachineHealthReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalMaintenanceDurationHours: totalMaintenanceDurationHours,
  createdBy: createdBy,
)
.submittedAt(submittedAt)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateScrapMachineHealthReportData, CreateScrapMachineHealthReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createScrapMachineHealthReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalMaintenanceDurationHours: totalMaintenanceDurationHours,
  createdBy: createdBy,
);
CreateScrapMachineHealthReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
double totalMaintenanceDurationHours = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createScrapMachineHealthReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalMaintenanceDurationHours: totalMaintenanceDurationHours,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateScrapMaintenanceEntry
#### Required Arguments
```dart
CreateScrapMaintenanceEntryVariablesReportId reportId = ...;
String maintenanceItem = ...;
Timestamp startTime = ...;
Timestamp endTime = ...;
String personDoingMaintenance = ...;
String description = ...;
double durationHours = ...;
DefaultConnector.instance.createScrapMaintenanceEntry(
  reportId: reportId,
  maintenanceItem: maintenanceItem,
  startTime: startTime,
  endTime: endTime,
  personDoingMaintenance: personDoingMaintenance,
  description: description,
  durationHours: durationHours,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateScrapMaintenanceEntryData, CreateScrapMaintenanceEntryVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createScrapMaintenanceEntry(
  reportId: reportId,
  maintenanceItem: maintenanceItem,
  startTime: startTime,
  endTime: endTime,
  personDoingMaintenance: personDoingMaintenance,
  description: description,
  durationHours: durationHours,
);
CreateScrapMaintenanceEntryData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
CreateScrapMaintenanceEntryVariablesReportId reportId = ...;
String maintenanceItem = ...;
Timestamp startTime = ...;
Timestamp endTime = ...;
String personDoingMaintenance = ...;
String description = ...;
double durationHours = ...;

final ref = DefaultConnector.instance.createScrapMaintenanceEntry(
  reportId: reportId,
  maintenanceItem: maintenanceItem,
  startTime: startTime,
  endTime: endTime,
  personDoingMaintenance: personDoingMaintenance,
  description: description,
  durationHours: durationHours,
).ref();
ref.execute();
```


### CreateScrapProductionDetailsReport
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
double totalProductionWeight = ...;
String createdBy = ...;
DefaultConnector.instance.createScrapProductionDetailsReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalProductionWeight: totalProductionWeight,
  createdBy: createdBy,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateScrapProductionDetailsReport, we created `CreateScrapProductionDetailsReportBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateScrapProductionDetailsReportVariablesBuilder {
  ...
   CreateScrapProductionDetailsReportVariablesBuilder submittedAt(Timestamp? t) {
   _submittedAt.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.createScrapProductionDetailsReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalProductionWeight: totalProductionWeight,
  createdBy: createdBy,
)
.submittedAt(submittedAt)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateScrapProductionDetailsReportData, CreateScrapProductionDetailsReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createScrapProductionDetailsReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalProductionWeight: totalProductionWeight,
  createdBy: createdBy,
);
CreateScrapProductionDetailsReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
double totalProductionWeight = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createScrapProductionDetailsReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalProductionWeight: totalProductionWeight,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateScrapProductionLineItem
#### Required Arguments
```dart
CreateScrapProductionLineItemVariablesReportId reportId = ...;
String product = ...;
double weightPerBag = ...;
int totalBags = ...;
double totalWeight = ...;
DefaultConnector.instance.createScrapProductionLineItem(
  reportId: reportId,
  product: product,
  weightPerBag: weightPerBag,
  totalBags: totalBags,
  totalWeight: totalWeight,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateScrapProductionLineItemData, CreateScrapProductionLineItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createScrapProductionLineItem(
  reportId: reportId,
  product: product,
  weightPerBag: weightPerBag,
  totalBags: totalBags,
  totalWeight: totalWeight,
);
CreateScrapProductionLineItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
CreateScrapProductionLineItemVariablesReportId reportId = ...;
String product = ...;
double weightPerBag = ...;
int totalBags = ...;
double totalWeight = ...;

final ref = DefaultConnector.instance.createScrapProductionLineItem(
  reportId: reportId,
  product: product,
  weightPerBag: weightPerBag,
  totalBags: totalBags,
  totalWeight: totalWeight,
).ref();
ref.execute();
```


### CreateScrapProductionWeightReport
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
double totalProductionWeight = ...;
double maintenanceWeight = ...;
double totalWeight = ...;
double targetWeight = ...;
double efficiencyPercentage = ...;
String createdBy = ...;
DefaultConnector.instance.createScrapProductionWeightReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalProductionWeight: totalProductionWeight,
  maintenanceWeight: maintenanceWeight,
  totalWeight: totalWeight,
  targetWeight: targetWeight,
  efficiencyPercentage: efficiencyPercentage,
  createdBy: createdBy,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateScrapProductionWeightReportData, CreateScrapProductionWeightReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createScrapProductionWeightReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalProductionWeight: totalProductionWeight,
  maintenanceWeight: maintenanceWeight,
  totalWeight: totalWeight,
  targetWeight: targetWeight,
  efficiencyPercentage: efficiencyPercentage,
  createdBy: createdBy,
);
CreateScrapProductionWeightReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
double totalProductionWeight = ...;
double maintenanceWeight = ...;
double totalWeight = ...;
double targetWeight = ...;
double efficiencyPercentage = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createScrapProductionWeightReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalProductionWeight: totalProductionWeight,
  maintenanceWeight: maintenanceWeight,
  totalWeight: totalWeight,
  targetWeight: targetWeight,
  efficiencyPercentage: efficiencyPercentage,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateScrapWritingEfficiency
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
Timestamp shiftEndTime = ...;
int score = ...;
String operatorId = ...;
DefaultConnector.instance.createScrapWritingEfficiency(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  shiftEndTime: shiftEndTime,
  score: score,
  operatorId: operatorId,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateScrapWritingEfficiency, we created `CreateScrapWritingEfficiencyBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateScrapWritingEfficiencyVariablesBuilder {
  ...
   CreateScrapWritingEfficiencyVariablesBuilder submittedAt(Timestamp? t) {
   _submittedAt.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.createScrapWritingEfficiency(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  shiftEndTime: shiftEndTime,
  score: score,
  operatorId: operatorId,
)
.submittedAt(submittedAt)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateScrapWritingEfficiencyData, CreateScrapWritingEfficiencyVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createScrapWritingEfficiency(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  shiftEndTime: shiftEndTime,
  score: score,
  operatorId: operatorId,
);
CreateScrapWritingEfficiencyData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
Timestamp shiftEndTime = ...;
int score = ...;
String operatorId = ...;

final ref = DefaultConnector.instance.createScrapWritingEfficiency(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  shiftEndTime: shiftEndTime,
  score: score,
  operatorId: operatorId,
).ref();
ref.execute();
```


### CreateScrapQualityReport
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
String product = ...;
int qualityRating = ...;
String createdBy = ...;
DefaultConnector.instance.createScrapQualityReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  product: product,
  qualityRating: qualityRating,
  createdBy: createdBy,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateScrapQualityReport, we created `CreateScrapQualityReportBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateScrapQualityReportVariablesBuilder {
  ...
   CreateScrapQualityReportVariablesBuilder comments(String? t) {
   _comments.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.createScrapQualityReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  product: product,
  qualityRating: qualityRating,
  createdBy: createdBy,
)
.comments(comments)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateScrapQualityReportData, CreateScrapQualityReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createScrapQualityReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  product: product,
  qualityRating: qualityRating,
  createdBy: createdBy,
);
CreateScrapQualityReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
String product = ...;
int qualityRating = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createScrapQualityReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  product: product,
  qualityRating: qualityRating,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateScrapSalaryCalculation
#### Required Arguments
```dart
String operatorId = ...;
String operatorName = ...;
int year = ...;
int month = ...;
double a = ...;
double b = ...;
double e = ...;
double f = ...;
double g = ...;
double wA = ...;
double wB = ...;
double wE = ...;
double wF = ...;
double wG = ...;
double multiplier = ...;
double fixedSalary = ...;
double calculatedSalary = ...;
DefaultConnector.instance.createScrapSalaryCalculation(
  operatorId: operatorId,
  operatorName: operatorName,
  year: year,
  month: month,
  a: a,
  b: b,
  e: e,
  f: f,
  g: g,
  wA: wA,
  wB: wB,
  wE: wE,
  wF: wF,
  wG: wG,
  multiplier: multiplier,
  fixedSalary: fixedSalary,
  calculatedSalary: calculatedSalary,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateScrapSalaryCalculationData, CreateScrapSalaryCalculationVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createScrapSalaryCalculation(
  operatorId: operatorId,
  operatorName: operatorName,
  year: year,
  month: month,
  a: a,
  b: b,
  e: e,
  f: f,
  g: g,
  wA: wA,
  wB: wB,
  wE: wE,
  wF: wF,
  wG: wG,
  multiplier: multiplier,
  fixedSalary: fixedSalary,
  calculatedSalary: calculatedSalary,
);
CreateScrapSalaryCalculationData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String operatorId = ...;
String operatorName = ...;
int year = ...;
int month = ...;
double a = ...;
double b = ...;
double e = ...;
double f = ...;
double g = ...;
double wA = ...;
double wB = ...;
double wE = ...;
double wF = ...;
double wG = ...;
double multiplier = ...;
double fixedSalary = ...;
double calculatedSalary = ...;

final ref = DefaultConnector.instance.createScrapSalaryCalculation(
  operatorId: operatorId,
  operatorName: operatorName,
  year: year,
  month: month,
  a: a,
  b: b,
  e: e,
  f: f,
  g: g,
  wA: wA,
  wB: wB,
  wE: wE,
  wF: wF,
  wG: wG,
  multiplier: multiplier,
  fixedSalary: fixedSalary,
  calculatedSalary: calculatedSalary,
).ref();
ref.execute();
```


### SeedAdminUser
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedAdminUser().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedAdminUserData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedAdminUser();
SeedAdminUserData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedAdminUser().ref();
ref.execute();
```


### SeedOperator1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedOperator1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedOperator1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedOperator1();
SeedOperator1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedOperator1().ref();
ref.execute();
```


### SeedOperator2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedOperator2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedOperator2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedOperator2();
SeedOperator2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedOperator2().ref();
ref.execute();
```


### SeedOperator3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedOperator3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedOperator3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedOperator3();
SeedOperator3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedOperator3().ref();
ref.execute();
```


### SeedOperator4
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedOperator4().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedOperator4Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedOperator4();
SeedOperator4Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedOperator4().ref();
ref.execute();
```


### SeedQualityPacking
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedQualityPacking().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedQualityPackingData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedQualityPacking();
SeedQualityPackingData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedQualityPacking().ref();
ref.execute();
```


### SeedMachineFrame1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMachineFrame1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMachineFrame1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMachineFrame1();
SeedMachineFrame1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMachineFrame1().ref();
ref.execute();
```


### SeedMachineFrame2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMachineFrame2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMachineFrame2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMachineFrame2();
SeedMachineFrame2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMachineFrame2().ref();
ref.execute();
```


### SeedMachineSheet3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMachineSheet3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMachineSheet3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMachineSheet3();
SeedMachineSheet3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMachineSheet3().ref();
ref.execute();
```


### SeedMachineSheet4
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMachineSheet4().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMachineSheet4Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMachineSheet4();
SeedMachineSheet4Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMachineSheet4().ref();
ref.execute();
```


### SeedMachineSheet5
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMachineSheet5().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMachineSheet5Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMachineSheet5();
SeedMachineSheet5Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMachineSheet5().ref();
ref.execute();
```


### SeedMachineCrusher1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMachineCrusher1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMachineCrusher1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMachineCrusher1();
SeedMachineCrusher1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMachineCrusher1().ref();
ref.execute();
```


### SeedMachineCrusher2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMachineCrusher2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMachineCrusher2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMachineCrusher2();
SeedMachineCrusher2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMachineCrusher2().ref();
ref.execute();
```


### SeedMachineCrusher3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMachineCrusher3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMachineCrusher3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMachineCrusher3();
SeedMachineCrusher3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMachineCrusher3().ref();
ref.execute();
```


### SeedMachinePulverizer1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMachinePulverizer1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMachinePulverizer1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMachinePulverizer1();
SeedMachinePulverizer1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMachinePulverizer1().ref();
ref.execute();
```


### SeedMachinePulverizer2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMachinePulverizer2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMachinePulverizer2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMachinePulverizer2();
SeedMachinePulverizer2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMachinePulverizer2().ref();
ref.execute();
```


### SeedMachinePulverizer3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMachinePulverizer3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMachinePulverizer3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMachinePulverizer3();
SeedMachinePulverizer3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMachinePulverizer3().ref();
ref.execute();
```


### SeedMachineShredder
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMachineShredder().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMachineShredderData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMachineShredder();
SeedMachineShredderData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMachineShredder().ref();
ref.execute();
```


### SeedShiftDay
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedShiftDay().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedShiftDayData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedShiftDay();
SeedShiftDayData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedShiftDay().ref();
ref.execute();
```


### SeedShiftNight
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedShiftNight().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedShiftNightData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedShiftNight();
SeedShiftNightData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedShiftNight().ref();
ref.execute();
```


### SeedRoleOperator
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedRoleOperator().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedRoleOperatorData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedRoleOperator();
SeedRoleOperatorData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedRoleOperator().ref();
ref.execute();
```


### SeedRoleQuality
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedRoleQuality().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedRoleQualityData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedRoleQuality();
SeedRoleQualityData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedRoleQuality().ref();
ref.execute();
```


### SeedRoleFrameSenior
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedRoleFrameSenior().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedRoleFrameSeniorData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedRoleFrameSenior();
SeedRoleFrameSeniorData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedRoleFrameSenior().ref();
ref.execute();
```


### SeedRoleSheetSenior
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedRoleSheetSenior().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedRoleSheetSeniorData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedRoleSheetSenior();
SeedRoleSheetSeniorData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedRoleSheetSenior().ref();
ref.execute();
```


### SeedRolePlantManager
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedRolePlantManager().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedRolePlantManagerData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedRolePlantManager();
SeedRolePlantManagerData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedRolePlantManager().ref();
ref.execute();
```


### SeedRoleAdmin
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedRoleAdmin().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedRoleAdminData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedRoleAdmin();
SeedRoleAdminData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedRoleAdmin().ref();
ref.execute();
```


### SeedFrameSection1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameSection1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameSection1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameSection1();
SeedFrameSection1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameSection1().ref();
ref.execute();
```


### SeedFrameSection2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameSection2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameSection2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameSection2();
SeedFrameSection2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameSection2().ref();
ref.execute();
```


### SeedFrameSection3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameSection3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameSection3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameSection3();
SeedFrameSection3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameSection3().ref();
ref.execute();
```


### SeedFrameSection4
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameSection4().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameSection4Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameSection4();
SeedFrameSection4Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameSection4().ref();
ref.execute();
```


### SeedFrameSection5
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameSection5().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameSection5Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameSection5();
SeedFrameSection5Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameSection5().ref();
ref.execute();
```


### SeedFrameSection6
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameSection6().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameSection6Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameSection6();
SeedFrameSection6Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameSection6().ref();
ref.execute();
```


### SeedFrameSection7
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameSection7().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameSection7Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameSection7();
SeedFrameSection7Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameSection7().ref();
ref.execute();
```


### SeedFrameDensity1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameDensity1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameDensity1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameDensity1();
SeedFrameDensity1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameDensity1().ref();
ref.execute();
```


### SeedFrameDensity2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameDensity2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameDensity2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameDensity2();
SeedFrameDensity2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameDensity2().ref();
ref.execute();
```


### SeedFrameDensity3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameDensity3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameDensity3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameDensity3();
SeedFrameDensity3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameDensity3().ref();
ref.execute();
```


### SeedFrameDensity4
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameDensity4().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameDensity4Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameDensity4();
SeedFrameDensity4Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameDensity4().ref();
ref.execute();
```


### SeedFrameColor1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameColor1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameColor1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameColor1();
SeedFrameColor1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameColor1().ref();
ref.execute();
```


### SeedFrameColor2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameColor2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameColor2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameColor2();
SeedFrameColor2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameColor2().ref();
ref.execute();
```


### SeedFrameColor3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameColor3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameColor3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameColor3();
SeedFrameColor3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameColor3().ref();
ref.execute();
```


### SeedSheetThick1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick1();
SeedSheetThick1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick1().ref();
ref.execute();
```


### SeedSheetThick2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick2();
SeedSheetThick2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick2().ref();
ref.execute();
```


### SeedSheetThick3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick3();
SeedSheetThick3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick3().ref();
ref.execute();
```


### SeedSheetThick4
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick4().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick4Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick4();
SeedSheetThick4Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick4().ref();
ref.execute();
```


### SeedSheetThick5
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick5().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick5Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick5();
SeedSheetThick5Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick5().ref();
ref.execute();
```


### SeedSheetThick6
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick6().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick6Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick6();
SeedSheetThick6Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick6().ref();
ref.execute();
```


### SeedSheetThick7
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick7().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick7Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick7();
SeedSheetThick7Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick7().ref();
ref.execute();
```


### SeedSheetThick8
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick8().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick8Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick8();
SeedSheetThick8Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick8().ref();
ref.execute();
```


### SeedSheetThick9
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick9().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick9Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick9();
SeedSheetThick9Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick9().ref();
ref.execute();
```


### SeedSheetThick10
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick10().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick10Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick10();
SeedSheetThick10Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick10().ref();
ref.execute();
```


### SeedSheetThick11
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick11().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick11Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick11();
SeedSheetThick11Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick11().ref();
ref.execute();
```


### SeedSheetThick12
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick12().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick12Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick12();
SeedSheetThick12Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick12().ref();
ref.execute();
```


### SeedSheetThick13
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick13().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick13Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick13();
SeedSheetThick13Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick13().ref();
ref.execute();
```


### SeedSheetThick14
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick14().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick14Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick14();
SeedSheetThick14Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick14().ref();
ref.execute();
```


### SeedSheetThick15
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick15().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick15Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick15();
SeedSheetThick15Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick15().ref();
ref.execute();
```


### SeedSheetThick16
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick16().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick16Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick16();
SeedSheetThick16Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick16().ref();
ref.execute();
```


### SeedSheetThick17
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick17().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick17Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick17();
SeedSheetThick17Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick17().ref();
ref.execute();
```


### SeedSheetThick18
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick18().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick18Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick18();
SeedSheetThick18Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick18().ref();
ref.execute();
```


### SeedSheetThick19
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick19().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick19Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick19();
SeedSheetThick19Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick19().ref();
ref.execute();
```


### SeedSheetThick20
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick20().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick20Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick20();
SeedSheetThick20Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick20().ref();
ref.execute();
```


### SeedSheetThick21
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetThick21().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetThick21Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetThick21();
SeedSheetThick21Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetThick21().ref();
ref.execute();
```


### SeedSheetDensity1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetDensity1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetDensity1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetDensity1();
SeedSheetDensity1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetDensity1().ref();
ref.execute();
```


### SeedSheetDensity2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetDensity2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetDensity2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetDensity2();
SeedSheetDensity2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetDensity2().ref();
ref.execute();
```


### SeedSheetDensity3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetDensity3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetDensity3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetDensity3();
SeedSheetDensity3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetDensity3().ref();
ref.execute();
```


### SeedSheetDensity4
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetDensity4().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetDensity4Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetDensity4();
SeedSheetDensity4Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetDensity4().ref();
ref.execute();
```


### SeedSheetDensity5
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetDensity5().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetDensity5Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetDensity5();
SeedSheetDensity5Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetDensity5().ref();
ref.execute();
```


### SeedSheetDensity6
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetDensity6().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetDensity6Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetDensity6();
SeedSheetDensity6Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetDensity6().ref();
ref.execute();
```


### SeedSheetDensity7
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetDensity7().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetDensity7Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetDensity7();
SeedSheetDensity7Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetDensity7().ref();
ref.execute();
```


### SeedSheetDensity8
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetDensity8().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetDensity8Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetDensity8();
SeedSheetDensity8Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetDensity8().ref();
ref.execute();
```


### SeedSheetColor1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetColor1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetColor1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetColor1();
SeedSheetColor1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetColor1().ref();
ref.execute();
```


### SeedSheetColor2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetColor2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetColor2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetColor2();
SeedSheetColor2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetColor2().ref();
ref.execute();
```


### SeedSheetColor3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetColor3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetColor3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetColor3();
SeedSheetColor3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetColor3().ref();
ref.execute();
```


### SeedSheetColor4
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetColor4().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetColor4Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetColor4();
SeedSheetColor4Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetColor4().ref();
ref.execute();
```


### SeedSheetColor5
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetColor5().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetColor5Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetColor5();
SeedSheetColor5Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetColor5().ref();
ref.execute();
```


### SeedMaint1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMaint1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMaint1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMaint1();
SeedMaint1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMaint1().ref();
ref.execute();
```


### SeedMaint2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMaint2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMaint2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMaint2();
SeedMaint2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMaint2().ref();
ref.execute();
```


### SeedMaint3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMaint3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMaint3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMaint3();
SeedMaint3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMaint3().ref();
ref.execute();
```


### SeedMaint4
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMaint4().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMaint4Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMaint4();
SeedMaint4Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMaint4().ref();
ref.execute();
```


### SeedMaint5
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMaint5().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMaint5Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMaint5();
SeedMaint5Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMaint5().ref();
ref.execute();
```


### SeedMaint6
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMaint6().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMaint6Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMaint6();
SeedMaint6Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMaint6().ref();
ref.execute();
```


### SeedMaint7
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMaint7().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMaint7Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMaint7();
SeedMaint7Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMaint7().ref();
ref.execute();
```


### SeedMaint8
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMaint8().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMaint8Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMaint8();
SeedMaint8Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMaint8().ref();
ref.execute();
```


### SeedMaint9
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMaint9().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMaint9Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMaint9();
SeedMaint9Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMaint9().ref();
ref.execute();
```


### SeedMaintScrap1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMaintScrap1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMaintScrap1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMaintScrap1();
SeedMaintScrap1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMaintScrap1().ref();
ref.execute();
```


### SeedMaintScrap2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMaintScrap2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMaintScrap2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMaintScrap2();
SeedMaintScrap2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMaintScrap2().ref();
ref.execute();
```


### SeedMaintScrap3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMaintScrap3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMaintScrap3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMaintScrap3();
SeedMaintScrap3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMaintScrap3().ref();
ref.execute();
```


### SeedMaintScrap4
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMaintScrap4().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMaintScrap4Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMaintScrap4();
SeedMaintScrap4Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMaintScrap4().ref();
ref.execute();
```


### SeedMaintScrap5
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMaintScrap5().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMaintScrap5Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMaintScrap5();
SeedMaintScrap5Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMaintScrap5().ref();
ref.execute();
```


### SeedMaintScrap6
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMaintScrap6().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMaintScrap6Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMaintScrap6();
SeedMaintScrap6Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMaintScrap6().ref();
ref.execute();
```


### SeedMaintScrap7
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMaintScrap7().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMaintScrap7Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMaintScrap7();
SeedMaintScrap7Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMaintScrap7().ref();
ref.execute();
```


### SeedMaintScrap8
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedMaintScrap8().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedMaintScrap8Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedMaintScrap8();
SeedMaintScrap8Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedMaintScrap8().ref();
ref.execute();
```


### SeedScrapProd1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapProd1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapProd1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapProd1();
SeedScrapProd1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapProd1().ref();
ref.execute();
```


### SeedScrapProd2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapProd2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapProd2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapProd2();
SeedScrapProd2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapProd2().ref();
ref.execute();
```


### SeedScrapProd3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapProd3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapProd3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapProd3();
SeedScrapProd3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapProd3().ref();
ref.execute();
```


### SeedScrapProd4
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapProd4().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapProd4Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapProd4();
SeedScrapProd4Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapProd4().ref();
ref.execute();
```


### SeedScrapProd5
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapProd5().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapProd5Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapProd5();
SeedScrapProd5Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapProd5().ref();
ref.execute();
```


### SeedScrapProd6
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapProd6().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapProd6Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapProd6();
SeedScrapProd6Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapProd6().ref();
ref.execute();
```


### SeedFW1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw1();
SeedFW1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw1().ref();
ref.execute();
```


### SeedFW2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw2();
SeedFW2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw2().ref();
ref.execute();
```


### SeedFW3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw3();
SeedFW3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw3().ref();
ref.execute();
```


### SeedFW4
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw4().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW4Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw4();
SeedFW4Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw4().ref();
ref.execute();
```


### SeedFW5
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw5().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW5Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw5();
SeedFW5Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw5().ref();
ref.execute();
```


### SeedFW6
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw6().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW6Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw6();
SeedFW6Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw6().ref();
ref.execute();
```


### SeedFW7
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw7().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW7Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw7();
SeedFW7Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw7().ref();
ref.execute();
```


### SeedFW8
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw8().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW8Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw8();
SeedFW8Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw8().ref();
ref.execute();
```


### SeedFW9
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw9().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW9Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw9();
SeedFW9Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw9().ref();
ref.execute();
```


### SeedFW10
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw10().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW10Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw10();
SeedFW10Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw10().ref();
ref.execute();
```


### SeedFW11
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw11().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW11Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw11();
SeedFW11Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw11().ref();
ref.execute();
```


### SeedFW12
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw12().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW12Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw12();
SeedFW12Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw12().ref();
ref.execute();
```


### SeedFW13
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw13().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW13Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw13();
SeedFW13Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw13().ref();
ref.execute();
```


### SeedFW14
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw14().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW14Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw14();
SeedFW14Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw14().ref();
ref.execute();
```


### SeedFW15
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw15().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW15Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw15();
SeedFW15Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw15().ref();
ref.execute();
```


### SeedFW16
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw16().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW16Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw16();
SeedFW16Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw16().ref();
ref.execute();
```


### SeedFW17
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw17().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW17Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw17();
SeedFW17Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw17().ref();
ref.execute();
```


### SeedFW18
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw18().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW18Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw18();
SeedFW18Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw18().ref();
ref.execute();
```


### SeedFW19
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw19().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW19Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw19();
SeedFW19Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw19().ref();
ref.execute();
```


### SeedFW20
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw20().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW20Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw20();
SeedFW20Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw20().ref();
ref.execute();
```


### SeedFW21
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFw21().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFW21Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFw21();
SeedFW21Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFw21().ref();
ref.execute();
```


### SeedSalaryWA
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSalaryWa().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSalaryWAData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSalaryWa();
SeedSalaryWAData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSalaryWa().ref();
ref.execute();
```


### SeedSalaryWB
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSalaryWb().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSalaryWBData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSalaryWb();
SeedSalaryWBData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSalaryWb().ref();
ref.execute();
```


### SeedSalaryWC
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSalaryWc().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSalaryWCData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSalaryWc();
SeedSalaryWCData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSalaryWc().ref();
ref.execute();
```


### SeedSalaryWD
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSalaryWd().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSalaryWDData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSalaryWd();
SeedSalaryWDData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSalaryWd().ref();
ref.execute();
```


### SeedSalaryWE
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSalaryWe().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSalaryWEData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSalaryWe();
SeedSalaryWEData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSalaryWe().ref();
ref.execute();
```


### SeedSalaryWF
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSalaryWf().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSalaryWFData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSalaryWf();
SeedSalaryWFData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSalaryWf().ref();
ref.execute();
```


### SeedScrapSalaryWA
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapSalaryWa().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapSalaryWAData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapSalaryWa();
SeedScrapSalaryWAData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapSalaryWa().ref();
ref.execute();
```


### SeedScrapSalaryWB
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapSalaryWb().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapSalaryWBData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapSalaryWb();
SeedScrapSalaryWBData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapSalaryWb().ref();
ref.execute();
```


### SeedScrapSalaryWE
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapSalaryWe().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapSalaryWEData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapSalaryWe();
SeedScrapSalaryWEData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapSalaryWe().ref();
ref.execute();
```


### SeedScrapSalaryWF
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapSalaryWf().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapSalaryWFData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapSalaryWf();
SeedScrapSalaryWFData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapSalaryWf().ref();
ref.execute();
```


### SeedScrapSalaryWG
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapSalaryWg().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapSalaryWGData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapSalaryWg();
SeedScrapSalaryWGData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapSalaryWg().ref();
ref.execute();
```


### SeedFrameCleaning1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameCleaning1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameCleaning1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameCleaning1();
SeedFrameCleaning1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameCleaning1().ref();
ref.execute();
```


### SeedFrameCleaning2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameCleaning2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameCleaning2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameCleaning2();
SeedFrameCleaning2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameCleaning2().ref();
ref.execute();
```


### SeedFrameCleaning3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameCleaning3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameCleaning3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameCleaning3();
SeedFrameCleaning3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameCleaning3().ref();
ref.execute();
```


### SeedFrameCleaning4
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameCleaning4().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameCleaning4Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameCleaning4();
SeedFrameCleaning4Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameCleaning4().ref();
ref.execute();
```


### SeedFrameCleaning5
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameCleaning5().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameCleaning5Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameCleaning5();
SeedFrameCleaning5Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameCleaning5().ref();
ref.execute();
```


### SeedFrameTools1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameTools1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameTools1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameTools1();
SeedFrameTools1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameTools1().ref();
ref.execute();
```


### SeedFrameTools2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameTools2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameTools2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameTools2();
SeedFrameTools2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameTools2().ref();
ref.execute();
```


### SeedFrameTools3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameTools3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameTools3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameTools3();
SeedFrameTools3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameTools3().ref();
ref.execute();
```


### SeedFrameTools4
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameTools4().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameTools4Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameTools4();
SeedFrameTools4Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameTools4().ref();
ref.execute();
```


### SeedFrameHealth1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameHealth1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameHealth1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameHealth1();
SeedFrameHealth1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameHealth1().ref();
ref.execute();
```


### SeedFrameHealth2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameHealth2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameHealth2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameHealth2();
SeedFrameHealth2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameHealth2().ref();
ref.execute();
```


### SeedFrameHealth3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameHealth3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameHealth3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameHealth3();
SeedFrameHealth3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameHealth3().ref();
ref.execute();
```


### SeedFrameWeight1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameWeight1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameWeight1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameWeight1();
SeedFrameWeight1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameWeight1().ref();
ref.execute();
```


### SeedFrameWeight2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameWeight2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameWeight2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameWeight2();
SeedFrameWeight2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameWeight2().ref();
ref.execute();
```


### SeedFrameWeight3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameWeight3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameWeight3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameWeight3();
SeedFrameWeight3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameWeight3().ref();
ref.execute();
```


### SeedFrameWeight4
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameWeight4().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameWeight4Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameWeight4();
SeedFrameWeight4Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameWeight4().ref();
ref.execute();
```


### SeedSheetCleaning1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetCleaning1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetCleaning1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetCleaning1();
SeedSheetCleaning1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetCleaning1().ref();
ref.execute();
```


### SeedSheetCleaning2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetCleaning2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetCleaning2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetCleaning2();
SeedSheetCleaning2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetCleaning2().ref();
ref.execute();
```


### SeedSheetCleaning3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetCleaning3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetCleaning3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetCleaning3();
SeedSheetCleaning3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetCleaning3().ref();
ref.execute();
```


### SeedSheetCleaning4
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetCleaning4().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetCleaning4Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetCleaning4();
SeedSheetCleaning4Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetCleaning4().ref();
ref.execute();
```


### SeedSheetCleaning5
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetCleaning5().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetCleaning5Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetCleaning5();
SeedSheetCleaning5Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetCleaning5().ref();
ref.execute();
```


### SeedSheetRunningFeet1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetRunningFeet1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetRunningFeet1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetRunningFeet1();
SeedSheetRunningFeet1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetRunningFeet1().ref();
ref.execute();
```


### SeedSheetRunningFeet2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetRunningFeet2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetRunningFeet2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetRunningFeet2();
SeedSheetRunningFeet2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetRunningFeet2().ref();
ref.execute();
```


### SeedSheetRunningFeet3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetRunningFeet3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetRunningFeet3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetRunningFeet3();
SeedSheetRunningFeet3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetRunningFeet3().ref();
ref.execute();
```


### SeedSalaryOp1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSalaryOp1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSalaryOp1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSalaryOp1();
SeedSalaryOp1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSalaryOp1().ref();
ref.execute();
```


### SeedSalaryOp2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSalaryOp2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSalaryOp2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSalaryOp2();
SeedSalaryOp2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSalaryOp2().ref();
ref.execute();
```


### SeedSalaryOp3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSalaryOp3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSalaryOp3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSalaryOp3();
SeedSalaryOp3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSalaryOp3().ref();
ref.execute();
```


### SeedSalaryOp4
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSalaryOp4().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSalaryOp4Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSalaryOp4();
SeedSalaryOp4Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSalaryOp4().ref();
ref.execute();
```


### SeedFrameWriting1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameWriting1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameWriting1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameWriting1();
SeedFrameWriting1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameWriting1().ref();
ref.execute();
```


### SeedFrameWriting2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameWriting2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameWriting2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameWriting2();
SeedFrameWriting2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameWriting2().ref();
ref.execute();
```


### SeedFrameWriting3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedFrameWriting3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedFrameWriting3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedFrameWriting3();
SeedFrameWriting3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedFrameWriting3().ref();
ref.execute();
```


### SeedSheetWriting1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetWriting1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetWriting1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetWriting1();
SeedSheetWriting1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetWriting1().ref();
ref.execute();
```


### SeedSheetWriting2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedSheetWriting2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedSheetWriting2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedSheetWriting2();
SeedSheetWriting2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedSheetWriting2().ref();
ref.execute();
```


### SeedScrapOperator1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapOperator1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapOperator1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapOperator1();
SeedScrapOperator1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapOperator1().ref();
ref.execute();
```


### SeedScrapOperator2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapOperator2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapOperator2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapOperator2();
SeedScrapOperator2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapOperator2().ref();
ref.execute();
```


### SeedScrapCleaning1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapCleaning1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapCleaning1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapCleaning1();
SeedScrapCleaning1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapCleaning1().ref();
ref.execute();
```


### SeedScrapCleaning2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapCleaning2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapCleaning2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapCleaning2();
SeedScrapCleaning2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapCleaning2().ref();
ref.execute();
```


### SeedScrapCleaning3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapCleaning3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapCleaning3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapCleaning3();
SeedScrapCleaning3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapCleaning3().ref();
ref.execute();
```


### SeedScrapCleaning4
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapCleaning4().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapCleaning4Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapCleaning4();
SeedScrapCleaning4Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapCleaning4().ref();
ref.execute();
```


### SeedScrapTools1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapTools1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapTools1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapTools1();
SeedScrapTools1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapTools1().ref();
ref.execute();
```


### SeedScrapTools2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapTools2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapTools2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapTools2();
SeedScrapTools2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapTools2().ref();
ref.execute();
```


### SeedScrapTools3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapTools3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapTools3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapTools3();
SeedScrapTools3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapTools3().ref();
ref.execute();
```


### SeedScrapProdWeight1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapProdWeight1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapProdWeight1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapProdWeight1();
SeedScrapProdWeight1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapProdWeight1().ref();
ref.execute();
```


### SeedScrapProdWeight2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapProdWeight2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapProdWeight2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapProdWeight2();
SeedScrapProdWeight2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapProdWeight2().ref();
ref.execute();
```


### SeedScrapProdWeight3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapProdWeight3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapProdWeight3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapProdWeight3();
SeedScrapProdWeight3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapProdWeight3().ref();
ref.execute();
```


### SeedScrapWriting1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapWriting1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapWriting1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapWriting1();
SeedScrapWriting1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapWriting1().ref();
ref.execute();
```


### SeedScrapWriting2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapWriting2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapWriting2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapWriting2();
SeedScrapWriting2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapWriting2().ref();
ref.execute();
```


### SeedScrapWriting3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapWriting3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapWriting3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapWriting3();
SeedScrapWriting3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapWriting3().ref();
ref.execute();
```


### SeedScrapQuality1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapQuality1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapQuality1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapQuality1();
SeedScrapQuality1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapQuality1().ref();
ref.execute();
```


### SeedScrapQuality2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapQuality2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapQuality2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapQuality2();
SeedScrapQuality2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapQuality2().ref();
ref.execute();
```


### SeedScrapQuality3
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapQuality3().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapQuality3Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapQuality3();
SeedScrapQuality3Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapQuality3().ref();
ref.execute();
```


### SeedScrapQuality4
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapQuality4().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapQuality4Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapQuality4();
SeedScrapQuality4Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapQuality4().ref();
ref.execute();
```


### SeedScrapSalary1
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapSalary1().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapSalary1Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapSalary1();
SeedScrapSalary1Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapSalary1().ref();
ref.execute();
```


### SeedScrapSalary2
#### Required Arguments
```dart
// No required arguments
DefaultConnector.instance.seedScrapSalary2().execute();
```



#### Return Type
`execute()` returns a `OperationResult<SeedScrapSalary2Data, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.seedScrapSalary2();
SeedScrapSalary2Data data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = DefaultConnector.instance.seedScrapSalary2().ref();
ref.execute();
```


### CreateSheetCleaningReport
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
int machineCondition = ...;
int groundCondition = ...;
int mouldCondition = ...;
int totalScore = ...;
double percentage = ...;
String createdBy = ...;
DefaultConnector.instance.createSheetCleaningReport(
  date: date,
  machineNumber: machineNumber,
  machineCondition: machineCondition,
  groundCondition: groundCondition,
  mouldCondition: mouldCondition,
  totalScore: totalScore,
  percentage: percentage,
  createdBy: createdBy,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateSheetCleaningReportData, CreateSheetCleaningReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createSheetCleaningReport(
  date: date,
  machineNumber: machineNumber,
  machineCondition: machineCondition,
  groundCondition: groundCondition,
  mouldCondition: mouldCondition,
  totalScore: totalScore,
  percentage: percentage,
  createdBy: createdBy,
);
CreateSheetCleaningReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
int machineCondition = ...;
int groundCondition = ...;
int mouldCondition = ...;
int totalScore = ...;
double percentage = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createSheetCleaningReport(
  date: date,
  machineNumber: machineNumber,
  machineCondition: machineCondition,
  groundCondition: groundCondition,
  mouldCondition: mouldCondition,
  totalScore: totalScore,
  percentage: percentage,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateSheetToolsCountReport
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
int totalToolsGiven = ...;
int totalToolsAvailable = ...;
double percentageAvailable = ...;
String createdBy = ...;
DefaultConnector.instance.createSheetToolsCountReport(
  date: date,
  machineNumber: machineNumber,
  totalToolsGiven: totalToolsGiven,
  totalToolsAvailable: totalToolsAvailable,
  percentageAvailable: percentageAvailable,
  createdBy: createdBy,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateSheetToolsCountReportData, CreateSheetToolsCountReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createSheetToolsCountReport(
  date: date,
  machineNumber: machineNumber,
  totalToolsGiven: totalToolsGiven,
  totalToolsAvailable: totalToolsAvailable,
  percentageAvailable: percentageAvailable,
  createdBy: createdBy,
);
CreateSheetToolsCountReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
int totalToolsGiven = ...;
int totalToolsAvailable = ...;
double percentageAvailable = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createSheetToolsCountReport(
  date: date,
  machineNumber: machineNumber,
  totalToolsGiven: totalToolsGiven,
  totalToolsAvailable: totalToolsAvailable,
  percentageAvailable: percentageAvailable,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateSheetHealthReport
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
int totalScore = ...;
double percentage = ...;
String createdBy = ...;
DefaultConnector.instance.createSheetHealthReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalScore: totalScore,
  percentage: percentage,
  createdBy: createdBy,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateSheetHealthReport, we created `CreateSheetHealthReportBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateSheetHealthReportVariablesBuilder {
  ...
   CreateSheetHealthReportVariablesBuilder submittedAt(Timestamp? t) {
   _submittedAt.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.createSheetHealthReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalScore: totalScore,
  percentage: percentage,
  createdBy: createdBy,
)
.submittedAt(submittedAt)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateSheetHealthReportData, CreateSheetHealthReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createSheetHealthReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalScore: totalScore,
  percentage: percentage,
  createdBy: createdBy,
);
CreateSheetHealthReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
int totalScore = ...;
double percentage = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createSheetHealthReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalScore: totalScore,
  percentage: percentage,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateSheetHealthRatingItem
#### Required Arguments
```dart
CreateSheetHealthRatingItemVariablesReportId reportId = ...;
String item = ...;
int rating = ...;
DefaultConnector.instance.createSheetHealthRatingItem(
  reportId: reportId,
  item: item,
  rating: rating,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateSheetHealthRatingItemData, CreateSheetHealthRatingItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createSheetHealthRatingItem(
  reportId: reportId,
  item: item,
  rating: rating,
);
CreateSheetHealthRatingItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
CreateSheetHealthRatingItemVariablesReportId reportId = ...;
String item = ...;
int rating = ...;

final ref = DefaultConnector.instance.createSheetHealthRatingItem(
  reportId: reportId,
  item: item,
  rating: rating,
).ref();
ref.execute();
```


### CreateSheetProductionDetailsReport
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
int totalQuantity = ...;
double totalWeight = ...;
double totalRunningFeet = ...;
String createdBy = ...;
DefaultConnector.instance.createSheetProductionDetailsReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalQuantity: totalQuantity,
  totalWeight: totalWeight,
  totalRunningFeet: totalRunningFeet,
  createdBy: createdBy,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateSheetProductionDetailsReport, we created `CreateSheetProductionDetailsReportBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateSheetProductionDetailsReportVariablesBuilder {
  ...
   CreateSheetProductionDetailsReportVariablesBuilder submittedAt(Timestamp? t) {
   _submittedAt.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.createSheetProductionDetailsReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalQuantity: totalQuantity,
  totalWeight: totalWeight,
  totalRunningFeet: totalRunningFeet,
  createdBy: createdBy,
)
.submittedAt(submittedAt)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateSheetProductionDetailsReportData, CreateSheetProductionDetailsReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createSheetProductionDetailsReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalQuantity: totalQuantity,
  totalWeight: totalWeight,
  totalRunningFeet: totalRunningFeet,
  createdBy: createdBy,
);
CreateSheetProductionDetailsReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
int totalQuantity = ...;
double totalWeight = ...;
double totalRunningFeet = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createSheetProductionDetailsReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalQuantity: totalQuantity,
  totalWeight: totalWeight,
  totalRunningFeet: totalRunningFeet,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateSheetProductionLineItem
#### Required Arguments
```dart
CreateSheetProductionLineItemVariablesReportId reportId = ...;
String thickness = ...;
String density = ...;
String color = ...;
double length = ...;
double width = ...;
int quantity = ...;
double sqft = ...;
double perPieceWeight = ...;
double totalWeight = ...;
double totalRunningFeet = ...;
DefaultConnector.instance.createSheetProductionLineItem(
  reportId: reportId,
  thickness: thickness,
  density: density,
  color: color,
  length: length,
  width: width,
  quantity: quantity,
  sqft: sqft,
  perPieceWeight: perPieceWeight,
  totalWeight: totalWeight,
  totalRunningFeet: totalRunningFeet,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateSheetProductionLineItem, we created `CreateSheetProductionLineItemBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateSheetProductionLineItemVariablesBuilder {
  ...
   CreateSheetProductionLineItemVariablesBuilder timeOfChange(Timestamp? t) {
   _timeOfChange.value = t;
   return this;
  }
  CreateSheetProductionLineItemVariablesBuilder manualWeightPerSqft(double? t) {
   _manualWeightPerSqft.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.createSheetProductionLineItem(
  reportId: reportId,
  thickness: thickness,
  density: density,
  color: color,
  length: length,
  width: width,
  quantity: quantity,
  sqft: sqft,
  perPieceWeight: perPieceWeight,
  totalWeight: totalWeight,
  totalRunningFeet: totalRunningFeet,
)
.timeOfChange(timeOfChange)
.manualWeightPerSqft(manualWeightPerSqft)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateSheetProductionLineItemData, CreateSheetProductionLineItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createSheetProductionLineItem(
  reportId: reportId,
  thickness: thickness,
  density: density,
  color: color,
  length: length,
  width: width,
  quantity: quantity,
  sqft: sqft,
  perPieceWeight: perPieceWeight,
  totalWeight: totalWeight,
  totalRunningFeet: totalRunningFeet,
);
CreateSheetProductionLineItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
CreateSheetProductionLineItemVariablesReportId reportId = ...;
String thickness = ...;
String density = ...;
String color = ...;
double length = ...;
double width = ...;
int quantity = ...;
double sqft = ...;
double perPieceWeight = ...;
double totalWeight = ...;
double totalRunningFeet = ...;

final ref = DefaultConnector.instance.createSheetProductionLineItem(
  reportId: reportId,
  thickness: thickness,
  density: density,
  color: color,
  length: length,
  width: width,
  quantity: quantity,
  sqft: sqft,
  perPieceWeight: perPieceWeight,
  totalWeight: totalWeight,
  totalRunningFeet: totalRunningFeet,
).ref();
ref.execute();
```


### CreateSheetRunningFeetReport
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
double productionRunningFeet = ...;
double maintenanceRunningFeet = ...;
double totalProductionRunningFeet = ...;
double targetRunningFeet = ...;
double efficiencyPercentage = ...;
String createdBy = ...;
DefaultConnector.instance.createSheetRunningFeetReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  productionRunningFeet: productionRunningFeet,
  maintenanceRunningFeet: maintenanceRunningFeet,
  totalProductionRunningFeet: totalProductionRunningFeet,
  targetRunningFeet: targetRunningFeet,
  efficiencyPercentage: efficiencyPercentage,
  createdBy: createdBy,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateSheetRunningFeetReportData, CreateSheetRunningFeetReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createSheetRunningFeetReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  productionRunningFeet: productionRunningFeet,
  maintenanceRunningFeet: maintenanceRunningFeet,
  totalProductionRunningFeet: totalProductionRunningFeet,
  targetRunningFeet: targetRunningFeet,
  efficiencyPercentage: efficiencyPercentage,
  createdBy: createdBy,
);
CreateSheetRunningFeetReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
double productionRunningFeet = ...;
double maintenanceRunningFeet = ...;
double totalProductionRunningFeet = ...;
double targetRunningFeet = ...;
double efficiencyPercentage = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createSheetRunningFeetReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  productionRunningFeet: productionRunningFeet,
  maintenanceRunningFeet: maintenanceRunningFeet,
  totalProductionRunningFeet: totalProductionRunningFeet,
  targetRunningFeet: targetRunningFeet,
  efficiencyPercentage: efficiencyPercentage,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateSheetShiftPackingReport
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
double totalRejectedRunningFeet = ...;
double qualityAcceptancePercentage = ...;
double packingEfficiency = ...;
String createdBy = ...;
DefaultConnector.instance.createSheetShiftPackingReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalRejectedRunningFeet: totalRejectedRunningFeet,
  qualityAcceptancePercentage: qualityAcceptancePercentage,
  packingEfficiency: packingEfficiency,
  createdBy: createdBy,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateSheetShiftPackingReportData, CreateSheetShiftPackingReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createSheetShiftPackingReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalRejectedRunningFeet: totalRejectedRunningFeet,
  qualityAcceptancePercentage: qualityAcceptancePercentage,
  packingEfficiency: packingEfficiency,
  createdBy: createdBy,
);
CreateSheetShiftPackingReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
double totalRejectedRunningFeet = ...;
double qualityAcceptancePercentage = ...;
double packingEfficiency = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createSheetShiftPackingReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalRejectedRunningFeet: totalRejectedRunningFeet,
  qualityAcceptancePercentage: qualityAcceptancePercentage,
  packingEfficiency: packingEfficiency,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateSheetPackingLineItem
#### Required Arguments
```dart
CreateSheetPackingLineItemVariablesReportId reportId = ...;
String thickness = ...;
String density = ...;
String color = ...;
double length = ...;
double width = ...;
int productionQuantity = ...;
double perPieceWeight = ...;
double runningFeetPerItem = ...;
int packed = ...;
int onlySanding = ...;
int sandingAndPacked = ...;
int rejectedQuality = ...;
DefaultConnector.instance.createSheetPackingLineItem(
  reportId: reportId,
  thickness: thickness,
  density: density,
  color: color,
  length: length,
  width: width,
  productionQuantity: productionQuantity,
  perPieceWeight: perPieceWeight,
  runningFeetPerItem: runningFeetPerItem,
  packed: packed,
  onlySanding: onlySanding,
  sandingAndPacked: sandingAndPacked,
  rejectedQuality: rejectedQuality,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateSheetPackingLineItemData, CreateSheetPackingLineItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createSheetPackingLineItem(
  reportId: reportId,
  thickness: thickness,
  density: density,
  color: color,
  length: length,
  width: width,
  productionQuantity: productionQuantity,
  perPieceWeight: perPieceWeight,
  runningFeetPerItem: runningFeetPerItem,
  packed: packed,
  onlySanding: onlySanding,
  sandingAndPacked: sandingAndPacked,
  rejectedQuality: rejectedQuality,
);
CreateSheetPackingLineItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
CreateSheetPackingLineItemVariablesReportId reportId = ...;
String thickness = ...;
String density = ...;
String color = ...;
double length = ...;
double width = ...;
int productionQuantity = ...;
double perPieceWeight = ...;
double runningFeetPerItem = ...;
int packed = ...;
int onlySanding = ...;
int sandingAndPacked = ...;
int rejectedQuality = ...;

final ref = DefaultConnector.instance.createSheetPackingLineItem(
  reportId: reportId,
  thickness: thickness,
  density: density,
  color: color,
  length: length,
  width: width,
  productionQuantity: productionQuantity,
  perPieceWeight: perPieceWeight,
  runningFeetPerItem: runningFeetPerItem,
  packed: packed,
  onlySanding: onlySanding,
  sandingAndPacked: sandingAndPacked,
  rejectedQuality: rejectedQuality,
).ref();
ref.execute();
```


### CreateSheetWritingEfficiency
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
Timestamp shiftEndTime = ...;
int score = ...;
String operatorId = ...;
DefaultConnector.instance.createSheetWritingEfficiency(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  shiftEndTime: shiftEndTime,
  score: score,
  operatorId: operatorId,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateSheetWritingEfficiency, we created `CreateSheetWritingEfficiencyBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateSheetWritingEfficiencyVariablesBuilder {
  ...
   CreateSheetWritingEfficiencyVariablesBuilder submittedAt(Timestamp? t) {
   _submittedAt.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.createSheetWritingEfficiency(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  shiftEndTime: shiftEndTime,
  score: score,
  operatorId: operatorId,
)
.submittedAt(submittedAt)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateSheetWritingEfficiencyData, CreateSheetWritingEfficiencyVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createSheetWritingEfficiency(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  shiftEndTime: shiftEndTime,
  score: score,
  operatorId: operatorId,
);
CreateSheetWritingEfficiencyData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
Timestamp shiftEndTime = ...;
int score = ...;
String operatorId = ...;

final ref = DefaultConnector.instance.createSheetWritingEfficiency(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  shiftEndTime: shiftEndTime,
  score: score,
  operatorId: operatorId,
).ref();
ref.execute();
```


### CreateSheetCustomerRejectionReport
#### Required Arguments
```dart
DateTime originalProductionDate = ...;
String machineNumber = ...;
String shift = ...;
double totalRejectedRunningFeet = ...;
String createdBy = ...;
DefaultConnector.instance.createSheetCustomerRejectionReport(
  originalProductionDate: originalProductionDate,
  machineNumber: machineNumber,
  shift: shift,
  totalRejectedRunningFeet: totalRejectedRunningFeet,
  createdBy: createdBy,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateSheetCustomerRejectionReportData, CreateSheetCustomerRejectionReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createSheetCustomerRejectionReport(
  originalProductionDate: originalProductionDate,
  machineNumber: machineNumber,
  shift: shift,
  totalRejectedRunningFeet: totalRejectedRunningFeet,
  createdBy: createdBy,
);
CreateSheetCustomerRejectionReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime originalProductionDate = ...;
String machineNumber = ...;
String shift = ...;
double totalRejectedRunningFeet = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createSheetCustomerRejectionReport(
  originalProductionDate: originalProductionDate,
  machineNumber: machineNumber,
  shift: shift,
  totalRejectedRunningFeet: totalRejectedRunningFeet,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateSheetCustomerRejectionItem
#### Required Arguments
```dart
CreateSheetCustomerRejectionItemVariablesReportId reportId = ...;
String thickness = ...;
String density = ...;
String color = ...;
double length = ...;
double width = ...;
int quantity = ...;
double sqft = ...;
double perPieceWeight = ...;
double totalWeight = ...;
double totalRunningFeet = ...;
DefaultConnector.instance.createSheetCustomerRejectionItem(
  reportId: reportId,
  thickness: thickness,
  density: density,
  color: color,
  length: length,
  width: width,
  quantity: quantity,
  sqft: sqft,
  perPieceWeight: perPieceWeight,
  totalWeight: totalWeight,
  totalRunningFeet: totalRunningFeet,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateSheetCustomerRejectionItemData, CreateSheetCustomerRejectionItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createSheetCustomerRejectionItem(
  reportId: reportId,
  thickness: thickness,
  density: density,
  color: color,
  length: length,
  width: width,
  quantity: quantity,
  sqft: sqft,
  perPieceWeight: perPieceWeight,
  totalWeight: totalWeight,
  totalRunningFeet: totalRunningFeet,
);
CreateSheetCustomerRejectionItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
CreateSheetCustomerRejectionItemVariablesReportId reportId = ...;
String thickness = ...;
String density = ...;
String color = ...;
double length = ...;
double width = ...;
int quantity = ...;
double sqft = ...;
double perPieceWeight = ...;
double totalWeight = ...;
double totalRunningFeet = ...;

final ref = DefaultConnector.instance.createSheetCustomerRejectionItem(
  reportId: reportId,
  thickness: thickness,
  density: density,
  color: color,
  length: length,
  width: width,
  quantity: quantity,
  sqft: sqft,
  perPieceWeight: perPieceWeight,
  totalWeight: totalWeight,
  totalRunningFeet: totalRunningFeet,
).ref();
ref.execute();
```


### CreateFrameCleaningReport
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
int machineCondition = ...;
int groundCondition = ...;
int mouldCondition = ...;
int totalScore = ...;
double percentage = ...;
String createdBy = ...;
DefaultConnector.instance.createFrameCleaningReport(
  date: date,
  machineNumber: machineNumber,
  machineCondition: machineCondition,
  groundCondition: groundCondition,
  mouldCondition: mouldCondition,
  totalScore: totalScore,
  percentage: percentage,
  createdBy: createdBy,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateFrameCleaningReportData, CreateFrameCleaningReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createFrameCleaningReport(
  date: date,
  machineNumber: machineNumber,
  machineCondition: machineCondition,
  groundCondition: groundCondition,
  mouldCondition: mouldCondition,
  totalScore: totalScore,
  percentage: percentage,
  createdBy: createdBy,
);
CreateFrameCleaningReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
int machineCondition = ...;
int groundCondition = ...;
int mouldCondition = ...;
int totalScore = ...;
double percentage = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createFrameCleaningReport(
  date: date,
  machineNumber: machineNumber,
  machineCondition: machineCondition,
  groundCondition: groundCondition,
  mouldCondition: mouldCondition,
  totalScore: totalScore,
  percentage: percentage,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateFrameToolsCountReport
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
int totalToolsGiven = ...;
int totalToolsAvailable = ...;
double percentageAvailable = ...;
String createdBy = ...;
DefaultConnector.instance.createFrameToolsCountReport(
  date: date,
  machineNumber: machineNumber,
  totalToolsGiven: totalToolsGiven,
  totalToolsAvailable: totalToolsAvailable,
  percentageAvailable: percentageAvailable,
  createdBy: createdBy,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateFrameToolsCountReportData, CreateFrameToolsCountReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createFrameToolsCountReport(
  date: date,
  machineNumber: machineNumber,
  totalToolsGiven: totalToolsGiven,
  totalToolsAvailable: totalToolsAvailable,
  percentageAvailable: percentageAvailable,
  createdBy: createdBy,
);
CreateFrameToolsCountReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
int totalToolsGiven = ...;
int totalToolsAvailable = ...;
double percentageAvailable = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createFrameToolsCountReport(
  date: date,
  machineNumber: machineNumber,
  totalToolsGiven: totalToolsGiven,
  totalToolsAvailable: totalToolsAvailable,
  percentageAvailable: percentageAvailable,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateFrameHealthReport
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
int totalScore = ...;
double percentage = ...;
String createdBy = ...;
DefaultConnector.instance.createFrameHealthReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalScore: totalScore,
  percentage: percentage,
  createdBy: createdBy,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateFrameHealthReport, we created `CreateFrameHealthReportBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateFrameHealthReportVariablesBuilder {
  ...
   CreateFrameHealthReportVariablesBuilder submittedAt(Timestamp? t) {
   _submittedAt.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.createFrameHealthReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalScore: totalScore,
  percentage: percentage,
  createdBy: createdBy,
)
.submittedAt(submittedAt)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateFrameHealthReportData, CreateFrameHealthReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createFrameHealthReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalScore: totalScore,
  percentage: percentage,
  createdBy: createdBy,
);
CreateFrameHealthReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
int totalScore = ...;
double percentage = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createFrameHealthReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalScore: totalScore,
  percentage: percentage,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateFrameHealthRatingItem
#### Required Arguments
```dart
CreateFrameHealthRatingItemVariablesReportId reportId = ...;
String item = ...;
int rating = ...;
DefaultConnector.instance.createFrameHealthRatingItem(
  reportId: reportId,
  item: item,
  rating: rating,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateFrameHealthRatingItemData, CreateFrameHealthRatingItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createFrameHealthRatingItem(
  reportId: reportId,
  item: item,
  rating: rating,
);
CreateFrameHealthRatingItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
CreateFrameHealthRatingItemVariablesReportId reportId = ...;
String item = ...;
int rating = ...;

final ref = DefaultConnector.instance.createFrameHealthRatingItem(
  reportId: reportId,
  item: item,
  rating: rating,
).ref();
ref.execute();
```


### CreateFrameProductionDetailsReport
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
int totalQuantity = ...;
double totalWeight = ...;
String createdBy = ...;
DefaultConnector.instance.createFrameProductionDetailsReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalQuantity: totalQuantity,
  totalWeight: totalWeight,
  createdBy: createdBy,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateFrameProductionDetailsReport, we created `CreateFrameProductionDetailsReportBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateFrameProductionDetailsReportVariablesBuilder {
  ...
   CreateFrameProductionDetailsReportVariablesBuilder submittedAt(Timestamp? t) {
   _submittedAt.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.createFrameProductionDetailsReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalQuantity: totalQuantity,
  totalWeight: totalWeight,
  createdBy: createdBy,
)
.submittedAt(submittedAt)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateFrameProductionDetailsReportData, CreateFrameProductionDetailsReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createFrameProductionDetailsReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalQuantity: totalQuantity,
  totalWeight: totalWeight,
  createdBy: createdBy,
);
CreateFrameProductionDetailsReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
int totalQuantity = ...;
double totalWeight = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createFrameProductionDetailsReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalQuantity: totalQuantity,
  totalWeight: totalWeight,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateFrameProductionLineItem
#### Required Arguments
```dart
CreateFrameProductionLineItemVariablesReportId reportId = ...;
String section = ...;
String density = ...;
String color = ...;
double length = ...;
int quantity = ...;
double perPieceWeight = ...;
double totalWeight = ...;
DefaultConnector.instance.createFrameProductionLineItem(
  reportId: reportId,
  section: section,
  density: density,
  color: color,
  length: length,
  quantity: quantity,
  perPieceWeight: perPieceWeight,
  totalWeight: totalWeight,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateFrameProductionLineItem, we created `CreateFrameProductionLineItemBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateFrameProductionLineItemVariablesBuilder {
  ...
   CreateFrameProductionLineItemVariablesBuilder manualWeightPerFoot(double? t) {
   _manualWeightPerFoot.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.createFrameProductionLineItem(
  reportId: reportId,
  section: section,
  density: density,
  color: color,
  length: length,
  quantity: quantity,
  perPieceWeight: perPieceWeight,
  totalWeight: totalWeight,
)
.manualWeightPerFoot(manualWeightPerFoot)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateFrameProductionLineItemData, CreateFrameProductionLineItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createFrameProductionLineItem(
  reportId: reportId,
  section: section,
  density: density,
  color: color,
  length: length,
  quantity: quantity,
  perPieceWeight: perPieceWeight,
  totalWeight: totalWeight,
);
CreateFrameProductionLineItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
CreateFrameProductionLineItemVariablesReportId reportId = ...;
String section = ...;
String density = ...;
String color = ...;
double length = ...;
int quantity = ...;
double perPieceWeight = ...;
double totalWeight = ...;

final ref = DefaultConnector.instance.createFrameProductionLineItem(
  reportId: reportId,
  section: section,
  density: density,
  color: color,
  length: length,
  quantity: quantity,
  perPieceWeight: perPieceWeight,
  totalWeight: totalWeight,
).ref();
ref.execute();
```


### CreateFrameProductionWeightReport
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
double productionWeight = ...;
double maintenanceWeight = ...;
double totalProductionWeight = ...;
double targetWeight = ...;
double efficiencyPercentage = ...;
String createdBy = ...;
DefaultConnector.instance.createFrameProductionWeightReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  productionWeight: productionWeight,
  maintenanceWeight: maintenanceWeight,
  totalProductionWeight: totalProductionWeight,
  targetWeight: targetWeight,
  efficiencyPercentage: efficiencyPercentage,
  createdBy: createdBy,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateFrameProductionWeightReportData, CreateFrameProductionWeightReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createFrameProductionWeightReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  productionWeight: productionWeight,
  maintenanceWeight: maintenanceWeight,
  totalProductionWeight: totalProductionWeight,
  targetWeight: targetWeight,
  efficiencyPercentage: efficiencyPercentage,
  createdBy: createdBy,
);
CreateFrameProductionWeightReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
double productionWeight = ...;
double maintenanceWeight = ...;
double totalProductionWeight = ...;
double targetWeight = ...;
double efficiencyPercentage = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createFrameProductionWeightReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  productionWeight: productionWeight,
  maintenanceWeight: maintenanceWeight,
  totalProductionWeight: totalProductionWeight,
  targetWeight: targetWeight,
  efficiencyPercentage: efficiencyPercentage,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateFrameShiftPackingReport
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
double totalRejectedWeight = ...;
double qualityAcceptancePercentage = ...;
double packingEfficiency = ...;
String createdBy = ...;
DefaultConnector.instance.createFrameShiftPackingReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalRejectedWeight: totalRejectedWeight,
  qualityAcceptancePercentage: qualityAcceptancePercentage,
  packingEfficiency: packingEfficiency,
  createdBy: createdBy,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateFrameShiftPackingReportData, CreateFrameShiftPackingReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createFrameShiftPackingReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalRejectedWeight: totalRejectedWeight,
  qualityAcceptancePercentage: qualityAcceptancePercentage,
  packingEfficiency: packingEfficiency,
  createdBy: createdBy,
);
CreateFrameShiftPackingReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
double totalRejectedWeight = ...;
double qualityAcceptancePercentage = ...;
double packingEfficiency = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createFrameShiftPackingReport(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  totalRejectedWeight: totalRejectedWeight,
  qualityAcceptancePercentage: qualityAcceptancePercentage,
  packingEfficiency: packingEfficiency,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateFramePackingLineItem
#### Required Arguments
```dart
CreateFramePackingLineItemVariablesReportId reportId = ...;
String section = ...;
String density = ...;
String color = ...;
double length = ...;
int productionQuantity = ...;
double perPieceWeight = ...;
int packed = ...;
int rejectedQuality = ...;
DefaultConnector.instance.createFramePackingLineItem(
  reportId: reportId,
  section: section,
  density: density,
  color: color,
  length: length,
  productionQuantity: productionQuantity,
  perPieceWeight: perPieceWeight,
  packed: packed,
  rejectedQuality: rejectedQuality,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateFramePackingLineItemData, CreateFramePackingLineItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createFramePackingLineItem(
  reportId: reportId,
  section: section,
  density: density,
  color: color,
  length: length,
  productionQuantity: productionQuantity,
  perPieceWeight: perPieceWeight,
  packed: packed,
  rejectedQuality: rejectedQuality,
);
CreateFramePackingLineItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
CreateFramePackingLineItemVariablesReportId reportId = ...;
String section = ...;
String density = ...;
String color = ...;
double length = ...;
int productionQuantity = ...;
double perPieceWeight = ...;
int packed = ...;
int rejectedQuality = ...;

final ref = DefaultConnector.instance.createFramePackingLineItem(
  reportId: reportId,
  section: section,
  density: density,
  color: color,
  length: length,
  productionQuantity: productionQuantity,
  perPieceWeight: perPieceWeight,
  packed: packed,
  rejectedQuality: rejectedQuality,
).ref();
ref.execute();
```


### CreateFrameWritingEfficiency
#### Required Arguments
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
Timestamp shiftEndTime = ...;
int score = ...;
String operatorId = ...;
DefaultConnector.instance.createFrameWritingEfficiency(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  shiftEndTime: shiftEndTime,
  score: score,
  operatorId: operatorId,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateFrameWritingEfficiency, we created `CreateFrameWritingEfficiencyBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateFrameWritingEfficiencyVariablesBuilder {
  ...
   CreateFrameWritingEfficiencyVariablesBuilder submittedAt(Timestamp? t) {
   _submittedAt.value = t;
   return this;
  }

  ...
}
DefaultConnector.instance.createFrameWritingEfficiency(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  shiftEndTime: shiftEndTime,
  score: score,
  operatorId: operatorId,
)
.submittedAt(submittedAt)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateFrameWritingEfficiencyData, CreateFrameWritingEfficiencyVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createFrameWritingEfficiency(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  shiftEndTime: shiftEndTime,
  score: score,
  operatorId: operatorId,
);
CreateFrameWritingEfficiencyData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime date = ...;
String machineNumber = ...;
String shift = ...;
Timestamp shiftEndTime = ...;
int score = ...;
String operatorId = ...;

final ref = DefaultConnector.instance.createFrameWritingEfficiency(
  date: date,
  machineNumber: machineNumber,
  shift: shift,
  shiftEndTime: shiftEndTime,
  score: score,
  operatorId: operatorId,
).ref();
ref.execute();
```


### CreateFrameCustomerRejectionReport
#### Required Arguments
```dart
DateTime originalProductionDate = ...;
DateTime rejectionDate = ...;
String machineNumber = ...;
String shift = ...;
double totalRejectedWeight = ...;
String createdBy = ...;
DefaultConnector.instance.createFrameCustomerRejectionReport(
  originalProductionDate: originalProductionDate,
  rejectionDate: rejectionDate,
  machineNumber: machineNumber,
  shift: shift,
  totalRejectedWeight: totalRejectedWeight,
  createdBy: createdBy,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateFrameCustomerRejectionReportData, CreateFrameCustomerRejectionReportVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createFrameCustomerRejectionReport(
  originalProductionDate: originalProductionDate,
  rejectionDate: rejectionDate,
  machineNumber: machineNumber,
  shift: shift,
  totalRejectedWeight: totalRejectedWeight,
  createdBy: createdBy,
);
CreateFrameCustomerRejectionReportData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
DateTime originalProductionDate = ...;
DateTime rejectionDate = ...;
String machineNumber = ...;
String shift = ...;
double totalRejectedWeight = ...;
String createdBy = ...;

final ref = DefaultConnector.instance.createFrameCustomerRejectionReport(
  originalProductionDate: originalProductionDate,
  rejectionDate: rejectionDate,
  machineNumber: machineNumber,
  shift: shift,
  totalRejectedWeight: totalRejectedWeight,
  createdBy: createdBy,
).ref();
ref.execute();
```


### CreateFrameCustomerRejectionItem
#### Required Arguments
```dart
CreateFrameCustomerRejectionItemVariablesReportId reportId = ...;
String section = ...;
String density = ...;
String color = ...;
double length = ...;
int quantity = ...;
double perPieceWeight = ...;
double totalWeight = ...;
DefaultConnector.instance.createFrameCustomerRejectionItem(
  reportId: reportId,
  section: section,
  density: density,
  color: color,
  length: length,
  quantity: quantity,
  perPieceWeight: perPieceWeight,
  totalWeight: totalWeight,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateFrameCustomerRejectionItemData, CreateFrameCustomerRejectionItemVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await DefaultConnector.instance.createFrameCustomerRejectionItem(
  reportId: reportId,
  section: section,
  density: density,
  color: color,
  length: length,
  quantity: quantity,
  perPieceWeight: perPieceWeight,
  totalWeight: totalWeight,
);
CreateFrameCustomerRejectionItemData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
CreateFrameCustomerRejectionItemVariablesReportId reportId = ...;
String section = ...;
String density = ...;
String color = ...;
double length = ...;
int quantity = ...;
double perPieceWeight = ...;
double totalWeight = ...;

final ref = DefaultConnector.instance.createFrameCustomerRejectionItem(
  reportId: reportId,
  section: section,
  density: density,
  color: color,
  length: length,
  quantity: quantity,
  perPieceWeight: perPieceWeight,
  totalWeight: totalWeight,
).ref();
ref.execute();
```

