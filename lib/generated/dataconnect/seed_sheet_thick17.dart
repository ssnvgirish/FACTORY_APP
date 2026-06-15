part of 'default.dart';

class SeedSheetThick17VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick17VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick17Data> dataDeserializer = (dynamic json)  => SeedSheetThick17Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick17Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick17Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick17", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick17MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick17MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick17MasterSheetThicknessInsert otherTyped = other as SeedSheetThick17MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick17MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick17Data {
  final SeedSheetThick17MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick17Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick17MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick17Data otherTyped = other as SeedSheetThick17Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick17Data({
    required this.masterSheetThickness_insert,
  });
}

