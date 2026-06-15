part of 'default.dart';

class SeedMaint4VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMaint4VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMaint4Data> dataDeserializer = (dynamic json)  => SeedMaint4Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMaint4Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMaint4Data, void> ref() {
    
    return _dataConnect.mutation("SeedMaint4", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMaint4MasterMaintenanceItemInsert {
  final String id;
  SeedMaint4MasterMaintenanceItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaint4MasterMaintenanceItemInsert otherTyped = other as SeedMaint4MasterMaintenanceItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMaint4MasterMaintenanceItemInsert({
    required this.id,
  });
}

@immutable
class SeedMaint4Data {
  final SeedMaint4MasterMaintenanceItemInsert masterMaintenanceItem_insert;
  SeedMaint4Data.fromJson(dynamic json):
  
  masterMaintenanceItem_insert = SeedMaint4MasterMaintenanceItemInsert.fromJson(json['masterMaintenanceItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaint4Data otherTyped = other as SeedMaint4Data;
    return masterMaintenanceItem_insert == otherTyped.masterMaintenanceItem_insert;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItem_insert'] = masterMaintenanceItem_insert.toJson();
    return json;
  }

  SeedMaint4Data({
    required this.masterMaintenanceItem_insert,
  });
}

