part of 'default.dart';

class SeedSheetCleaning5VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetCleaning5VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetCleaning5Data> dataDeserializer = (dynamic json)  => SeedSheetCleaning5Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetCleaning5Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetCleaning5Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetCleaning5", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetCleaning5SheetCleaningReportInsert {
  final String id;
  SeedSheetCleaning5SheetCleaningReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetCleaning5SheetCleaningReportInsert otherTyped = other as SeedSheetCleaning5SheetCleaningReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetCleaning5SheetCleaningReportInsert({
    required this.id,
  });
}

@immutable
class SeedSheetCleaning5Data {
  final SeedSheetCleaning5SheetCleaningReportInsert sheetCleaningReport_insert;
  SeedSheetCleaning5Data.fromJson(dynamic json):
  
  sheetCleaningReport_insert = SeedSheetCleaning5SheetCleaningReportInsert.fromJson(json['sheetCleaningReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetCleaning5Data otherTyped = other as SeedSheetCleaning5Data;
    return sheetCleaningReport_insert == otherTyped.sheetCleaningReport_insert;
    
  }
  @override
  int get hashCode => sheetCleaningReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetCleaningReport_insert'] = sheetCleaningReport_insert.toJson();
    return json;
  }

  SeedSheetCleaning5Data({
    required this.sheetCleaningReport_insert,
  });
}

