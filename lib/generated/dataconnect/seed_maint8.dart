part of 'default.dart';

class SeedMaint8VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMaint8VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMaint8Data> dataDeserializer = (dynamic json)  => SeedMaint8Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMaint8Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMaint8Data, void> ref() {
    
    return _dataConnect.mutation("SeedMaint8", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMaint8MasterMaintenanceItemInsert {
  final String id;
  SeedMaint8MasterMaintenanceItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaint8MasterMaintenanceItemInsert otherTyped = other as SeedMaint8MasterMaintenanceItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMaint8MasterMaintenanceItemInsert({
    required this.id,
  });
}

@immutable
class SeedMaint8Data {
  final SeedMaint8MasterMaintenanceItemInsert masterMaintenanceItem_insert;
  SeedMaint8Data.fromJson(dynamic json):
  
  masterMaintenanceItem_insert = SeedMaint8MasterMaintenanceItemInsert.fromJson(json['masterMaintenanceItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaint8Data otherTyped = other as SeedMaint8Data;
    return masterMaintenanceItem_insert == otherTyped.masterMaintenanceItem_insert;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItem_insert'] = masterMaintenanceItem_insert.toJson();
    return json;
  }

  SeedMaint8Data({
    required this.masterMaintenanceItem_insert,
  });
}

