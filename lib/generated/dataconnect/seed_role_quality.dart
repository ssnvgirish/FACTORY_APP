part of 'default.dart';

class SeedRoleQualityVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedRoleQualityVariablesBuilder(this._dataConnect, );
  Deserializer<SeedRoleQualityData> dataDeserializer = (dynamic json)  => SeedRoleQualityData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedRoleQualityData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedRoleQualityData, void> ref() {
    
    return _dataConnect.mutation("SeedRoleQuality", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedRoleQualityMasterRoleInsert {
  final String id;
  SeedRoleQualityMasterRoleInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedRoleQualityMasterRoleInsert otherTyped = other as SeedRoleQualityMasterRoleInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedRoleQualityMasterRoleInsert({
    required this.id,
  });
}

@immutable
class SeedRoleQualityData {
  final SeedRoleQualityMasterRoleInsert masterRole_insert;
  SeedRoleQualityData.fromJson(dynamic json):
  
  masterRole_insert = SeedRoleQualityMasterRoleInsert.fromJson(json['masterRole_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedRoleQualityData otherTyped = other as SeedRoleQualityData;
    return masterRole_insert == otherTyped.masterRole_insert;
    
  }
  @override
  int get hashCode => masterRole_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterRole_insert'] = masterRole_insert.toJson();
    return json;
  }

  SeedRoleQualityData({
    required this.masterRole_insert,
  });
}

