part of 'default.dart';

class CreateFrameMaintenanceEntryVariablesBuilder {
  CreateFrameMaintenanceEntryVariablesReportId reportId;
  String maintenanceItem;
  Timestamp startTime;
  Timestamp endTime;
  String personDoingMaintenance;
  String description;
  double durationHours;

  final FirebaseDataConnect _dataConnect;
  CreateFrameMaintenanceEntryVariablesBuilder(this._dataConnect, {required  this.reportId,required  this.maintenanceItem,required  this.startTime,required  this.endTime,required  this.personDoingMaintenance,required  this.description,required  this.durationHours,});
  Deserializer<CreateFrameMaintenanceEntryData> dataDeserializer = (dynamic json)  => CreateFrameMaintenanceEntryData.fromJson(jsonDecode(json));
  Serializer<CreateFrameMaintenanceEntryVariables> varsSerializer = (CreateFrameMaintenanceEntryVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateFrameMaintenanceEntryData, CreateFrameMaintenanceEntryVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateFrameMaintenanceEntryData, CreateFrameMaintenanceEntryVariables> ref() {
    CreateFrameMaintenanceEntryVariables vars= CreateFrameMaintenanceEntryVariables(reportId: reportId,maintenanceItem: maintenanceItem,startTime: startTime,endTime: endTime,personDoingMaintenance: personDoingMaintenance,description: description,durationHours: durationHours,);
    return _dataConnect.mutation("CreateFrameMaintenanceEntry", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateFrameMaintenanceEntryFrameMaintenanceEntryInsert {
  final String id;
  CreateFrameMaintenanceEntryFrameMaintenanceEntryInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameMaintenanceEntryFrameMaintenanceEntryInsert otherTyped = other as CreateFrameMaintenanceEntryFrameMaintenanceEntryInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateFrameMaintenanceEntryFrameMaintenanceEntryInsert({
    required this.id,
  });
}

@immutable
class CreateFrameMaintenanceEntryData {
  final CreateFrameMaintenanceEntryFrameMaintenanceEntryInsert frameMaintenanceEntry_insert;
  CreateFrameMaintenanceEntryData.fromJson(dynamic json):
  
  frameMaintenanceEntry_insert = CreateFrameMaintenanceEntryFrameMaintenanceEntryInsert.fromJson(json['frameMaintenanceEntry_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameMaintenanceEntryData otherTyped = other as CreateFrameMaintenanceEntryData;
    return frameMaintenanceEntry_insert == otherTyped.frameMaintenanceEntry_insert;
    
  }
  @override
  int get hashCode => frameMaintenanceEntry_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameMaintenanceEntry_insert'] = frameMaintenanceEntry_insert.toJson();
    return json;
  }

  CreateFrameMaintenanceEntryData({
    required this.frameMaintenanceEntry_insert,
  });
}

@immutable
class CreateFrameMaintenanceEntryVariablesReportId {
  final String id;
  CreateFrameMaintenanceEntryVariablesReportId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameMaintenanceEntryVariablesReportId otherTyped = other as CreateFrameMaintenanceEntryVariablesReportId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateFrameMaintenanceEntryVariablesReportId({
    required this.id,
  });
}

@immutable
class CreateFrameMaintenanceEntryVariables {
  final CreateFrameMaintenanceEntryVariablesReportId reportId;
  final String maintenanceItem;
  final Timestamp startTime;
  final Timestamp endTime;
  final String personDoingMaintenance;
  final String description;
  final double durationHours;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateFrameMaintenanceEntryVariables.fromJson(Map<String, dynamic> json):
  
  reportId = CreateFrameMaintenanceEntryVariablesReportId.fromJson(json['reportId']),
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

    final CreateFrameMaintenanceEntryVariables otherTyped = other as CreateFrameMaintenanceEntryVariables;
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

  CreateFrameMaintenanceEntryVariables({
    required this.reportId,
    required this.maintenanceItem,
    required this.startTime,
    required this.endTime,
    required this.personDoingMaintenance,
    required this.description,
    required this.durationHours,
  });
}
