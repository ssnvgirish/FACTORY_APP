part of 'default.dart';

class SeedScrapProd4VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapProd4VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapProd4Data> dataDeserializer = (dynamic json)  => SeedScrapProd4Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapProd4Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapProd4Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapProd4", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapProd4MasterScrapProductInsert {
  final String id;
  SeedScrapProd4MasterScrapProductInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapProd4MasterScrapProductInsert otherTyped = other as SeedScrapProd4MasterScrapProductInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapProd4MasterScrapProductInsert({
    required this.id,
  });
}

@immutable
class SeedScrapProd4Data {
  final SeedScrapProd4MasterScrapProductInsert masterScrapProduct_insert;
  SeedScrapProd4Data.fromJson(dynamic json):
  
  masterScrapProduct_insert = SeedScrapProd4MasterScrapProductInsert.fromJson(json['masterScrapProduct_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapProd4Data otherTyped = other as SeedScrapProd4Data;
    return masterScrapProduct_insert == otherTyped.masterScrapProduct_insert;
    
  }
  @override
  int get hashCode => masterScrapProduct_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterScrapProduct_insert'] = masterScrapProduct_insert.toJson();
    return json;
  }

  SeedScrapProd4Data({
    required this.masterScrapProduct_insert,
  });
}

