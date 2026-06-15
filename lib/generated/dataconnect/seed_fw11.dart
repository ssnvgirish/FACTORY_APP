part of 'default.dart';

class SeedFw11VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw11VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw11Data> dataDeserializer = (dynamic json)  => SeedFw11Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw11Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw11Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW11", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw11MasterFrameWeightInsert {
  final String id;
  SeedFw11MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw11MasterFrameWeightInsert otherTyped = other as SeedFw11MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw11MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw11Data {
  final SeedFw11MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw11Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw11MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw11Data otherTyped = other as SeedFw11Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw11Data({
    required this.masterFrameWeight_insert,
  });
}

