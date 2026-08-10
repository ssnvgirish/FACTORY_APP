part of 'default.dart';

class DeleteFrameProductionDetailsReportVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteFrameProductionDetailsReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteFrameProductionDetailsReportData> dataDeserializer = (dynamic json)  => DeleteFrameProductionDetailsReportData.fromJson(jsonDecode(json));
  Serializer<DeleteFrameProductionDetailsReportVariables> varsSerializer = (DeleteFrameProductionDetailsReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteFrameProductionDetailsReportData, DeleteFrameProductionDetailsReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteFrameProductionDetailsReportData, DeleteFrameProductionDetailsReportVariables> ref() {
    DeleteFrameProductionDetailsReportVariables vars= DeleteFrameProductionDetailsReportVariables(id: id,);
    return _dataConnect.mutation("DeleteFrameProductionDetailsReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteFrameProductionDetailsReportFrameProductionDetailsReportDelete {
  final String id;
  DeleteFrameProductionDetailsReportFrameProductionDetailsReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameProductionDetailsReportFrameProductionDetailsReportDelete otherTyped = other as DeleteFrameProductionDetailsReportFrameProductionDetailsReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteFrameProductionDetailsReportFrameProductionDetailsReportDelete({
    required this.id,
  });
}

@immutable
class DeleteFrameProductionDetailsReportData {
  final int frameProductionLineItem_deleteMany;
  final DeleteFrameProductionDetailsReportFrameProductionDetailsReportDelete? frameProductionDetailsReport_delete;
  DeleteFrameProductionDetailsReportData.fromJson(dynamic json):
  
  frameProductionLineItem_deleteMany = nativeFromJson<int>(json['frameProductionLineItem_deleteMany']),
  frameProductionDetailsReport_delete = json['frameProductionDetailsReport_delete'] == null ? null : DeleteFrameProductionDetailsReportFrameProductionDetailsReportDelete.fromJson(json['frameProductionDetailsReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameProductionDetailsReportData otherTyped = other as DeleteFrameProductionDetailsReportData;
    return frameProductionLineItem_deleteMany == otherTyped.frameProductionLineItem_deleteMany && 
    frameProductionDetailsReport_delete == otherTyped.frameProductionDetailsReport_delete;
    
  }
  @override
  int get hashCode => Object.hashAll([frameProductionLineItem_deleteMany.hashCode, frameProductionDetailsReport_delete.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameProductionLineItem_deleteMany'] = nativeToJson<int>(frameProductionLineItem_deleteMany);
    if (frameProductionDetailsReport_delete != null) {
      json['frameProductionDetailsReport_delete'] = frameProductionDetailsReport_delete!.toJson();
    }
    return json;
  }

  DeleteFrameProductionDetailsReportData({
    required this.frameProductionLineItem_deleteMany,
    this.frameProductionDetailsReport_delete,
  });
}

@immutable
class DeleteFrameProductionDetailsReportVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteFrameProductionDetailsReportVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameProductionDetailsReportVariables otherTyped = other as DeleteFrameProductionDetailsReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteFrameProductionDetailsReportVariables({
    required this.id,
  });
}

