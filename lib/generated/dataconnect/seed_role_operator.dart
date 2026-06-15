part of 'default.dart';

class SeedRoleOperatorVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedRoleOperatorVariablesBuilder(this._dataConnect, );
  Deserializer<SeedRoleOperatorData> dataDeserializer = (dynamic json)  => SeedRoleOperatorData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedRoleOperatorData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedRoleOperatorData, void> ref() {
    
    return _dataConnect.mutation("SeedRoleOperator", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedRoleOperatorMasterRoleInsert {
  final String id;
  SeedRoleOperatorMasterRoleInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedRoleOperatorMasterRoleInsert otherTyped = other as SeedRoleOperatorMasterRoleInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedRoleOperatorMasterRoleInsert({
    required this.id,
  });
}

@immutable
class SeedRoleOperatorData {
  final SeedRoleOperatorMasterRoleInsert masterRole_insert;
  SeedRoleOperatorData.fromJson(dynamic json):
  
  masterRole_insert = SeedRoleOperatorMasterRoleInsert.fromJson(json['masterRole_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedRoleOperatorData otherTyped = other as SeedRoleOperatorData;
    return masterRole_insert == otherTyped.masterRole_insert;
    
  }
  @override
  int get hashCode => masterRole_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterRole_insert'] = masterRole_insert.toJson();
    return json;
  }

  SeedRoleOperatorData({
    required this.masterRole_insert,
  });
}

