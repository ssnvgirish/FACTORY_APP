part of 'default.dart';

class CreateScrapCleaningReportVariablesBuilder {
  DateTime date;
  String machineNumber;
  int machineCondition;
  int groundCondition;
  int totalScore;
  double percentage;
  String createdBy;

  final FirebaseDataConnect _dataConnect;
  CreateScrapCleaningReportVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.machineCondition,required  this.groundCondition,required  this.totalScore,required  this.percentage,required  this.createdBy,});
  Deserializer<CreateScrapCleaningReportData> dataDeserializer = (dynamic json)  => CreateScrapCleaningReportData.fromJson(jsonDecode(json));
  Serializer<CreateScrapCleaningReportVariables> varsSerializer = (CreateScrapCleaningReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateScrapCleaningReportData, CreateScrapCleaningReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateScrapCleaningReportData, CreateScrapCleaningReportVariables> ref() {
    CreateScrapCleaningReportVariables vars= CreateScrapCleaningReportVariables(date: date,machineNumber: machineNumber,machineCondition: machineCondition,groundCondition: groundCondition,totalScore: totalScore,percentage: percentage,createdBy: createdBy,);
    return _dataConnect.mutation("CreateScrapCleaningReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateScrapCleaningReportScrapCleaningReportInsert {
  final String id;
  CreateScrapCleaningReportScrapCleaningReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapCleaningReportScrapCleaningReportInsert otherTyped = other as CreateScrapCleaningReportScrapCleaningReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateScrapCleaningReportScrapCleaningReportInsert({
    required this.id,
  });
}

@immutable
class CreateScrapCleaningReportData {
  final CreateScrapCleaningReportScrapCleaningReportInsert scrapCleaningReport_insert;
  CreateScrapCleaningReportData.fromJson(dynamic json):
  
  scrapCleaningReport_insert = CreateScrapCleaningReportScrapCleaningReportInsert.fromJson(json['scrapCleaningReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapCleaningReportData otherTyped = other as CreateScrapCleaningReportData;
    return scrapCleaningReport_insert == otherTyped.scrapCleaningReport_insert;
    
  }
  @override
  int get hashCode => scrapCleaningReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapCleaningReport_insert'] = scrapCleaningReport_insert.toJson();
    return json;
  }

  CreateScrapCleaningReportData({
    required this.scrapCleaningReport_insert,
  });
}

@immutable
class CreateScrapCleaningReportVariables {
  final DateTime date;
  final String machineNumber;
  final int machineCondition;
  final int groundCondition;
  final int totalScore;
  final double percentage;
  final String createdBy;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateScrapCleaningReportVariables.fromJson(Map<String, dynamic> json):
  
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  machineCondition = nativeFromJson<int>(json['machineCondition']),
  groundCondition = nativeFromJson<int>(json['groundCondition']),
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

    final CreateScrapCleaningReportVariables otherTyped = other as CreateScrapCleaningReportVariables;
    return date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    machineCondition == otherTyped.machineCondition && 
    groundCondition == otherTyped.groundCondition && 
    totalScore == otherTyped.totalScore && 
    percentage == otherTyped.percentage && 
    createdBy == otherTyped.createdBy;
    
  }
  @override
  int get hashCode => Object.hashAll([date.hashCode, machineNumber.hashCode, machineCondition.hashCode, groundCondition.hashCode, totalScore.hashCode, percentage.hashCode, createdBy.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['machineCondition'] = nativeToJson<int>(machineCondition);
    json['groundCondition'] = nativeToJson<int>(groundCondition);
    json['totalScore'] = nativeToJson<int>(totalScore);
    json['percentage'] = nativeToJson<double>(percentage);
    json['createdBy'] = nativeToJson<String>(createdBy);
    return json;
  }

  CreateScrapCleaningReportVariables({
    required this.date,
    required this.machineNumber,
    required this.machineCondition,
    required this.groundCondition,
    required this.totalScore,
    required this.percentage,
    required this.createdBy,
  });
}

