part of 'default.dart';

class SeedSheetThick5VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick5VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick5Data> dataDeserializer = (dynamic json)  => SeedSheetThick5Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick5Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick5Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick5", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick5MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick5MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick5MasterSheetThicknessInsert otherTyped = other as SeedSheetThick5MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick5MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick5Data {
  final SeedSheetThick5MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick5Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick5MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick5Data otherTyped = other as SeedSheetThick5Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick5Data({
    required this.masterSheetThickness_insert,
  });
}

