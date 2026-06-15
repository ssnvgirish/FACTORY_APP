part of 'default.dart';

class ListScrapReportWritingEfficiencyVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListScrapReportWritingEfficiencyVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListScrapReportWritingEfficiencyVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListScrapReportWritingEfficiencyVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListScrapReportWritingEfficiencyVariablesBuilder(this._dataConnect, );
  Deserializer<ListScrapReportWritingEfficiencyData> dataDeserializer = (dynamic json)  => ListScrapReportWritingEfficiencyData.fromJson(jsonDecode(json));
  Serializer<ListScrapReportWritingEfficiencyVariables> varsSerializer = (ListScrapReportWritingEfficiencyVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListScrapReportWritingEfficiencyData, ListScrapReportWritingEfficiencyVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListScrapReportWritingEfficiencyData, ListScrapReportWritingEfficiencyVariables> ref() {
    ListScrapReportWritingEfficiencyVariables vars= ListScrapReportWritingEfficiencyVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListScrapReportWritingEfficiency", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListScrapReportWritingEfficiencyScrapWritingEfficiencies {
  final String id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final Timestamp? submittedAt;
  final Timestamp shiftEndTime;
  final int score;
  final String operatorId;
  final Timestamp? timestamp;
  ListScrapReportWritingEfficiencyScrapWritingEfficiencies.fromJson(dynamic json):
  
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

    final ListScrapReportWritingEfficiencyScrapWritingEfficiencies otherTyped = other as ListScrapReportWritingEfficiencyScrapWritingEfficiencies;
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

  ListScrapReportWritingEfficiencyScrapWritingEfficiencies({
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
class ListScrapReportWritingEfficiencyData {
  final List<ListScrapReportWritingEfficiencyScrapWritingEfficiencies> scrapWritingEfficiencies;
  ListScrapReportWritingEfficiencyData.fromJson(dynamic json):
  
  scrapWritingEfficiencies = (json['scrapWritingEfficiencies'] as List<dynamic>)
        .map((e) => ListScrapReportWritingEfficiencyScrapWritingEfficiencies.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListScrapReportWritingEfficiencyData otherTyped = other as ListScrapReportWritingEfficiencyData;
    return scrapWritingEfficiencies == otherTyped.scrapWritingEfficiencies;
    
  }
  @override
  int get hashCode => scrapWritingEfficiencies.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapWritingEfficiencies'] = scrapWritingEfficiencies.map((e) => e.toJson()).toList();
    return json;
  }

  ListScrapReportWritingEfficiencyData({
    required this.scrapWritingEfficiencies,
  });
}

@immutable
class ListScrapReportWritingEfficiencyVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListScrapReportWritingEfficiencyVariables.fromJson(Map<String, dynamic> json) {
  
  
    machineNumber = Optional.optional(nativeFromJson, nativeToJson);
    machineNumber.value = json['machineNumber'] == null ? null : nativeFromJson<String>(json['machineNumber']);
  
  
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

    final ListScrapReportWritingEfficiencyVariables otherTyped = other as ListScrapReportWritingEfficiencyVariables;
    return machineNumber == otherTyped.machineNumber && 
    startDate == otherTyped.startDate && 
    endDate == otherTyped.endDate;
    
  }
  @override
  int get hashCode => Object.hashAll([machineNumber.hashCode, startDate.hashCode, endDate.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(machineNumber.state == OptionalState.set) {
      json['machineNumber'] = machineNumber.toJson();
    }
    if(startDate.state == OptionalState.set) {
      json['startDate'] = startDate.toJson();
    }
    if(endDate.state == OptionalState.set) {
      json['endDate'] = endDate.toJson();
    }
    return json;
  }

  ListScrapReportWritingEfficiencyVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

