part of 'default.dart';

class SeedMaintScrap5VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMaintScrap5VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMaintScrap5Data> dataDeserializer = (dynamic json)  => SeedMaintScrap5Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMaintScrap5Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMaintScrap5Data, void> ref() {
    
    return _dataConnect.mutation("SeedMaintScrap5", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMaintScrap5MasterMaintenanceItemInsert {
  final String id;
  SeedMaintScrap5MasterMaintenanceItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaintScrap5MasterMaintenanceItemInsert otherTyped = other as SeedMaintScrap5MasterMaintenanceItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMaintScrap5MasterMaintenanceItemInsert({
    required this.id,
  });
}

@immutable
class SeedMaintScrap5Data {
  final SeedMaintScrap5MasterMaintenanceItemInsert masterMaintenanceItem_insert;
  SeedMaintScrap5Data.fromJson(dynamic json):
  
  masterMaintenanceItem_insert = SeedMaintScrap5MasterMaintenanceItemInsert.fromJson(json['masterMaintenanceItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMaintScrap5Data otherTyped = other as SeedMaintScrap5Data;
    return masterMaintenanceItem_insert == otherTyped.masterMaintenanceItem_insert;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItem_insert'] = masterMaintenanceItem_insert.toJson();
    return json;
  }

  SeedMaintScrap5Data({
    required this.masterMaintenanceItem_insert,
  });
}

