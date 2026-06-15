part of 'default.dart';

class SeedSheetThick13VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick13VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick13Data> dataDeserializer = (dynamic json)  => SeedSheetThick13Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick13Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick13Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick13", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick13MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick13MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick13MasterSheetThicknessInsert otherTyped = other as SeedSheetThick13MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick13MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick13Data {
  final SeedSheetThick13MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick13Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick13MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick13Data otherTyped = other as SeedSheetThick13Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick13Data({
    required this.masterSheetThickness_insert,
  });
}

