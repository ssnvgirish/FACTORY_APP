part of 'default.dart';

class SeedScrapProd2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapProd2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapProd2Data> dataDeserializer = (dynamic json)  => SeedScrapProd2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapProd2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapProd2Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapProd2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapProd2MasterScrapProductInsert {
  final String id;
  SeedScrapProd2MasterScrapProductInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapProd2MasterScrapProductInsert otherTyped = other as SeedScrapProd2MasterScrapProductInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapProd2MasterScrapProductInsert({
    required this.id,
  });
}

@immutable
class SeedScrapProd2Data {
  final SeedScrapProd2MasterScrapProductInsert masterScrapProduct_insert;
  SeedScrapProd2Data.fromJson(dynamic json):
  
  masterScrapProduct_insert = SeedScrapProd2MasterScrapProductInsert.fromJson(json['masterScrapProduct_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapProd2Data otherTyped = other as SeedScrapProd2Data;
    return masterScrapProduct_insert == otherTyped.masterScrapProduct_insert;
    
  }
  @override
  int get hashCode => masterScrapProduct_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterScrapProduct_insert'] = masterScrapProduct_insert.toJson();
    return json;
  }

  SeedScrapProd2Data({
    required this.masterScrapProduct_insert,
  });
}

