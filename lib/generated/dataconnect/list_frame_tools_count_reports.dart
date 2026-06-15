part of 'default.dart';

class ListFrameToolsCountReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListFrameToolsCountReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListFrameToolsCountReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListFrameToolsCountReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListFrameToolsCountReportsVariablesBuilder(this._dataConnect, );
  Deserializer<ListFrameToolsCountReportsData> dataDeserializer = (dynamic json)  => ListFrameToolsCountReportsData.fromJson(jsonDecode(json));
  Serializer<ListFrameToolsCountReportsVariables> varsSerializer = (ListFrameToolsCountReportsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListFrameToolsCountReportsData, ListFrameToolsCountReportsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListFrameToolsCountReportsData, ListFrameToolsCountReportsVariables> ref() {
    ListFrameToolsCountReportsVariables vars= ListFrameToolsCountReportsVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListFrameToolsCountReports", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListFrameToolsCountReportsFrameToolsCountReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final int totalToolsGiven;
  final int totalToolsAvailable;
  final double percentageAvailable;
  final String createdBy;
  final Timestamp? timestamp;
  ListFrameToolsCountReportsFrameToolsCountReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  totalToolsGiven = nativeFromJson<int>(json['totalToolsGiven']),
  totalToolsAvailable = nativeFromJson<int>(json['totalToolsAvailable']),
  percentageAvailable = nativeFromJson<double>(json['percentageAvailable']),
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

    final ListFrameToolsCountReportsFrameToolsCountReports otherTyped = other as ListFrameToolsCountReportsFrameToolsCountReports;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    totalToolsGiven == otherTyped.totalToolsGiven && 
    totalToolsAvailable == otherTyped.totalToolsAvailable && 
    percentageAvailable == otherTyped.percentageAvailable && 
    createdBy == otherTyped.createdBy && 
    timestamp == otherTyped.timestamp;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, machineNumber.hashCode, totalToolsGiven.hashCode, totalToolsAvailable.hashCode, percentageAvailable.hashCode, createdBy.hashCode, timestamp.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['totalToolsGiven'] = nativeToJson<int>(totalToolsGiven);
    json['totalToolsAvailable'] = nativeToJson<int>(totalToolsAvailable);
    json['percentageAvailable'] = nativeToJson<double>(percentageAvailable);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    return json;
  }

  ListFrameToolsCountReportsFrameToolsCountReports({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.totalToolsGiven,
    required this.totalToolsAvailable,
    required this.percentageAvailable,
    required this.createdBy,
    this.timestamp,
  });
}

@immutable
class ListFrameToolsCountReportsData {
  final List<ListFrameToolsCountReportsFrameToolsCountReports> frameToolsCountReports;
  ListFrameToolsCountReportsData.fromJson(dynamic json):
  
  frameToolsCountReports = (json['frameToolsCountReports'] as List<dynamic>)
        .map((e) => ListFrameToolsCountReportsFrameToolsCountReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameToolsCountReportsData otherTyped = other as ListFrameToolsCountReportsData;
    return frameToolsCountReports == otherTyped.frameToolsCountReports;
    
  }
  @override
  int get hashCode => frameToolsCountReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameToolsCountReports'] = frameToolsCountReports.map((e) => e.toJson()).toList();
    return json;
  }

  ListFrameToolsCountReportsData({
    required this.frameToolsCountReports,
  });
}

@immutable
class ListFrameToolsCountReportsVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListFrameToolsCountReportsVariables.fromJson(Map<String, dynamic> json) {
  
  
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

    final ListFrameToolsCountReportsVariables otherTyped = other as ListFrameToolsCountReportsVariables;
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

  ListFrameToolsCountReportsVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

