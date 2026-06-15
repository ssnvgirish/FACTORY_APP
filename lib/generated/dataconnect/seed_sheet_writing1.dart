part of 'default.dart';

class SeedSheetWriting1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetWriting1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetWriting1Data> dataDeserializer = (dynamic json)  => SeedSheetWriting1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetWriting1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetWriting1Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetWriting1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetWriting1SheetWritingEfficiencyInsert {
  final String id;
  SeedSheetWriting1SheetWritingEfficiencyInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetWriting1SheetWritingEfficiencyInsert otherTyped = other as SeedSheetWriting1SheetWritingEfficiencyInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetWriting1SheetWritingEfficiencyInsert({
    required this.id,
  });
}

@immutable
class SeedSheetWriting1Data {
  final SeedSheetWriting1SheetWritingEfficiencyInsert sheetWritingEfficiency_insert;
  SeedSheetWriting1Data.fromJson(dynamic json):
  
  sheetWritingEfficiency_insert = SeedSheetWriting1SheetWritingEfficiencyInsert.fromJson(json['sheetWritingEfficiency_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetWriting1Data otherTyped = other as SeedSheetWriting1Data;
    return sheetWritingEfficiency_insert == otherTyped.sheetWritingEfficiency_insert;
    
  }
  @override
  int get hashCode => sheetWritingEfficiency_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetWritingEfficiency_insert'] = sheetWritingEfficiency_insert.toJson();
    return json;
  }

  SeedSheetWriting1Data({
    required this.sheetWritingEfficiency_insert,
  });
}

