part of 'default.dart';

class SeedSheetDensity5VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetDensity5VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetDensity5Data> dataDeserializer = (dynamic json)  => SeedSheetDensity5Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetDensity5Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetDensity5Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetDensity5", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetDensity5MasterSheetDensityInsert {
  final String id;
  SeedSheetDensity5MasterSheetDensityInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetDensity5MasterSheetDensityInsert otherTyped = other as SeedSheetDensity5MasterSheetDensityInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetDensity5MasterSheetDensityInsert({
    required this.id,
  });
}

@immutable
class SeedSheetDensity5Data {
  final SeedSheetDensity5MasterSheetDensityInsert masterSheetDensity_insert;
  SeedSheetDensity5Data.fromJson(dynamic json):
  
  masterSheetDensity_insert = SeedSheetDensity5MasterSheetDensityInsert.fromJson(json['masterSheetDensity_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetDensity5Data otherTyped = other as SeedSheetDensity5Data;
    return masterSheetDensity_insert == otherTyped.masterSheetDensity_insert;
    
  }
  @override
  int get hashCode => masterSheetDensity_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetDensity_insert'] = masterSheetDensity_insert.toJson();
    return json;
  }

  SeedSheetDensity5Data({
    required this.masterSheetDensity_insert,
  });
}

