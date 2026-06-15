part of 'default.dart';

class SeedFw13VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw13VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw13Data> dataDeserializer = (dynamic json)  => SeedFw13Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw13Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw13Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW13", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw13MasterFrameWeightInsert {
  final String id;
  SeedFw13MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw13MasterFrameWeightInsert otherTyped = other as SeedFw13MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw13MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw13Data {
  final SeedFw13MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw13Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw13MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw13Data otherTyped = other as SeedFw13Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw13Data({
    required this.masterFrameWeight_insert,
  });
}

