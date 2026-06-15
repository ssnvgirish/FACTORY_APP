part of 'default.dart';

class SeedFrameTools1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameTools1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameTools1Data> dataDeserializer = (dynamic json)  => SeedFrameTools1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameTools1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameTools1Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameTools1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameTools1FrameToolsCountReportInsert {
  final String id;
  SeedFrameTools1FrameToolsCountReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameTools1FrameToolsCountReportInsert otherTyped = other as SeedFrameTools1FrameToolsCountReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameTools1FrameToolsCountReportInsert({
    required this.id,
  });
}

@immutable
class SeedFrameTools1Data {
  final SeedFrameTools1FrameToolsCountReportInsert frameToolsCountReport_insert;
  SeedFrameTools1Data.fromJson(dynamic json):
  
  frameToolsCountReport_insert = SeedFrameTools1FrameToolsCountReportInsert.fromJson(json['frameToolsCountReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameTools1Data otherTyped = other as SeedFrameTools1Data;
    return frameToolsCountReport_insert == otherTyped.frameToolsCountReport_insert;
    
  }
  @override
  int get hashCode => frameToolsCountReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameToolsCountReport_insert'] = frameToolsCountReport_insert.toJson();
    return json;
  }

  SeedFrameTools1Data({
    required this.frameToolsCountReport_insert,
  });
}

