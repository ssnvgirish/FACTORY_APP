part of 'default.dart';

class SeedFw9VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw9VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw9Data> dataDeserializer = (dynamic json)  => SeedFw9Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw9Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw9Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW9", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw9MasterFrameWeightInsert {
  final String id;
  SeedFw9MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw9MasterFrameWeightInsert otherTyped = other as SeedFw9MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw9MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw9Data {
  final SeedFw9MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw9Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw9MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw9Data otherTyped = other as SeedFw9Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw9Data({
    required this.masterFrameWeight_insert,
  });
}

