part of 'default.dart';

class SeedMaint5VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMaint5VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMaint5Data> dataDeserializer = (dynamic json)  => SeedMaint5Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMaint5Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMaint5Data, void> ref() {
    
    return _dataConnect.mutation("SeedMaint5", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMaint5MasterMaintenanceItemInsert {
  final String id;
  SeedMaint5MasterMaintenanceItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaint5MasterMaintenanceItemInsert otherTyped = other as SeedMaint5MasterMaintenanceItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMaint5MasterMaintenanceItemInsert({
    required this.id,
  });
}

@immutable
class SeedMaint5Data {
  final SeedMaint5MasterMaintenanceItemInsert masterMaintenanceItem_insert;
  SeedMaint5Data.fromJson(dynamic json):
  
  masterMaintenanceItem_insert = SeedMaint5MasterMaintenanceItemInsert.fromJson(json['masterMaintenanceItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaint5Data otherTyped = other as SeedMaint5Data;
    return masterMaintenanceItem_insert == otherTyped.masterMaintenanceItem_insert;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItem_insert'] = masterMaintenanceItem_insert.toJson();
    return json;
  }

  SeedMaint5Data({
    required this.masterMaintenanceItem_insert,
  });
}

