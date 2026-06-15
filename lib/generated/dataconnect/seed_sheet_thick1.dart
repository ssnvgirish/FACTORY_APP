part of 'default.dart';

class SeedSheetThick1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick1Data> dataDeserializer = (dynamic json)  => SeedSheetThick1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick1Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick1MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick1MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick1MasterSheetThicknessInsert otherTyped = other as SeedSheetThick1MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick1MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick1Data {
  final SeedSheetThick1MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick1Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick1MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick1Data otherTyped = other as SeedSheetThick1Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick1Data({
    required this.masterSheetThickness_insert,
  });
}

