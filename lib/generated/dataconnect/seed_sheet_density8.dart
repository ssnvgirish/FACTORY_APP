part of 'default.dart';

class SeedSheetDensity8VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetDensity8VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetDensity8Data> dataDeserializer = (dynamic json)  => SeedSheetDensity8Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetDensity8Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetDensity8Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetDensity8", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetDensity8MasterSheetDensityInsert {
  final String id;
  SeedSheetDensity8MasterSheetDensityInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetDensity8MasterSheetDensityInsert otherTyped = other as SeedSheetDensity8MasterSheetDensityInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetDensity8MasterSheetDensityInsert({
    required this.id,
  });
}

@immutable
class SeedSheetDensity8Data {
  final SeedSheetDensity8MasterSheetDensityInsert masterSheetDensity_insert;
  SeedSheetDensity8Data.fromJson(dynamic json):
  
  masterSheetDensity_insert = SeedSheetDensity8MasterSheetDensityInsert.fromJson(json['masterSheetDensity_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetDensity8Data otherTyped = other as SeedSheetDensity8Data;
    return masterSheetDensity_insert == otherTyped.masterSheetDensity_insert;
    
  }
  @override
  int get hashCode => masterSheetDensity_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetDensity_insert'] = masterSheetDensity_insert.toJson();
    return json;
  }

  SeedSheetDensity8Data({
    required this.masterSheetDensity_insert,
  });
}

