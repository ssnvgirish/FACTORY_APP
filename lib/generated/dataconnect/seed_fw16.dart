part of 'default.dart';

class SeedFw16VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw16VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw16Data> dataDeserializer = (dynamic json)  => SeedFw16Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw16Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw16Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW16", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw16MasterFrameWeightInsert {
  final String id;
  SeedFw16MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw16MasterFrameWeightInsert otherTyped = other as SeedFw16MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw16MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw16Data {
  final SeedFw16MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw16Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw16MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw16Data otherTyped = other as SeedFw16Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw16Data({
    required this.masterFrameWeight_insert,
  });
}

