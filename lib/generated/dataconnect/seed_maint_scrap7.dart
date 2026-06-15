part of 'default.dart';

class SeedMaintScrap7VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMaintScrap7VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMaintScrap7Data> dataDeserializer = (dynamic json)  => SeedMaintScrap7Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMaintScrap7Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMaintScrap7Data, void> ref() {
    
    return _dataConnect.mutation("SeedMaintScrap7", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMaintScrap7MasterMaintenanceItemInsert {
  final String id;
  SeedMaintScrap7MasterMaintenanceItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaintScrap7MasterMaintenanceItemInsert otherTyped = other as SeedMaintScrap7MasterMaintenanceItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMaintScrap7MasterMaintenanceItemInsert({
    required this.id,
  });
}

@immutable
class SeedMaintScrap7Data {
  final SeedMaintScrap7MasterMaintenanceItemInsert masterMaintenanceItem_insert;
  SeedMaintScrap7Data.fromJson(dynamic json):
  
  masterMaintenanceItem_insert = SeedMaintScrap7MasterMaintenanceItemInsert.fromJson(json['masterMaintenanceItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaintScrap7Data otherTyped = other as SeedMaintScrap7Data;
    return masterMaintenanceItem_insert == otherTyped.masterMaintenanceItem_insert;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItem_insert'] = masterMaintenanceItem_insert.toJson();
    return json;
  }

  SeedMaintScrap7Data({
    required this.masterMaintenanceItem_insert,
  });
}

