part of 'default.dart';

class SeedFw3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw3Data> dataDeserializer = (dynamic json)  => SeedFw3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw3Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw3MasterFrameWeightInsert {
  final String id;
  SeedFw3MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw3MasterFrameWeightInsert otherTyped = other as SeedFw3MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw3MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw3Data {
  final SeedFw3MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw3Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw3MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw3Data otherTyped = other as SeedFw3Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw3Data({
    required this.masterFrameWeight_insert,
  });
}

