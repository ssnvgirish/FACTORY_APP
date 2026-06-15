part of 'default.dart';

class SeedScrapProd3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapProd3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapProd3Data> dataDeserializer = (dynamic json)  => SeedScrapProd3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapProd3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapProd3Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapProd3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapProd3MasterScrapProductInsert {
  final String id;
  SeedScrapProd3MasterScrapProductInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapProd3MasterScrapProductInsert otherTyped = other as SeedScrapProd3MasterScrapProductInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapProd3MasterScrapProductInsert({
    required this.id,
  });
}

@immutable
class SeedScrapProd3Data {
  final SeedScrapProd3MasterScrapProductInsert masterScrapProduct_insert;
  SeedScrapProd3Data.fromJson(dynamic json):
  
  masterScrapProduct_insert = SeedScrapProd3MasterScrapProductInsert.fromJson(json['masterScrapProduct_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapProd3Data otherTyped = other as SeedScrapProd3Data;
    return masterScrapProduct_insert == otherTyped.masterScrapProduct_insert;
    
  }
  @override
  int get hashCode => masterScrapProduct_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterScrapProduct_insert'] = masterScrapProduct_insert.toJson();
    return json;
  }

  SeedScrapProd3Data({
    required this.masterScrapProduct_insert,
  });
}

