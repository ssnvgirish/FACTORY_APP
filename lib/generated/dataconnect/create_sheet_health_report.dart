part of 'default.dart';

class CreateSheetHealthReportVariablesBuilder {
  DateTime date;
  String machineNumber;
  String shift;
  int totalScore;
  double percentage;
  String createdBy;
  Optional<Timestamp> _submittedAt = Optional.optional((json) => json['submittedAt'] = Timestamp.fromJson(json['submittedAt']), defaultSerializer);

  final FirebaseDataConnect _dataConnect;  CreateSheetHealthReportVariablesBuilder submittedAt(Timestamp? t) {
   _submittedAt.value = t;
   return this;
  }

  CreateSheetHealthReportVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.shift,required  this.totalScore,required  this.percentage,required  this.createdBy,});
  Deserializer<CreateSheetHealthReportData> dataDeserializer = (dynamic json)  => CreateSheetHealthReportData.fromJson(jsonDecode(json));
  Serializer<CreateSheetHealthReportVariables> varsSerializer = (CreateSheetHealthReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateSheetHealthReportData, CreateSheetHealthReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateSheetHealthReportData, CreateSheetHealthReportVariables> ref() {
    CreateSheetHealthReportVariables vars= CreateSheetHealthReportVariables(date: date,machineNumber: machineNumber,shift: shift,totalScore: totalScore,percentage: percentage,createdBy: createdBy,submittedAt: _submittedAt,);
    return _dataConnect.mutation("CreateSheetHealthReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateSheetHealthReportSheetHealthReportInsert {
  final String id;
  CreateSheetHealthReportSheetHealthReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetHealthReportSheetHealthReportInsert otherTyped = other as CreateSheetHealthReportSheetHealthReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetHealthReportSheetHealthReportInsert({
    required this.id,
  });
}

@immutable
class CreateSheetHealthReportData {
  final CreateSheetHealthReportSheetHealthReportInsert sheetHealthReport_insert;
  CreateSheetHealthReportData.fromJson(dynamic json):
  
  sheetHealthReport_insert = CreateSheetHealthReportSheetHealthReportInsert.fromJson(json['sheetHealthReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetHealthReportData otherTyped = other as CreateSheetHealthReportData;
    return sheetHealthReport_insert == otherTyped.sheetHealthReport_insert;
    
  }
  @override
  int get hashCode => sheetHealthReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetHealthReport_insert'] = sheetHealthReport_insert.toJson();
    return json;
  }

  CreateSheetHealthReportData({
    required this.sheetHealthReport_insert,
  });
}

@immutable
class CreateSheetHealthReportVariables {
  final DateTime date;
  final String machineNumber;
  final String shift;
  final int totalScore;
  final double percentage;
  final String createdBy;
  late final Optional<Timestamp>submittedAt;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateSheetHealthReportVariables.fromJson(Map<String, dynamic> json):
  
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalScore = nativeFromJson<int>(json['totalScore']),
  percentage = nativeFromJson<double>(json['percentage']),
  createdBy = nativeFromJson<String>(json['createdBy']) {
  
  
  
  
  
  
  
  
    submittedAt = Optional.optional((json) => json['submittedAt'] = Timestamp.fromJson(json['submittedAt']), defaultSerializer);
    submittedAt.value = json['submittedAt'] == null ? null : Timestamp.fromJson(json['submittedAt']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetHealthReportVariables otherTyped = other as CreateSheetHealthReportVariables;
    return date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalScore == otherTyped.totalScore && 
    percentage == otherTyped.percentage && 
    createdBy == otherTyped.createdBy && 
    submittedAt == otherTyped.submittedAt;
    
  }
  @override
  int get hashCode => Object.hashAll([date.hashCode, machineNumber.hashCode, shift.hashCode, totalScore.hashCode, percentage.hashCode, createdBy.hashCode, submittedAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalScore'] = nativeToJson<int>(totalScore);
    json['percentage'] = nativeToJson<double>(percentage);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if(submittedAt.state == OptionalState.set) {
      json['submittedAt'] = submittedAt.toJson();
    }
    return json;
  }

  CreateSheetHealthReportVariables({
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalScore,
    required this.percentage,
    required this.createdBy,
    required this.submittedAt,
  });
}

