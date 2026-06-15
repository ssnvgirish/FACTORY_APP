part of 'default.dart';

class SeedMaint7VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMaint7VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMaint7Data> dataDeserializer = (dynamic json)  => SeedMaint7Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMaint7Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMaint7Data, void> ref() {
    
    return _dataConnect.mutation("SeedMaint7", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMaint7MasterMaintenanceItemInsert {
  final String id;
  SeedMaint7MasterMaintenanceItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaint7MasterMaintenanceItemInsert otherTyped = other as SeedMaint7MasterMaintenanceItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMaint7MasterMaintenanceItemInsert({
    required this.id,
  });
}

@immutable
class SeedMaint7Data {
  final SeedMaint7MasterMaintenanceItemInsert masterMaintenanceItem_insert;
  SeedMaint7Data.fromJson(dynamic json):
  
  masterMaintenanceItem_insert = SeedMaint7MasterMaintenanceItemInsert.fromJson(json['masterMaintenanceItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaint7Data otherTyped = other as SeedMaint7Data;
    return masterMaintenanceItem_insert == otherTyped.masterMaintenanceItem_insert;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItem_insert'] = masterMaintenanceItem_insert.toJson();
    return json;
  }

  SeedMaint7Data({
    required this.masterMaintenanceItem_insert,
  });
}

