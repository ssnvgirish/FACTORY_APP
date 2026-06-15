part of 'default.dart';

class SeedFw2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw2Data> dataDeserializer = (dynamic json)  => SeedFw2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw2Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw2MasterFrameWeightInsert {
  final String id;
  SeedFw2MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw2MasterFrameWeightInsert otherTyped = other as SeedFw2MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw2MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw2Data {
  final SeedFw2MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw2Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw2MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw2Data otherTyped = other as SeedFw2Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw2Data({
    required this.masterFrameWeight_insert,
  });
}

