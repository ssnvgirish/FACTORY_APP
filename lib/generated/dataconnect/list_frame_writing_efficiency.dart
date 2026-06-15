part of 'default.dart';

class ListFrameWritingEfficiencyVariablesBuilder {
  Optional<String> _operatorId = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListFrameWritingEfficiencyVariablesBuilder operatorId(String? t) {
   _operatorId.value = t;
   return this;
  }
  ListFrameWritingEfficiencyVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListFrameWritingEfficiencyVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListFrameWritingEfficiencyVariablesBuilder(this._dataConnect, );
  Deserializer<ListFrameWritingEfficiencyData> dataDeserializer = (dynamic json)  => ListFrameWritingEfficiencyData.fromJson(jsonDecode(json));
  Serializer<ListFrameWritingEfficiencyVariables> varsSerializer = (ListFrameWritingEfficiencyVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListFrameWritingEfficiencyData, ListFrameWritingEfficiencyVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListFrameWritingEfficiencyData, ListFrameWritingEfficiencyVariables> ref() {
    ListFrameWritingEfficiencyVariables vars= ListFrameWritingEfficiencyVariables(operatorId: _operatorId,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListFrameWritingEfficiency", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListFrameWritingEfficiencyFrameWritingEfficiencies {
  final String id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final Timestamp? submittedAt;
  final Timestamp shiftEndTime;
  final int score;
  final String operatorId;
  final Timestamp? timestamp;
  ListFrameWritingEfficiencyFrameWritingEfficiencies.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  submittedAt = json['submittedAt'] == null ? null : Timestamp.fromJson(json['submittedAt']),
  shiftEndTime = Timestamp.fromJson(json['shiftEndTime']),
  score = nativeFromJson<int>(json['score']),
  operatorId = nativeFromJson<String>(json['operatorId']),
  timestamp = json['timestamp'] == null ? null : Timestamp.fromJson(json['timestamp']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameWritingEfficiencyFrameWritingEfficiencies otherTyped = other as ListFrameWritingEfficiencyFrameWritingEfficiencies;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    submittedAt == otherTyped.submittedAt && 
    shiftEndTime == otherTyped.shiftEndTime && 
    score == otherTyped.score && 
    operatorId == otherTyped.operatorId && 
    timestamp == otherTyped.timestamp;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, machineNumber.hashCode, shift.hashCode, submittedAt.hashCode, shiftEndTime.hashCode, score.hashCode, operatorId.hashCode, timestamp.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    if (submittedAt != null) {
      json['submittedAt'] = submittedAt!.toJson();
    }
    json['shiftEndTime'] = shiftEndTime.toJson();
    json['score'] = nativeToJson<int>(score);
    json['operatorId'] = nativeToJson<String>(operatorId);
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    return json;
  }

  ListFrameWritingEfficiencyFrameWritingEfficiencies({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    this.submittedAt,
    required this.shiftEndTime,
    required this.score,
    required this.operatorId,
    this.timestamp,
  });
}

@immutable
class ListFrameWritingEfficiencyData {
  final List<ListFrameWritingEfficiencyFrameWritingEfficiencies> frameWritingEfficiencies;
  ListFrameWritingEfficiencyData.fromJson(dynamic json):
  
  frameWritingEfficiencies = (json['frameWritingEfficiencies'] as List<dynamic>)
        .map((e) => ListFrameWritingEfficiencyFrameWritingEfficiencies.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameWritingEfficiencyData otherTyped = other as ListFrameWritingEfficiencyData;
    return frameWritingEfficiencies == otherTyped.frameWritingEfficiencies;
    
  }
  @override
  int get hashCode => frameWritingEfficiencies.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameWritingEfficiencies'] = frameWritingEfficiencies.map((e) => e.toJson()).toList();
    return json;
  }

  ListFrameWritingEfficiencyData({
    required this.frameWritingEfficiencies,
  });
}

@immutable
class ListFrameWritingEfficiencyVariables {
  late final Optional<String>operatorId;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListFrameWritingEfficiencyVariables.fromJson(Map<String, dynamic> json) {
  
  
    operatorId = Optional.optional(nativeFromJson, nativeToJson);
    operatorId.value = json['operatorId'] == null ? null : nativeFromJson<String>(json['operatorId']);
  
  
    startDate = Optional.optional(nativeFromJson, nativeToJson);
    startDate.value = json['startDate'] == null ? null : nativeFromJson<DateTime>(json['startDate']);
  
  
    endDate = Optional.optional(nativeFromJson, nativeToJson);
    endDate.value = json['endDate'] == null ? null : nativeFromJson<DateTime>(json['endDate']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameWritingEfficiencyVariables otherTyped = other as ListFrameWritingEfficiencyVariables;
    return operatorId == otherTyped.operatorId && 
    startDate == otherTyped.startDate && 
    endDate == otherTyped.endDate;
    
  }
  @override
  int get hashCode => Object.hashAll([operatorId.hashCode, startDate.hashCode, endDate.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(operatorId.state == OptionalState.set) {
      json['operatorId'] = operatorId.toJson();
    }
    if(startDate.state == OptionalState.set) {
      json['startDate'] = startDate.toJson();
    }
    if(endDate.state == OptionalState.set) {
      json['endDate'] = endDate.toJson();
    }
    return json;
  }

  ListFrameWritingEfficiencyVariables({
    required this.operatorId,
    required this.startDate,
    required this.endDate,
  });
}

