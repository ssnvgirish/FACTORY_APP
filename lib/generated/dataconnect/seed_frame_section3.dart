part of 'default.dart';

class SeedFrameSection3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameSection3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameSection3Data> dataDeserializer = (dynamic json)  => SeedFrameSection3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameSection3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameSection3Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameSection3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameSection3MasterFrameSectionInsert {
  final String id;
  SeedFrameSection3MasterFrameSectionInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameSection3MasterFrameSectionInsert otherTyped = other as SeedFrameSection3MasterFrameSectionInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameSection3MasterFrameSectionInsert({
    required this.id,
  });
}

@immutable
class SeedFrameSection3Data {
  final SeedFrameSection3MasterFrameSectionInsert masterFrameSection_insert;
  SeedFrameSection3Data.fromJson(dynamic json):
  
  masterFrameSection_insert = SeedFrameSection3MasterFrameSectionInsert.fromJson(json['masterFrameSection_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameSection3Data otherTyped = other as SeedFrameSection3Data;
    return masterFrameSection_insert == otherTyped.masterFrameSection_insert;
    
  }
  @override
  int get hashCode => masterFrameSection_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameSection_insert'] = masterFrameSection_insert.toJson();
    return json;
  }

  SeedFrameSection3Data({
    required this.masterFrameSection_insert,
  });
}

