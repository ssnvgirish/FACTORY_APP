part of 'default.dart';

class SeedSheetCleaning1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetCleaning1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetCleaning1Data> dataDeserializer = (dynamic json)  => SeedSheetCleaning1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetCleaning1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetCleaning1Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetCleaning1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetCleaning1SheetCleaningReportInsert {
  final String id;
  SeedSheetCleaning1SheetCleaningReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetCleaning1SheetCleaningReportInsert otherTyped = other as SeedSheetCleaning1SheetCleaningReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetCleaning1SheetCleaningReportInsert({
    required this.id,
  });
}

@immutable
class SeedSheetCleaning1Data {
  final SeedSheetCleaning1SheetCleaningReportInsert sheetCleaningReport_insert;
  SeedSheetCleaning1Data.fromJson(dynamic json):
  
  sheetCleaningReport_insert = SeedSheetCleaning1SheetCleaningReportInsert.fromJson(json['sheetCleaningReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetCleaning1Data otherTyped = other as SeedSheetCleaning1Data;
    return sheetCleaningReport_insert == otherTyped.sheetCleaningReport_insert;
    
  }
  @override
  int get hashCode => sheetCleaningReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetCleaningReport_insert'] = sheetCleaningReport_insert.toJson();
    return json;
  }

  SeedSheetCleaning1Data({
    required this.sheetCleaningReport_insert,
  });
}

