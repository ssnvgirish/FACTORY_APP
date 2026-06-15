part of 'default.dart';

class ListSheetHealthReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListSheetHealthReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListSheetHealthReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListSheetHealthReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListSheetHealthReportsVariablesBuilder(this._dataConnect, );
  Deserializer<ListSheetHealthReportsData> dataDeserializer = (dynamic json)  => ListSheetHealthReportsData.fromJson(jsonDecode(json));
  Serializer<ListSheetHealthReportsVariables> varsSerializer = (ListSheetHealthReportsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListSheetHealthReportsData, ListSheetHealthReportsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListSheetHealthReportsData, ListSheetHealthReportsVariables> ref() {
    ListSheetHealthReportsVariables vars= ListSheetHealthReportsVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListSheetHealthReports", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListSheetHealthReportsSheetHealthReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final int totalScore;
  final double percentage;
  final String createdBy;
  final Timestamp? submittedAt;
  final Timestamp? timestamp;
  final List<ListSheetHealthReportsSheetHealthReportsSheetHealthRatingItemsOnReport> sheetHealthRatingItems_on_report;
  ListSheetHealthReportsSheetHealthReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalScore = nativeFromJson<int>(json['totalScore']),
  percentage = nativeFromJson<double>(json['percentage']),
  createdBy = nativeFromJson<String>(json['createdBy']),
  submittedAt = json['submittedAt'] == null ? null : Timestamp.fromJson(json['submittedAt']),
  timestamp = json['timestamp'] == null ? null : Timestamp.fromJson(json['timestamp']),
  sheetHealthRatingItems_on_report = (json['sheetHealthRatingItems_on_report'] as List<dynamic>)
        .map((e) => ListSheetHealthReportsSheetHealthReportsSheetHealthRatingItemsOnReport.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSheetHealthReportsSheetHealthReports otherTyped = other as ListSheetHealthReportsSheetHealthReports;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalScore == otherTyped.totalScore && 
    percentage == otherTyped.percentage && 
    createdBy == otherTyped.createdBy && 
    submittedAt == otherTyped.submittedAt && 
    timestamp == otherTyped.timestamp && 
    sheetHealthRatingItems_on_report == otherTyped.sheetHealthRatingItems_on_report;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, machineNumber.hashCode, shift.hashCode, totalScore.hashCode, percentage.hashCode, createdBy.hashCode, submittedAt.hashCode, timestamp.hashCode, sheetHealthRatingItems_on_report.hashCode]);
  

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
    json['sheetHealthRatingItems_on_report'] = sheetHealthRatingItems_on_report.map((e) => e.toJson()).toList();
    return json;
  }

  ListSheetHealthReportsSheetHealthReports({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalScore,
    required this.percentage,
    required this.createdBy,
    this.submittedAt,
    this.timestamp,
    required this.sheetHealthRatingItems_on_report,
  });
}

@immutable
class ListSheetHealthReportsSheetHealthReportsSheetHealthRatingItemsOnReport {
  final String item;
  final int rating;
  ListSheetHealthReportsSheetHealthReportsSheetHealthRatingItemsOnReport.fromJson(dynamic json):
  
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

    final ListSheetHealthReportsSheetHealthReportsSheetHealthRatingItemsOnReport otherTyped = other as ListSheetHealthReportsSheetHealthReportsSheetHealthRatingItemsOnReport;
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

  ListSheetHealthReportsSheetHealthReportsSheetHealthRatingItemsOnReport({
    required this.item,
    required this.rating,
  });
}

@immutable
class ListSheetHealthReportsData {
  final List<ListSheetHealthReportsSheetHealthReports> sheetHealthReports;
  ListSheetHealthReportsData.fromJson(dynamic json):
  
  sheetHealthReports = (json['sheetHealthReports'] as List<dynamic>)
        .map((e) => ListSheetHealthReportsSheetHealthReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSheetHealthReportsData otherTyped = other as ListSheetHealthReportsData;
    return sheetHealthReports == otherTyped.sheetHealthReports;
    
  }
  @override
  int get hashCode => sheetHealthReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetHealthReports'] = sheetHealthReports.map((e) => e.toJson()).toList();
    return json;
  }

  ListSheetHealthReportsData({
    required this.sheetHealthReports,
  });
}

@immutable
class ListSheetHealthReportsVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListSheetHealthReportsVariables.fromJson(Map<String, dynamic> json) {
  
  
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

    final ListSheetHealthReportsVariables otherTyped = other as ListSheetHealthReportsVariables;
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

  ListSheetHealthReportsVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

