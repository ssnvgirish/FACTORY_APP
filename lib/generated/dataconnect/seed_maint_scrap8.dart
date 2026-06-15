part of 'default.dart';

class SeedMaintScrap8VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMaintScrap8VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMaintScrap8Data> dataDeserializer = (dynamic json)  => SeedMaintScrap8Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMaintScrap8Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMaintScrap8Data, void> ref() {
    
    return _dataConnect.mutation("SeedMaintScrap8", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMaintScrap8MasterMaintenanceItemInsert {
  final String id;
  SeedMaintScrap8MasterMaintenanceItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaintScrap8MasterMaintenanceItemInsert otherTyped = other as SeedMaintScrap8MasterMaintenanceItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMaintScrap8MasterMaintenanceItemInsert({
    required this.id,
  });
}

@immutable
class SeedMaintScrap8Data {
  final SeedMaintScrap8MasterMaintenanceItemInsert masterMaintenanceItem_insert;
  SeedMaintScrap8Data.fromJson(dynamic json):
  
  masterMaintenanceItem_insert = SeedMaintScrap8MasterMaintenanceItemInsert.fromJson(json['masterMaintenanceItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaintScrap8Data otherTyped = other as SeedMaintScrap8Data;
    return masterMaintenanceItem_insert == otherTyped.masterMaintenanceItem_insert;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItem_insert'] = masterMaintenanceItem_insert.toJson();
    return json;
  }

  SeedMaintScrap8Data({
    required this.masterMaintenanceItem_insert,
  });
}

