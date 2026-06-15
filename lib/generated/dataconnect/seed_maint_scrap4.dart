part of 'default.dart';

class SeedMaintScrap4VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMaintScrap4VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMaintScrap4Data> dataDeserializer = (dynamic json)  => SeedMaintScrap4Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMaintScrap4Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMaintScrap4Data, void> ref() {
    
    return _dataConnect.mutation("SeedMaintScrap4", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMaintScrap4MasterMaintenanceItemInsert {
  final String id;
  SeedMaintScrap4MasterMaintenanceItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaintScrap4MasterMaintenanceItemInsert otherTyped = other as SeedMaintScrap4MasterMaintenanceItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMaintScrap4MasterMaintenanceItemInsert({
    required this.id,
  });
}

@immutable
class SeedMaintScrap4Data {
  final SeedMaintScrap4MasterMaintenanceItemInsert masterMaintenanceItem_insert;
  SeedMaintScrap4Data.fromJson(dynamic json):
  
  masterMaintenanceItem_insert = SeedMaintScrap4MasterMaintenanceItemInsert.fromJson(json['masterMaintenanceItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaintScrap4Data otherTyped = other as SeedMaintScrap4Data;
    return masterMaintenanceItem_insert == otherTyped.masterMaintenanceItem_insert;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItem_insert'] = masterMaintenanceItem_insert.toJson();
    return json;
  }

  SeedMaintScrap4Data({
    required this.masterMaintenanceItem_insert,
  });
}

