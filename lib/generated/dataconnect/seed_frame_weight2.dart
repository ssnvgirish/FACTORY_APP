part of 'default.dart';

class SeedFrameWeight2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameWeight2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameWeight2Data> dataDeserializer = (dynamic json)  => SeedFrameWeight2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameWeight2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameWeight2Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameWeight2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameWeight2FrameProductionWeightReportInsert {
  final String id;
  SeedFrameWeight2FrameProductionWeightReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameWeight2FrameProductionWeightReportInsert otherTyped = other as SeedFrameWeight2FrameProductionWeightReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameWeight2FrameProductionWeightReportInsert({
    required this.id,
  });
}

@immutable
class SeedFrameWeight2Data {
  final SeedFrameWeight2FrameProductionWeightReportInsert frameProductionWeightReport_insert;
  SeedFrameWeight2Data.fromJson(dynamic json):
  
  frameProductionWeightReport_insert = SeedFrameWeight2FrameProductionWeightReportInsert.fromJson(json['frameProductionWeightReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameWeight2Data otherTyped = other as SeedFrameWeight2Data;
    return frameProductionWeightReport_insert == otherTyped.frameProductionWeightReport_insert;
    
  }
  @override
  int get hashCode => frameProductionWeightReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameProductionWeightReport_insert'] = frameProductionWeightReport_insert.toJson();
    return json;
  }

  SeedFrameWeight2Data({
    required this.frameProductionWeightReport_insert,
  });
}

