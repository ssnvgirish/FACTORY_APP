part of 'default.dart';

class UpdateMasterRoleVariablesBuilder {
  UpdateMasterRoleVariablesId id;
  String code;
  String displayName;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  UpdateMasterRoleVariablesBuilder(this._dataConnect, {required  this.id,required  this.code,required  this.displayName,required  this.sortOrder,required  this.isActive,});
  Deserializer<UpdateMasterRoleData> dataDeserializer = (dynamic json)  => UpdateMasterRoleData.fromJson(jsonDecode(json));
  Serializer<UpdateMasterRoleVariables> varsSerializer = (UpdateMasterRoleVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMasterRoleData, UpdateMasterRoleVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateMasterRoleData, UpdateMasterRoleVariables> ref() {
    UpdateMasterRoleVariables vars= UpdateMasterRoleVariables(id: id,code: code,displayName: displayName,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("UpdateMasterRole", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateMasterRoleMasterRoleUpdate {
  final String id;
  UpdateMasterRoleMasterRoleUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterRoleMasterRoleUpdate otherTyped = other as UpdateMasterRoleMasterRoleUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterRoleMasterRoleUpdate({
    required this.id,
  });
}

@immutable
class UpdateMasterRoleData {
  final UpdateMasterRoleMasterRoleUpdate? masterRole_update;
  UpdateMasterRoleData.fromJson(dynamic json):
  
  masterRole_update = json['masterRole_update'] == null ? null : UpdateMasterRoleMasterRoleUpdate.fromJson(json['masterRole_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterRoleData otherTyped = other as UpdateMasterRoleData;
    return masterRole_update == otherTyped.masterRole_update;
    
  }
  @override
  int get hashCode => masterRole_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterRole_update != null) {
      json['masterRole_update'] = masterRole_update!.toJson();
    }
    return json;
  }

  UpdateMasterRoleData({
    this.masterRole_update,
  });
}

@immutable
class UpdateMasterRoleVariablesId {
  final String id;
  UpdateMasterRoleVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterRoleVariablesId otherTyped = other as UpdateMasterRoleVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterRoleVariablesId({
    required this.id,
  });
}

@immutable
class UpdateMasterRoleVariables {
  final UpdateMasterRoleVariablesId id;
  final String code;
  final String displayName;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateMasterRoleVariables.fromJson(Map<String, dynamic> json):
  
  id = UpdateMasterRoleVariablesId.fromJson(json['id']),
  code = nativeFromJson<String>(json['code']),
  displayName = nativeFromJson<String>(json['displayName']),
  sortOrder = nativeFromJson<int>(json['sortOrder']),
  isActive = nativeFromJson<bool>(json['isActive']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterRoleVariables otherTyped = other as UpdateMasterRoleVariables;
    return id == otherTyped.id && 
    code == otherTyped.code && 
    displayName == otherTyped.displayName && 
    sortOrder == otherTyped.sortOrder && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, code.hashCode, displayName.hashCode, sortOrder.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    json['code'] = nativeToJson<String>(code);
    json['displayName'] = nativeToJson<String>(displayName);
    json['sortOrder'] = nativeToJson<int>(sortOrder);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  UpdateMasterRoleVariables({
    required this.id,
    required this.code,
    required this.displayName,
    required this.sortOrder,
    required this.isActive,
  });
}

