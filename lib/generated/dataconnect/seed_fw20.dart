part of 'default.dart';

class SeedFw20VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw20VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw20Data> dataDeserializer = (dynamic json)  => SeedFw20Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw20Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw20Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW20", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw20MasterFrameWeightInsert {
  final String id;
  SeedFw20MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw20MasterFrameWeightInsert otherTyped = other as SeedFw20MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw20MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw20Data {
  final SeedFw20MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw20Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw20MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw20Data otherTyped = other as SeedFw20Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw20Data({
    required this.masterFrameWeight_insert,
  });
}

