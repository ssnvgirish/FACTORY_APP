part of 'default.dart';

class SeedSheetThick7VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick7VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick7Data> dataDeserializer = (dynamic json)  => SeedSheetThick7Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick7Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick7Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick7", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick7MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick7MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick7MasterSheetThicknessInsert otherTyped = other as SeedSheetThick7MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick7MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick7Data {
  final SeedSheetThick7MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick7Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick7MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick7Data otherTyped = other as SeedSheetThick7Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick7Data({
    required this.masterSheetThickness_insert,
  });
}

