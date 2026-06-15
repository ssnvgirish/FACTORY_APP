part of 'default.dart';

class SeedFrameSection6VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameSection6VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameSection6Data> dataDeserializer = (dynamic json)  => SeedFrameSection6Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameSection6Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameSection6Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameSection6", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameSection6MasterFrameSectionInsert {
  final String id;
  SeedFrameSection6MasterFrameSectionInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameSection6MasterFrameSectionInsert otherTyped = other as SeedFrameSection6MasterFrameSectionInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameSection6MasterFrameSectionInsert({
    required this.id,
  });
}

@immutable
class SeedFrameSection6Data {
  final SeedFrameSection6MasterFrameSectionInsert masterFrameSection_insert;
  SeedFrameSection6Data.fromJson(dynamic json):
  
  masterFrameSection_insert = SeedFrameSection6MasterFrameSectionInsert.fromJson(json['masterFrameSection_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameSection6Data otherTyped = other as SeedFrameSection6Data;
    return masterFrameSection_insert == otherTyped.masterFrameSection_insert;
    
  }
  @override
  int get hashCode => masterFrameSection_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameSection_insert'] = masterFrameSection_insert.toJson();
    return json;
  }

  SeedFrameSection6Data({
    required this.masterFrameSection_insert,
  });
}

