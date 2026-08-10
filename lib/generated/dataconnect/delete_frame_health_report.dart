part of 'default.dart';

class DeleteFrameHealthReportVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteFrameHealthReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteFrameHealthReportData> dataDeserializer = (dynamic json)  => DeleteFrameHealthReportData.fromJson(jsonDecode(json));
  Serializer<DeleteFrameHealthReportVariables> varsSerializer = (DeleteFrameHealthReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteFrameHealthReportData, DeleteFrameHealthReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteFrameHealthReportData, DeleteFrameHealthReportVariables> ref() {
    DeleteFrameHealthReportVariables vars= DeleteFrameHealthReportVariables(id: id,);
    return _dataConnect.mutation("DeleteFrameHealthReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteFrameHealthReportFrameHealthReportDelete {
  final String id;
  DeleteFrameHealthReportFrameHealthReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameHealthReportFrameHealthReportDelete otherTyped = other as DeleteFrameHealthReportFrameHealthReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteFrameHealthReportFrameHealthReportDelete({
    required this.id,
  });
}

@immutable
class DeleteFrameHealthReportData {
  final int frameMaintenanceEntry_deleteMany;
  final DeleteFrameHealthReportFrameHealthReportDelete? frameHealthReport_delete;
  DeleteFrameHealthReportData.fromJson(dynamic json):
  
  frameMaintenanceEntry_deleteMany = nativeFromJson<int>(json['frameMaintenanceEntry_deleteMany']),
  frameHealthReport_delete = json['frameHealthReport_delete'] == null ? null : DeleteFrameHealthReportFrameHealthReportDelete.fromJson(json['frameHealthReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameHealthReportData otherTyped = other as DeleteFrameHealthReportData;
    return frameMaintenanceEntry_deleteMany == otherTyped.frameMaintenanceEntry_deleteMany && 
    frameHealthReport_delete == otherTyped.frameHealthReport_delete;
    
  }
  @override
  int get hashCode => Object.hashAll([frameMaintenanceEntry_deleteMany.hashCode, frameHealthReport_delete.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameMaintenanceEntry_deleteMany'] = nativeToJson<int>(frameMaintenanceEntry_deleteMany);
    if (frameHealthReport_delete != null) {
      json['frameHealthReport_delete'] = frameHealthReport_delete!.toJson();
    }
    return json;
  }

  DeleteFrameHealthReportData({
    required this.frameMaintenanceEntry_deleteMany,
    this.frameHealthReport_delete,
  });
}

@immutable
class DeleteFrameHealthReportVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteFrameHealthReportVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameHealthReportVariables otherTyped = other as DeleteFrameHealthReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteFrameHealthReportVariables({
    required this.id,
  });
}

