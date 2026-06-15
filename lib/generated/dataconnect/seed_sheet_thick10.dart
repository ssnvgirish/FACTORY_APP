part of 'default.dart';

class SeedSheetThick10VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick10VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick10Data> dataDeserializer = (dynamic json)  => SeedSheetThick10Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick10Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick10Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick10", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick10MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick10MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick10MasterSheetThicknessInsert otherTyped = other as SeedSheetThick10MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick10MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick10Data {
  final SeedSheetThick10MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick10Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick10MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick10Data otherTyped = other as SeedSheetThick10Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick10Data({
    required this.masterSheetThickness_insert,
  });
}

