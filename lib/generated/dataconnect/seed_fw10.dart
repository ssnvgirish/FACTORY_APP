part of 'default.dart';

class SeedFw10VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw10VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw10Data> dataDeserializer = (dynamic json)  => SeedFw10Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw10Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw10Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW10", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw10MasterFrameWeightInsert {
  final String id;
  SeedFw10MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw10MasterFrameWeightInsert otherTyped = other as SeedFw10MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw10MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw10Data {
  final SeedFw10MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw10Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw10MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw10Data otherTyped = other as SeedFw10Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw10Data({
    required this.masterFrameWeight_insert,
  });
}

