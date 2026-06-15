part of 'default.dart';

class SeedFrameSection2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameSection2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameSection2Data> dataDeserializer = (dynamic json)  => SeedFrameSection2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameSection2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameSection2Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameSection2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameSection2MasterFrameSectionInsert {
  final String id;
  SeedFrameSection2MasterFrameSectionInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameSection2MasterFrameSectionInsert otherTyped = other as SeedFrameSection2MasterFrameSectionInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameSection2MasterFrameSectionInsert({
    required this.id,
  });
}

@immutable
class SeedFrameSection2Data {
  final SeedFrameSection2MasterFrameSectionInsert masterFrameSection_insert;
  SeedFrameSection2Data.fromJson(dynamic json):
  
  masterFrameSection_insert = SeedFrameSection2MasterFrameSectionInsert.fromJson(json['masterFrameSection_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameSection2Data otherTyped = other as SeedFrameSection2Data;
    return masterFrameSection_insert == otherTyped.masterFrameSection_insert;
    
  }
  @override
  int get hashCode => masterFrameSection_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameSection_insert'] = masterFrameSection_insert.toJson();
    return json;
  }

  SeedFrameSection2Data({
    required this.masterFrameSection_insert,
  });
}

