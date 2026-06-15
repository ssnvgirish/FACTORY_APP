part of 'default.dart';

class SeedSheetCleaning3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetCleaning3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetCleaning3Data> dataDeserializer = (dynamic json)  => SeedSheetCleaning3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetCleaning3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetCleaning3Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetCleaning3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetCleaning3SheetCleaningReportInsert {
  final String id;
  SeedSheetCleaning3SheetCleaningReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetCleaning3SheetCleaningReportInsert otherTyped = other as SeedSheetCleaning3SheetCleaningReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetCleaning3SheetCleaningReportInsert({
    required this.id,
  });
}

@immutable
class SeedSheetCleaning3Data {
  final SeedSheetCleaning3SheetCleaningReportInsert sheetCleaningReport_insert;
  SeedSheetCleaning3Data.fromJson(dynamic json):
  
  sheetCleaningReport_insert = SeedSheetCleaning3SheetCleaningReportInsert.fromJson(json['sheetCleaningReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetCleaning3Data otherTyped = other as SeedSheetCleaning3Data;
    return sheetCleaningReport_insert == otherTyped.sheetCleaningReport_insert;
    
  }
  @override
  int get hashCode => sheetCleaningReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetCleaningReport_insert'] = sheetCleaningReport_insert.toJson();
    return json;
  }

  SeedSheetCleaning3Data({
    required this.sheetCleaningReport_insert,
  });
}

