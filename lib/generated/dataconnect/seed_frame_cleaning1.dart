part of 'default.dart';

class SeedFrameCleaning1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameCleaning1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameCleaning1Data> dataDeserializer = (dynamic json)  => SeedFrameCleaning1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameCleaning1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameCleaning1Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameCleaning1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameCleaning1FrameCleaningReportInsert {
  final String id;
  SeedFrameCleaning1FrameCleaningReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameCleaning1FrameCleaningReportInsert otherTyped = other as SeedFrameCleaning1FrameCleaningReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameCleaning1FrameCleaningReportInsert({
    required this.id,
  });
}

@immutable
class SeedFrameCleaning1Data {
  final SeedFrameCleaning1FrameCleaningReportInsert frameCleaningReport_insert;
  SeedFrameCleaning1Data.fromJson(dynamic json):
  
  frameCleaningReport_insert = SeedFrameCleaning1FrameCleaningReportInsert.fromJson(json['frameCleaningReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameCleaning1Data otherTyped = other as SeedFrameCleaning1Data;
    return frameCleaningReport_insert == otherTyped.frameCleaningReport_insert;
    
  }
  @override
  int get hashCode => frameCleaningReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameCleaningReport_insert'] = frameCleaningReport_insert.toJson();
    return json;
  }

  SeedFrameCleaning1Data({
    required this.frameCleaningReport_insert,
  });
}

