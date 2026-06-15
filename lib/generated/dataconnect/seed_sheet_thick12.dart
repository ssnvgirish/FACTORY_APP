part of 'default.dart';

class SeedSheetThick12VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick12VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick12Data> dataDeserializer = (dynamic json)  => SeedSheetThick12Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick12Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick12Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick12", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick12MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick12MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick12MasterSheetThicknessInsert otherTyped = other as SeedSheetThick12MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick12MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick12Data {
  final SeedSheetThick12MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick12Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick12MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick12Data otherTyped = other as SeedSheetThick12Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick12Data({
    required this.masterSheetThickness_insert,
  });
}

