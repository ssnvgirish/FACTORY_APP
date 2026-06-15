part of 'default.dart';

class SeedFrameWeight3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameWeight3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameWeight3Data> dataDeserializer = (dynamic json)  => SeedFrameWeight3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameWeight3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameWeight3Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameWeight3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameWeight3FrameProductionWeightReportInsert {
  final String id;
  SeedFrameWeight3FrameProductionWeightReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameWeight3FrameProductionWeightReportInsert otherTyped = other as SeedFrameWeight3FrameProductionWeightReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameWeight3FrameProductionWeightReportInsert({
    required this.id,
  });
}

@immutable
class SeedFrameWeight3Data {
  final SeedFrameWeight3FrameProductionWeightReportInsert frameProductionWeightReport_insert;
  SeedFrameWeight3Data.fromJson(dynamic json):
  
  frameProductionWeightReport_insert = SeedFrameWeight3FrameProductionWeightReportInsert.fromJson(json['frameProductionWeightReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameWeight3Data otherTyped = other as SeedFrameWeight3Data;
    return frameProductionWeightReport_insert == otherTyped.frameProductionWeightReport_insert;
    
  }
  @override
  int get hashCode => frameProductionWeightReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameProductionWeightReport_insert'] = frameProductionWeightReport_insert.toJson();
    return json;
  }

  SeedFrameWeight3Data({
    required this.frameProductionWeightReport_insert,
  });
}

