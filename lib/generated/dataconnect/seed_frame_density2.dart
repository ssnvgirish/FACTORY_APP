part of 'default.dart';

class SeedFrameDensity2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameDensity2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameDensity2Data> dataDeserializer = (dynamic json)  => SeedFrameDensity2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameDensity2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameDensity2Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameDensity2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameDensity2MasterFrameDensityInsert {
  final String id;
  SeedFrameDensity2MasterFrameDensityInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameDensity2MasterFrameDensityInsert otherTyped = other as SeedFrameDensity2MasterFrameDensityInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameDensity2MasterFrameDensityInsert({
    required this.id,
  });
}

@immutable
class SeedFrameDensity2Data {
  final SeedFrameDensity2MasterFrameDensityInsert masterFrameDensity_insert;
  SeedFrameDensity2Data.fromJson(dynamic json):
  
  masterFrameDensity_insert = SeedFrameDensity2MasterFrameDensityInsert.fromJson(json['masterFrameDensity_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameDensity2Data otherTyped = other as SeedFrameDensity2Data;
    return masterFrameDensity_insert == otherTyped.masterFrameDensity_insert;
    
  }
  @override
  int get hashCode => masterFrameDensity_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameDensity_insert'] = masterFrameDensity_insert.toJson();
    return json;
  }

  SeedFrameDensity2Data({
    required this.masterFrameDensity_insert,
  });
}

