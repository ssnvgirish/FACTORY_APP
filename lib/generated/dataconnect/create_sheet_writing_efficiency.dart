part of 'default.dart';

class CreateSheetWritingEfficiencyVariablesBuilder {
  DateTime date;
  String machineNumber;
  String shift;
  Optional<Timestamp> _submittedAt = Optional.optional((json) => json['submittedAt'] = Timestamp.fromJson(json['submittedAt']), defaultSerializer);
  Timestamp shiftEndTime;
  int score;
  String operatorId;

  final FirebaseDataConnect _dataConnect;  CreateSheetWritingEfficiencyVariablesBuilder submittedAt(Timestamp? t) {
   _submittedAt.value = t;
   return this;
  }

  CreateSheetWritingEfficiencyVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.shift,required  this.shiftEndTime,required  this.score,required  this.operatorId,});
  Deserializer<CreateSheetWritingEfficiencyData> dataDeserializer = (dynamic json)  => CreateSheetWritingEfficiencyData.fromJson(jsonDecode(json));
  Serializer<CreateSheetWritingEfficiencyVariables> varsSerializer = (CreateSheetWritingEfficiencyVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateSheetWritingEfficiencyData, CreateSheetWritingEfficiencyVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateSheetWritingEfficiencyData, CreateSheetWritingEfficiencyVariables> ref() {
    CreateSheetWritingEfficiencyVariables vars= CreateSheetWritingEfficiencyVariables(date: date,machineNumber: machineNumber,shift: shift,submittedAt: _submittedAt,shiftEndTime: shiftEndTime,score: score,operatorId: operatorId,);
    return _dataConnect.mutation("CreateSheetWritingEfficiency", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateSheetWritingEfficiencySheetWritingEfficiencyInsert {
  final String id;
  CreateSheetWritingEfficiencySheetWritingEfficiencyInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetWritingEfficiencySheetWritingEfficiencyInsert otherTyped = other as CreateSheetWritingEfficiencySheetWritingEfficiencyInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetWritingEfficiencySheetWritingEfficiencyInsert({
    required this.id,
  });
}

@immutable
class CreateSheetWritingEfficiencyData {
  final CreateSheetWritingEfficiencySheetWritingEfficiencyInsert sheetWritingEfficiency_insert;
  CreateSheetWritingEfficiencyData.fromJson(dynamic json):
  
  sheetWritingEfficiency_insert = CreateSheetWritingEfficiencySheetWritingEfficiencyInsert.fromJson(json['sheetWritingEfficiency_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetWritingEfficiencyData otherTyped = other as CreateSheetWritingEfficiencyData;
    return sheetWritingEfficiency_insert == otherTyped.sheetWritingEfficiency_insert;
    
  }
  @override
  int get hashCode => sheetWritingEfficiency_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetWritingEfficiency_insert'] = sheetWritingEfficiency_insert.toJson();
    return json;
  }

  CreateSheetWritingEfficiencyData({
    required this.sheetWritingEfficiency_insert,
  });
}

@immutable
class CreateSheetWritingEfficiencyVariables {
  final DateTime date;
  final String machineNumber;
  final String shift;
  late final Optional<Timestamp>submittedAt;
  final Timestamp shiftEndTime;
  final int score;
  final String operatorId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateSheetWritingEfficiencyVariables.fromJson(Map<String, dynamic> json):
  
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  shiftEndTime = Timestamp.fromJson(json['shiftEndTime']),
  score = nativeFromJson<int>(json['score']),
  operatorId = nativeFromJson<String>(json['operatorId']) {
  
  
  
  
  
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

    final CreateSheetWritingEfficiencyVariables otherTyped = other as CreateSheetWritingEfficiencyVariables;
    return date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    submittedAt == otherTyped.submittedAt && 
    shiftEndTime == otherTyped.shiftEndTime && 
    score == otherTyped.score && 
    operatorId == otherTyped.operatorId;
    
  }
  @override
  int get hashCode => Object.hashAll([date.hashCode, machineNumber.hashCode, shift.hashCode, submittedAt.hashCode, shiftEndTime.hashCode, score.hashCode, operatorId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    if(submittedAt.state == OptionalState.set) {
      json['submittedAt'] = submittedAt.toJson();
    }
    json['shiftEndTime'] = shiftEndTime.toJson();
    json['score'] = nativeToJson<int>(score);
    json['operatorId'] = nativeToJson<String>(operatorId);
    return json;
  }

  CreateSheetWritingEfficiencyVariables({
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.submittedAt,
    required this.shiftEndTime,
    required this.score,
    required this.operatorId,
  });
}

