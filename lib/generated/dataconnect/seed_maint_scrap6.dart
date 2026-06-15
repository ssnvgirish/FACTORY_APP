part of 'default.dart';

class SeedMaintScrap6VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMaintScrap6VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMaintScrap6Data> dataDeserializer = (dynamic json)  => SeedMaintScrap6Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMaintScrap6Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMaintScrap6Data, void> ref() {
    
    return _dataConnect.mutation("SeedMaintScrap6", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMaintScrap6MasterMaintenanceItemInsert {
  final String id;
  SeedMaintScrap6MasterMaintenanceItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaintScrap6MasterMaintenanceItemInsert otherTyped = other as SeedMaintScrap6MasterMaintenanceItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMaintScrap6MasterMaintenanceItemInsert({
    required this.id,
  });
}

@immutable
class SeedMaintScrap6Data {
  final SeedMaintScrap6MasterMaintenanceItemInsert masterMaintenanceItem_insert;
  SeedMaintScrap6Data.fromJson(dynamic json):
  
  masterMaintenanceItem_insert = SeedMaintScrap6MasterMaintenanceItemInsert.fromJson(json['masterMaintenanceItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaintScrap6Data otherTyped = other as SeedMaintScrap6Data;
    return masterMaintenanceItem_insert == otherTyped.masterMaintenanceItem_insert;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItem_insert'] = masterMaintenanceItem_insert.toJson();
    return json;
  }

  SeedMaintScrap6Data({
    required this.masterMaintenanceItem_insert,
  });
}

