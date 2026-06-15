part of 'default.dart';

class CreateSheetCleaningReportVariablesBuilder {
  DateTime date;
  String machineNumber;
  int machineCondition;
  int groundCondition;
  int mouldCondition;
  int totalScore;
  double percentage;
  String createdBy;

  final FirebaseDataConnect _dataConnect;
  CreateSheetCleaningReportVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.machineCondition,required  this.groundCondition,required  this.mouldCondition,required  this.totalScore,required  this.percentage,required  this.createdBy,});
  Deserializer<CreateSheetCleaningReportData> dataDeserializer = (dynamic json)  => CreateSheetCleaningReportData.fromJson(jsonDecode(json));
  Serializer<CreateSheetCleaningReportVariables> varsSerializer = (CreateSheetCleaningReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateSheetCleaningReportData, CreateSheetCleaningReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateSheetCleaningReportData, CreateSheetCleaningReportVariables> ref() {
    CreateSheetCleaningReportVariables vars= CreateSheetCleaningReportVariables(date: date,machineNumber: machineNumber,machineCondition: machineCondition,groundCondition: groundCondition,mouldCondition: mouldCondition,totalScore: totalScore,percentage: percentage,createdBy: createdBy,);
    return _dataConnect.mutation("CreateSheetCleaningReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateSheetCleaningReportSheetCleaningReportInsert {
  final String id;
  CreateSheetCleaningReportSheetCleaningReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetCleaningReportSheetCleaningReportInsert otherTyped = other as CreateSheetCleaningReportSheetCleaningReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetCleaningReportSheetCleaningReportInsert({
    required this.id,
  });
}

@immutable
class CreateSheetCleaningReportData {
  final CreateSheetCleaningReportSheetCleaningReportInsert sheetCleaningReport_insert;
  CreateSheetCleaningReportData.fromJson(dynamic json):
  
  sheetCleaningReport_insert = CreateSheetCleaningReportSheetCleaningReportInsert.fromJson(json['sheetCleaningReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetCleaningReportData otherTyped = other as CreateSheetCleaningReportData;
    return sheetCleaningReport_insert == otherTyped.sheetCleaningReport_insert;
    
  }
  @override
  int get hashCode => sheetCleaningReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetCleaningReport_insert'] = sheetCleaningReport_insert.toJson();
    return json;
  }

  CreateSheetCleaningReportData({
    required this.sheetCleaningReport_insert,
  });
}

@immutable
class CreateSheetCleaningReportVariables {
  final DateTime date;
  final String machineNumber;
  final int machineCondition;
  final int groundCondition;
  final int mouldCondition;
  final int totalScore;
  final double percentage;
  final String createdBy;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateSheetCleaningReportVariables.fromJson(Map<String, dynamic> json):
  
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  machineCondition = nativeFromJson<int>(json['machineCondition']),
  groundCondition = nativeFromJson<int>(json['groundCondition']),
  mouldCondition = nativeFromJson<int>(json['mouldCondition']),
  totalScore = nativeFromJson<int>(json['totalScore']),
  percentage = nativeFromJson<double>(json['percentage']),
  createdBy = nativeFromJson<String>(json['createdBy']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetCleaningReportVariables otherTyped = other as CreateSheetCleaningReportVariables;
    return date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    machineCondition == otherTyped.machineCondition && 
    groundCondition == otherTyped.groundCondition && 
    mouldCondition == otherTyped.mouldCondition && 
    totalScore == otherTyped.totalScore && 
    percentage == otherTyped.percentage && 
    createdBy == otherTyped.createdBy;
    
  }
  @override
  int get hashCode => Object.hashAll([date.hashCode, machineNumber.hashCode, machineCondition.hashCode, groundCondition.hashCode, mouldCondition.hashCode, totalScore.hashCode, percentage.hashCode, createdBy.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['machineCondition'] = nativeToJson<int>(machineCondition);
    json['groundCondition'] = nativeToJson<int>(groundCondition);
    json['mouldCondition'] = nativeToJson<int>(mouldCondition);
    json['totalScore'] = nativeToJson<int>(totalScore);
    json['percentage'] = nativeToJson<double>(percentage);
    json['createdBy'] = nativeToJson<String>(createdBy);
    return json;
  }

  CreateSheetCleaningReportVariables({
    required this.date,
    required this.machineNumber,
    required this.machineCondition,
    required this.groundCondition,
    required this.mouldCondition,
    required this.totalScore,
    required this.percentage,
    required this.createdBy,
  });
}

