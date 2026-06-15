part of 'default.dart';

class SeedScrapProdWeight1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapProdWeight1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapProdWeight1Data> dataDeserializer = (dynamic json)  => SeedScrapProdWeight1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapProdWeight1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapProdWeight1Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapProdWeight1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapProdWeight1ScrapProductionWeightReportInsert {
  final String id;
  SeedScrapProdWeight1ScrapProductionWeightReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapProdWeight1ScrapProductionWeightReportInsert otherTyped = other as SeedScrapProdWeight1ScrapProductionWeightReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapProdWeight1ScrapProductionWeightReportInsert({
    required this.id,
  });
}

@immutable
class SeedScrapProdWeight1Data {
  final SeedScrapProdWeight1ScrapProductionWeightReportInsert scrapProductionWeightReport_insert;
  SeedScrapProdWeight1Data.fromJson(dynamic json):
  
  scrapProductionWeightReport_insert = SeedScrapProdWeight1ScrapProductionWeightReportInsert.fromJson(json['scrapProductionWeightReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapProdWeight1Data otherTyped = other as SeedScrapProdWeight1Data;
    return scrapProductionWeightReport_insert == otherTyped.scrapProductionWeightReport_insert;
    
  }
  @override
  int get hashCode => scrapProductionWeightReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapProductionWeightReport_insert'] = scrapProductionWeightReport_insert.toJson();
    return json;
  }

  SeedScrapProdWeight1Data({
    required this.scrapProductionWeightReport_insert,
  });
}

