part of 'default.dart';

class SeedSheetThick16VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick16VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick16Data> dataDeserializer = (dynamic json)  => SeedSheetThick16Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick16Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick16Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick16", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick16MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick16MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick16MasterSheetThicknessInsert otherTyped = other as SeedSheetThick16MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick16MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick16Data {
  final SeedSheetThick16MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick16Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick16MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick16Data otherTyped = other as SeedSheetThick16Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick16Data({
    required this.masterSheetThickness_insert,
  });
}

