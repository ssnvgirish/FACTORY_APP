part of 'default.dart';

class SeedRoleSheetSeniorVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedRoleSheetSeniorVariablesBuilder(this._dataConnect, );
  Deserializer<SeedRoleSheetSeniorData> dataDeserializer = (dynamic json)  => SeedRoleSheetSeniorData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedRoleSheetSeniorData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedRoleSheetSeniorData, void> ref() {
    
    return _dataConnect.mutation("SeedRoleSheetSenior", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedRoleSheetSeniorMasterRoleInsert {
  final String id;
  SeedRoleSheetSeniorMasterRoleInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedRoleSheetSeniorMasterRoleInsert otherTyped = other as SeedRoleSheetSeniorMasterRoleInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedRoleSheetSeniorMasterRoleInsert({
    required this.id,
  });
}

@immutable
class SeedRoleSheetSeniorData {
  final SeedRoleSheetSeniorMasterRoleInsert masterRole_insert;
  SeedRoleSheetSeniorData.fromJson(dynamic json):
  
  masterRole_insert = SeedRoleSheetSeniorMasterRoleInsert.fromJson(json['masterRole_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedRoleSheetSeniorData otherTyped = other as SeedRoleSheetSeniorData;
    return masterRole_insert == otherTyped.masterRole_insert;
    
  }
  @override
  int get hashCode => masterRole_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterRole_insert'] = masterRole_insert.toJson();
    return json;
  }

  SeedRoleSheetSeniorData({
    required this.masterRole_insert,
  });
}

