part of 'default.dart';

class SeedFw6VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw6VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw6Data> dataDeserializer = (dynamic json)  => SeedFw6Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw6Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw6Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW6", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw6MasterFrameWeightInsert {
  final String id;
  SeedFw6MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw6MasterFrameWeightInsert otherTyped = other as SeedFw6MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw6MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw6Data {
  final SeedFw6MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw6Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw6MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw6Data otherTyped = other as SeedFw6Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw6Data({
    required this.masterFrameWeight_insert,
  });
}

