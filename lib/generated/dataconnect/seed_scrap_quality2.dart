part of 'default.dart';

class SeedScrapQuality2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapQuality2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapQuality2Data> dataDeserializer = (dynamic json)  => SeedScrapQuality2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapQuality2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapQuality2Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapQuality2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapQuality2ScrapQualityReportInsert {
  final String id;
  SeedScrapQuality2ScrapQualityReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapQuality2ScrapQualityReportInsert otherTyped = other as SeedScrapQuality2ScrapQualityReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapQuality2ScrapQualityReportInsert({
    required this.id,
  });
}

@immutable
class SeedScrapQuality2Data {
  final SeedScrapQuality2ScrapQualityReportInsert scrapQualityReport_insert;
  SeedScrapQuality2Data.fromJson(dynamic json):
  
  scrapQualityReport_insert = SeedScrapQuality2ScrapQualityReportInsert.fromJson(json['scrapQualityReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapQuality2Data otherTyped = other as SeedScrapQuality2Data;
    return scrapQualityReport_insert == otherTyped.scrapQualityReport_insert;
    
  }
  @override
  int get hashCode => scrapQualityReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapQualityReport_insert'] = scrapQualityReport_insert.toJson();
    return json;
  }

  SeedScrapQuality2Data({
    required this.scrapQualityReport_insert,
  });
}

