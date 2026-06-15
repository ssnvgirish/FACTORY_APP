part of 'default.dart';

class SeedSheetDensity7VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetDensity7VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetDensity7Data> dataDeserializer = (dynamic json)  => SeedSheetDensity7Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetDensity7Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetDensity7Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetDensity7", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetDensity7MasterSheetDensityInsert {
  final String id;
  SeedSheetDensity7MasterSheetDensityInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetDensity7MasterSheetDensityInsert otherTyped = other as SeedSheetDensity7MasterSheetDensityInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetDensity7MasterSheetDensityInsert({
    required this.id,
  });
}

@immutable
class SeedSheetDensity7Data {
  final SeedSheetDensity7MasterSheetDensityInsert masterSheetDensity_insert;
  SeedSheetDensity7Data.fromJson(dynamic json):
  
  masterSheetDensity_insert = SeedSheetDensity7MasterSheetDensityInsert.fromJson(json['masterSheetDensity_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetDensity7Data otherTyped = other as SeedSheetDensity7Data;
    return masterSheetDensity_insert == otherTyped.masterSheetDensity_insert;
    
  }
  @override
  int get hashCode => masterSheetDensity_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetDensity_insert'] = masterSheetDensity_insert.toJson();
    return json;
  }

  SeedSheetDensity7Data({
    required this.masterSheetDensity_insert,
  });
}

