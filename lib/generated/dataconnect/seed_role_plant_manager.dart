part of 'default.dart';

class SeedRolePlantManagerVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedRolePlantManagerVariablesBuilder(this._dataConnect, );
  Deserializer<SeedRolePlantManagerData> dataDeserializer = (dynamic json)  => SeedRolePlantManagerData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedRolePlantManagerData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedRolePlantManagerData, void> ref() {
    
    return _dataConnect.mutation("SeedRolePlantManager", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedRolePlantManagerMasterRoleInsert {
  final String id;
  SeedRolePlantManagerMasterRoleInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedRolePlantManagerMasterRoleInsert otherTyped = other as SeedRolePlantManagerMasterRoleInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedRolePlantManagerMasterRoleInsert({
    required this.id,
  });
}

@immutable
class SeedRolePlantManagerData {
  final SeedRolePlantManagerMasterRoleInsert masterRole_insert;
  SeedRolePlantManagerData.fromJson(dynamic json):
  
  masterRole_insert = SeedRolePlantManagerMasterRoleInsert.fromJson(json['masterRole_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedRolePlantManagerData otherTyped = other as SeedRolePlantManagerData;
    return masterRole_insert == otherTyped.masterRole_insert;
    
  }
  @override
  int get hashCode => masterRole_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterRole_insert'] = masterRole_insert.toJson();
    return json;
  }

  SeedRolePlantManagerData({
    required this.masterRole_insert,
  });
}

