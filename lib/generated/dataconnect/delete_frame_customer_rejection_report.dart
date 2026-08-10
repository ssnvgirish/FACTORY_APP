part of 'default.dart';

class DeleteFrameCustomerRejectionReportVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteFrameCustomerRejectionReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteFrameCustomerRejectionReportData> dataDeserializer = (dynamic json)  => DeleteFrameCustomerRejectionReportData.fromJson(jsonDecode(json));
  Serializer<DeleteFrameCustomerRejectionReportVariables> varsSerializer = (DeleteFrameCustomerRejectionReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteFrameCustomerRejectionReportData, DeleteFrameCustomerRejectionReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteFrameCustomerRejectionReportData, DeleteFrameCustomerRejectionReportVariables> ref() {
    DeleteFrameCustomerRejectionReportVariables vars= DeleteFrameCustomerRejectionReportVariables(id: id,);
    return _dataConnect.mutation("DeleteFrameCustomerRejectionReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteFrameCustomerRejectionReportFrameCustomerRejectionReportDelete {
  final String id;
  DeleteFrameCustomerRejectionReportFrameCustomerRejectionReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameCustomerRejectionReportFrameCustomerRejectionReportDelete otherTyped = other as DeleteFrameCustomerRejectionReportFrameCustomerRejectionReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteFrameCustomerRejectionReportFrameCustomerRejectionReportDelete({
    required this.id,
  });
}

@immutable
class DeleteFrameCustomerRejectionReportData {
  final int frameCustomerRejectionItem_deleteMany;
  final DeleteFrameCustomerRejectionReportFrameCustomerRejectionReportDelete? frameCustomerRejectionReport_delete;
  DeleteFrameCustomerRejectionReportData.fromJson(dynamic json):
  
  frameCustomerRejectionItem_deleteMany = nativeFromJson<int>(json['frameCustomerRejectionItem_deleteMany']),
  frameCustomerRejectionReport_delete = json['frameCustomerRejectionReport_delete'] == null ? null : DeleteFrameCustomerRejectionReportFrameCustomerRejectionReportDelete.fromJson(json['frameCustomerRejectionReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameCustomerRejectionReportData otherTyped = other as DeleteFrameCustomerRejectionReportData;
    return frameCustomerRejectionItem_deleteMany == otherTyped.frameCustomerRejectionItem_deleteMany && 
    frameCustomerRejectionReport_delete == otherTyped.frameCustomerRejectionReport_delete;
    
  }
  @override
  int get hashCode => Object.hashAll([frameCustomerRejectionItem_deleteMany.hashCode, frameCustomerRejectionReport_delete.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameCustomerRejectionItem_deleteMany'] = nativeToJson<int>(frameCustomerRejectionItem_deleteMany);
    if (frameCustomerRejectionReport_delete != null) {
      json['frameCustomerRejectionReport_delete'] = frameCustomerRejectionReport_delete!.toJson();
    }
    return json;
  }

  DeleteFrameCustomerRejectionReportData({
    required this.frameCustomerRejectionItem_deleteMany,
    this.frameCustomerRejectionReport_delete,
  });
}

@immutable
class DeleteFrameCustomerRejectionReportVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteFrameCustomerRejectionReportVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameCustomerRejectionReportVariables otherTyped = other as DeleteFrameCustomerRejectionReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteFrameCustomerRejectionReportVariables({
    required this.id,
  });
}

