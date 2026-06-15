part of 'default.dart';

class SeedSheetColor2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetColor2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetColor2Data> dataDeserializer = (dynamic json)  => SeedSheetColor2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetColor2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetColor2Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetColor2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetColor2MasterSheetColorInsert {
  final String id;
  SeedSheetColor2MasterSheetColorInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetColor2MasterSheetColorInsert otherTyped = other as SeedSheetColor2MasterSheetColorInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetColor2MasterSheetColorInsert({
    required this.id,
  });
}

@immutable
class SeedSheetColor2Data {
  final SeedSheetColor2MasterSheetColorInsert masterSheetColor_insert;
  SeedSheetColor2Data.fromJson(dynamic json):
  
  masterSheetColor_insert = SeedSheetColor2MasterSheetColorInsert.fromJson(json['masterSheetColor_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetColor2Data otherTyped = other as SeedSheetColor2Data;
    return masterSheetColor_insert == otherTyped.masterSheetColor_insert;
    
  }
  @override
  int get hashCode => masterSheetColor_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetColor_insert'] = masterSheetColor_insert.toJson();
    return json;
  }

  SeedSheetColor2Data({
    required this.masterSheetColor_insert,
  });
}

