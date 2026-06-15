part of 'default.dart';

class SeedFw12VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw12VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw12Data> dataDeserializer = (dynamic json)  => SeedFw12Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw12Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw12Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW12", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw12MasterFrameWeightInsert {
  final String id;
  SeedFw12MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw12MasterFrameWeightInsert otherTyped = other as SeedFw12MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw12MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw12Data {
  final SeedFw12MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw12Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw12MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw12Data otherTyped = other as SeedFw12Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw12Data({
    required this.masterFrameWeight_insert,
  });
}

