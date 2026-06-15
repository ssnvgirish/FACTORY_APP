part of 'default.dart';

class CreateSheetToolsCountReportVariablesBuilder {
  DateTime date;
  String machineNumber;
  int totalToolsGiven;
  int totalToolsAvailable;
  double percentageAvailable;
  String createdBy;

  final FirebaseDataConnect _dataConnect;
  CreateSheetToolsCountReportVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.totalToolsGiven,required  this.totalToolsAvailable,required  this.percentageAvailable,required  this.createdBy,});
  Deserializer<CreateSheetToolsCountReportData> dataDeserializer = (dynamic json)  => CreateSheetToolsCountReportData.fromJson(jsonDecode(json));
  Serializer<CreateSheetToolsCountReportVariables> varsSerializer = (CreateSheetToolsCountReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateSheetToolsCountReportData, CreateSheetToolsCountReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateSheetToolsCountReportData, CreateSheetToolsCountReportVariables> ref() {
    CreateSheetToolsCountReportVariables vars= CreateSheetToolsCountReportVariables(date: date,machineNumber: machineNumber,totalToolsGiven: totalToolsGiven,totalToolsAvailable: totalToolsAvailable,percentageAvailable: percentageAvailable,createdBy: createdBy,);
    return _dataConnect.mutation("CreateSheetToolsCountReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateSheetToolsCountReportSheetToolsCountReportInsert {
  final String id;
  CreateSheetToolsCountReportSheetToolsCountReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetToolsCountReportSheetToolsCountReportInsert otherTyped = other as CreateSheetToolsCountReportSheetToolsCountReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetToolsCountReportSheetToolsCountReportInsert({
    required this.id,
  });
}

@immutable
class CreateSheetToolsCountReportData {
  final CreateSheetToolsCountReportSheetToolsCountReportInsert sheetToolsCountReport_insert;
  CreateSheetToolsCountReportData.fromJson(dynamic json):
  
  sheetToolsCountReport_insert = CreateSheetToolsCountReportSheetToolsCountReportInsert.fromJson(json['sheetToolsCountReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetToolsCountReportData otherTyped = other as CreateSheetToolsCountReportData;
    return sheetToolsCountReport_insert == otherTyped.sheetToolsCountReport_insert;
    
  }
  @override
  int get hashCode => sheetToolsCountReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetToolsCountReport_insert'] = sheetToolsCountReport_insert.toJson();
    return json;
  }

  CreateSheetToolsCountReportData({
    required this.sheetToolsCountReport_insert,
  });
}

@immutable
class CreateSheetToolsCountReportVariables {
  final DateTime date;
  final String machineNumber;
  final int totalToolsGiven;
  final int totalToolsAvailable;
  final double percentageAvailable;
  final String createdBy;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateSheetToolsCountReportVariables.fromJson(Map<String, dynamic> json):
  
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  totalToolsGiven = nativeFromJson<int>(json['totalToolsGiven']),
  totalToolsAvailable = nativeFromJson<int>(json['totalToolsAvailable']),
  percentageAvailable = nativeFromJson<double>(json['percentageAvailable']),
  createdBy = nativeFromJson<String>(json['createdBy']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetToolsCountReportVariables otherTyped = other as CreateSheetToolsCountReportVariables;
    return date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    totalToolsGiven == otherTyped.totalToolsGiven && 
    totalToolsAvailable == otherTyped.totalToolsAvailable && 
    percentageAvailable == otherTyped.percentageAvailable && 
    createdBy == otherTyped.createdBy;
    
  }
  @override
  int get hashCode => Object.hashAll([date.hashCode, machineNumber.hashCode, totalToolsGiven.hashCode, totalToolsAvailable.hashCode, percentageAvailable.hashCode, createdBy.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['totalToolsGiven'] = nativeToJson<int>(totalToolsGiven);
    json['totalToolsAvailable'] = nativeToJson<int>(totalToolsAvailable);
    json['percentageAvailable'] = nativeToJson<double>(percentageAvailable);
    json['createdBy'] = nativeToJson<String>(createdBy);
    return json;
  }

  CreateSheetToolsCountReportVariables({
    required this.date,
    required this.machineNumber,
    required this.totalToolsGiven,
    required this.totalToolsAvailable,
    required this.percentageAvailable,
    required this.createdBy,
  });
}

