part of 'default.dart';

class SeedFw8VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw8VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw8Data> dataDeserializer = (dynamic json)  => SeedFw8Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw8Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw8Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW8", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw8MasterFrameWeightInsert {
  final String id;
  SeedFw8MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw8MasterFrameWeightInsert otherTyped = other as SeedFw8MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw8MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw8Data {
  final SeedFw8MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw8Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw8MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw8Data otherTyped = other as SeedFw8Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw8Data({
    required this.masterFrameWeight_insert,
  });
}

