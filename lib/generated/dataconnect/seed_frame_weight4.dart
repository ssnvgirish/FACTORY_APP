part of 'default.dart';

class SeedFrameWeight4VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedFrameWeight4VariablesBuilder(this._dataConnect, );
  Deserializer<SeedFrameWeight4Data> dataDeserializer = (dynamic json)  => SeedFrameWeight4Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedFrameWeight4Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedFrameWeight4Data, void> ref() {
    
    return _dataConnect.mutation("SeedFrameWeight4", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedFrameWeight4FrameProductionWeightReportInsert {
  final String id;
  SeedFrameWeight4FrameProductionWeightReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameWeight4FrameProductionWeightReportInsert otherTyped = other as SeedFrameWeight4FrameProductionWeightReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedFrameWeight4FrameProductionWeightReportInsert({
    required this.id,
  });
}

@immutable
class SeedFrameWeight4Data {
  final SeedFrameWeight4FrameProductionWeightReportInsert frameProductionWeightReport_insert;
  SeedFrameWeight4Data.fromJson(dynamic json):
  
  frameProductionWeightReport_insert = SeedFrameWeight4FrameProductionWeightReportInsert.fromJson(json['frameProductionWeightReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedFrameWeight4Data otherTyped = other as SeedFrameWeight4Data;
    return frameProductionWeightReport_insert == otherTyped.frameProductionWeightReport_insert;
    
  }
  @override
  int get hashCode => frameProductionWeightReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameProductionWeightReport_insert'] = frameProductionWeightReport_insert.toJson();
    return json;
  }

  SeedFrameWeight4Data({
    required this.frameProductionWeightReport_insert,
  });
}

