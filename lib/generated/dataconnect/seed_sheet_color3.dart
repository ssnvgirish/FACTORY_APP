part of 'default.dart';

class SeedSheetColor3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetColor3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetColor3Data> dataDeserializer = (dynamic json)  => SeedSheetColor3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetColor3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetColor3Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetColor3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetColor3MasterSheetColorInsert {
  final String id;
  SeedSheetColor3MasterSheetColorInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetColor3MasterSheetColorInsert otherTyped = other as SeedSheetColor3MasterSheetColorInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetColor3MasterSheetColorInsert({
    required this.id,
  });
}

@immutable
class SeedSheetColor3Data {
  final SeedSheetColor3MasterSheetColorInsert masterSheetColor_insert;
  SeedSheetColor3Data.fromJson(dynamic json):
  
  masterSheetColor_insert = SeedSheetColor3MasterSheetColorInsert.fromJson(json['masterSheetColor_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetColor3Data otherTyped = other as SeedSheetColor3Data;
    return masterSheetColor_insert == otherTyped.masterSheetColor_insert;
    
  }
  @override
  int get hashCode => masterSheetColor_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetColor_insert'] = masterSheetColor_insert.toJson();
    return json;
  }

  SeedSheetColor3Data({
    required this.masterSheetColor_insert,
  });
}

