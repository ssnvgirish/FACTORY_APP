part of 'default.dart';

class SeedFrameDensity3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameDensity3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameDensity3Data> dataDeserializer = (dynamic json)  => SeedFrameDensity3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameDensity3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameDensity3Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameDensity3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameDensity3MasterFrameDensityInsert {
  final String id;
  SeedFrameDensity3MasterFrameDensityInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameDensity3MasterFrameDensityInsert otherTyped = other as SeedFrameDensity3MasterFrameDensityInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameDensity3MasterFrameDensityInsert({
    required this.id,
  });
}

@immutable
class SeedFrameDensity3Data {
  final SeedFrameDensity3MasterFrameDensityInsert masterFrameDensity_insert;
  SeedFrameDensity3Data.fromJson(dynamic json):
  
  masterFrameDensity_insert = SeedFrameDensity3MasterFrameDensityInsert.fromJson(json['masterFrameDensity_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameDensity3Data otherTyped = other as SeedFrameDensity3Data;
    return masterFrameDensity_insert == otherTyped.masterFrameDensity_insert;
    
  }
  @override
  int get hashCode => masterFrameDensity_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameDensity_insert'] = masterFrameDensity_insert.toJson();
    return json;
  }

  SeedFrameDensity3Data({
    required this.masterFrameDensity_insert,
  });
}

