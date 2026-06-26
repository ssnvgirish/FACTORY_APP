part of 'default.dart';

class CreateSheetMaintenanceEntryVariablesBuilder {
  CreateSheetMaintenanceEntryVariablesReportId reportId;
  String maintenanceItem;
  Timestamp startTime;
  Timestamp endTime;
  String personDoingMaintenance;
  String description;
  double durationHours;

  final FirebaseDataConnect _dataConnect;
  CreateSheetMaintenanceEntryVariablesBuilder(this._dataConnect, {required  this.reportId,required  this.maintenanceItem,required  this.startTime,required  this.endTime,required  this.personDoingMaintenance,required  this.description,required  this.durationHours,});
  Deserializer<CreateSheetMaintenanceEntryData> dataDeserializer = (dynamic json)  => CreateSheetMaintenanceEntryData.fromJson(jsonDecode(json));
  Serializer<CreateSheetMaintenanceEntryVariables> varsSerializer = (CreateSheetMaintenanceEntryVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateSheetMaintenanceEntryData, CreateSheetMaintenanceEntryVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateSheetMaintenanceEntryData, CreateSheetMaintenanceEntryVariables> ref() {
    CreateSheetMaintenanceEntryVariables vars= CreateSheetMaintenanceEntryVariables(reportId: reportId,maintenanceItem: maintenanceItem,startTime: startTime,endTime: endTime,personDoingMaintenance: personDoingMaintenance,description: description,durationHours: durationHours,);
    return _dataConnect.mutation("CreateSheetMaintenanceEntry", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateSheetMaintenanceEntrySheetMaintenanceEntryInsert {
  final String id;
  CreateSheetMaintenanceEntrySheetMaintenanceEntryInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetMaintenanceEntrySheetMaintenanceEntryInsert otherTyped = other as CreateSheetMaintenanceEntrySheetMaintenanceEntryInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetMaintenanceEntrySheetMaintenanceEntryInsert({
    required this.id,
  });
}

@immutable
class CreateSheetMaintenanceEntryData {
  final CreateSheetMaintenanceEntrySheetMaintenanceEntryInsert sheetMaintenanceEntry_insert;
  CreateSheetMaintenanceEntryData.fromJson(dynamic json):
  
  sheetMaintenanceEntry_insert = CreateSheetMaintenanceEntrySheetMaintenanceEntryInsert.fromJson(json['sheetMaintenanceEntry_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetMaintenanceEntryData otherTyped = other as CreateSheetMaintenanceEntryData;
    return sheetMaintenanceEntry_insert == otherTyped.sheetMaintenanceEntry_insert;
    
  }
  @override
  int get hashCode => sheetMaintenanceEntry_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetMaintenanceEntry_insert'] = sheetMaintenanceEntry_insert.toJson();
    return json;
  }

  CreateSheetMaintenanceEntryData({
    required this.sheetMaintenanceEntry_insert,
  });
}

@immutable
class CreateSheetMaintenanceEntryVariablesReportId {
  final String id;
  CreateSheetMaintenanceEntryVariablesReportId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetMaintenanceEntryVariablesReportId otherTyped = other as CreateSheetMaintenanceEntryVariablesReportId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetMaintenanceEntryVariablesReportId({
    required this.id,
  });
}

@immutable
class CreateSheetMaintenanceEntryVariables {
  final CreateSheetMaintenanceEntryVariablesReportId reportId;
  final String maintenanceItem;
  final Timestamp startTime;
  final Timestamp endTime;
  final String personDoingMaintenance;
  final String description;
  final double durationHours;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateSheetMaintenanceEntryVariables.fromJson(Map<String, dynamic> json):
  
  reportId = CreateSheetMaintenanceEntryVariablesReportId.fromJson(json['reportId']),
  maintenanceItem = nativeFromJson<String>(json['maintenanceItem']),
  startTime = Timestamp.fromJson(json['startTime']),
  endTime = Timestamp.fromJson(json['endTime']),
  personDoingMaintenance = nativeFromJson<String>(json['personDoingMaintenance']),
  description = nativeFromJson<String>(json['description']),
  durationHours = nativeFromJson<double>(json['durationHours']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetMaintenanceEntryVariables otherTyped = other as CreateSheetMaintenanceEntryVariables;
    return reportId == otherTyped.reportId && 
    maintenanceItem == otherTyped.maintenanceItem && 
    startTime == otherTyped.startTime && 
    endTime == otherTyped.endTime && 
    personDoingMaintenance == otherTyped.personDoingMaintenance && 
    description == otherTyped.description && 
    durationHours == otherTyped.durationHours;
    
  }
  @override
  int get hashCode => Object.hashAll([reportId.hashCode, maintenanceItem.hashCode, startTime.hashCode, endTime.hashCode, personDoingMaintenance.hashCode, description.hashCode, durationHours.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['reportId'] = reportId.toJson();
    json['maintenanceItem'] = nativeToJson<String>(maintenanceItem);
    json['startTime'] = startTime.toJson();
    json['endTime'] = endTime.toJson();
    json['personDoingMaintenance'] = nativeToJson<String>(personDoingMaintenance);
    json['description'] = nativeToJson<String>(description);
    json['durationHours'] = nativeToJson<double>(durationHours);
    return json;
  }

  CreateSheetMaintenanceEntryVariables({
    required this.reportId,
    required this.maintenanceItem,
    required this.startTime,
    required this.endTime,
    required this.personDoingMaintenance,
    required this.description,
    required this.durationHours,
  });
}
