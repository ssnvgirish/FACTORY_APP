part of 'default.dart';

class SeedFrameSection7VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameSection7VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameSection7Data> dataDeserializer = (dynamic json)  => SeedFrameSection7Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameSection7Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameSection7Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameSection7", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameSection7MasterFrameSectionInsert {
  final String id;
  SeedFrameSection7MasterFrameSectionInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameSection7MasterFrameSectionInsert otherTyped = other as SeedFrameSection7MasterFrameSectionInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameSection7MasterFrameSectionInsert({
    required this.id,
  });
}

@immutable
class SeedFrameSection7Data {
  final SeedFrameSection7MasterFrameSectionInsert masterFrameSection_insert;
  SeedFrameSection7Data.fromJson(dynamic json):
  
  masterFrameSection_insert = SeedFrameSection7MasterFrameSectionInsert.fromJson(json['masterFrameSection_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameSection7Data otherTyped = other as SeedFrameSection7Data;
    return masterFrameSection_insert == otherTyped.masterFrameSection_insert;
    
  }
  @override
  int get hashCode => masterFrameSection_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameSection_insert'] = masterFrameSection_insert.toJson();
    return json;
  }

  SeedFrameSection7Data({
    required this.masterFrameSection_insert,
  });
}

