part of 'default.dart';

class SeedScrapWriting2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapWriting2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapWriting2Data> dataDeserializer = (dynamic json)  => SeedScrapWriting2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapWriting2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapWriting2Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapWriting2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapWriting2ScrapWritingEfficiencyInsert {
  final String id;
  SeedScrapWriting2ScrapWritingEfficiencyInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapWriting2ScrapWritingEfficiencyInsert otherTyped = other as SeedScrapWriting2ScrapWritingEfficiencyInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapWriting2ScrapWritingEfficiencyInsert({
    required this.id,
  });
}

@immutable
class SeedScrapWriting2Data {
  final SeedScrapWriting2ScrapWritingEfficiencyInsert scrapWritingEfficiency_insert;
  SeedScrapWriting2Data.fromJson(dynamic json):
  
  scrapWritingEfficiency_insert = SeedScrapWriting2ScrapWritingEfficiencyInsert.fromJson(json['scrapWritingEfficiency_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapWriting2Data otherTyped = other as SeedScrapWriting2Data;
    return scrapWritingEfficiency_insert == otherTyped.scrapWritingEfficiency_insert;
    
  }
  @override
  int get hashCode => scrapWritingEfficiency_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapWritingEfficiency_insert'] = scrapWritingEfficiency_insert.toJson();
    return json;
  }

  SeedScrapWriting2Data({
    required this.scrapWritingEfficiency_insert,
  });
}

