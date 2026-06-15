part of 'default.dart';

class SeedFrameDensity4VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameDensity4VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameDensity4Data> dataDeserializer = (dynamic json)  => SeedFrameDensity4Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameDensity4Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameDensity4Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameDensity4", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameDensity4MasterFrameDensityInsert {
  final String id;
  SeedFrameDensity4MasterFrameDensityInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameDensity4MasterFrameDensityInsert otherTyped = other as SeedFrameDensity4MasterFrameDensityInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameDensity4MasterFrameDensityInsert({
    required this.id,
  });
}

@immutable
class SeedFrameDensity4Data {
  final SeedFrameDensity4MasterFrameDensityInsert masterFrameDensity_insert;
  SeedFrameDensity4Data.fromJson(dynamic json):
  
  masterFrameDensity_insert = SeedFrameDensity4MasterFrameDensityInsert.fromJson(json['masterFrameDensity_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameDensity4Data otherTyped = other as SeedFrameDensity4Data;
    return masterFrameDensity_insert == otherTyped.masterFrameDensity_insert;
    
  }
  @override
  int get hashCode => masterFrameDensity_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameDensity_insert'] = masterFrameDensity_insert.toJson();
    return json;
  }

  SeedFrameDensity4Data({
    required this.masterFrameDensity_insert,
  });
}

