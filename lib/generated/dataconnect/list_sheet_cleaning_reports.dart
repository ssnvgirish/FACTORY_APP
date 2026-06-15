part of 'default.dart';

class ListSheetCleaningReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListSheetCleaningReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListSheetCleaningReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListSheetCleaningReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListSheetCleaningReportsVariablesBuilder(this._dataConnect, );
  Deserializer<ListSheetCleaningReportsData> dataDeserializer = (dynamic json)  => ListSheetCleaningReportsData.fromJson(jsonDecode(json));
  Serializer<ListSheetCleaningReportsVariables> varsSerializer = (ListSheetCleaningReportsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListSheetCleaningReportsData, ListSheetCleaningReportsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListSheetCleaningReportsData, ListSheetCleaningReportsVariables> ref() {
    ListSheetCleaningReportsVariables vars= ListSheetCleaningReportsVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListSheetCleaningReports", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListSheetCleaningReportsSheetCleaningReports {
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
  ListSheetCleaningReportsSheetCleaningReports.fromJson(dynamic json):
  
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

    final ListSheetCleaningReportsSheetCleaningReports otherTyped = other as ListSheetCleaningReportsSheetCleaningReports;
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

  ListSheetCleaningReportsSheetCleaningReports({
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
class ListSheetCleaningReportsData {
  final List<ListSheetCleaningReportsSheetCleaningReports> sheetCleaningReports;
  ListSheetCleaningReportsData.fromJson(dynamic json):
  
  sheetCleaningReports = (json['sheetCleaningReports'] as List<dynamic>)
        .map((e) => ListSheetCleaningReportsSheetCleaningReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSheetCleaningReportsData otherTyped = other as ListSheetCleaningReportsData;
    return sheetCleaningReports == otherTyped.sheetCleaningReports;
    
  }
  @override
  int get hashCode => sheetCleaningReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetCleaningReports'] = sheetCleaningReports.map((e) => e.toJson()).toList();
    return json;
  }

  ListSheetCleaningReportsData({
    required this.sheetCleaningReports,
  });
}

@immutable
class ListSheetCleaningReportsVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListSheetCleaningReportsVariables.fromJson(Map<String, dynamic> json) {
  
  
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

    final ListSheetCleaningReportsVariables otherTyped = other as ListSheetCleaningReportsVariables;
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

  ListSheetCleaningReportsVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

