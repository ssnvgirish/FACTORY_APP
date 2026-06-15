part of 'default.dart';

class SeedSheetThick4VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick4VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick4Data> dataDeserializer = (dynamic json)  => SeedSheetThick4Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick4Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick4Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick4", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick4MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick4MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick4MasterSheetThicknessInsert otherTyped = other as SeedSheetThick4MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick4MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick4Data {
  final SeedSheetThick4MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick4Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick4MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick4Data otherTyped = other as SeedSheetThick4Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick4Data({
    required this.masterSheetThickness_insert,
  });
}

