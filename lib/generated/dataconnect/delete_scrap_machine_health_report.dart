part of 'default.dart';

class DeleteScrapMachineHealthReportVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteScrapMachineHealthReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteScrapMachineHealthReportData> dataDeserializer = (dynamic json)  => DeleteScrapMachineHealthReportData.fromJson(jsonDecode(json));
  Serializer<DeleteScrapMachineHealthReportVariables> varsSerializer = (DeleteScrapMachineHealthReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteScrapMachineHealthReportData, DeleteScrapMachineHealthReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteScrapMachineHealthReportData, DeleteScrapMachineHealthReportVariables> ref() {
    DeleteScrapMachineHealthReportVariables vars= DeleteScrapMachineHealthReportVariables(id: id,);
    return _dataConnect.mutation("DeleteScrapMachineHealthReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteScrapMachineHealthReportScrapMachineHealthReportDelete {
  final String id;
  DeleteScrapMachineHealthReportScrapMachineHealthReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapMachineHealthReportScrapMachineHealthReportDelete otherTyped = other as DeleteScrapMachineHealthReportScrapMachineHealthReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteScrapMachineHealthReportScrapMachineHealthReportDelete({
    required this.id,
  });
}

@immutable
class DeleteScrapMachineHealthReportData {
  final int scrapMaintenanceEntry_deleteMany;
  final DeleteScrapMachineHealthReportScrapMachineHealthReportDelete? scrapMachineHealthReport_delete;
  DeleteScrapMachineHealthReportData.fromJson(dynamic json):
  
  scrapMaintenanceEntry_deleteMany = nativeFromJson<int>(json['scrapMaintenanceEntry_deleteMany']),
  scrapMachineHealthReport_delete = json['scrapMachineHealthReport_delete'] == null ? null : DeleteScrapMachineHealthReportScrapMachineHealthReportDelete.fromJson(json['scrapMachineHealthReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapMachineHealthReportData otherTyped = other as DeleteScrapMachineHealthReportData;
    return scrapMaintenanceEntry_deleteMany == otherTyped.scrapMaintenanceEntry_deleteMany && 
    scrapMachineHealthReport_delete == otherTyped.scrapMachineHealthReport_delete;
    
  }
  @override
  int get hashCode => Object.hashAll([scrapMaintenanceEntry_deleteMany.hashCode, scrapMachineHealthReport_delete.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapMaintenanceEntry_deleteMany'] = nativeToJson<int>(scrapMaintenanceEntry_deleteMany);
    if (scrapMachineHealthReport_delete != null) {
      json['scrapMachineHealthReport_delete'] = scrapMachineHealthReport_delete!.toJson();
    }
    return json;
  }

  DeleteScrapMachineHealthReportData({
    required this.scrapMaintenanceEntry_deleteMany,
    this.scrapMachineHealthReport_delete,
  });
}

@immutable
class DeleteScrapMachineHealthReportVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteScrapMachineHealthReportVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapMachineHealthReportVariables otherTyped = other as DeleteScrapMachineHealthReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteScrapMachineHealthReportVariables({
    required this.id,
  });
}

