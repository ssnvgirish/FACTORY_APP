part of 'default.dart';

class SeedSheetDensity2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetDensity2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetDensity2Data> dataDeserializer = (dynamic json)  => SeedSheetDensity2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetDensity2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetDensity2Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetDensity2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetDensity2MasterSheetDensityInsert {
  final String id;
  SeedSheetDensity2MasterSheetDensityInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetDensity2MasterSheetDensityInsert otherTyped = other as SeedSheetDensity2MasterSheetDensityInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetDensity2MasterSheetDensityInsert({
    required this.id,
  });
}

@immutable
class SeedSheetDensity2Data {
  final SeedSheetDensity2MasterSheetDensityInsert masterSheetDensity_insert;
  SeedSheetDensity2Data.fromJson(dynamic json):
  
  masterSheetDensity_insert = SeedSheetDensity2MasterSheetDensityInsert.fromJson(json['masterSheetDensity_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetDensity2Data otherTyped = other as SeedSheetDensity2Data;
    return masterSheetDensity_insert == otherTyped.masterSheetDensity_insert;
    
  }
  @override
  int get hashCode => masterSheetDensity_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetDensity_insert'] = masterSheetDensity_insert.toJson();
    return json;
  }

  SeedSheetDensity2Data({
    required this.masterSheetDensity_insert,
  });
}

