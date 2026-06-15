part of 'default.dart';

class SeedFrameColor2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameColor2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameColor2Data> dataDeserializer = (dynamic json)  => SeedFrameColor2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameColor2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameColor2Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameColor2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameColor2MasterFrameColorInsert {
  final String id;
  SeedFrameColor2MasterFrameColorInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameColor2MasterFrameColorInsert otherTyped = other as SeedFrameColor2MasterFrameColorInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameColor2MasterFrameColorInsert({
    required this.id,
  });
}

@immutable
class SeedFrameColor2Data {
  final SeedFrameColor2MasterFrameColorInsert masterFrameColor_insert;
  SeedFrameColor2Data.fromJson(dynamic json):
  
  masterFrameColor_insert = SeedFrameColor2MasterFrameColorInsert.fromJson(json['masterFrameColor_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameColor2Data otherTyped = other as SeedFrameColor2Data;
    return masterFrameColor_insert == otherTyped.masterFrameColor_insert;
    
  }
  @override
  int get hashCode => masterFrameColor_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameColor_insert'] = masterFrameColor_insert.toJson();
    return json;
  }

  SeedFrameColor2Data({
    required this.masterFrameColor_insert,
  });
}

