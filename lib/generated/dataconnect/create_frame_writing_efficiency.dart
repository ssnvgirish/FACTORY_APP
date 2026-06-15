part of 'default.dart';

class CreateFrameWritingEfficiencyVariablesBuilder {
  DateTime date;
  String machineNumber;
  String shift;
  Optional<Timestamp> _submittedAt = Optional.optional((json) => json['submittedAt'] = Timestamp.fromJson(json['submittedAt']), defaultSerializer);
  Timestamp shiftEndTime;
  int score;
  String operatorId;

  final FirebaseDataConnect _dataConnect;  CreateFrameWritingEfficiencyVariablesBuilder submittedAt(Timestamp? t) {
   _submittedAt.value = t;
   return this;
  }

  CreateFrameWritingEfficiencyVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.shift,required  this.shiftEndTime,required  this.score,required  this.operatorId,});
  Deserializer<CreateFrameWritingEfficiencyData> dataDeserializer = (dynamic json)  => CreateFrameWritingEfficiencyData.fromJson(jsonDecode(json));
  Serializer<CreateFrameWritingEfficiencyVariables> varsSerializer = (CreateFrameWritingEfficiencyVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateFrameWritingEfficiencyData, CreateFrameWritingEfficiencyVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateFrameWritingEfficiencyData, CreateFrameWritingEfficiencyVariables> ref() {
    CreateFrameWritingEfficiencyVariables vars= CreateFrameWritingEfficiencyVariables(date: date,machineNumber: machineNumber,shift: shift,submittedAt: _submittedAt,shiftEndTime: shiftEndTime,score: score,operatorId: operatorId,);
    return _dataConnect.mutation("CreateFrameWritingEfficiency", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateFrameWritingEfficiencyFrameWritingEfficiencyInsert {
  final String id;
  CreateFrameWritingEfficiencyFrameWritingEfficiencyInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameWritingEfficiencyFrameWritingEfficiencyInsert otherTyped = other as CreateFrameWritingEfficiencyFrameWritingEfficiencyInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateFrameWritingEfficiencyFrameWritingEfficiencyInsert({
    required this.id,
  });
}

@immutable
class CreateFrameWritingEfficiencyData {
  final CreateFrameWritingEfficiencyFrameWritingEfficiencyInsert frameWritingEfficiency_insert;
  CreateFrameWritingEfficiencyData.fromJson(dynamic json):
  
  frameWritingEfficiency_insert = CreateFrameWritingEfficiencyFrameWritingEfficiencyInsert.fromJson(json['frameWritingEfficiency_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameWritingEfficiencyData otherTyped = other as CreateFrameWritingEfficiencyData;
    return frameWritingEfficiency_insert == otherTyped.frameWritingEfficiency_insert;
    
  }
  @override
  int get hashCode => frameWritingEfficiency_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameWritingEfficiency_insert'] = frameWritingEfficiency_insert.toJson();
    return json;
  }

  CreateFrameWritingEfficiencyData({
    required this.frameWritingEfficiency_insert,
  });
}

@immutable
class CreateFrameWritingEfficiencyVariables {
  final DateTime date;
  final String machineNumber;
  final String shift;
  late final Optional<Timestamp>submittedAt;
  final Timestamp shiftEndTime;
  final int score;
  final String operatorId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateFrameWritingEfficiencyVariables.fromJson(Map<String, dynamic> json):
  
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

    final CreateFrameWritingEfficiencyVariables otherTyped = other as CreateFrameWritingEfficiencyVariables;
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

  CreateFrameWritingEfficiencyVariables({
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.submittedAt,
    required this.shiftEndTime,
    required this.score,
    required this.operatorId,
  });
}

