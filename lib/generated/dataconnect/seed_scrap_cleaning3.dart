part of 'default.dart';

class SeedScrapCleaning3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapCleaning3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapCleaning3Data> dataDeserializer = (dynamic json)  => SeedScrapCleaning3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapCleaning3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapCleaning3Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapCleaning3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapCleaning3ScrapCleaningReportInsert {
  final String id;
  SeedScrapCleaning3ScrapCleaningReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapCleaning3ScrapCleaningReportInsert otherTyped = other as SeedScrapCleaning3ScrapCleaningReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapCleaning3ScrapCleaningReportInsert({
    required this.id,
  });
}

@immutable
class SeedScrapCleaning3Data {
  final SeedScrapCleaning3ScrapCleaningReportInsert scrapCleaningReport_insert;
  SeedScrapCleaning3Data.fromJson(dynamic json):
  
  scrapCleaningReport_insert = SeedScrapCleaning3ScrapCleaningReportInsert.fromJson(json['scrapCleaningReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapCleaning3Data otherTyped = other as SeedScrapCleaning3Data;
    return scrapCleaningReport_insert == otherTyped.scrapCleaningReport_insert;
    
  }
  @override
  int get hashCode => scrapCleaningReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapCleaningReport_insert'] = scrapCleaningReport_insert.toJson();
    return json;
  }

  SeedScrapCleaning3Data({
    required this.scrapCleaningReport_insert,
  });
}

