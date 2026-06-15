part of 'default.dart';

class SeedScrapProd6VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapProd6VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapProd6Data> dataDeserializer = (dynamic json)  => SeedScrapProd6Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapProd6Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapProd6Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapProd6", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapProd6MasterScrapProductInsert {
  final String id;
  SeedScrapProd6MasterScrapProductInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapProd6MasterScrapProductInsert otherTyped = other as SeedScrapProd6MasterScrapProductInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapProd6MasterScrapProductInsert({
    required this.id,
  });
}

@immutable
class SeedScrapProd6Data {
  final SeedScrapProd6MasterScrapProductInsert masterScrapProduct_insert;
  SeedScrapProd6Data.fromJson(dynamic json):
  
  masterScrapProduct_insert = SeedScrapProd6MasterScrapProductInsert.fromJson(json['masterScrapProduct_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapProd6Data otherTyped = other as SeedScrapProd6Data;
    return masterScrapProduct_insert == otherTyped.masterScrapProduct_insert;
    
  }
  @override
  int get hashCode => masterScrapProduct_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterScrapProduct_insert'] = masterScrapProduct_insert.toJson();
    return json;
  }

  SeedScrapProd6Data({
    required this.masterScrapProduct_insert,
  });
}

