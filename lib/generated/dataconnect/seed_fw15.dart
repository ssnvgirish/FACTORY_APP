part of 'default.dart';

class SeedFw15VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFw15VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFw15Data> dataDeserializer = (dynamic json)  => SeedFw15Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFw15Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFw15Data, void> ref() {
    
    return _dataConnect.mutation("SeedFW15", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFw15MasterFrameWeightInsert {
  final String id;
  SeedFw15MasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw15MasterFrameWeightInsert otherTyped = other as SeedFw15MasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFw15MasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class SeedFw15Data {
  final SeedFw15MasterFrameWeightInsert masterFrameWeight_insert;
  SeedFw15Data.fromJson(dynamic json):
  
  masterFrameWeight_insert = SeedFw15MasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFw15Data otherTyped = other as SeedFw15Data;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  SeedFw15Data({
    required this.masterFrameWeight_insert,
  });
}

