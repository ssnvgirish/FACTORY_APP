part of 'default.dart';

class SeedScrapQuality4VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapQuality4VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapQuality4Data> dataDeserializer = (dynamic json)  => SeedScrapQuality4Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapQuality4Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapQuality4Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapQuality4", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapQuality4ScrapQualityReportInsert {
  final String id;
  SeedScrapQuality4ScrapQualityReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapQuality4ScrapQualityReportInsert otherTyped = other as SeedScrapQuality4ScrapQualityReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapQuality4ScrapQualityReportInsert({
    required this.id,
  });
}

@immutable
class SeedScrapQuality4Data {
  final SeedScrapQuality4ScrapQualityReportInsert scrapQualityReport_insert;
  SeedScrapQuality4Data.fromJson(dynamic json):
  
  scrapQualityReport_insert = SeedScrapQuality4ScrapQualityReportInsert.fromJson(json['scrapQualityReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapQuality4Data otherTyped = other as SeedScrapQuality4Data;
    return scrapQualityReport_insert == otherTyped.scrapQualityReport_insert;
    
  }
  @override
  int get hashCode => scrapQualityReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapQualityReport_insert'] = scrapQualityReport_insert.toJson();
    return json;
  }

  SeedScrapQuality4Data({
    required this.scrapQualityReport_insert,
  });
}

