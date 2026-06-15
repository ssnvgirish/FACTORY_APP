part of 'default.dart';

class SeedSheetCleaning2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetCleaning2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetCleaning2Data> dataDeserializer = (dynamic json)  => SeedSheetCleaning2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetCleaning2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetCleaning2Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetCleaning2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetCleaning2SheetCleaningReportInsert {
  final String id;
  SeedSheetCleaning2SheetCleaningReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetCleaning2SheetCleaningReportInsert otherTyped = other as SeedSheetCleaning2SheetCleaningReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetCleaning2SheetCleaningReportInsert({
    required this.id,
  });
}

@immutable
class SeedSheetCleaning2Data {
  final SeedSheetCleaning2SheetCleaningReportInsert sheetCleaningReport_insert;
  SeedSheetCleaning2Data.fromJson(dynamic json):
  
  sheetCleaningReport_insert = SeedSheetCleaning2SheetCleaningReportInsert.fromJson(json['sheetCleaningReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetCleaning2Data otherTyped = other as SeedSheetCleaning2Data;
    return sheetCleaningReport_insert == otherTyped.sheetCleaningReport_insert;
    
  }
  @override
  int get hashCode => sheetCleaningReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetCleaningReport_insert'] = sheetCleaningReport_insert.toJson();
    return json;
  }

  SeedSheetCleaning2Data({
    required this.sheetCleaningReport_insert,
  });
}

