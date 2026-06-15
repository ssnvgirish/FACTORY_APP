part of 'default.dart';

class ListFrameHealthReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListFrameHealthReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListFrameHealthReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListFrameHealthReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListFrameHealthReportsVariablesBuilder(this._dataConnect, );
  Deserializer<ListFrameHealthReportsData> dataDeserializer = (dynamic json)  => ListFrameHealthReportsData.fromJson(jsonDecode(json));
  Serializer<ListFrameHealthReportsVariables> varsSerializer = (ListFrameHealthReportsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListFrameHealthReportsData, ListFrameHealthReportsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListFrameHealthReportsData, ListFrameHealthReportsVariables> ref() {
    ListFrameHealthReportsVariables vars= ListFrameHealthReportsVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListFrameHealthReports", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListFrameHealthReportsFrameHealthReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final int totalScore;
  final double percentage;
  final String createdBy;
  final Timestamp? submittedAt;
  final Timestamp? timestamp;
  final List<ListFrameHealthReportsFrameHealthReportsFrameHealthRatingItemsOnReport> frameHealthRatingItems_on_report;
  ListFrameHealthReportsFrameHealthReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalScore = nativeFromJson<int>(json['totalScore']),
  percentage = nativeFromJson<double>(json['percentage']),
  createdBy = nativeFromJson<String>(json['createdBy']),
  submittedAt = json['submittedAt'] == null ? null : Timestamp.fromJson(json['submittedAt']),
  timestamp = json['timestamp'] == null ? null : Timestamp.fromJson(json['timestamp']),
  frameHealthRatingItems_on_report = (json['frameHealthRatingItems_on_report'] as List<dynamic>)
        .map((e) => ListFrameHealthReportsFrameHealthReportsFrameHealthRatingItemsOnReport.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameHealthReportsFrameHealthReports otherTyped = other as ListFrameHealthReportsFrameHealthReports;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalScore == otherTyped.totalScore && 
    percentage == otherTyped.percentage && 
    createdBy == otherTyped.createdBy && 
    submittedAt == otherTyped.submittedAt && 
    timestamp == otherTyped.timestamp && 
    frameHealthRatingItems_on_report == otherTyped.frameHealthRatingItems_on_report;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, machineNumber.hashCode, shift.hashCode, totalScore.hashCode, percentage.hashCode, createdBy.hashCode, submittedAt.hashCode, timestamp.hashCode, frameHealthRatingItems_on_report.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalScore'] = nativeToJson<int>(totalScore);
    json['percentage'] = nativeToJson<double>(percentage);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if (submittedAt != null) {
      json['submittedAt'] = submittedAt!.toJson();
    }
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    json['frameHealthRatingItems_on_report'] = frameHealthRatingItems_on_report.map((e) => e.toJson()).toList();
    return json;
  }

  ListFrameHealthReportsFrameHealthReports({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalScore,
    required this.percentage,
    required this.createdBy,
    this.submittedAt,
    this.timestamp,
    required this.frameHealthRatingItems_on_report,
  });
}

@immutable
class ListFrameHealthReportsFrameHealthReportsFrameHealthRatingItemsOnReport {
  final String item;
  final int rating;
  ListFrameHealthReportsFrameHealthReportsFrameHealthRatingItemsOnReport.fromJson(dynamic json):
  
  item = nativeFromJson<String>(json['item']),
  rating = nativeFromJson<int>(json['rating']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameHealthReportsFrameHealthReportsFrameHealthRatingItemsOnReport otherTyped = other as ListFrameHealthReportsFrameHealthReportsFrameHealthRatingItemsOnReport;
    return item == otherTyped.item && 
    rating == otherTyped.rating;
    
  }
  @override
  int get hashCode => Object.hashAll([item.hashCode, rating.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['item'] = nativeToJson<String>(item);
    json['rating'] = nativeToJson<int>(rating);
    return json;
  }

  ListFrameHealthReportsFrameHealthReportsFrameHealthRatingItemsOnReport({
    required this.item,
    required this.rating,
  });
}

@immutable
class ListFrameHealthReportsData {
  final List<ListFrameHealthReportsFrameHealthReports> frameHealthReports;
  ListFrameHealthReportsData.fromJson(dynamic json):
  
  frameHealthReports = (json['frameHealthReports'] as List<dynamic>)
        .map((e) => ListFrameHealthReportsFrameHealthReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameHealthReportsData otherTyped = other as ListFrameHealthReportsData;
    return frameHealthReports == otherTyped.frameHealthReports;
    
  }
  @override
  int get hashCode => frameHealthReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameHealthReports'] = frameHealthReports.map((e) => e.toJson()).toList();
    return json;
  }

  ListFrameHealthReportsData({
    required this.frameHealthReports,
  });
}

@immutable
class ListFrameHealthReportsVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListFrameHealthReportsVariables.fromJson(Map<String, dynamic> json) {
  
  
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

    final ListFrameHealthReportsVariables otherTyped = other as ListFrameHealthReportsVariables;
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

  ListFrameHealthReportsVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

