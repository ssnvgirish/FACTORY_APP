part of 'default.dart';

class SeedSheetThick18VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick18VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick18Data> dataDeserializer = (dynamic json)  => SeedSheetThick18Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick18Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick18Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick18", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick18MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick18MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick18MasterSheetThicknessInsert otherTyped = other as SeedSheetThick18MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick18MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick18Data {
  final SeedSheetThick18MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick18Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick18MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick18Data otherTyped = other as SeedSheetThick18Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick18Data({
    required this.masterSheetThickness_insert,
  });
}

