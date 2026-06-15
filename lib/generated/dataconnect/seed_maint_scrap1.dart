part of 'default.dart';

class SeedMaintScrap1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMaintScrap1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMaintScrap1Data> dataDeserializer = (dynamic json)  => SeedMaintScrap1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMaintScrap1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMaintScrap1Data, void> ref() {
    
    return _dataConnect.mutation("SeedMaintScrap1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMaintScrap1MasterMaintenanceItemInsert {
  final String id;
  SeedMaintScrap1MasterMaintenanceItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaintScrap1MasterMaintenanceItemInsert otherTyped = other as SeedMaintScrap1MasterMaintenanceItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMaintScrap1MasterMaintenanceItemInsert({
    required this.id,
  });
}

@immutable
class SeedMaintScrap1Data {
  final SeedMaintScrap1MasterMaintenanceItemInsert masterMaintenanceItem_insert;
  SeedMaintScrap1Data.fromJson(dynamic json):
  
  masterMaintenanceItem_insert = SeedMaintScrap1MasterMaintenanceItemInsert.fromJson(json['masterMaintenanceItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaintScrap1Data otherTyped = other as SeedMaintScrap1Data;
    return masterMaintenanceItem_insert == otherTyped.masterMaintenanceItem_insert;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItem_insert'] = masterMaintenanceItem_insert.toJson();
    return json;
  }

  SeedMaintScrap1Data({
    required this.masterMaintenanceItem_insert,
  });
}

