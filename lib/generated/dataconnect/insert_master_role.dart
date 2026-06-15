part of 'default.dart';

class InsertMasterRoleVariablesBuilder {
  String code;
  String displayName;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  InsertMasterRoleVariablesBuilder(this._dataConnect, {required  this.code,required  this.displayName,required  this.sortOrder,required  this.isActive,});
  Deserializer<InsertMasterRoleData> dataDeserializer = (dynamic json)  => InsertMasterRoleData.fromJson(jsonDecode(json));
  Serializer<InsertMasterRoleVariables> varsSerializer = (InsertMasterRoleVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMasterRoleData, InsertMasterRoleVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMasterRoleData, InsertMasterRoleVariables> ref() {
    InsertMasterRoleVariables vars= InsertMasterRoleVariables(code: code,displayName: displayName,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("InsertMasterRole", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMasterRoleMasterRoleInsert {
  final String id;
  InsertMasterRoleMasterRoleInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterRoleMasterRoleInsert otherTyped = other as InsertMasterRoleMasterRoleInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMasterRoleMasterRoleInsert({
    required this.id,
  });
}

@immutable
class InsertMasterRoleData {
  final InsertMasterRoleMasterRoleInsert masterRole_insert;
  InsertMasterRoleData.fromJson(dynamic json):
  
  masterRole_insert = InsertMasterRoleMasterRoleInsert.fromJson(json['masterRole_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterRoleData otherTyped = other as InsertMasterRoleData;
    return masterRole_insert == otherTyped.masterRole_insert;
    
  }
  @override
  int get hashCode => masterRole_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterRole_insert'] = masterRole_insert.toJson();
    return json;
  }

  InsertMasterRoleData({
    required this.masterRole_insert,
  });
}

@immutable
class InsertMasterRoleVariables {
  final String code;
  final String displayName;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMasterRoleVariables.fromJson(Map<String, dynamic> json):
  
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

    final InsertMasterRoleVariables otherTyped = other as InsertMasterRoleVariables;
    return code == otherTyped.code && 
    displayName == otherTyped.displayName && 
    sortOrder == otherTyped.sortOrder && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([code.hashCode, displayName.hashCode, sortOrder.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['code'] = nativeToJson<String>(code);
    json['displayName'] = nativeToJson<String>(displayName);
    json['sortOrder'] = nativeToJson<int>(sortOrder);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  InsertMasterRoleVariables({
    required this.code,
    required this.displayName,
    required this.sortOrder,
    required this.isActive,
  });
}

