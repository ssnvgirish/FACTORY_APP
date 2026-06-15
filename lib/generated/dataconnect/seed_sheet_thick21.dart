part of 'default.dart';

class SeedSheetThick21VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick21VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick21Data> dataDeserializer = (dynamic json)  => SeedSheetThick21Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick21Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick21Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick21", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick21MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick21MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick21MasterSheetThicknessInsert otherTyped = other as SeedSheetThick21MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick21MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick21Data {
  final SeedSheetThick21MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick21Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick21MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick21Data otherTyped = other as SeedSheetThick21Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick21Data({
    required this.masterSheetThickness_insert,
  });
}

