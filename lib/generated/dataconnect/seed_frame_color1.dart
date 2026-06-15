part of 'default.dart';

class SeedFrameColor1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameColor1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameColor1Data> dataDeserializer = (dynamic json)  => SeedFrameColor1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameColor1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameColor1Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameColor1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameColor1MasterFrameColorInsert {
  final String id;
  SeedFrameColor1MasterFrameColorInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameColor1MasterFrameColorInsert otherTyped = other as SeedFrameColor1MasterFrameColorInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameColor1MasterFrameColorInsert({
    required this.id,
  });
}

@immutable
class SeedFrameColor1Data {
  final SeedFrameColor1MasterFrameColorInsert masterFrameColor_insert;
  SeedFrameColor1Data.fromJson(dynamic json):
  
  masterFrameColor_insert = SeedFrameColor1MasterFrameColorInsert.fromJson(json['masterFrameColor_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameColor1Data otherTyped = other as SeedFrameColor1Data;
    return masterFrameColor_insert == otherTyped.masterFrameColor_insert;
    
  }
  @override
  int get hashCode => masterFrameColor_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameColor_insert'] = masterFrameColor_insert.toJson();
    return json;
  }

  SeedFrameColor1Data({
    required this.masterFrameColor_insert,
  });
}

