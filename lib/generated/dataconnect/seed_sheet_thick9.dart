part of 'default.dart';

class SeedSheetThick9VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick9VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick9Data> dataDeserializer = (dynamic json)  => SeedSheetThick9Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick9Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick9Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick9", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick9MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick9MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick9MasterSheetThicknessInsert otherTyped = other as SeedSheetThick9MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick9MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick9Data {
  final SeedSheetThick9MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick9Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick9MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick9Data otherTyped = other as SeedSheetThick9Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick9Data({
    required this.masterSheetThickness_insert,
  });
}

