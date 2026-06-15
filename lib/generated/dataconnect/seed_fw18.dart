part of 'default.dart';

class SeedFw18VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw18VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw18Data> dataDeserializer = (dynamic json)  => SeedFw18Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw18Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw18Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW18", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw18MasterFrameWeightInsert {
  final String id;
  SeedFw18MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw18MasterFrameWeightInsert otherTyped = other as SeedFw18MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw18MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw18Data {
  final SeedFw18MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw18Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw18MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw18Data otherTyped = other as SeedFw18Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw18Data({
    required this.masterFrameWeight_insert,
  });
}

