part of 'default.dart';

class SeedFrameWeight1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameWeight1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameWeight1Data> dataDeserializer = (dynamic json)  => SeedFrameWeight1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameWeight1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameWeight1Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameWeight1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameWeight1FrameProductionWeightReportInsert {
  final String id;
  SeedFrameWeight1FrameProductionWeightReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameWeight1FrameProductionWeightReportInsert otherTyped = other as SeedFrameWeight1FrameProductionWeightReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameWeight1FrameProductionWeightReportInsert({
    required this.id,
  });
}

@immutable
class SeedFrameWeight1Data {
  final SeedFrameWeight1FrameProductionWeightReportInsert frameProductionWeightReport_insert;
  SeedFrameWeight1Data.fromJson(dynamic json):
  
  frameProductionWeightReport_insert = SeedFrameWeight1FrameProductionWeightReportInsert.fromJson(json['frameProductionWeightReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameWeight1Data otherTyped = other as SeedFrameWeight1Data;
    return frameProductionWeightReport_insert == otherTyped.frameProductionWeightReport_insert;
    
  }
  @override
  int get hashCode => frameProductionWeightReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameProductionWeightReport_insert'] = frameProductionWeightReport_insert.toJson();
    return json;
  }

  SeedFrameWeight1Data({
    required this.frameProductionWeightReport_insert,
  });
}

