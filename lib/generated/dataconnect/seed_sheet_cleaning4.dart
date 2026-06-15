part of 'default.dart';

class SeedSheetCleaning4VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetCleaning4VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetCleaning4Data> dataDeserializer = (dynamic json)  => SeedSheetCleaning4Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetCleaning4Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetCleaning4Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetCleaning4", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetCleaning4SheetCleaningReportInsert {
  final String id;
  SeedSheetCleaning4SheetCleaningReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetCleaning4SheetCleaningReportInsert otherTyped = other as SeedSheetCleaning4SheetCleaningReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetCleaning4SheetCleaningReportInsert({
    required this.id,
  });
}

@immutable
class SeedSheetCleaning4Data {
  final SeedSheetCleaning4SheetCleaningReportInsert sheetCleaningReport_insert;
  SeedSheetCleaning4Data.fromJson(dynamic json):
  
  sheetCleaningReport_insert = SeedSheetCleaning4SheetCleaningReportInsert.fromJson(json['sheetCleaningReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetCleaning4Data otherTyped = other as SeedSheetCleaning4Data;
    return sheetCleaningReport_insert == otherTyped.sheetCleaningReport_insert;
    
  }
  @override
  int get hashCode => sheetCleaningReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetCleaningReport_insert'] = sheetCleaningReport_insert.toJson();
    return json;
  }

  SeedSheetCleaning4Data({
    required this.sheetCleaningReport_insert,
  });
}

