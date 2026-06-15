part of 'default.dart';

class DeleteMasterRoleVariablesBuilder {
  DeleteMasterRoleVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteMasterRoleVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMasterRoleData> dataDeserializer = (dynamic json)  => DeleteMasterRoleData.fromJson(jsonDecode(json));
  Serializer<DeleteMasterRoleVariables> varsSerializer = (DeleteMasterRoleVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMasterRoleData, DeleteMasterRoleVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMasterRoleData, DeleteMasterRoleVariables> ref() {
    DeleteMasterRoleVariables vars= DeleteMasterRoleVariables(id: id,);
    return _dataConnect.mutation("DeleteMasterRole", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMasterRoleMasterRoleDelete {
  final String id;
  DeleteMasterRoleMasterRoleDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterRoleMasterRoleDelete otherTyped = other as DeleteMasterRoleMasterRoleDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterRoleMasterRoleDelete({
    required this.id,
  });
}

@immutable
class DeleteMasterRoleData {
  final DeleteMasterRoleMasterRoleDelete? masterRole_delete;
  DeleteMasterRoleData.fromJson(dynamic json):
  
  masterRole_delete = json['masterRole_delete'] == null ? null : DeleteMasterRoleMasterRoleDelete.fromJson(json['masterRole_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterRoleData otherTyped = other as DeleteMasterRoleData;
    return masterRole_delete == otherTyped.masterRole_delete;
    
  }
  @override
  int get hashCode => masterRole_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterRole_delete != null) {
      json['masterRole_delete'] = masterRole_delete!.toJson();
    }
    return json;
  }

  DeleteMasterRoleData({
    this.masterRole_delete,
  });
}

@immutable
class DeleteMasterRoleVariablesId {
  final String id;
  DeleteMasterRoleVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterRoleVariablesId otherTyped = other as DeleteMasterRoleVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterRoleVariablesId({
    required this.id,
  });
}

@immutable
class DeleteMasterRoleVariables {
  final DeleteMasterRoleVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMasterRoleVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteMasterRoleVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterRoleVariables otherTyped = other as DeleteMasterRoleVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteMasterRoleVariables({
    required this.id,
  });
}

