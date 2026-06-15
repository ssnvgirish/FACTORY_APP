part of 'default.dart';

class SeedRoleFrameSeniorVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedRoleFrameSeniorVariablesBuilder(this._dataConnect, );
  Deserializer<SeedRoleFrameSeniorData> dataDeserializer = (dynamic json)  => SeedRoleFrameSeniorData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedRoleFrameSeniorData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedRoleFrameSeniorData, void> ref() {
    
    return _dataConnect.mutation("SeedRoleFrameSenior", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedRoleFrameSeniorMasterRoleInsert {
  final String id;
  SeedRoleFrameSeniorMasterRoleInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedRoleFrameSeniorMasterRoleInsert otherTyped = other as SeedRoleFrameSeniorMasterRoleInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedRoleFrameSeniorMasterRoleInsert({
    required this.id,
  });
}

@immutable
class SeedRoleFrameSeniorData {
  final SeedRoleFrameSeniorMasterRoleInsert masterRole_insert;
  SeedRoleFrameSeniorData.fromJson(dynamic json):
  
  masterRole_insert = SeedRoleFrameSeniorMasterRoleInsert.fromJson(json['masterRole_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedRoleFrameSeniorData otherTyped = other as SeedRoleFrameSeniorData;
    return masterRole_insert == otherTyped.masterRole_insert;
    
  }
  @override
  int get hashCode => masterRole_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterRole_insert'] = masterRole_insert.toJson();
    return json;
  }

  SeedRoleFrameSeniorData({
    required this.masterRole_insert,
  });
}

