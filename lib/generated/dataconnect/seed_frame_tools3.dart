part of 'default.dart';

class SeedFrameTools3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameTools3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameTools3Data> dataDeserializer = (dynamic json)  => SeedFrameTools3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameTools3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameTools3Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameTools3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameTools3FrameToolsCountReportInsert {
  final String id;
  SeedFrameTools3FrameToolsCountReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameTools3FrameToolsCountReportInsert otherTyped = other as SeedFrameTools3FrameToolsCountReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameTools3FrameToolsCountReportInsert({
    required this.id,
  });
}

@immutable
class SeedFrameTools3Data {
  final SeedFrameTools3FrameToolsCountReportInsert frameToolsCountReport_insert;
  SeedFrameTools3Data.fromJson(dynamic json):
  
  frameToolsCountReport_insert = SeedFrameTools3FrameToolsCountReportInsert.fromJson(json['frameToolsCountReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameTools3Data otherTyped = other as SeedFrameTools3Data;
    return frameToolsCountReport_insert == otherTyped.frameToolsCountReport_insert;
    
  }
  @override
  int get hashCode => frameToolsCountReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameToolsCountReport_insert'] = frameToolsCountReport_insert.toJson();
    return json;
  }

  SeedFrameTools3Data({
    required this.frameToolsCountReport_insert,
  });
}

