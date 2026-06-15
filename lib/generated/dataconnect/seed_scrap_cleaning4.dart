part of 'default.dart';

class SeedScrapCleaning4VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapCleaning4VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapCleaning4Data> dataDeserializer = (dynamic json)  => SeedScrapCleaning4Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapCleaning4Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapCleaning4Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapCleaning4", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapCleaning4ScrapCleaningReportInsert {
  final String id;
  SeedScrapCleaning4ScrapCleaningReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapCleaning4ScrapCleaningReportInsert otherTyped = other as SeedScrapCleaning4ScrapCleaningReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapCleaning4ScrapCleaningReportInsert({
    required this.id,
  });
}

@immutable
class SeedScrapCleaning4Data {
  final SeedScrapCleaning4ScrapCleaningReportInsert scrapCleaningReport_insert;
  SeedScrapCleaning4Data.fromJson(dynamic json):
  
  scrapCleaningReport_insert = SeedScrapCleaning4ScrapCleaningReportInsert.fromJson(json['scrapCleaningReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapCleaning4Data otherTyped = other as SeedScrapCleaning4Data;
    return scrapCleaningReport_insert == otherTyped.scrapCleaningReport_insert;
    
  }
  @override
  int get hashCode => scrapCleaningReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapCleaningReport_insert'] = scrapCleaningReport_insert.toJson();
    return json;
  }

  SeedScrapCleaning4Data({
    required this.scrapCleaningReport_insert,
  });
}

