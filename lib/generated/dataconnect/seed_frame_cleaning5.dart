part of 'default.dart';

class SeedFrameCleaning5VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameCleaning5VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameCleaning5Data> dataDeserializer = (dynamic json)  => SeedFrameCleaning5Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameCleaning5Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameCleaning5Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameCleaning5", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameCleaning5FrameCleaningReportInsert {
  final String id;
  SeedFrameCleaning5FrameCleaningReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameCleaning5FrameCleaningReportInsert otherTyped = other as SeedFrameCleaning5FrameCleaningReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameCleaning5FrameCleaningReportInsert({
    required this.id,
  });
}

@immutable
class SeedFrameCleaning5Data {
  final SeedFrameCleaning5FrameCleaningReportInsert frameCleaningReport_insert;
  SeedFrameCleaning5Data.fromJson(dynamic json):
  
  frameCleaningReport_insert = SeedFrameCleaning5FrameCleaningReportInsert.fromJson(json['frameCleaningReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameCleaning5Data otherTyped = other as SeedFrameCleaning5Data;
    return frameCleaningReport_insert == otherTyped.frameCleaningReport_insert;
    
  }
  @override
  int get hashCode => frameCleaningReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameCleaningReport_insert'] = frameCleaningReport_insert.toJson();
    return json;
  }

  SeedFrameCleaning5Data({
    required this.frameCleaningReport_insert,
  });
}

