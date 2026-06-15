part of 'default.dart';

class SeedMaint6VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMaint6VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMaint6Data> dataDeserializer = (dynamic json)  => SeedMaint6Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMaint6Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMaint6Data, void> ref() {
    
    return _dataConnect.mutation("SeedMaint6", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMaint6MasterMaintenanceItemInsert {
  final String id;
  SeedMaint6MasterMaintenanceItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaint6MasterMaintenanceItemInsert otherTyped = other as SeedMaint6MasterMaintenanceItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMaint6MasterMaintenanceItemInsert({
    required this.id,
  });
}

@immutable
class SeedMaint6Data {
  final SeedMaint6MasterMaintenanceItemInsert masterMaintenanceItem_insert;
  SeedMaint6Data.fromJson(dynamic json):
  
  masterMaintenanceItem_insert = SeedMaint6MasterMaintenanceItemInsert.fromJson(json['masterMaintenanceItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaint6Data otherTyped = other as SeedMaint6Data;
    return masterMaintenanceItem_insert == otherTyped.masterMaintenanceItem_insert;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItem_insert'] = masterMaintenanceItem_insert.toJson();
    return json;
  }

  SeedMaint6Data({
    required this.masterMaintenanceItem_insert,
  });
}

