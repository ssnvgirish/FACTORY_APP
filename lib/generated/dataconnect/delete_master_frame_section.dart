part of 'default.dart';

class DeleteMasterFrameSectionVariablesBuilder {
  DeleteMasterFrameSectionVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteMasterFrameSectionVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMasterFrameSectionData> dataDeserializer = (dynamic json)  => DeleteMasterFrameSectionData.fromJson(jsonDecode(json));
  Serializer<DeleteMasterFrameSectionVariables> varsSerializer = (DeleteMasterFrameSectionVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMasterFrameSectionData, DeleteMasterFrameSectionVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMasterFrameSectionData, DeleteMasterFrameSectionVariables> ref() {
    DeleteMasterFrameSectionVariables vars= DeleteMasterFrameSectionVariables(id: id,);
    return _dataConnect.mutation("DeleteMasterFrameSection", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMasterFrameSectionMasterFrameSectionDelete {
  final String id;
  DeleteMasterFrameSectionMasterFrameSectionDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameSectionMasterFrameSectionDelete otherTyped = other as DeleteMasterFrameSectionMasterFrameSectionDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterFrameSectionMasterFrameSectionDelete({
    required this.id,
  });
}

@immutable
class DeleteMasterFrameSectionData {
  final DeleteMasterFrameSectionMasterFrameSectionDelete? masterFrameSection_delete;
  DeleteMasterFrameSectionData.fromJson(dynamic json):
  
  masterFrameSection_delete = json['masterFrameSection_delete'] == null ? null : DeleteMasterFrameSectionMasterFrameSectionDelete.fromJson(json['masterFrameSection_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameSectionData otherTyped = other as DeleteMasterFrameSectionData;
    return masterFrameSection_delete == otherTyped.masterFrameSection_delete;
    
  }
  @override
  int get hashCode => masterFrameSection_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterFrameSection_delete != null) {
      json['masterFrameSection_delete'] = masterFrameSection_delete!.toJson();
    }
    return json;
  }

  DeleteMasterFrameSectionData({
    this.masterFrameSection_delete,
  });
}

@immutable
class DeleteMasterFrameSectionVariablesId {
  final String id;
  DeleteMasterFrameSectionVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameSectionVariablesId otherTyped = other as DeleteMasterFrameSectionVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterFrameSectionVariablesId({
    required this.id,
  });
}

@immutable
class DeleteMasterFrameSectionVariables {
  final DeleteMasterFrameSectionVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMasterFrameSectionVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteMasterFrameSectionVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameSectionVariables otherTyped = other as DeleteMasterFrameSectionVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteMasterFrameSectionVariables({
    required this.id,
  });
}

