part of 'default.dart';

class SeedSheetThick8VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick8VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick8Data> dataDeserializer = (dynamic json)  => SeedSheetThick8Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick8Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick8Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick8", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick8MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick8MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick8MasterSheetThicknessInsert otherTyped = other as SeedSheetThick8MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick8MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick8Data {
  final SeedSheetThick8MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick8Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick8MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick8Data otherTyped = other as SeedSheetThick8Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick8Data({
    required this.masterSheetThickness_insert,
  });
}

