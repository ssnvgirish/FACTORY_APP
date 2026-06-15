part of 'default.dart';

class SeedFrameSection5VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameSection5VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameSection5Data> dataDeserializer = (dynamic json)  => SeedFrameSection5Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameSection5Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameSection5Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameSection5", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameSection5MasterFrameSectionInsert {
  final String id;
  SeedFrameSection5MasterFrameSectionInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameSection5MasterFrameSectionInsert otherTyped = other as SeedFrameSection5MasterFrameSectionInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameSection5MasterFrameSectionInsert({
    required this.id,
  });
}

@immutable
class SeedFrameSection5Data {
  final SeedFrameSection5MasterFrameSectionInsert masterFrameSection_insert;
  SeedFrameSection5Data.fromJson(dynamic json):
  
  masterFrameSection_insert = SeedFrameSection5MasterFrameSectionInsert.fromJson(json['masterFrameSection_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameSection5Data otherTyped = other as SeedFrameSection5Data;
    return masterFrameSection_insert == otherTyped.masterFrameSection_insert;
    
  }
  @override
  int get hashCode => masterFrameSection_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameSection_insert'] = masterFrameSection_insert.toJson();
    return json;
  }

  SeedFrameSection5Data({
    required this.masterFrameSection_insert,
  });
}

