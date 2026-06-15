part of 'default.dart';

class SeedSheetThick19VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick19VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick19Data> dataDeserializer = (dynamic json)  => SeedSheetThick19Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick19Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick19Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick19", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick19MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick19MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick19MasterSheetThicknessInsert otherTyped = other as SeedSheetThick19MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick19MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick19Data {
  final SeedSheetThick19MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick19Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick19MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick19Data otherTyped = other as SeedSheetThick19Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick19Data({
    required this.masterSheetThickness_insert,
  });
}

