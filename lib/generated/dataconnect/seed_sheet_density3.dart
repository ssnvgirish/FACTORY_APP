part of 'default.dart';

class SeedSheetDensity3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetDensity3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetDensity3Data> dataDeserializer = (dynamic json)  => SeedSheetDensity3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetDensity3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetDensity3Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetDensity3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetDensity3MasterSheetDensityInsert {
  final String id;
  SeedSheetDensity3MasterSheetDensityInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetDensity3MasterSheetDensityInsert otherTyped = other as SeedSheetDensity3MasterSheetDensityInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetDensity3MasterSheetDensityInsert({
    required this.id,
  });
}

@immutable
class SeedSheetDensity3Data {
  final SeedSheetDensity3MasterSheetDensityInsert masterSheetDensity_insert;
  SeedSheetDensity3Data.fromJson(dynamic json):
  
  masterSheetDensity_insert = SeedSheetDensity3MasterSheetDensityInsert.fromJson(json['masterSheetDensity_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetDensity3Data otherTyped = other as SeedSheetDensity3Data;
    return masterSheetDensity_insert == otherTyped.masterSheetDensity_insert;
    
  }
  @override
  int get hashCode => masterSheetDensity_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetDensity_insert'] = masterSheetDensity_insert.toJson();
    return json;
  }

  SeedSheetDensity3Data({
    required this.masterSheetDensity_insert,
  });
}

