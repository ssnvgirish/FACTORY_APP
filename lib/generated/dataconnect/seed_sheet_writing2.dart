part of 'default.dart';

class SeedSheetWriting2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetWriting2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetWriting2Data> dataDeserializer = (dynamic json)  => SeedSheetWriting2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetWriting2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetWriting2Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetWriting2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetWriting2SheetWritingEfficiencyInsert {
  final String id;
  SeedSheetWriting2SheetWritingEfficiencyInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetWriting2SheetWritingEfficiencyInsert otherTyped = other as SeedSheetWriting2SheetWritingEfficiencyInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetWriting2SheetWritingEfficiencyInsert({
    required this.id,
  });
}

@immutable
class SeedSheetWriting2Data {
  final SeedSheetWriting2SheetWritingEfficiencyInsert sheetWritingEfficiency_insert;
  SeedSheetWriting2Data.fromJson(dynamic json):
  
  sheetWritingEfficiency_insert = SeedSheetWriting2SheetWritingEfficiencyInsert.fromJson(json['sheetWritingEfficiency_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetWriting2Data otherTyped = other as SeedSheetWriting2Data;
    return sheetWritingEfficiency_insert == otherTyped.sheetWritingEfficiency_insert;
    
  }
  @override
  int get hashCode => sheetWritingEfficiency_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetWritingEfficiency_insert'] = sheetWritingEfficiency_insert.toJson();
    return json;
  }

  SeedSheetWriting2Data({
    required this.sheetWritingEfficiency_insert,
  });
}

