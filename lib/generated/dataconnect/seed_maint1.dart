part of 'default.dart';

class SeedMaint1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMaint1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMaint1Data> dataDeserializer = (dynamic json)  => SeedMaint1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMaint1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMaint1Data, void> ref() {
    
    return _dataConnect.mutation("SeedMaint1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMaint1MasterMaintenanceItemInsert {
  final String id;
  SeedMaint1MasterMaintenanceItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaint1MasterMaintenanceItemInsert otherTyped = other as SeedMaint1MasterMaintenanceItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMaint1MasterMaintenanceItemInsert({
    required this.id,
  });
}

@immutable
class SeedMaint1Data {
  final SeedMaint1MasterMaintenanceItemInsert masterMaintenanceItem_insert;
  SeedMaint1Data.fromJson(dynamic json):
  
  masterMaintenanceItem_insert = SeedMaint1MasterMaintenanceItemInsert.fromJson(json['masterMaintenanceItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaint1Data otherTyped = other as SeedMaint1Data;
    return masterMaintenanceItem_insert == otherTyped.masterMaintenanceItem_insert;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItem_insert'] = masterMaintenanceItem_insert.toJson();
    return json;
  }

  SeedMaint1Data({
    required this.masterMaintenanceItem_insert,
  });
}

