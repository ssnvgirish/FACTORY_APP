part of 'default.dart';

class SeedScrapProdWeight3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapProdWeight3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapProdWeight3Data> dataDeserializer = (dynamic json)  => SeedScrapProdWeight3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapProdWeight3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapProdWeight3Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapProdWeight3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapProdWeight3ScrapProductionWeightReportInsert {
  final String id;
  SeedScrapProdWeight3ScrapProductionWeightReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapProdWeight3ScrapProductionWeightReportInsert otherTyped = other as SeedScrapProdWeight3ScrapProductionWeightReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapProdWeight3ScrapProductionWeightReportInsert({
    required this.id,
  });
}

@immutable
class SeedScrapProdWeight3Data {
  final SeedScrapProdWeight3ScrapProductionWeightReportInsert scrapProductionWeightReport_insert;
  SeedScrapProdWeight3Data.fromJson(dynamic json):
  
  scrapProductionWeightReport_insert = SeedScrapProdWeight3ScrapProductionWeightReportInsert.fromJson(json['scrapProductionWeightReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapProdWeight3Data otherTyped = other as SeedScrapProdWeight3Data;
    return scrapProductionWeightReport_insert == otherTyped.scrapProductionWeightReport_insert;
    
  }
  @override
  int get hashCode => scrapProductionWeightReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapProductionWeightReport_insert'] = scrapProductionWeightReport_insert.toJson();
    return json;
  }

  SeedScrapProdWeight3Data({
    required this.scrapProductionWeightReport_insert,
  });
}

