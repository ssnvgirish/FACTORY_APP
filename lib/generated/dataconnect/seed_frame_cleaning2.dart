part of 'default.dart';

class SeedFrameCleaning2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameCleaning2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameCleaning2Data> dataDeserializer = (dynamic json)  => SeedFrameCleaning2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameCleaning2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameCleaning2Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameCleaning2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameCleaning2FrameCleaningReportInsert {
  final String id;
  SeedFrameCleaning2FrameCleaningReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameCleaning2FrameCleaningReportInsert otherTyped = other as SeedFrameCleaning2FrameCleaningReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameCleaning2FrameCleaningReportInsert({
    required this.id,
  });
}

@immutable
class SeedFrameCleaning2Data {
  final SeedFrameCleaning2FrameCleaningReportInsert frameCleaningReport_insert;
  SeedFrameCleaning2Data.fromJson(dynamic json):
  
  frameCleaningReport_insert = SeedFrameCleaning2FrameCleaningReportInsert.fromJson(json['frameCleaningReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameCleaning2Data otherTyped = other as SeedFrameCleaning2Data;
    return frameCleaningReport_insert == otherTyped.frameCleaningReport_insert;
    
  }
  @override
  int get hashCode => frameCleaningReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameCleaningReport_insert'] = frameCleaningReport_insert.toJson();
    return json;
  }

  SeedFrameCleaning2Data({
    required this.frameCleaningReport_insert,
  });
}

