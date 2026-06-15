part of 'default.dart';

class SeedFrameCleaning3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameCleaning3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameCleaning3Data> dataDeserializer = (dynamic json)  => SeedFrameCleaning3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameCleaning3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameCleaning3Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameCleaning3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameCleaning3FrameCleaningReportInsert {
  final String id;
  SeedFrameCleaning3FrameCleaningReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameCleaning3FrameCleaningReportInsert otherTyped = other as SeedFrameCleaning3FrameCleaningReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameCleaning3FrameCleaningReportInsert({
    required this.id,
  });
}

@immutable
class SeedFrameCleaning3Data {
  final SeedFrameCleaning3FrameCleaningReportInsert frameCleaningReport_insert;
  SeedFrameCleaning3Data.fromJson(dynamic json):
  
  frameCleaningReport_insert = SeedFrameCleaning3FrameCleaningReportInsert.fromJson(json['frameCleaningReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameCleaning3Data otherTyped = other as SeedFrameCleaning3Data;
    return frameCleaningReport_insert == otherTyped.frameCleaningReport_insert;
    
  }
  @override
  int get hashCode => frameCleaningReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameCleaningReport_insert'] = frameCleaningReport_insert.toJson();
    return json;
  }

  SeedFrameCleaning3Data({
    required this.frameCleaningReport_insert,
  });
}

