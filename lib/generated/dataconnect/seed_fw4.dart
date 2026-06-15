part of 'default.dart';

class SeedFw4VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw4VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw4Data> dataDeserializer = (dynamic json)  => SeedFw4Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw4Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw4Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW4", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw4MasterFrameWeightInsert {
  final String id;
  SeedFw4MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw4MasterFrameWeightInsert otherTyped = other as SeedFw4MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw4MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw4Data {
  final SeedFw4MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw4Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw4MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw4Data otherTyped = other as SeedFw4Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw4Data({
    required this.masterFrameWeight_insert,
  });
}

