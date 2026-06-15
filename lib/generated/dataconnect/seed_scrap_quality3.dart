part of 'default.dart';

class SeedScrapQuality3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapQuality3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapQuality3Data> dataDeserializer = (dynamic json)  => SeedScrapQuality3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapQuality3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapQuality3Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapQuality3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapQuality3ScrapQualityReportInsert {
  final String id;
  SeedScrapQuality3ScrapQualityReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapQuality3ScrapQualityReportInsert otherTyped = other as SeedScrapQuality3ScrapQualityReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapQuality3ScrapQualityReportInsert({
    required this.id,
  });
}

@immutable
class SeedScrapQuality3Data {
  final SeedScrapQuality3ScrapQualityReportInsert scrapQualityReport_insert;
  SeedScrapQuality3Data.fromJson(dynamic json):
  
  scrapQualityReport_insert = SeedScrapQuality3ScrapQualityReportInsert.fromJson(json['scrapQualityReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapQuality3Data otherTyped = other as SeedScrapQuality3Data;
    return scrapQualityReport_insert == otherTyped.scrapQualityReport_insert;
    
  }
  @override
  int get hashCode => scrapQualityReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapQualityReport_insert'] = scrapQualityReport_insert.toJson();
    return json;
  }

  SeedScrapQuality3Data({
    required this.scrapQualityReport_insert,
  });
}

