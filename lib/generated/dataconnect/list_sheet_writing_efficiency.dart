part of 'default.dart';

class ListSheetWritingEfficiencyVariablesBuilder {
  Optional<String> _operatorId = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListSheetWritingEfficiencyVariablesBuilder operatorId(String? t) {
   _operatorId.value = t;
   return this;
  }
  ListSheetWritingEfficiencyVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListSheetWritingEfficiencyVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListSheetWritingEfficiencyVariablesBuilder(this._dataConnect, );
  Deserializer<ListSheetWritingEfficiencyData> dataDeserializer = (dynamic json)  => ListSheetWritingEfficiencyData.fromJson(jsonDecode(json));
  Serializer<ListSheetWritingEfficiencyVariables> varsSerializer = (ListSheetWritingEfficiencyVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListSheetWritingEfficiencyData, ListSheetWritingEfficiencyVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListSheetWritingEfficiencyData, ListSheetWritingEfficiencyVariables> ref() {
    ListSheetWritingEfficiencyVariables vars= ListSheetWritingEfficiencyVariables(operatorId: _operatorId,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListSheetWritingEfficiency", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListSheetWritingEfficiencySheetWritingEfficiencies {
  final String id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final Timestamp? submittedAt;
  final Timestamp shiftEndTime;
  final int score;
  final String operatorId;
  final Timestamp? timestamp;
  ListSheetWritingEfficiencySheetWritingEfficiencies.fromJson(dynamic json):
  
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

    final ListSheetWritingEfficiencySheetWritingEfficiencies otherTyped = other as ListSheetWritingEfficiencySheetWritingEfficiencies;
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

  ListSheetWritingEfficiencySheetWritingEfficiencies({
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
class ListSheetWritingEfficiencyData {
  final List<ListSheetWritingEfficiencySheetWritingEfficiencies> sheetWritingEfficiencies;
  ListSheetWritingEfficiencyData.fromJson(dynamic json):
  
  sheetWritingEfficiencies = (json['sheetWritingEfficiencies'] as List<dynamic>)
        .map((e) => ListSheetWritingEfficiencySheetWritingEfficiencies.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSheetWritingEfficiencyData otherTyped = other as ListSheetWritingEfficiencyData;
    return sheetWritingEfficiencies == otherTyped.sheetWritingEfficiencies;
    
  }
  @override
  int get hashCode => sheetWritingEfficiencies.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetWritingEfficiencies'] = sheetWritingEfficiencies.map((e) => e.toJson()).toList();
    return json;
  }

  ListSheetWritingEfficiencyData({
    required this.sheetWritingEfficiencies,
  });
}

@immutable
class ListSheetWritingEfficiencyVariables {
  late final Optional<String>operatorId;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListSheetWritingEfficiencyVariables.fromJson(Map<String, dynamic> json) {
  
  
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

    final ListSheetWritingEfficiencyVariables otherTyped = other as ListSheetWritingEfficiencyVariables;
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

  ListSheetWritingEfficiencyVariables({
    required this.operatorId,
    required this.startDate,
    required this.endDate,
  });
}

