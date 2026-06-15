part of 'default.dart';

class SeedSheetThick20VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick20VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick20Data> dataDeserializer = (dynamic json)  => SeedSheetThick20Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick20Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick20Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick20", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick20MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick20MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick20MasterSheetThicknessInsert otherTyped = other as SeedSheetThick20MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick20MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick20Data {
  final SeedSheetThick20MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick20Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick20MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick20Data otherTyped = other as SeedSheetThick20Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick20Data({
    required this.masterSheetThickness_insert,
  });
}

