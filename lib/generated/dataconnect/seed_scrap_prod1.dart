part of 'default.dart';

class SeedScrapProd1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapProd1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapProd1Data> dataDeserializer = (dynamic json)  => SeedScrapProd1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapProd1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapProd1Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapProd1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapProd1MasterScrapProductInsert {
  final String id;
  SeedScrapProd1MasterScrapProductInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapProd1MasterScrapProductInsert otherTyped = other as SeedScrapProd1MasterScrapProductInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapProd1MasterScrapProductInsert({
    required this.id,
  });
}

@immutable
class SeedScrapProd1Data {
  final SeedScrapProd1MasterScrapProductInsert masterScrapProduct_insert;
  SeedScrapProd1Data.fromJson(dynamic json):
  
  masterScrapProduct_insert = SeedScrapProd1MasterScrapProductInsert.fromJson(json['masterScrapProduct_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapProd1Data otherTyped = other as SeedScrapProd1Data;
    return masterScrapProduct_insert == otherTyped.masterScrapProduct_insert;
    
  }
  @override
  int get hashCode => masterScrapProduct_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterScrapProduct_insert'] = masterScrapProduct_insert.toJson();
    return json;
  }

  SeedScrapProd1Data({
    required this.masterScrapProduct_insert,
  });
}

