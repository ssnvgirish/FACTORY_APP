part of 'default.dart';

class SeedMaint2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMaint2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMaint2Data> dataDeserializer = (dynamic json)  => SeedMaint2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMaint2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMaint2Data, void> ref() {
    
    return _dataConnect.mutation("SeedMaint2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMaint2MasterMaintenanceItemInsert {
  final String id;
  SeedMaint2MasterMaintenanceItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaint2MasterMaintenanceItemInsert otherTyped = other as SeedMaint2MasterMaintenanceItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMaint2MasterMaintenanceItemInsert({
    required this.id,
  });
}

@immutable
class SeedMaint2Data {
  final SeedMaint2MasterMaintenanceItemInsert masterMaintenanceItem_insert;
  SeedMaint2Data.fromJson(dynamic json):
  
  masterMaintenanceItem_insert = SeedMaint2MasterMaintenanceItemInsert.fromJson(json['masterMaintenanceItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaint2Data otherTyped = other as SeedMaint2Data;
    return masterMaintenanceItem_insert == otherTyped.masterMaintenanceItem_insert;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItem_insert'] = masterMaintenanceItem_insert.toJson();
    return json;
  }

  SeedMaint2Data({
    required this.masterMaintenanceItem_insert,
  });
}

