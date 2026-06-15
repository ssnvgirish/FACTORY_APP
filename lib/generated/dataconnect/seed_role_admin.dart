part of 'default.dart';

class SeedRoleAdminVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedRoleAdminVariablesBuilder(this._dataConnect, );
  Deserializer<SeedRoleAdminData> dataDeserializer = (dynamic json)  => SeedRoleAdminData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedRoleAdminData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedRoleAdminData, void> ref() {
    
    return _dataConnect.mutation("SeedRoleAdmin", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedRoleAdminMasterRoleInsert {
  final String id;
  SeedRoleAdminMasterRoleInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedRoleAdminMasterRoleInsert otherTyped = other as SeedRoleAdminMasterRoleInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedRoleAdminMasterRoleInsert({
    required this.id,
  });
}

@immutable
class SeedRoleAdminData {
  final SeedRoleAdminMasterRoleInsert masterRole_insert;
  SeedRoleAdminData.fromJson(dynamic json):
  
  masterRole_insert = SeedRoleAdminMasterRoleInsert.fromJson(json['masterRole_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedRoleAdminData otherTyped = other as SeedRoleAdminData;
    return masterRole_insert == otherTyped.masterRole_insert;
    
  }
  @override
  int get hashCode => masterRole_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterRole_insert'] = masterRole_insert.toJson();
    return json;
  }

  SeedRoleAdminData({
    required this.masterRole_insert,
  });
}

