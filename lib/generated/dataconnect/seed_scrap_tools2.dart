part of 'default.dart';

class SeedScrapTools2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapTools2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapTools2Data> dataDeserializer = (dynamic json)  => SeedScrapTools2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapTools2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapTools2Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapTools2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapTools2ScrapToolsCountReportInsert {
  final String id;
  SeedScrapTools2ScrapToolsCountReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapTools2ScrapToolsCountReportInsert otherTyped = other as SeedScrapTools2ScrapToolsCountReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapTools2ScrapToolsCountReportInsert({
    required this.id,
  });
}

@immutable
class SeedScrapTools2Data {
  final SeedScrapTools2ScrapToolsCountReportInsert scrapToolsCountReport_insert;
  SeedScrapTools2Data.fromJson(dynamic json):
  
  scrapToolsCountReport_insert = SeedScrapTools2ScrapToolsCountReportInsert.fromJson(json['scrapToolsCountReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapTools2Data otherTyped = other as SeedScrapTools2Data;
    return scrapToolsCountReport_insert == otherTyped.scrapToolsCountReport_insert;
    
  }
  @override
  int get hashCode => scrapToolsCountReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapToolsCountReport_insert'] = scrapToolsCountReport_insert.toJson();
    return json;
  }

  SeedScrapTools2Data({
    required this.scrapToolsCountReport_insert,
  });
}

