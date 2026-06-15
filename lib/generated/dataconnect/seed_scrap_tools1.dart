part of 'default.dart';

class SeedScrapTools1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapTools1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapTools1Data> dataDeserializer = (dynamic json)  => SeedScrapTools1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapTools1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapTools1Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapTools1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapTools1ScrapToolsCountReportInsert {
  final String id;
  SeedScrapTools1ScrapToolsCountReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapTools1ScrapToolsCountReportInsert otherTyped = other as SeedScrapTools1ScrapToolsCountReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapTools1ScrapToolsCountReportInsert({
    required this.id,
  });
}

@immutable
class SeedScrapTools1Data {
  final SeedScrapTools1ScrapToolsCountReportInsert scrapToolsCountReport_insert;
  SeedScrapTools1Data.fromJson(dynamic json):
  
  scrapToolsCountReport_insert = SeedScrapTools1ScrapToolsCountReportInsert.fromJson(json['scrapToolsCountReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapTools1Data otherTyped = other as SeedScrapTools1Data;
    return scrapToolsCountReport_insert == otherTyped.scrapToolsCountReport_insert;
    
  }
  @override
  int get hashCode => scrapToolsCountReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapToolsCountReport_insert'] = scrapToolsCountReport_insert.toJson();
    return json;
  }

  SeedScrapTools1Data({
    required this.scrapToolsCountReport_insert,
  });
}

