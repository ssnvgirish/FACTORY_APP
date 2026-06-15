part of 'default.dart';

class ListScrapToolsCountReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListScrapToolsCountReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListScrapToolsCountReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListScrapToolsCountReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListScrapToolsCountReportsVariablesBuilder(this._dataConnect, );
  Deserializer<ListScrapToolsCountReportsData> dataDeserializer = (dynamic json)  => ListScrapToolsCountReportsData.fromJson(jsonDecode(json));
  Serializer<ListScrapToolsCountReportsVariables> varsSerializer = (ListScrapToolsCountReportsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListScrapToolsCountReportsData, ListScrapToolsCountReportsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListScrapToolsCountReportsData, ListScrapToolsCountReportsVariables> ref() {
    ListScrapToolsCountReportsVariables vars= ListScrapToolsCountReportsVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListScrapToolsCountReports", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListScrapToolsCountReportsScrapToolsCountReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final int totalToolsGiven;
  final int totalToolsAvailable;
  final double percentageAvailable;
  final String createdBy;
  final Timestamp? timestamp;
  ListScrapToolsCountReportsScrapToolsCountReports.fromJson(dynamic json):
  
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

    final ListScrapToolsCountReportsScrapToolsCountReports otherTyped = other as ListScrapToolsCountReportsScrapToolsCountReports;
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

  ListScrapToolsCountReportsScrapToolsCountReports({
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
class ListScrapToolsCountReportsData {
  final List<ListScrapToolsCountReportsScrapToolsCountReports> scrapToolsCountReports;
  ListScrapToolsCountReportsData.fromJson(dynamic json):
  
  scrapToolsCountReports = (json['scrapToolsCountReports'] as List<dynamic>)
        .map((e) => ListScrapToolsCountReportsScrapToolsCountReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListScrapToolsCountReportsData otherTyped = other as ListScrapToolsCountReportsData;
    return scrapToolsCountReports == otherTyped.scrapToolsCountReports;
    
  }
  @override
  int get hashCode => scrapToolsCountReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapToolsCountReports'] = scrapToolsCountReports.map((e) => e.toJson()).toList();
    return json;
  }

  ListScrapToolsCountReportsData({
    required this.scrapToolsCountReports,
  });
}

@immutable
class ListScrapToolsCountReportsVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListScrapToolsCountReportsVariables.fromJson(Map<String, dynamic> json) {
  
  
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

    final ListScrapToolsCountReportsVariables otherTyped = other as ListScrapToolsCountReportsVariables;
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

  ListScrapToolsCountReportsVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

