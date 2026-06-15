part of 'default.dart';

class SeedFrameHealth2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameHealth2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameHealth2Data> dataDeserializer = (dynamic json)  => SeedFrameHealth2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameHealth2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameHealth2Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameHealth2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameHealth2FrameHealthReportInsert {
  final String id;
  SeedFrameHealth2FrameHealthReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameHealth2FrameHealthReportInsert otherTyped = other as SeedFrameHealth2FrameHealthReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameHealth2FrameHealthReportInsert({
    required this.id,
  });
}

@immutable
class SeedFrameHealth2Data {
  final SeedFrameHealth2FrameHealthReportInsert frameHealthReport_insert;
  SeedFrameHealth2Data.fromJson(dynamic json):
  
  frameHealthReport_insert = SeedFrameHealth2FrameHealthReportInsert.fromJson(json['frameHealthReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameHealth2Data otherTyped = other as SeedFrameHealth2Data;
    return frameHealthReport_insert == otherTyped.frameHealthReport_insert;
    
  }
  @override
  int get hashCode => frameHealthReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameHealthReport_insert'] = frameHealthReport_insert.toJson();
    return json;
  }

  SeedFrameHealth2Data({
    required this.frameHealthReport_insert,
  });
}

