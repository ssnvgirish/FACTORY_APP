part of 'default.dart';

class SeedMaint9VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMaint9VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMaint9Data> dataDeserializer = (dynamic json)  => SeedMaint9Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMaint9Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMaint9Data, void> ref() {
    
    return _dataConnect.mutation("SeedMaint9", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMaint9MasterMaintenanceItemInsert {
  final String id;
  SeedMaint9MasterMaintenanceItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaint9MasterMaintenanceItemInsert otherTyped = other as SeedMaint9MasterMaintenanceItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMaint9MasterMaintenanceItemInsert({
    required this.id,
  });
}

@immutable
class SeedMaint9Data {
  final SeedMaint9MasterMaintenanceItemInsert masterMaintenanceItem_insert;
  SeedMaint9Data.fromJson(dynamic json):
  
  masterMaintenanceItem_insert = SeedMaint9MasterMaintenanceItemInsert.fromJson(json['masterMaintenanceItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaint9Data otherTyped = other as SeedMaint9Data;
    return masterMaintenanceItem_insert == otherTyped.masterMaintenanceItem_insert;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItem_insert'] = masterMaintenanceItem_insert.toJson();
    return json;
  }

  SeedMaint9Data({
    required this.masterMaintenanceItem_insert,
  });
}

