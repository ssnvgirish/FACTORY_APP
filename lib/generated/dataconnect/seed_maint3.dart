part of 'default.dart';

class SeedMaint3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMaint3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMaint3Data> dataDeserializer = (dynamic json)  => SeedMaint3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMaint3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMaint3Data, void> ref() {
    
    return _dataConnect.mutation("SeedMaint3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMaint3MasterMaintenanceItemInsert {
  final String id;
  SeedMaint3MasterMaintenanceItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaint3MasterMaintenanceItemInsert otherTyped = other as SeedMaint3MasterMaintenanceItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMaint3MasterMaintenanceItemInsert({
    required this.id,
  });
}

@immutable
class SeedMaint3Data {
  final SeedMaint3MasterMaintenanceItemInsert masterMaintenanceItem_insert;
  SeedMaint3Data.fromJson(dynamic json):
  
  masterMaintenanceItem_insert = SeedMaint3MasterMaintenanceItemInsert.fromJson(json['masterMaintenanceItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaint3Data otherTyped = other as SeedMaint3Data;
    return masterMaintenanceItem_insert == otherTyped.masterMaintenanceItem_insert;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItem_insert'] = masterMaintenanceItem_insert.toJson();
    return json;
  }

  SeedMaint3Data({
    required this.masterMaintenanceItem_insert,
  });
}

