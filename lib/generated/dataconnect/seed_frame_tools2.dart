part of 'default.dart';

class SeedFrameTools2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameTools2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameTools2Data> dataDeserializer = (dynamic json)  => SeedFrameTools2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameTools2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameTools2Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameTools2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameTools2FrameToolsCountReportInsert {
  final String id;
  SeedFrameTools2FrameToolsCountReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameTools2FrameToolsCountReportInsert otherTyped = other as SeedFrameTools2FrameToolsCountReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameTools2FrameToolsCountReportInsert({
    required this.id,
  });
}

@immutable
class SeedFrameTools2Data {
  final SeedFrameTools2FrameToolsCountReportInsert frameToolsCountReport_insert;
  SeedFrameTools2Data.fromJson(dynamic json):
  
  frameToolsCountReport_insert = SeedFrameTools2FrameToolsCountReportInsert.fromJson(json['frameToolsCountReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameTools2Data otherTyped = other as SeedFrameTools2Data;
    return frameToolsCountReport_insert == otherTyped.frameToolsCountReport_insert;
    
  }
  @override
  int get hashCode => frameToolsCountReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameToolsCountReport_insert'] = frameToolsCountReport_insert.toJson();
    return json;
  }

  SeedFrameTools2Data({
    required this.frameToolsCountReport_insert,
  });
}

