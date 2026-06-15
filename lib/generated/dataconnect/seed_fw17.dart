part of 'default.dart';

class SeedFw17VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw17VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw17Data> dataDeserializer = (dynamic json)  => SeedFw17Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw17Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw17Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW17", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw17MasterFrameWeightInsert {
  final String id;
  SeedFw17MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw17MasterFrameWeightInsert otherTyped = other as SeedFw17MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw17MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw17Data {
  final SeedFw17MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw17Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw17MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw17Data otherTyped = other as SeedFw17Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw17Data({
    required this.masterFrameWeight_insert,
  });
}

