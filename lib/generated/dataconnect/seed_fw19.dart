part of 'default.dart';

class SeedFw19VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw19VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw19Data> dataDeserializer = (dynamic json)  => SeedFw19Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw19Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw19Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW19", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw19MasterFrameWeightInsert {
  final String id;
  SeedFw19MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw19MasterFrameWeightInsert otherTyped = other as SeedFw19MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw19MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw19Data {
  final SeedFw19MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw19Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw19MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw19Data otherTyped = other as SeedFw19Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw19Data({
    required this.masterFrameWeight_insert,
  });
}

