part of 'default.dart';

class SeedFrameHealth3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameHealth3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameHealth3Data> dataDeserializer = (dynamic json)  => SeedFrameHealth3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameHealth3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameHealth3Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameHealth3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameHealth3FrameHealthReportInsert {
  final String id;
  SeedFrameHealth3FrameHealthReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameHealth3FrameHealthReportInsert otherTyped = other as SeedFrameHealth3FrameHealthReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameHealth3FrameHealthReportInsert({
    required this.id,
  });
}

@immutable
class SeedFrameHealth3Data {
  final SeedFrameHealth3FrameHealthReportInsert frameHealthReport_insert;
  SeedFrameHealth3Data.fromJson(dynamic json):
  
  frameHealthReport_insert = SeedFrameHealth3FrameHealthReportInsert.fromJson(json['frameHealthReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameHealth3Data otherTyped = other as SeedFrameHealth3Data;
    return frameHealthReport_insert == otherTyped.frameHealthReport_insert;
    
  }
  @override
  int get hashCode => frameHealthReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameHealthReport_insert'] = frameHealthReport_insert.toJson();
    return json;
  }

  SeedFrameHealth3Data({
    required this.frameHealthReport_insert,
  });
}

