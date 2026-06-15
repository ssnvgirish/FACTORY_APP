part of 'default.dart';

class SeedFw21VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw21VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw21Data> dataDeserializer = (dynamic json)  => SeedFw21Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw21Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw21Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW21", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw21MasterFrameWeightInsert {
  final String id;
  SeedFw21MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw21MasterFrameWeightInsert otherTyped = other as SeedFw21MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw21MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw21Data {
  final SeedFw21MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw21Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw21MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw21Data otherTyped = other as SeedFw21Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw21Data({
    required this.masterFrameWeight_insert,
  });
}

