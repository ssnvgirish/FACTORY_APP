part of 'default.dart';

class SeedSheetColor1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetColor1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetColor1Data> dataDeserializer = (dynamic json)  => SeedSheetColor1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetColor1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetColor1Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetColor1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetColor1MasterSheetColorInsert {
  final String id;
  SeedSheetColor1MasterSheetColorInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetColor1MasterSheetColorInsert otherTyped = other as SeedSheetColor1MasterSheetColorInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetColor1MasterSheetColorInsert({
    required this.id,
  });
}

@immutable
class SeedSheetColor1Data {
  final SeedSheetColor1MasterSheetColorInsert masterSheetColor_insert;
  SeedSheetColor1Data.fromJson(dynamic json):
  
  masterSheetColor_insert = SeedSheetColor1MasterSheetColorInsert.fromJson(json['masterSheetColor_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetColor1Data otherTyped = other as SeedSheetColor1Data;
    return masterSheetColor_insert == otherTyped.masterSheetColor_insert;
    
  }
  @override
  int get hashCode => masterSheetColor_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetColor_insert'] = masterSheetColor_insert.toJson();
    return json;
  }

  SeedSheetColor1Data({
    required this.masterSheetColor_insert,
  });
}

