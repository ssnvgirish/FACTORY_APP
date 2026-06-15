part of 'default.dart';

class SeedSheetDensity1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetDensity1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetDensity1Data> dataDeserializer = (dynamic json)  => SeedSheetDensity1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetDensity1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetDensity1Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetDensity1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetDensity1MasterSheetDensityInsert {
  final String id;
  SeedSheetDensity1MasterSheetDensityInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetDensity1MasterSheetDensityInsert otherTyped = other as SeedSheetDensity1MasterSheetDensityInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetDensity1MasterSheetDensityInsert({
    required this.id,
  });
}

@immutable
class SeedSheetDensity1Data {
  final SeedSheetDensity1MasterSheetDensityInsert masterSheetDensity_insert;
  SeedSheetDensity1Data.fromJson(dynamic json):
  
  masterSheetDensity_insert = SeedSheetDensity1MasterSheetDensityInsert.fromJson(json['masterSheetDensity_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetDensity1Data otherTyped = other as SeedSheetDensity1Data;
    return masterSheetDensity_insert == otherTyped.masterSheetDensity_insert;
    
  }
  @override
  int get hashCode => masterSheetDensity_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetDensity_insert'] = masterSheetDensity_insert.toJson();
    return json;
  }

  SeedSheetDensity1Data({
    required this.masterSheetDensity_insert,
  });
}

