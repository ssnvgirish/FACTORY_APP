part of 'default.dart';

class SeedFrameWriting1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameWriting1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameWriting1Data> dataDeserializer = (dynamic json)  => SeedFrameWriting1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameWriting1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameWriting1Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameWriting1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameWriting1FrameWritingEfficiencyInsert {
  final String id;
  SeedFrameWriting1FrameWritingEfficiencyInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameWriting1FrameWritingEfficiencyInsert otherTyped = other as SeedFrameWriting1FrameWritingEfficiencyInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameWriting1FrameWritingEfficiencyInsert({
    required this.id,
  });
}

@immutable
class SeedFrameWriting1Data {
  final SeedFrameWriting1FrameWritingEfficiencyInsert frameWritingEfficiency_insert;
  SeedFrameWriting1Data.fromJson(dynamic json):
  
  frameWritingEfficiency_insert = SeedFrameWriting1FrameWritingEfficiencyInsert.fromJson(json['frameWritingEfficiency_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameWriting1Data otherTyped = other as SeedFrameWriting1Data;
    return frameWritingEfficiency_insert == otherTyped.frameWritingEfficiency_insert;
    
  }
  @override
  int get hashCode => frameWritingEfficiency_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameWritingEfficiency_insert'] = frameWritingEfficiency_insert.toJson();
    return json;
  }

  SeedFrameWriting1Data({
    required this.frameWritingEfficiency_insert,
  });
}

