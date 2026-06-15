part of 'default.dart';

class ListFrameCleaningReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListFrameCleaningReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListFrameCleaningReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListFrameCleaningReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListFrameCleaningReportsVariablesBuilder(this._dataConnect, );
  Deserializer<ListFrameCleaningReportsData> dataDeserializer = (dynamic json)  => ListFrameCleaningReportsData.fromJson(jsonDecode(json));
  Serializer<ListFrameCleaningReportsVariables> varsSerializer = (ListFrameCleaningReportsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListFrameCleaningReportsData, ListFrameCleaningReportsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListFrameCleaningReportsData, ListFrameCleaningReportsVariables> ref() {
    ListFrameCleaningReportsVariables vars= ListFrameCleaningReportsVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListFrameCleaningReports", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListFrameCleaningReportsFrameCleaningReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final int machineCondition;
  final int groundCondition;
  final int mouldCondition;
  final int totalScore;
  final double percentage;
  final String createdBy;
  final Timestamp? timestamp;
  ListFrameCleaningReportsFrameCleaningReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  machineCondition = nativeFromJson<int>(json['machineCondition']),
  groundCondition = nativeFromJson<int>(json['groundCondition']),
  mouldCondition = nativeFromJson<int>(json['mouldCondition']),
  totalScore = nativeFromJson<int>(json['totalScore']),
  percentage = nativeFromJson<double>(json['percentage']),
  createdBy = nativeFromJson<String>(json['createdBy']),
  timestamp = json['timestamp'] == null ? null : Timestamp.fromJson(json['timestamp']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameCleaningReportsFrameCleaningReports otherTyped = other as ListFrameCleaningReportsFrameCleaningReports;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    machineCondition == otherTyped.machineCondition && 
    groundCondition == otherTyped.groundCondition && 
    mouldCondition == otherTyped.mouldCondition && 
    totalScore == otherTyped.totalScore && 
    percentage == otherTyped.percentage && 
    createdBy == otherTyped.createdBy && 
    timestamp == otherTyped.timestamp;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, machineNumber.hashCode, machineCondition.hashCode, groundCondition.hashCode, mouldCondition.hashCode, totalScore.hashCode, percentage.hashCode, createdBy.hashCode, timestamp.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['machineCondition'] = nativeToJson<int>(machineCondition);
    json['groundCondition'] = nativeToJson<int>(groundCondition);
    json['mouldCondition'] = nativeToJson<int>(mouldCondition);
    json['totalScore'] = nativeToJson<int>(totalScore);
    json['percentage'] = nativeToJson<double>(percentage);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    return json;
  }

  ListFrameCleaningReportsFrameCleaningReports({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.machineCondition,
    required this.groundCondition,
    required this.mouldCondition,
    required this.totalScore,
    required this.percentage,
    required this.createdBy,
    this.timestamp,
  });
}

@immutable
class ListFrameCleaningReportsData {
  final List<ListFrameCleaningReportsFrameCleaningReports> frameCleaningReports;
  ListFrameCleaningReportsData.fromJson(dynamic json):
  
  frameCleaningReports = (json['frameCleaningReports'] as List<dynamic>)
        .map((e) => ListFrameCleaningReportsFrameCleaningReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameCleaningReportsData otherTyped = other as ListFrameCleaningReportsData;
    return frameCleaningReports == otherTyped.frameCleaningReports;
    
  }
  @override
  int get hashCode => frameCleaningReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameCleaningReports'] = frameCleaningReports.map((e) => e.toJson()).toList();
    return json;
  }

  ListFrameCleaningReportsData({
    required this.frameCleaningReports,
  });
}

@immutable
class ListFrameCleaningReportsVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListFrameCleaningReportsVariables.fromJson(Map<String, dynamic> json) {
  
  
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

    final ListFrameCleaningReportsVariables otherTyped = other as ListFrameCleaningReportsVariables;
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

  ListFrameCleaningReportsVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

