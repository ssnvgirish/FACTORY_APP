part of 'default.dart';

class SeedFrameSection1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameSection1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameSection1Data> dataDeserializer = (dynamic json)  => SeedFrameSection1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameSection1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameSection1Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameSection1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameSection1MasterFrameSectionInsert {
  final String id;
  SeedFrameSection1MasterFrameSectionInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameSection1MasterFrameSectionInsert otherTyped = other as SeedFrameSection1MasterFrameSectionInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameSection1MasterFrameSectionInsert({
    required this.id,
  });
}

@immutable
class SeedFrameSection1Data {
  final SeedFrameSection1MasterFrameSectionInsert masterFrameSection_insert;
  SeedFrameSection1Data.fromJson(dynamic json):
  
  masterFrameSection_insert = SeedFrameSection1MasterFrameSectionInsert.fromJson(json['masterFrameSection_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameSection1Data otherTyped = other as SeedFrameSection1Data;
    return masterFrameSection_insert == otherTyped.masterFrameSection_insert;
    
  }
  @override
  int get hashCode => masterFrameSection_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameSection_insert'] = masterFrameSection_insert.toJson();
    return json;
  }

  SeedFrameSection1Data({
    required this.masterFrameSection_insert,
  });
}

