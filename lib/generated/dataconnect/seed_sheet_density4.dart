part of 'default.dart';

class SeedSheetDensity4VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetDensity4VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetDensity4Data> dataDeserializer = (dynamic json)  => SeedSheetDensity4Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetDensity4Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetDensity4Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetDensity4", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetDensity4MasterSheetDensityInsert {
  final String id;
  SeedSheetDensity4MasterSheetDensityInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetDensity4MasterSheetDensityInsert otherTyped = other as SeedSheetDensity4MasterSheetDensityInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetDensity4MasterSheetDensityInsert({
    required this.id,
  });
}

@immutable
class SeedSheetDensity4Data {
  final SeedSheetDensity4MasterSheetDensityInsert masterSheetDensity_insert;
  SeedSheetDensity4Data.fromJson(dynamic json):
  
  masterSheetDensity_insert = SeedSheetDensity4MasterSheetDensityInsert.fromJson(json['masterSheetDensity_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetDensity4Data otherTyped = other as SeedSheetDensity4Data;
    return masterSheetDensity_insert == otherTyped.masterSheetDensity_insert;
    
  }
  @override
  int get hashCode => masterSheetDensity_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetDensity_insert'] = masterSheetDensity_insert.toJson();
    return json;
  }

  SeedSheetDensity4Data({
    required this.masterSheetDensity_insert,
  });
}

