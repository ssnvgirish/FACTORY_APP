part of 'default.dart';

class SeedSheetThick6VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick6VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick6Data> dataDeserializer = (dynamic json)  => SeedSheetThick6Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick6Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick6Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick6", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick6MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick6MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick6MasterSheetThicknessInsert otherTyped = other as SeedSheetThick6MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick6MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick6Data {
  final SeedSheetThick6MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick6Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick6MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick6Data otherTyped = other as SeedSheetThick6Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick6Data({
    required this.masterSheetThickness_insert,
  });
}

