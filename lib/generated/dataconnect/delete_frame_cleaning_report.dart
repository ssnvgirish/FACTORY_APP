part of 'default.dart';

class DeleteFrameCleaningReportVariablesBuilder {
  DeleteFrameCleaningReportVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteFrameCleaningReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteFrameCleaningReportData> dataDeserializer = (dynamic json)  => DeleteFrameCleaningReportData.fromJson(jsonDecode(json));
  Serializer<DeleteFrameCleaningReportVariables> varsSerializer = (DeleteFrameCleaningReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteFrameCleaningReportData, DeleteFrameCleaningReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteFrameCleaningReportData, DeleteFrameCleaningReportVariables> ref() {
    DeleteFrameCleaningReportVariables vars= DeleteFrameCleaningReportVariables(id: id,);
    return _dataConnect.mutation("DeleteFrameCleaningReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteFrameCleaningReportFrameCleaningReportDelete {
  final String id;
  DeleteFrameCleaningReportFrameCleaningReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameCleaningReportFrameCleaningReportDelete otherTyped = other as DeleteFrameCleaningReportFrameCleaningReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteFrameCleaningReportFrameCleaningReportDelete({
    required this.id,
  });
}

@immutable
class DeleteFrameCleaningReportData {
  final DeleteFrameCleaningReportFrameCleaningReportDelete? frameCleaningReport_delete;
  DeleteFrameCleaningReportData.fromJson(dynamic json):
  
  frameCleaningReport_delete = json['frameCleaningReport_delete'] == null ? null : DeleteFrameCleaningReportFrameCleaningReportDelete.fromJson(json['frameCleaningReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameCleaningReportData otherTyped = other as DeleteFrameCleaningReportData;
    return frameCleaningReport_delete == otherTyped.frameCleaningReport_delete;
    
  }
  @override
  int get hashCode => frameCleaningReport_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (frameCleaningReport_delete != null) {
      json['frameCleaningReport_delete'] = frameCleaningReport_delete!.toJson();
    }
    return json;
  }

  DeleteFrameCleaningReportData({
    this.frameCleaningReport_delete,
  });
}

@immutable
class DeleteFrameCleaningReportVariablesId {
  final String id;
  DeleteFrameCleaningReportVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameCleaningReportVariablesId otherTyped = other as DeleteFrameCleaningReportVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteFrameCleaningReportVariablesId({
    required this.id,
  });
}

@immutable
class DeleteFrameCleaningReportVariables {
  final DeleteFrameCleaningReportVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteFrameCleaningReportVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteFrameCleaningReportVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameCleaningReportVariables otherTyped = other as DeleteFrameCleaningReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteFrameCleaningReportVariables({
    required this.id,
  });
}

