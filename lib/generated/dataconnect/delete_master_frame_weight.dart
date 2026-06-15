part of 'default.dart';

class DeleteMasterFrameWeightVariablesBuilder {
  DeleteMasterFrameWeightVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteMasterFrameWeightVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMasterFrameWeightData> dataDeserializer = (dynamic json)  => DeleteMasterFrameWeightData.fromJson(jsonDecode(json));
  Serializer<DeleteMasterFrameWeightVariables> varsSerializer = (DeleteMasterFrameWeightVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMasterFrameWeightData, DeleteMasterFrameWeightVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMasterFrameWeightData, DeleteMasterFrameWeightVariables> ref() {
    DeleteMasterFrameWeightVariables vars= DeleteMasterFrameWeightVariables(id: id,);
    return _dataConnect.mutation("DeleteMasterFrameWeight", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMasterFrameWeightMasterFrameWeightDelete {
  final String id;
  DeleteMasterFrameWeightMasterFrameWeightDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameWeightMasterFrameWeightDelete otherTyped = other as DeleteMasterFrameWeightMasterFrameWeightDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterFrameWeightMasterFrameWeightDelete({
    required this.id,
  });
}

@immutable
class DeleteMasterFrameWeightData {
  final DeleteMasterFrameWeightMasterFrameWeightDelete? masterFrameWeight_delete;
  DeleteMasterFrameWeightData.fromJson(dynamic json):
  
  masterFrameWeight_delete = json['masterFrameWeight_delete'] == null ? null : DeleteMasterFrameWeightMasterFrameWeightDelete.fromJson(json['masterFrameWeight_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameWeightData otherTyped = other as DeleteMasterFrameWeightData;
    return masterFrameWeight_delete == otherTyped.masterFrameWeight_delete;
    
  }
  @override
  int get hashCode => masterFrameWeight_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterFrameWeight_delete != null) {
      json['masterFrameWeight_delete'] = masterFrameWeight_delete!.toJson();
    }
    return json;
  }

  DeleteMasterFrameWeightData({
    this.masterFrameWeight_delete,
  });
}

@immutable
class DeleteMasterFrameWeightVariablesId {
  final String id;
  DeleteMasterFrameWeightVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameWeightVariablesId otherTyped = other as DeleteMasterFrameWeightVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterFrameWeightVariablesId({
    required this.id,
  });
}

@immutable
class DeleteMasterFrameWeightVariables {
  final DeleteMasterFrameWeightVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMasterFrameWeightVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteMasterFrameWeightVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameWeightVariables otherTyped = other as DeleteMasterFrameWeightVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteMasterFrameWeightVariables({
    required this.id,
  });
}

