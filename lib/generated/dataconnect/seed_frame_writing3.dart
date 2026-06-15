part of 'default.dart';

class SeedFrameWriting3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameWriting3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameWriting3Data> dataDeserializer = (dynamic json)  => SeedFrameWriting3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameWriting3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameWriting3Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameWriting3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameWriting3FrameWritingEfficiencyInsert {
  final String id;
  SeedFrameWriting3FrameWritingEfficiencyInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameWriting3FrameWritingEfficiencyInsert otherTyped = other as SeedFrameWriting3FrameWritingEfficiencyInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameWriting3FrameWritingEfficiencyInsert({
    required this.id,
  });
}

@immutable
class SeedFrameWriting3Data {
  final SeedFrameWriting3FrameWritingEfficiencyInsert frameWritingEfficiency_insert;
  SeedFrameWriting3Data.fromJson(dynamic json):
  
  frameWritingEfficiency_insert = SeedFrameWriting3FrameWritingEfficiencyInsert.fromJson(json['frameWritingEfficiency_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameWriting3Data otherTyped = other as SeedFrameWriting3Data;
    return frameWritingEfficiency_insert == otherTyped.frameWritingEfficiency_insert;
    
  }
  @override
  int get hashCode => frameWritingEfficiency_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameWritingEfficiency_insert'] = frameWritingEfficiency_insert.toJson();
    return json;
  }

  SeedFrameWriting3Data({
    required this.frameWritingEfficiency_insert,
  });
}

