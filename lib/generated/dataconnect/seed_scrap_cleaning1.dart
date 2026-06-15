part of 'default.dart';

class SeedScrapCleaning1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapCleaning1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapCleaning1Data> dataDeserializer = (dynamic json)  => SeedScrapCleaning1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapCleaning1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapCleaning1Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapCleaning1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapCleaning1ScrapCleaningReportInsert {
  final String id;
  SeedScrapCleaning1ScrapCleaningReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapCleaning1ScrapCleaningReportInsert otherTyped = other as SeedScrapCleaning1ScrapCleaningReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapCleaning1ScrapCleaningReportInsert({
    required this.id,
  });
}

@immutable
class SeedScrapCleaning1Data {
  final SeedScrapCleaning1ScrapCleaningReportInsert scrapCleaningReport_insert;
  SeedScrapCleaning1Data.fromJson(dynamic json):
  
  scrapCleaningReport_insert = SeedScrapCleaning1ScrapCleaningReportInsert.fromJson(json['scrapCleaningReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapCleaning1Data otherTyped = other as SeedScrapCleaning1Data;
    return scrapCleaningReport_insert == otherTyped.scrapCleaningReport_insert;
    
  }
  @override
  int get hashCode => scrapCleaningReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapCleaningReport_insert'] = scrapCleaningReport_insert.toJson();
    return json;
  }

  SeedScrapCleaning1Data({
    required this.scrapCleaningReport_insert,
  });
}

