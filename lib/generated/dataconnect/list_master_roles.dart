part of 'default.dart';

class ListMasterRolesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMasterRolesVariablesBuilder(this._dataConnect, );
  Deserializer<ListMasterRolesData> dataDeserializer = (dynamic json)  => ListMasterRolesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMasterRolesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMasterRolesData, void> ref() {
    
    return _dataConnect.query("ListMasterRoles", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMasterRolesMasterRoles {
  final String id;
  final String code;
  final String displayName;
  final int sortOrder;
  final bool isActive;
  ListMasterRolesMasterRoles.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
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

    final ListMasterRolesMasterRoles otherTyped = other as ListMasterRolesMasterRoles;
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
    json['id'] = nativeToJson<String>(id);
    json['code'] = nativeToJson<String>(code);
    json['displayName'] = nativeToJson<String>(displayName);
    json['sortOrder'] = nativeToJson<int>(sortOrder);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  ListMasterRolesMasterRoles({
    required this.id,
    required this.code,
    required this.displayName,
    required this.sortOrder,
    required this.isActive,
  });
}

@immutable
class ListMasterRolesData {
  final List<ListMasterRolesMasterRoles> masterRoles;
  ListMasterRolesData.fromJson(dynamic json):
  
  masterRoles = (json['masterRoles'] as List<dynamic>)
        .map((e) => ListMasterRolesMasterRoles.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterRolesData otherTyped = other as ListMasterRolesData;
    return masterRoles == otherTyped.masterRoles;
    
  }
  @override
  int get hashCode => masterRoles.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterRoles'] = masterRoles.map((e) => e.toJson()).toList();
    return json;
  }

  ListMasterRolesData({
    required this.masterRoles,
  });
}

