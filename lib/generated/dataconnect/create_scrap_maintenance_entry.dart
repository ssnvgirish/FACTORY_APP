part of 'default.dart';

class CreateScrapMaintenanceEntryVariablesBuilder {
  CreateScrapMaintenanceEntryVariablesReportId reportId;
  String maintenanceItem;
  Timestamp startTime;
  Timestamp endTime;
  String personDoingMaintenance;
  String description;
  double durationHours;

  final FirebaseDataConnect _dataConnect;
  CreateScrapMaintenanceEntryVariablesBuilder(this._dataConnect, {required  this.reportId,required  this.maintenanceItem,required  this.startTime,required  this.endTime,required  this.personDoingMaintenance,required  this.description,required  this.durationHours,});
  Deserializer<CreateScrapMaintenanceEntryData> dataDeserializer = (dynamic json)  => CreateScrapMaintenanceEntryData.fromJson(jsonDecode(json));
  Serializer<CreateScrapMaintenanceEntryVariables> varsSerializer = (CreateScrapMaintenanceEntryVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateScrapMaintenanceEntryData, CreateScrapMaintenanceEntryVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateScrapMaintenanceEntryData, CreateScrapMaintenanceEntryVariables> ref() {
    CreateScrapMaintenanceEntryVariables vars= CreateScrapMaintenanceEntryVariables(reportId: reportId,maintenanceItem: maintenanceItem,startTime: startTime,endTime: endTime,personDoingMaintenance: personDoingMaintenance,description: description,durationHours: durationHours,);
    return _dataConnect.mutation("CreateScrapMaintenanceEntry", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateScrapMaintenanceEntryScrapMaintenanceEntryInsert {
  final String id;
  CreateScrapMaintenanceEntryScrapMaintenanceEntryInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapMaintenanceEntryScrapMaintenanceEntryInsert otherTyped = other as CreateScrapMaintenanceEntryScrapMaintenanceEntryInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateScrapMaintenanceEntryScrapMaintenanceEntryInsert({
    required this.id,
  });
}

@immutable
class CreateScrapMaintenanceEntryData {
  final CreateScrapMaintenanceEntryScrapMaintenanceEntryInsert scrapMaintenanceEntry_insert;
  CreateScrapMaintenanceEntryData.fromJson(dynamic json):
  
  scrapMaintenanceEntry_insert = CreateScrapMaintenanceEntryScrapMaintenanceEntryInsert.fromJson(json['scrapMaintenanceEntry_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapMaintenanceEntryData otherTyped = other as CreateScrapMaintenanceEntryData;
    return scrapMaintenanceEntry_insert == otherTyped.scrapMaintenanceEntry_insert;
    
  }
  @override
  int get hashCode => scrapMaintenanceEntry_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapMaintenanceEntry_insert'] = scrapMaintenanceEntry_insert.toJson();
    return json;
  }

  CreateScrapMaintenanceEntryData({
    required this.scrapMaintenanceEntry_insert,
  });
}

@immutable
class CreateScrapMaintenanceEntryVariablesReportId {
  final String id;
  CreateScrapMaintenanceEntryVariablesReportId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapMaintenanceEntryVariablesReportId otherTyped = other as CreateScrapMaintenanceEntryVariablesReportId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateScrapMaintenanceEntryVariablesReportId({
    required this.id,
  });
}

@immutable
class CreateScrapMaintenanceEntryVariables {
  final CreateScrapMaintenanceEntryVariablesReportId reportId;
  final String maintenanceItem;
  final Timestamp startTime;
  final Timestamp endTime;
  final String personDoingMaintenance;
  final String description;
  final double durationHours;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateScrapMaintenanceEntryVariables.fromJson(Map<String, dynamic> json):
  
  reportId = CreateScrapMaintenanceEntryVariablesReportId.fromJson(json['reportId']),
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

    final CreateScrapMaintenanceEntryVariables otherTyped = other as CreateScrapMaintenanceEntryVariables;
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

  CreateScrapMaintenanceEntryVariables({
    required this.reportId,
    required this.maintenanceItem,
    required this.startTime,
    required this.endTime,
    required this.personDoingMaintenance,
    required this.description,
    required this.durationHours,
  });
}

