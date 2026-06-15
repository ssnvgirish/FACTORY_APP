part of 'default.dart';

class SeedSheetThick14VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick14VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick14Data> dataDeserializer = (dynamic json)  => SeedSheetThick14Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick14Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick14Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick14", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick14MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick14MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick14MasterSheetThicknessInsert otherTyped = other as SeedSheetThick14MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick14MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick14Data {
  final SeedSheetThick14MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick14Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick14MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick14Data otherTyped = other as SeedSheetThick14Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick14Data({
    required this.masterSheetThickness_insert,
  });
}

