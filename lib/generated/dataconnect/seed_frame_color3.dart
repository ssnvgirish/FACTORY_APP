part of 'default.dart';

class SeedFrameColor3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameColor3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameColor3Data> dataDeserializer = (dynamic json)  => SeedFrameColor3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameColor3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameColor3Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameColor3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameColor3MasterFrameColorInsert {
  final String id;
  SeedFrameColor3MasterFrameColorInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameColor3MasterFrameColorInsert otherTyped = other as SeedFrameColor3MasterFrameColorInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameColor3MasterFrameColorInsert({
    required this.id,
  });
}

@immutable
class SeedFrameColor3Data {
  final SeedFrameColor3MasterFrameColorInsert masterFrameColor_insert;
  SeedFrameColor3Data.fromJson(dynamic json):
  
  masterFrameColor_insert = SeedFrameColor3MasterFrameColorInsert.fromJson(json['masterFrameColor_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameColor3Data otherTyped = other as SeedFrameColor3Data;
    return masterFrameColor_insert == otherTyped.masterFrameColor_insert;
    
  }
  @override
  int get hashCode => masterFrameColor_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameColor_insert'] = masterFrameColor_insert.toJson();
    return json;
  }

  SeedFrameColor3Data({
    required this.masterFrameColor_insert,
  });
}

