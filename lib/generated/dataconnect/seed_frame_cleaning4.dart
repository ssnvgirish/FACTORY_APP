part of 'default.dart';

class SeedFrameCleaning4VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameCleaning4VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameCleaning4Data> dataDeserializer = (dynamic json)  => SeedFrameCleaning4Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameCleaning4Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameCleaning4Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameCleaning4", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameCleaning4FrameCleaningReportInsert {
  final String id;
  SeedFrameCleaning4FrameCleaningReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameCleaning4FrameCleaningReportInsert otherTyped = other as SeedFrameCleaning4FrameCleaningReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameCleaning4FrameCleaningReportInsert({
    required this.id,
  });
}

@immutable
class SeedFrameCleaning4Data {
  final SeedFrameCleaning4FrameCleaningReportInsert frameCleaningReport_insert;
  SeedFrameCleaning4Data.fromJson(dynamic json):
  
  frameCleaningReport_insert = SeedFrameCleaning4FrameCleaningReportInsert.fromJson(json['frameCleaningReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameCleaning4Data otherTyped = other as SeedFrameCleaning4Data;
    return frameCleaningReport_insert == otherTyped.frameCleaningReport_insert;
    
  }
  @override
  int get hashCode => frameCleaningReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameCleaningReport_insert'] = frameCleaningReport_insert.toJson();
    return json;
  }

  SeedFrameCleaning4Data({
    required this.frameCleaningReport_insert,
  });
}

