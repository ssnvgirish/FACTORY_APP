part of 'default.dart';

class SeedSheetThick15VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetThick15VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetThick15Data> dataDeserializer = (dynamic json)  => SeedSheetThick15Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetThick15Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetThick15Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetThick15", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetThick15MasterSheetThicknessInsert {
  final String id;
  SeedSheetThick15MasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick15MasterSheetThicknessInsert otherTyped = other as SeedSheetThick15MasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetThick15MasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class SeedSheetThick15Data {
  final SeedSheetThick15MasterSheetThicknessInsert masterSheetThickness_insert;
  SeedSheetThick15Data.fromJson(dynamic json):
  
  masterSheetThickness_insert = SeedSheetThick15MasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetThick15Data otherTyped = other as SeedSheetThick15Data;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  SeedSheetThick15Data({
    required this.masterSheetThickness_insert,
  });
}

