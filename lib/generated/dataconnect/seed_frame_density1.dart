part of 'default.dart';

class SeedFrameDensity1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameDensity1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameDensity1Data> dataDeserializer = (dynamic json)  => SeedFrameDensity1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameDensity1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameDensity1Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameDensity1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameDensity1MasterFrameDensityInsert {
  final String id;
  SeedFrameDensity1MasterFrameDensityInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameDensity1MasterFrameDensityInsert otherTyped = other as SeedFrameDensity1MasterFrameDensityInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameDensity1MasterFrameDensityInsert({
    required this.id,
  });
}

@immutable
class SeedFrameDensity1Data {
  final SeedFrameDensity1MasterFrameDensityInsert masterFrameDensity_insert;
  SeedFrameDensity1Data.fromJson(dynamic json):
  
  masterFrameDensity_insert = SeedFrameDensity1MasterFrameDensityInsert.fromJson(json['masterFrameDensity_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameDensity1Data otherTyped = other as SeedFrameDensity1Data;
    return masterFrameDensity_insert == otherTyped.masterFrameDensity_insert;
    
  }
  @override
  int get hashCode => masterFrameDensity_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameDensity_insert'] = masterFrameDensity_insert.toJson();
    return json;
  }

  SeedFrameDensity1Data({
    required this.masterFrameDensity_insert,
  });
}

