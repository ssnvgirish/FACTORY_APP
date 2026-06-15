part of 'default.dart';

class SeedSheetRunningFeet3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSheetRunningFeet3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSheetRunningFeet3Data> dataDeserializer = (dynamic json)  => SeedSheetRunningFeet3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSheetRunningFeet3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSheetRunningFeet3Data, void> ref() {
    
    return _dataConnect.mutation("SeedSheetRunningFeet3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSheetRunningFeet3SheetRunningFeetReportInsert {
  final String id;
  SeedSheetRunningFeet3SheetRunningFeetReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetRunningFeet3SheetRunningFeetReportInsert otherTyped = other as SeedSheetRunningFeet3SheetRunningFeetReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSheetRunningFeet3SheetRunningFeetReportInsert({
    required this.id,
  });
}

@immutable
class SeedSheetRunningFeet3Data {
  final SeedSheetRunningFeet3SheetRunningFeetReportInsert sheetRunningFeetReport_insert;
  SeedSheetRunningFeet3Data.fromJson(dynamic json):
  
  sheetRunningFeetReport_insert = SeedSheetRunningFeet3SheetRunningFeetReportInsert.fromJson(json['sheetRunningFeetReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSheetRunningFeet3Data otherTyped = other as SeedSheetRunningFeet3Data;
    return sheetRunningFeetReport_insert == otherTyped.sheetRunningFeetReport_insert;
    
  }
  @override
  int get hashCode => sheetRunningFeetReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetRunningFeetReport_insert'] = sheetRunningFeetReport_insert.toJson();
    return json;
  }

  SeedSheetRunningFeet3Data({
    required this.sheetRunningFeetReport_insert,
  });
}

