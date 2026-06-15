part of 'default.dart';

class SeedFw7VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw7VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw7Data> dataDeserializer = (dynamic json)  => SeedFw7Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw7Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw7Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW7", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw7MasterFrameWeightInsert {
  final String id;
  SeedFw7MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw7MasterFrameWeightInsert otherTyped = other as SeedFw7MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw7MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw7Data {
  final SeedFw7MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw7Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw7MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw7Data otherTyped = other as SeedFw7Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw7Data({
    required this.masterFrameWeight_insert,
  });
}

