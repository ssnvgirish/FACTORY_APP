part of 'default.dart';

class CreateScrapWritingEfficiencyVariablesBuilder {
  DateTime date;
  String machineNumber;
  String shift;
  Optional<Timestamp> _submittedAt = Optional.optional((json) => json['submittedAt'] = Timestamp.fromJson(json['submittedAt']), defaultSerializer);
  Timestamp shiftEndTime;
  int score;
  String operatorId;

  final FirebaseDataConnect _dataConnect;  CreateScrapWritingEfficiencyVariablesBuilder submittedAt(Timestamp? t) {
   _submittedAt.value = t;
   return this;
  }

  CreateScrapWritingEfficiencyVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.shift,required  this.shiftEndTime,required  this.score,required  this.operatorId,});
  Deserializer<CreateScrapWritingEfficiencyData> dataDeserializer = (dynamic json)  => CreateScrapWritingEfficiencyData.fromJson(jsonDecode(json));
  Serializer<CreateScrapWritingEfficiencyVariables> varsSerializer = (CreateScrapWritingEfficiencyVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateScrapWritingEfficiencyData, CreateScrapWritingEfficiencyVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateScrapWritingEfficiencyData, CreateScrapWritingEfficiencyVariables> ref() {
    CreateScrapWritingEfficiencyVariables vars= CreateScrapWritingEfficiencyVariables(date: date,machineNumber: machineNumber,shift: shift,submittedAt: _submittedAt,shiftEndTime: shiftEndTime,score: score,operatorId: operatorId,);
    return _dataConnect.mutation("CreateScrapWritingEfficiency", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateScrapWritingEfficiencyScrapWritingEfficiencyInsert {
  final String id;
  CreateScrapWritingEfficiencyScrapWritingEfficiencyInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapWritingEfficiencyScrapWritingEfficiencyInsert otherTyped = other as CreateScrapWritingEfficiencyScrapWritingEfficiencyInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateScrapWritingEfficiencyScrapWritingEfficiencyInsert({
    required this.id,
  });
}

@immutable
class CreateScrapWritingEfficiencyData {
  final CreateScrapWritingEfficiencyScrapWritingEfficiencyInsert scrapWritingEfficiency_insert;
  CreateScrapWritingEfficiencyData.fromJson(dynamic json):
  
  scrapWritingEfficiency_insert = CreateScrapWritingEfficiencyScrapWritingEfficiencyInsert.fromJson(json['scrapWritingEfficiency_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapWritingEfficiencyData otherTyped = other as CreateScrapWritingEfficiencyData;
    return scrapWritingEfficiency_insert == otherTyped.scrapWritingEfficiency_insert;
    
  }
  @override
  int get hashCode => scrapWritingEfficiency_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapWritingEfficiency_insert'] = scrapWritingEfficiency_insert.toJson();
    return json;
  }

  CreateScrapWritingEfficiencyData({
    required this.scrapWritingEfficiency_insert,
  });
}

@immutable
class CreateScrapWritingEfficiencyVariables {
  final DateTime date;
  final String machineNumber;
  final String shift;
  late final Optional<Timestamp>submittedAt;
  final Timestamp shiftEndTime;
  final int score;
  final String operatorId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateScrapWritingEfficiencyVariables.fromJson(Map<String, dynamic> json):
  
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

    final CreateScrapWritingEfficiencyVariables otherTyped = other as CreateScrapWritingEfficiencyVariables;
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

  CreateScrapWritingEfficiencyVariables({
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.submittedAt,
    required this.shiftEndTime,
    required this.score,
    required this.operatorId,
  });
}

