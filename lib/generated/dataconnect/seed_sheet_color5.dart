part of 'default.dart';

class SeedSheetColor5VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetColor5VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetColor5Data> dataDeserializer = (dynamic json)  => SeedSheetColor5Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetColor5Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetColor5Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetColor5", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetColor5MasterSheetColorInsert {
  final String id;
  SeedSheetColor5MasterSheetColorInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetColor5MasterSheetColorInsert otherTyped = other as SeedSheetColor5MasterSheetColorInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetColor5MasterSheetColorInsert({
    required this.id,
  });
}

@immutable
class SeedSheetColor5Data {
  final SeedSheetColor5MasterSheetColorInsert masterSheetColor_insert;
  SeedSheetColor5Data.fromJson(dynamic json):
  
  masterSheetColor_insert = SeedSheetColor5MasterSheetColorInsert.fromJson(json['masterSheetColor_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetColor5Data otherTyped = other as SeedSheetColor5Data;
    return masterSheetColor_insert == otherTyped.masterSheetColor_insert;
    
  }
  @override
  int get hashCode => masterSheetColor_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetColor_insert'] = masterSheetColor_insert.toJson();
    return json;
  }

  SeedSheetColor5Data({
    required this.masterSheetColor_insert,
  });
}

