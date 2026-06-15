part of 'default.dart';

class DeleteMasterFrameColorVariablesBuilder {
  DeleteMasterFrameColorVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteMasterFrameColorVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMasterFrameColorData> dataDeserializer = (dynamic json)  => DeleteMasterFrameColorData.fromJson(jsonDecode(json));
  Serializer<DeleteMasterFrameColorVariables> varsSerializer = (DeleteMasterFrameColorVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMasterFrameColorData, DeleteMasterFrameColorVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMasterFrameColorData, DeleteMasterFrameColorVariables> ref() {
    DeleteMasterFrameColorVariables vars= DeleteMasterFrameColorVariables(id: id,);
    return _dataConnect.mutation("DeleteMasterFrameColor", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMasterFrameColorMasterFrameColorDelete {
  final String id;
  DeleteMasterFrameColorMasterFrameColorDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameColorMasterFrameColorDelete otherTyped = other as DeleteMasterFrameColorMasterFrameColorDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterFrameColorMasterFrameColorDelete({
    required this.id,
  });
}

@immutable
class DeleteMasterFrameColorData {
  final DeleteMasterFrameColorMasterFrameColorDelete? masterFrameColor_delete;
  DeleteMasterFrameColorData.fromJson(dynamic json):
  
  masterFrameColor_delete = json['masterFrameColor_delete'] == null ? null : DeleteMasterFrameColorMasterFrameColorDelete.fromJson(json['masterFrameColor_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameColorData otherTyped = other as DeleteMasterFrameColorData;
    return masterFrameColor_delete == otherTyped.masterFrameColor_delete;
    
  }
  @override
  int get hashCode => masterFrameColor_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterFrameColor_delete != null) {
      json['masterFrameColor_delete'] = masterFrameColor_delete!.toJson();
    }
    return json;
  }

  DeleteMasterFrameColorData({
    this.masterFrameColor_delete,
  });
}

@immutable
class DeleteMasterFrameColorVariablesId {
  final String id;
  DeleteMasterFrameColorVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameColorVariablesId otherTyped = other as DeleteMasterFrameColorVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterFrameColorVariablesId({
    required this.id,
  });
}

@immutable
class DeleteMasterFrameColorVariables {
  final DeleteMasterFrameColorVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMasterFrameColorVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteMasterFrameColorVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameColorVariables otherTyped = other as DeleteMasterFrameColorVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteMasterFrameColorVariables({
    required this.id,
  });
}

