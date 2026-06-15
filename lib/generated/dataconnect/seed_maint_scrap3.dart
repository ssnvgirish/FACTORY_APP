part of 'default.dart';

class SeedMaintScrap3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMaintScrap3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMaintScrap3Data> dataDeserializer = (dynamic json)  => SeedMaintScrap3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMaintScrap3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMaintScrap3Data, void> ref() {
    
    return _dataConnect.mutation("SeedMaintScrap3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMaintScrap3MasterMaintenanceItemInsert {
  final String id;
  SeedMaintScrap3MasterMaintenanceItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaintScrap3MasterMaintenanceItemInsert otherTyped = other as SeedMaintScrap3MasterMaintenanceItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMaintScrap3MasterMaintenanceItemInsert({
    required this.id,
  });
}

@immutable
class SeedMaintScrap3Data {
  final SeedMaintScrap3MasterMaintenanceItemInsert masterMaintenanceItem_insert;
  SeedMaintScrap3Data.fromJson(dynamic json):
  
  masterMaintenanceItem_insert = SeedMaintScrap3MasterMaintenanceItemInsert.fromJson(json['masterMaintenanceItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaintScrap3Data otherTyped = other as SeedMaintScrap3Data;
    return masterMaintenanceItem_insert == otherTyped.masterMaintenanceItem_insert;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItem_insert'] = masterMaintenanceItem_insert.toJson();
    return json;
  }

  SeedMaintScrap3Data({
    required this.masterMaintenanceItem_insert,
  });
}

