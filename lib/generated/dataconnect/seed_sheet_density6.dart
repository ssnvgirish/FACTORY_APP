part of 'default.dart';

class SeedSheetDensity6VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetDensity6VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetDensity6Data> dataDeserializer = (dynamic json)  => SeedSheetDensity6Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetDensity6Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetDensity6Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetDensity6", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetDensity6MasterSheetDensityInsert {
  final String id;
  SeedSheetDensity6MasterSheetDensityInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetDensity6MasterSheetDensityInsert otherTyped = other as SeedSheetDensity6MasterSheetDensityInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetDensity6MasterSheetDensityInsert({
    required this.id,
  });
}

@immutable
class SeedSheetDensity6Data {
  final SeedSheetDensity6MasterSheetDensityInsert masterSheetDensity_insert;
  SeedSheetDensity6Data.fromJson(dynamic json):
  
  masterSheetDensity_insert = SeedSheetDensity6MasterSheetDensityInsert.fromJson(json['masterSheetDensity_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetDensity6Data otherTyped = other as SeedSheetDensity6Data;
    return masterSheetDensity_insert == otherTyped.masterSheetDensity_insert;
    
  }
  @override
  int get hashCode => masterSheetDensity_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetDensity_insert'] = masterSheetDensity_insert.toJson();
    return json;
  }

  SeedSheetDensity6Data({
    required this.masterSheetDensity_insert,
  });
}

