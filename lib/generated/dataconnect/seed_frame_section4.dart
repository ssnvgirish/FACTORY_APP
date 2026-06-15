part of 'default.dart';

class SeedFrameSection4VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameSection4VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameSection4Data> dataDeserializer = (dynamic json)  => SeedFrameSection4Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameSection4Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameSection4Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameSection4", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameSection4MasterFrameSectionInsert {
  final String id;
  SeedFrameSection4MasterFrameSectionInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameSection4MasterFrameSectionInsert otherTyped = other as SeedFrameSection4MasterFrameSectionInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameSection4MasterFrameSectionInsert({
    required this.id,
  });
}

@immutable
class SeedFrameSection4Data {
  final SeedFrameSection4MasterFrameSectionInsert masterFrameSection_insert;
  SeedFrameSection4Data.fromJson(dynamic json):
  
  masterFrameSection_insert = SeedFrameSection4MasterFrameSectionInsert.fromJson(json['masterFrameSection_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameSection4Data otherTyped = other as SeedFrameSection4Data;
    return masterFrameSection_insert == otherTyped.masterFrameSection_insert;
    
  }
  @override
  int get hashCode => masterFrameSection_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameSection_insert'] = masterFrameSection_insert.toJson();
    return json;
  }

  SeedFrameSection4Data({
    required this.masterFrameSection_insert,
  });
}

