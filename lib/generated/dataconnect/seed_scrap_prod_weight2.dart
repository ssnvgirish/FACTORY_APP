part of 'default.dart';

class SeedScrapProdWeight2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapProdWeight2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapProdWeight2Data> dataDeserializer = (dynamic json)  => SeedScrapProdWeight2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapProdWeight2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapProdWeight2Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapProdWeight2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapProdWeight2ScrapProductionWeightReportInsert {
  final String id;
  SeedScrapProdWeight2ScrapProductionWeightReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapProdWeight2ScrapProductionWeightReportInsert otherTyped = other as SeedScrapProdWeight2ScrapProductionWeightReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapProdWeight2ScrapProductionWeightReportInsert({
    required this.id,
  });
}

@immutable
class SeedScrapProdWeight2Data {
  final SeedScrapProdWeight2ScrapProductionWeightReportInsert scrapProductionWeightReport_insert;
  SeedScrapProdWeight2Data.fromJson(dynamic json):
  
  scrapProductionWeightReport_insert = SeedScrapProdWeight2ScrapProductionWeightReportInsert.fromJson(json['scrapProductionWeightReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapProdWeight2Data otherTyped = other as SeedScrapProdWeight2Data;
    return scrapProductionWeightReport_insert == otherTyped.scrapProductionWeightReport_insert;
    
  }
  @override
  int get hashCode => scrapProductionWeightReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapProductionWeightReport_insert'] = scrapProductionWeightReport_insert.toJson();
    return json;
  }

  SeedScrapProdWeight2Data({
    required this.scrapProductionWeightReport_insert,
  });
}

