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
  final double totalMaintenanceDurationHours;
  final String createdBy;
  final Timestamp? submittedAt;
  final Timestamp? timestamp;
  final List<ListSheetHealthReportsSheetHealthReportsSheetMaintenanceEntriesOnReport> sheetMaintenanceEntries_on_report;
  ListSheetHealthReportsSheetHealthReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalMaintenanceDurationHours = nativeFromJson<double>(json['totalMaintenanceDurationHours']),
  createdBy = nativeFromJson<String>(json['createdBy']),
  submittedAt = json['submittedAt'] == null ? null : Timestamp.fromJson(json['submittedAt']),
  timestamp = json['timestamp'] == null ? null : Timestamp.fromJson(json['timestamp']),
  sheetMaintenanceEntries_on_report = (json['sheetMaintenanceEntries_on_report'] as List<dynamic>)
        .map((e) => ListSheetHealthReportsSheetHealthReportsSheetMaintenanceEntriesOnReport.fromJson(e))
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
    totalMaintenanceDurationHours == otherTyped.totalMaintenanceDurationHours && 
    createdBy == otherTyped.createdBy && 
    submittedAt == otherTyped.submittedAt && 
    timestamp == otherTyped.timestamp && 
    sheetMaintenanceEntries_on_report == otherTyped.sheetMaintenanceEntries_on_report;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, machineNumber.hashCode, shift.hashCode, totalMaintenanceDurationHours.hashCode, createdBy.hashCode, submittedAt.hashCode, timestamp.hashCode, sheetMaintenanceEntries_on_report.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalMaintenanceDurationHours'] = nativeToJson<double>(totalMaintenanceDurationHours);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if (submittedAt != null) {
      json['submittedAt'] = submittedAt!.toJson();
    }
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    json['sheetMaintenanceEntries_on_report'] = sheetMaintenanceEntries_on_report.map((e) => e.toJson()).toList();
    return json;
  }

  ListSheetHealthReportsSheetHealthReports({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalMaintenanceDurationHours,
    required this.createdBy,
    this.submittedAt,
    this.timestamp,
    required this.sheetMaintenanceEntries_on_report,
  });
}


@immutable
class ListSheetHealthReportsSheetHealthReportsSheetMaintenanceEntriesOnReport {
  final String maintenanceItem;
  final Timestamp startTime;
  final Timestamp endTime;
  final String personDoingMaintenance;
  final String description;
  final double durationHours;
  ListSheetHealthReportsSheetHealthReportsSheetMaintenanceEntriesOnReport.fromJson(dynamic json):
  
  maintenanceItem = nativeFromJson<String>(json['maintenanceItem']),
  startTime = Timestamp.fromJson(json['startTime']),
  endTime = Timestamp.fromJson(json['endTime']),
  personDoingMaintenance = nativeFromJson<String>(json['personDoingMaintenance']),
  description = nativeFromJson<String>(json['description']),
  durationHours = nativeFromJson<double>(json['durationHours']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSheetHealthReportsSheetHealthReportsSheetMaintenanceEntriesOnReport otherTyped = other as ListSheetHealthReportsSheetHealthReportsSheetMaintenanceEntriesOnReport;
    return maintenanceItem == otherTyped.maintenanceItem && 
    startTime == otherTyped.startTime && 
    endTime == otherTyped.endTime && 
    personDoingMaintenance == otherTyped.personDoingMaintenance && 
    description == otherTyped.description && 
    durationHours == otherTyped.durationHours;
    
  }
  @override
  int get hashCode => Object.hashAll([maintenanceItem.hashCode, startTime.hashCode, endTime.hashCode, personDoingMaintenance.hashCode, description.hashCode, durationHours.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['maintenanceItem'] = nativeToJson<String>(maintenanceItem);
    json['startTime'] = startTime.toJson();
    json['endTime'] = endTime.toJson();
    json['personDoingMaintenance'] = nativeToJson<String>(personDoingMaintenance);
    json['description'] = nativeToJson<String>(description);
    json['durationHours'] = nativeToJson<double>(durationHours);
    return json;
  }

  ListSheetHealthReportsSheetHealthReportsSheetMaintenanceEntriesOnReport({
    required this.maintenanceItem,
    required this.startTime,
    required this.endTime,
    required this.personDoingMaintenance,
    required this.description,
    required this.durationHours,
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

