part of 'default.dart';

class DeleteFrameShiftPackingReportVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteFrameShiftPackingReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteFrameShiftPackingReportData> dataDeserializer = (dynamic json)  => DeleteFrameShiftPackingReportData.fromJson(jsonDecode(json));
  Serializer<DeleteFrameShiftPackingReportVariables> varsSerializer = (DeleteFrameShiftPackingReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteFrameShiftPackingReportData, DeleteFrameShiftPackingReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteFrameShiftPackingReportData, DeleteFrameShiftPackingReportVariables> ref() {
    DeleteFrameShiftPackingReportVariables vars= DeleteFrameShiftPackingReportVariables(id: id,);
    return _dataConnect.mutation("DeleteFrameShiftPackingReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteFrameShiftPackingReportFrameShiftPackingReportDelete {
  final String id;
  DeleteFrameShiftPackingReportFrameShiftPackingReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameShiftPackingReportFrameShiftPackingReportDelete otherTyped = other as DeleteFrameShiftPackingReportFrameShiftPackingReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteFrameShiftPackingReportFrameShiftPackingReportDelete({
    required this.id,
  });
}

@immutable
class DeleteFrameShiftPackingReportData {
  final int framePackingLineItem_deleteMany;
  final DeleteFrameShiftPackingReportFrameShiftPackingReportDelete? frameShiftPackingReport_delete;
  DeleteFrameShiftPackingReportData.fromJson(dynamic json):
  
  framePackingLineItem_deleteMany = nativeFromJson<int>(json['framePackingLineItem_deleteMany']),
  frameShiftPackingReport_delete = json['frameShiftPackingReport_delete'] == null ? null : DeleteFrameShiftPackingReportFrameShiftPackingReportDelete.fromJson(json['frameShiftPackingReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameShiftPackingReportData otherTyped = other as DeleteFrameShiftPackingReportData;
    return framePackingLineItem_deleteMany == otherTyped.framePackingLineItem_deleteMany && 
    frameShiftPackingReport_delete == otherTyped.frameShiftPackingReport_delete;
    
  }
  @override
  int get hashCode => Object.hashAll([framePackingLineItem_deleteMany.hashCode, frameShiftPackingReport_delete.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['framePackingLineItem_deleteMany'] = nativeToJson<int>(framePackingLineItem_deleteMany);
    if (frameShiftPackingReport_delete != null) {
      json['frameShiftPackingReport_delete'] = frameShiftPackingReport_delete!.toJson();
    }
    return json;
  }

  DeleteFrameShiftPackingReportData({
    required this.framePackingLineItem_deleteMany,
    this.frameShiftPackingReport_delete,
  });
}

@immutable
class DeleteFrameShiftPackingReportVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteFrameShiftPackingReportVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameShiftPackingReportVariables otherTyped = other as DeleteFrameShiftPackingReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteFrameShiftPackingReportVariables({
    required this.id,
  });
}

