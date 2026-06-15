part of 'default.dart';

class DeleteMasterFrameTargetVariablesBuilder {
  DeleteMasterFrameTargetVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteMasterFrameTargetVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMasterFrameTargetData> dataDeserializer = (dynamic json)  => DeleteMasterFrameTargetData.fromJson(jsonDecode(json));
  Serializer<DeleteMasterFrameTargetVariables> varsSerializer = (DeleteMasterFrameTargetVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMasterFrameTargetData, DeleteMasterFrameTargetVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMasterFrameTargetData, DeleteMasterFrameTargetVariables> ref() {
    DeleteMasterFrameTargetVariables vars= DeleteMasterFrameTargetVariables(id: id,);
    return _dataConnect.mutation("DeleteMasterFrameTarget", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMasterFrameTargetMasterFrameTargetDelete {
  final String id;
  DeleteMasterFrameTargetMasterFrameTargetDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameTargetMasterFrameTargetDelete otherTyped = other as DeleteMasterFrameTargetMasterFrameTargetDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterFrameTargetMasterFrameTargetDelete({
    required this.id,
  });
}

@immutable
class DeleteMasterFrameTargetData {
  final DeleteMasterFrameTargetMasterFrameTargetDelete? masterFrameTarget_delete;
  DeleteMasterFrameTargetData.fromJson(dynamic json):
  
  masterFrameTarget_delete = json['masterFrameTarget_delete'] == null ? null : DeleteMasterFrameTargetMasterFrameTargetDelete.fromJson(json['masterFrameTarget_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameTargetData otherTyped = other as DeleteMasterFrameTargetData;
    return masterFrameTarget_delete == otherTyped.masterFrameTarget_delete;
    
  }
  @override
  int get hashCode => masterFrameTarget_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterFrameTarget_delete != null) {
      json['masterFrameTarget_delete'] = masterFrameTarget_delete!.toJson();
    }
    return json;
  }

  DeleteMasterFrameTargetData({
    this.masterFrameTarget_delete,
  });
}

@immutable
class DeleteMasterFrameTargetVariablesId {
  final String id;
  DeleteMasterFrameTargetVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameTargetVariablesId otherTyped = other as DeleteMasterFrameTargetVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterFrameTargetVariablesId({
    required this.id,
  });
}

@immutable
class DeleteMasterFrameTargetVariables {
  final DeleteMasterFrameTargetVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMasterFrameTargetVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteMasterFrameTargetVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameTargetVariables otherTyped = other as DeleteMasterFrameTargetVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteMasterFrameTargetVariables({
    required this.id,
  });
}

