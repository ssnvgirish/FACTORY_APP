part of 'default.dart';

class SeedSheetThick11VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick11VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick11Data> dataDeserializer = (dynamic json)  => SeedSheetThick11Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick11Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick11Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick11", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick11MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick11MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick11MasterSheetThicknessInsert otherTyped = other as SeedSheetThick11MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick11MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick11Data {
  final SeedSheetThick11MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick11Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick11MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick11Data otherTyped = other as SeedSheetThick11Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick11Data({
    required this.masterSheetThickness_insert,
  });
}

