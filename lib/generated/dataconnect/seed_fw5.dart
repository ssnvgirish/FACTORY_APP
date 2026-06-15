part of 'default.dart';

class SeedFw5VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw5VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw5Data> dataDeserializer = (dynamic json)  => SeedFw5Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw5Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw5Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW5", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw5MasterFrameWeightInsert {
  final String id;
  SeedFw5MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw5MasterFrameWeightInsert otherTyped = other as SeedFw5MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw5MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw5Data {
  final SeedFw5MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw5Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw5MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw5Data otherTyped = other as SeedFw5Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw5Data({
    required this.masterFrameWeight_insert,
  });
}

