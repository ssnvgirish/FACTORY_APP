part of 'default.dart';

class SeedScrapTools3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapTools3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapTools3Data> dataDeserializer = (dynamic json)  => SeedScrapTools3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapTools3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapTools3Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapTools3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapTools3ScrapToolsCountReportInsert {
  final String id;
  SeedScrapTools3ScrapToolsCountReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapTools3ScrapToolsCountReportInsert otherTyped = other as SeedScrapTools3ScrapToolsCountReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapTools3ScrapToolsCountReportInsert({
    required this.id,
  });
}

@immutable
class SeedScrapTools3Data {
  final SeedScrapTools3ScrapToolsCountReportInsert scrapToolsCountReport_insert;
  SeedScrapTools3Data.fromJson(dynamic json):
  
  scrapToolsCountReport_insert = SeedScrapTools3ScrapToolsCountReportInsert.fromJson(json['scrapToolsCountReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapTools3Data otherTyped = other as SeedScrapTools3Data;
    return scrapToolsCountReport_insert == otherTyped.scrapToolsCountReport_insert;
    
  }
  @override
  int get hashCode => scrapToolsCountReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapToolsCountReport_insert'] = scrapToolsCountReport_insert.toJson();
    return json;
  }

  SeedScrapTools3Data({
    required this.scrapToolsCountReport_insert,
  });
}

