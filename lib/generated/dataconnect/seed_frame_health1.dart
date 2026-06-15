part of 'default.dart';

class SeedFrameHealth1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameHealth1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameHealth1Data> dataDeserializer = (dynamic json)  => SeedFrameHealth1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameHealth1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameHealth1Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameHealth1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameHealth1FrameHealthReportInsert {
  final String id;
  SeedFrameHealth1FrameHealthReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameHealth1FrameHealthReportInsert otherTyped = other as SeedFrameHealth1FrameHealthReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameHealth1FrameHealthReportInsert({
    required this.id,
  });
}

@immutable
class SeedFrameHealth1Data {
  final SeedFrameHealth1FrameHealthReportInsert frameHealthReport_insert;
  SeedFrameHealth1Data.fromJson(dynamic json):
  
  frameHealthReport_insert = SeedFrameHealth1FrameHealthReportInsert.fromJson(json['frameHealthReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameHealth1Data otherTyped = other as SeedFrameHealth1Data;
    return frameHealthReport_insert == otherTyped.frameHealthReport_insert;
    
  }
  @override
  int get hashCode => frameHealthReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameHealthReport_insert'] = frameHealthReport_insert.toJson();
    return json;
  }

  SeedFrameHealth1Data({
    required this.frameHealthReport_insert,
  });
}

