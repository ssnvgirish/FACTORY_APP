part of 'default.dart';

class SeedSheetThick3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick3Data> dataDeserializer = (dynamic json)  => SeedSheetThick3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick3Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick3MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick3MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick3MasterSheetThicknessInsert otherTyped = other as SeedSheetThick3MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick3MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick3Data {
  final SeedSheetThick3MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick3Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick3MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick3Data otherTyped = other as SeedSheetThick3Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick3Data({
    required this.masterSheetThickness_insert,
  });
}

