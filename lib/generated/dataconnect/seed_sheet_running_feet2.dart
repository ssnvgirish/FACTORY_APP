part of 'default.dart';

class SeedSheetRunningFeet2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetRunningFeet2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetRunningFeet2Data> dataDeserializer = (dynamic json)  => SeedSheetRunningFeet2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetRunningFeet2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetRunningFeet2Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetRunningFeet2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetRunningFeet2SheetRunningFeetReportInsert {
  final String id;
  SeedSheetRunningFeet2SheetRunningFeetReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetRunningFeet2SheetRunningFeetReportInsert otherTyped = other as SeedSheetRunningFeet2SheetRunningFeetReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetRunningFeet2SheetRunningFeetReportInsert({
    required this.id,
  });
}

@immutable
class SeedSheetRunningFeet2Data {
  final SeedSheetRunningFeet2SheetRunningFeetReportInsert sheetRunningFeetReport_insert;
  SeedSheetRunningFeet2Data.fromJson(dynamic json):
  
  sheetRunningFeetReport_insert = SeedSheetRunningFeet2SheetRunningFeetReportInsert.fromJson(json['sheetRunningFeetReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetRunningFeet2Data otherTyped = other as SeedSheetRunningFeet2Data;
    return sheetRunningFeetReport_insert == otherTyped.sheetRunningFeetReport_insert;
    
  }
  @override
  int get hashCode => sheetRunningFeetReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetRunningFeetReport_insert'] = sheetRunningFeetReport_insert.toJson();
    return json;
  }

  SeedSheetRunningFeet2Data({
    required this.sheetRunningFeetReport_insert,
  });
}

