part of 'default.dart';

class SeedFw14VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw14VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw14Data> dataDeserializer = (dynamic json)  => SeedFw14Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw14Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw14Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW14", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw14MasterFrameWeightInsert {
  final String id;
  SeedFw14MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw14MasterFrameWeightInsert otherTyped = other as SeedFw14MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw14MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw14Data {
  final SeedFw14MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw14Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw14MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw14Data otherTyped = other as SeedFw14Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw14Data({
    required this.masterFrameWeight_insert,
  });
}

