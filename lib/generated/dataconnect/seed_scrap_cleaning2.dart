part of 'default.dart';

class SeedScrapCleaning2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapCleaning2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapCleaning2Data> dataDeserializer = (dynamic json)  => SeedScrapCleaning2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapCleaning2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapCleaning2Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapCleaning2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapCleaning2ScrapCleaningReportInsert {
  final String id;
  SeedScrapCleaning2ScrapCleaningReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapCleaning2ScrapCleaningReportInsert otherTyped = other as SeedScrapCleaning2ScrapCleaningReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapCleaning2ScrapCleaningReportInsert({
    required this.id,
  });
}

@immutable
class SeedScrapCleaning2Data {
  final SeedScrapCleaning2ScrapCleaningReportInsert scrapCleaningReport_insert;
  SeedScrapCleaning2Data.fromJson(dynamic json):
  
  scrapCleaningReport_insert = SeedScrapCleaning2ScrapCleaningReportInsert.fromJson(json['scrapCleaningReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapCleaning2Data otherTyped = other as SeedScrapCleaning2Data;
    return scrapCleaningReport_insert == otherTyped.scrapCleaningReport_insert;
    
  }
  @override
  int get hashCode => scrapCleaningReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapCleaningReport_insert'] = scrapCleaningReport_insert.toJson();
    return json;
  }

  SeedScrapCleaning2Data({
    required this.scrapCleaningReport_insert,
  });
}

