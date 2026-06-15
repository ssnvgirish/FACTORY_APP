part of 'default.dart';

class SeedSheetThick2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick2Data> dataDeserializer = (dynamic json)  => SeedSheetThick2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick2Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick2MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick2MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick2MasterSheetThicknessInsert otherTyped = other as SeedSheetThick2MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick2MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick2Data {
  final SeedSheetThick2MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick2Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick2MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick2Data otherTyped = other as SeedSheetThick2Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick2Data({
    required this.masterSheetThickness_insert,
  });
}

