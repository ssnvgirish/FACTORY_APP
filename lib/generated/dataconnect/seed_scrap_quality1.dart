part of 'default.dart';

class SeedScrapQuality1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapQuality1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapQuality1Data> dataDeserializer = (dynamic json)  => SeedScrapQuality1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapQuality1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapQuality1Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapQuality1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapQuality1ScrapQualityReportInsert {
  final String id;
  SeedScrapQuality1ScrapQualityReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapQuality1ScrapQualityReportInsert otherTyped = other as SeedScrapQuality1ScrapQualityReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapQuality1ScrapQualityReportInsert({
    required this.id,
  });
}

@immutable
class SeedScrapQuality1Data {
  final SeedScrapQuality1ScrapQualityReportInsert scrapQualityReport_insert;
  SeedScrapQuality1Data.fromJson(dynamic json):
  
  scrapQualityReport_insert = SeedScrapQuality1ScrapQualityReportInsert.fromJson(json['scrapQualityReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapQuality1Data otherTyped = other as SeedScrapQuality1Data;
    return scrapQualityReport_insert == otherTyped.scrapQualityReport_insert;
    
  }
  @override
  int get hashCode => scrapQualityReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapQualityReport_insert'] = scrapQualityReport_insert.toJson();
    return json;
  }

  SeedScrapQuality1Data({
    required this.scrapQualityReport_insert,
  });
}

