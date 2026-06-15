part of 'default.dart';

class SeedFrameWriting2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameWriting2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameWriting2Data> dataDeserializer = (dynamic json)  => SeedFrameWriting2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameWriting2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameWriting2Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameWriting2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameWriting2FrameWritingEfficiencyInsert {
  final String id;
  SeedFrameWriting2FrameWritingEfficiencyInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameWriting2FrameWritingEfficiencyInsert otherTyped = other as SeedFrameWriting2FrameWritingEfficiencyInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameWriting2FrameWritingEfficiencyInsert({
    required this.id,
  });
}

@immutable
class SeedFrameWriting2Data {
  final SeedFrameWriting2FrameWritingEfficiencyInsert frameWritingEfficiency_insert;
  SeedFrameWriting2Data.fromJson(dynamic json):
  
  frameWritingEfficiency_insert = SeedFrameWriting2FrameWritingEfficiencyInsert.fromJson(json['frameWritingEfficiency_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameWriting2Data otherTyped = other as SeedFrameWriting2Data;
    return frameWritingEfficiency_insert == otherTyped.frameWritingEfficiency_insert;
    
  }
  @override
  int get hashCode => frameWritingEfficiency_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameWritingEfficiency_insert'] = frameWritingEfficiency_insert.toJson();
    return json;
  }

  SeedFrameWriting2Data({
    required this.frameWritingEfficiency_insert,
  });
}

