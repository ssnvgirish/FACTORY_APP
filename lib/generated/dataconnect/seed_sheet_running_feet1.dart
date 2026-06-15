part of 'default.dart';

class SeedSheetRunningFeet1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetRunningFeet1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetRunningFeet1Data> dataDeserializer = (dynamic json)  => SeedSheetRunningFeet1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetRunningFeet1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetRunningFeet1Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetRunningFeet1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetRunningFeet1SheetRunningFeetReportInsert {
  final String id;
  SeedSheetRunningFeet1SheetRunningFeetReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetRunningFeet1SheetRunningFeetReportInsert otherTyped = other as SeedSheetRunningFeet1SheetRunningFeetReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetRunningFeet1SheetRunningFeetReportInsert({
    required this.id,
  });
}

@immutable
class SeedSheetRunningFeet1Data {
  final SeedSheetRunningFeet1SheetRunningFeetReportInsert sheetRunningFeetReport_insert;
  SeedSheetRunningFeet1Data.fromJson(dynamic json):
  
  sheetRunningFeetReport_insert = SeedSheetRunningFeet1SheetRunningFeetReportInsert.fromJson(json['sheetRunningFeetReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetRunningFeet1Data otherTyped = other as SeedSheetRunningFeet1Data;
    return sheetRunningFeetReport_insert == otherTyped.sheetRunningFeetReport_insert;
    
  }
  @override
  int get hashCode => sheetRunningFeetReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetRunningFeetReport_insert'] = sheetRunningFeetReport_insert.toJson();
    return json;
  }

  SeedSheetRunningFeet1Data({
    required this.sheetRunningFeetReport_insert,
  });
}

