part of 'default.dart';

class CreateFrameCleaningReportVariablesBuilder {
  DateTime date;
  String machineNumber;
  int machineCondition;
  int groundCondition;
  int mouldCondition;
  int totalScore;
  double percentage;
  String createdBy;

  final FirebaseDataConnect _dataConnect;
  CreateFrameCleaningReportVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.machineCondition,required  this.groundCondition,required  this.mouldCondition,required  this.totalScore,required  this.percentage,required  this.createdBy,});
  Deserializer<CreateFrameCleaningReportData> dataDeserializer = (dynamic json)  => CreateFrameCleaningReportData.fromJson(jsonDecode(json));
  Serializer<CreateFrameCleaningReportVariables> varsSerializer = (CreateFrameCleaningReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateFrameCleaningReportData, CreateFrameCleaningReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateFrameCleaningReportData, CreateFrameCleaningReportVariables> ref() {
    CreateFrameCleaningReportVariables vars= CreateFrameCleaningReportVariables(date: date,machineNumber: machineNumber,machineCondition: machineCondition,groundCondition: groundCondition,mouldCondition: mouldCondition,totalScore: totalScore,percentage: percentage,createdBy: createdBy,);
    return _dataConnect.mutation("CreateFrameCleaningReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateFrameCleaningReportFrameCleaningReportInsert {
  final String id;
  CreateFrameCleaningReportFrameCleaningReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameCleaningReportFrameCleaningReportInsert otherTyped = other as CreateFrameCleaningReportFrameCleaningReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateFrameCleaningReportFrameCleaningReportInsert({
    required this.id,
  });
}

@immutable
class CreateFrameCleaningReportData {
  final CreateFrameCleaningReportFrameCleaningReportInsert frameCleaningReport_insert;
  CreateFrameCleaningReportData.fromJson(dynamic json):
  
  frameCleaningReport_insert = CreateFrameCleaningReportFrameCleaningReportInsert.fromJson(json['frameCleaningReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameCleaningReportData otherTyped = other as CreateFrameCleaningReportData;
    return frameCleaningReport_insert == otherTyped.frameCleaningReport_insert;
    
  }
  @override
  int get hashCode => frameCleaningReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameCleaningReport_insert'] = frameCleaningReport_insert.toJson();
    return json;
  }

  CreateFrameCleaningReportData({
    required this.frameCleaningReport_insert,
  });
}

@immutable
class CreateFrameCleaningReportVariables {
  final DateTime date;
  final String machineNumber;
  final int machineCondition;
  final int groundCondition;
  final int mouldCondition;
  final int totalScore;
  final double percentage;
  final String createdBy;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateFrameCleaningReportVariables.fromJson(Map<String, dynamic> json):
  
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

    final CreateFrameCleaningReportVariables otherTyped = other as CreateFrameCleaningReportVariables;
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

  CreateFrameCleaningReportVariables({
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

