part of 'default.dart';

class SeedMaintScrap2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMaintScrap2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMaintScrap2Data> dataDeserializer = (dynamic json)  => SeedMaintScrap2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMaintScrap2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMaintScrap2Data, void> ref() {
    
    return _dataConnect.mutation("SeedMaintScrap2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMaintScrap2MasterMaintenanceItemInsert {
  final String id;
  SeedMaintScrap2MasterMaintenanceItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaintScrap2MasterMaintenanceItemInsert otherTyped = other as SeedMaintScrap2MasterMaintenanceItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMaintScrap2MasterMaintenanceItemInsert({
    required this.id,
  });
}

@immutable
class SeedMaintScrap2Data {
  final SeedMaintScrap2MasterMaintenanceItemInsert masterMaintenanceItem_insert;
  SeedMaintScrap2Data.fromJson(dynamic json):
  
  masterMaintenanceItem_insert = SeedMaintScrap2MasterMaintenanceItemInsert.fromJson(json['masterMaintenanceItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaintScrap2Data otherTyped = other as SeedMaintScrap2Data;
    return masterMaintenanceItem_insert == otherTyped.masterMaintenanceItem_insert;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItem_insert'] = masterMaintenanceItem_insert.toJson();
    return json;
  }

  SeedMaintScrap2Data({
    required this.masterMaintenanceItem_insert,
  });
}

