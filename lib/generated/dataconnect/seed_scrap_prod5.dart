part of 'default.dart';

class SeedScrapProd5VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapProd5VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapProd5Data> dataDeserializer = (dynamic json)  => SeedScrapProd5Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapProd5Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapProd5Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapProd5", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapProd5MasterScrapProductInsert {
  final String id;
  SeedScrapProd5MasterScrapProductInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapProd5MasterScrapProductInsert otherTyped = other as SeedScrapProd5MasterScrapProductInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapProd5MasterScrapProductInsert({
    required this.id,
  });
}

@immutable
class SeedScrapProd5Data {
  final SeedScrapProd5MasterScrapProductInsert masterScrapProduct_insert;
  SeedScrapProd5Data.fromJson(dynamic json):
  
  masterScrapProduct_insert = SeedScrapProd5MasterScrapProductInsert.fromJson(json['masterScrapProduct_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapProd5Data otherTyped = other as SeedScrapProd5Data;
    return masterScrapProduct_insert == otherTyped.masterScrapProduct_insert;
    
  }
  @override
  int get hashCode => masterScrapProduct_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterScrapProduct_insert'] = masterScrapProduct_insert.toJson();
    return json;
  }

  SeedScrapProd5Data({
    required this.masterScrapProduct_insert,
  });
}

