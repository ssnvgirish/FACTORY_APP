part of 'default.dart';

class ListSheetToolsCountReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListSheetToolsCountReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListSheetToolsCountReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListSheetToolsCountReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListSheetToolsCountReportsVariablesBuilder(this._dataConnect, );
  Deserializer<ListSheetToolsCountReportsData> dataDeserializer = (dynamic json)  => ListSheetToolsCountReportsData.fromJson(jsonDecode(json));
  Serializer<ListSheetToolsCountReportsVariables> varsSerializer = (ListSheetToolsCountReportsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListSheetToolsCountReportsData, ListSheetToolsCountReportsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListSheetToolsCountReportsData, ListSheetToolsCountReportsVariables> ref() {
    ListSheetToolsCountReportsVariables vars= ListSheetToolsCountReportsVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListSheetToolsCountReports", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListSheetToolsCountReportsSheetToolsCountReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final int totalToolsGiven;
  final int totalToolsAvailable;
  final double percentageAvailable;
  final String createdBy;
  final Timestamp? timestamp;
  ListSheetToolsCountReportsSheetToolsCountReports.fromJson(dynamic json):
  
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

    final ListSheetToolsCountReportsSheetToolsCountReports otherTyped = other as ListSheetToolsCountReportsSheetToolsCountReports;
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

  ListSheetToolsCountReportsSheetToolsCountReports({
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
class ListSheetToolsCountReportsData {
  final List<ListSheetToolsCountReportsSheetToolsCountReports> sheetToolsCountReports;
  ListSheetToolsCountReportsData.fromJson(dynamic json):
  
  sheetToolsCountReports = (json['sheetToolsCountReports'] as List<dynamic>)
        .map((e) => ListSheetToolsCountReportsSheetToolsCountReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSheetToolsCountReportsData otherTyped = other as ListSheetToolsCountReportsData;
    return sheetToolsCountReports == otherTyped.sheetToolsCountReports;
    
  }
  @override
  int get hashCode => sheetToolsCountReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetToolsCountReports'] = sheetToolsCountReports.map((e) => e.toJson()).toList();
    return json;
  }

  ListSheetToolsCountReportsData({
    required this.sheetToolsCountReports,
  });
}

@immutable
class ListSheetToolsCountReportsVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListSheetToolsCountReportsVariables.fromJson(Map<String, dynamic> json) {
  
  
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

    final ListSheetToolsCountReportsVariables otherTyped = other as ListSheetToolsCountReportsVariables;
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

  ListSheetToolsCountReportsVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

