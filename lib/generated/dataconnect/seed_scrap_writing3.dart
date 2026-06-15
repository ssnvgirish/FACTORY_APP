part of 'default.dart';

class SeedScrapWriting3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapWriting3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapWriting3Data> dataDeserializer = (dynamic json)  => SeedScrapWriting3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapWriting3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapWriting3Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapWriting3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapWriting3ScrapWritingEfficiencyInsert {
  final String id;
  SeedScrapWriting3ScrapWritingEfficiencyInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapWriting3ScrapWritingEfficiencyInsert otherTyped = other as SeedScrapWriting3ScrapWritingEfficiencyInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapWriting3ScrapWritingEfficiencyInsert({
    required this.id,
  });
}

@immutable
class SeedScrapWriting3Data {
  final SeedScrapWriting3ScrapWritingEfficiencyInsert scrapWritingEfficiency_insert;
  SeedScrapWriting3Data.fromJson(dynamic json):
  
  scrapWritingEfficiency_insert = SeedScrapWriting3ScrapWritingEfficiencyInsert.fromJson(json['scrapWritingEfficiency_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapWriting3Data otherTyped = other as SeedScrapWriting3Data;
    return scrapWritingEfficiency_insert == otherTyped.scrapWritingEfficiency_insert;
    
  }
  @override
  int get hashCode => scrapWritingEfficiency_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapWritingEfficiency_insert'] = scrapWritingEfficiency_insert.toJson();
    return json;
  }

  SeedScrapWriting3Data({
    required this.scrapWritingEfficiency_insert,
  });
}

