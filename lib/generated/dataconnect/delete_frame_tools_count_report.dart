part of 'default.dart';

class DeleteFrameToolsCountReportVariablesBuilder {
  DeleteFrameToolsCountReportVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteFrameToolsCountReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteFrameToolsCountReportData> dataDeserializer = (dynamic json)  => DeleteFrameToolsCountReportData.fromJson(jsonDecode(json));
  Serializer<DeleteFrameToolsCountReportVariables> varsSerializer = (DeleteFrameToolsCountReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteFrameToolsCountReportData, DeleteFrameToolsCountReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteFrameToolsCountReportData, DeleteFrameToolsCountReportVariables> ref() {
    DeleteFrameToolsCountReportVariables vars= DeleteFrameToolsCountReportVariables(id: id,);
    return _dataConnect.mutation("DeleteFrameToolsCountReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteFrameToolsCountReportFrameToolsCountReportDelete {
  final String id;
  DeleteFrameToolsCountReportFrameToolsCountReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameToolsCountReportFrameToolsCountReportDelete otherTyped = other as DeleteFrameToolsCountReportFrameToolsCountReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteFrameToolsCountReportFrameToolsCountReportDelete({
    required this.id,
  });
}

@immutable
class DeleteFrameToolsCountReportData {
  final DeleteFrameToolsCountReportFrameToolsCountReportDelete? frameToolsCountReport_delete;
  DeleteFrameToolsCountReportData.fromJson(dynamic json):
  
  frameToolsCountReport_delete = json['frameToolsCountReport_delete'] == null ? null : DeleteFrameToolsCountReportFrameToolsCountReportDelete.fromJson(json['frameToolsCountReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameToolsCountReportData otherTyped = other as DeleteFrameToolsCountReportData;
    return frameToolsCountReport_delete == otherTyped.frameToolsCountReport_delete;
    
  }
  @override
  int get hashCode => frameToolsCountReport_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (frameToolsCountReport_delete != null) {
      json['frameToolsCountReport_delete'] = frameToolsCountReport_delete!.toJson();
    }
    return json;
  }

  DeleteFrameToolsCountReportData({
    this.frameToolsCountReport_delete,
  });
}

@immutable
class DeleteFrameToolsCountReportVariablesId {
  final String id;
  DeleteFrameToolsCountReportVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameToolsCountReportVariablesId otherTyped = other as DeleteFrameToolsCountReportVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteFrameToolsCountReportVariablesId({
    required this.id,
  });
}

@immutable
class DeleteFrameToolsCountReportVariables {
  final DeleteFrameToolsCountReportVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteFrameToolsCountReportVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteFrameToolsCountReportVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameToolsCountReportVariables otherTyped = other as DeleteFrameToolsCountReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteFrameToolsCountReportVariables({
    required this.id,
  });
}

