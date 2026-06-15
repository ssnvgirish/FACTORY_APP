part of 'default.dart';

class SeedScrapWriting1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapWriting1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapWriting1Data> dataDeserializer = (dynamic json)  => SeedScrapWriting1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapWriting1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapWriting1Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapWriting1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapWriting1ScrapWritingEfficiencyInsert {
  final String id;
  SeedScrapWriting1ScrapWritingEfficiencyInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapWriting1ScrapWritingEfficiencyInsert otherTyped = other as SeedScrapWriting1ScrapWritingEfficiencyInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapWriting1ScrapWritingEfficiencyInsert({
    required this.id,
  });
}

@immutable
class SeedScrapWriting1Data {
  final SeedScrapWriting1ScrapWritingEfficiencyInsert scrapWritingEfficiency_insert;
  SeedScrapWriting1Data.fromJson(dynamic json):
  
  scrapWritingEfficiency_insert = SeedScrapWriting1ScrapWritingEfficiencyInsert.fromJson(json['scrapWritingEfficiency_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapWriting1Data otherTyped = other as SeedScrapWriting1Data;
    return scrapWritingEfficiency_insert == otherTyped.scrapWritingEfficiency_insert;
    
  }
  @override
  int get hashCode => scrapWritingEfficiency_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapWritingEfficiency_insert'] = scrapWritingEfficiency_insert.toJson();
    return json;
  }

  SeedScrapWriting1Data({
    required this.scrapWritingEfficiency_insert,
  });
}

