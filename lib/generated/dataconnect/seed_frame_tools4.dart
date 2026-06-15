part of 'default.dart';

class SeedFrameTools4VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameTools4VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameTools4Data> dataDeserializer = (dynamic json)  => SeedFrameTools4Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameTools4Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameTools4Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameTools4", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameTools4FrameToolsCountReportInsert {
  final String id;
  SeedFrameTools4FrameToolsCountReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameTools4FrameToolsCountReportInsert otherTyped = other as SeedFrameTools4FrameToolsCountReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameTools4FrameToolsCountReportInsert({
    required this.id,
  });
}

@immutable
class SeedFrameTools4Data {
  final SeedFrameTools4FrameToolsCountReportInsert frameToolsCountReport_insert;
  SeedFrameTools4Data.fromJson(dynamic json):
  
  frameToolsCountReport_insert = SeedFrameTools4FrameToolsCountReportInsert.fromJson(json['frameToolsCountReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameTools4Data otherTyped = other as SeedFrameTools4Data;
    return frameToolsCountReport_insert == otherTyped.frameToolsCountReport_insert;
    
  }
  @override
  int get hashCode => frameToolsCountReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameToolsCountReport_insert'] = frameToolsCountReport_insert.toJson();
    return json;
  }

  SeedFrameTools4Data({
    required this.frameToolsCountReport_insert,
  });
}

