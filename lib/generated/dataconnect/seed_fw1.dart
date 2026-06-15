part of 'default.dart';

class SeedFw1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw1Data> dataDeserializer = (dynamic json)  => SeedFw1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw1Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw1MasterFrameWeightInsert {
  final String id;
  SeedFw1MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw1MasterFrameWeightInsert otherTyped = other as SeedFw1MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw1MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw1Data {
  final SeedFw1MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw1Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw1MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw1Data otherTyped = other as SeedFw1Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw1Data({
    required this.masterFrameWeight_insert,
  });
}

