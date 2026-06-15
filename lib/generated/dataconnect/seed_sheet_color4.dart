part of 'default.dart';

class SeedSheetColor4VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetColor4VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetColor4Data> dataDeserializer = (dynamic json)  => SeedSheetColor4Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetColor4Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetColor4Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetColor4", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetColor4MasterSheetColorInsert {
  final String id;
  SeedSheetColor4MasterSheetColorInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetColor4MasterSheetColorInsert otherTyped = other as SeedSheetColor4MasterSheetColorInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetColor4MasterSheetColorInsert({
    required this.id,
  });
}

@immutable
class SeedSheetColor4Data {
  final SeedSheetColor4MasterSheetColorInsert masterSheetColor_insert;
  SeedSheetColor4Data.fromJson(dynamic json):
  
  masterSheetColor_insert = SeedSheetColor4MasterSheetColorInsert.fromJson(json['masterSheetColor_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetColor4Data otherTyped = other as SeedSheetColor4Data;
    return masterSheetColor_insert == otherTyped.masterSheetColor_insert;
    
  }
  @override
  int get hashCode => masterSheetColor_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetColor_insert'] = masterSheetColor_insert.toJson();
    return json;
  }

  SeedSheetColor4Data({
    required this.masterSheetColor_insert,
  });
}

