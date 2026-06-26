part of 'default.dart';

class ListFrameHealthReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(
    nativeFromJson,
    nativeToJson,
  );
  Optional<DateTime> _startDate = Optional.optional(
    nativeFromJson,
    nativeToJson,
  );
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

  ListFrameHealthReportsVariablesBuilder(this._dataConnect);
  Deserializer<ListFrameHealthReportsData> dataDeserializer = (dynamic json) =>
      ListFrameHealthReportsData.fromJson(jsonDecode(json));
  Serializer<ListFrameHealthReportsVariables> varsSerializer =
      (ListFrameHealthReportsVariables vars) => jsonEncode(vars.toJson());
  Future<
    QueryResult<ListFrameHealthReportsData, ListFrameHealthReportsVariables>
  >
  execute() {
    return ref().execute();
  }

  QueryRef<ListFrameHealthReportsData, ListFrameHealthReportsVariables> ref() {
    ListFrameHealthReportsVariables vars = ListFrameHealthReportsVariables(
      machineNumber: _machineNumber,
      startDate: _startDate,
      endDate: _endDate,
    );
    return _dataConnect.query(
      "ListFrameHealthReports",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class ListFrameHealthReportsFrameHealthReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final double totalMaintenanceDurationHours;
  final String createdBy;
  final Timestamp? submittedAt;
  final Timestamp? timestamp;
  final List<
    ListFrameHealthReportsFrameHealthReportsFrameMaintenanceEntriesOnReport
  >
  frameMaintenanceEntries_on_report;
  ListFrameHealthReportsFrameHealthReports.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']),
      date = nativeFromJson<DateTime>(json['date']),
      machineNumber = nativeFromJson<String>(json['machineNumber']),
      shift = nativeFromJson<String>(json['shift']),
      totalMaintenanceDurationHours = nativeFromJson<double>(
        json['totalMaintenanceDurationHours'],
      ),
      createdBy = nativeFromJson<String>(json['createdBy']),
      submittedAt = json['submittedAt'] == null
          ? null
          : Timestamp.fromJson(json['submittedAt']),
      timestamp = json['timestamp'] == null
          ? null
          : Timestamp.fromJson(json['timestamp']),
      frameMaintenanceEntries_on_report =
          (json['frameMaintenanceEntries_on_report'] as List<dynamic>)
              .map(
                (e) =>
                    ListFrameHealthReportsFrameHealthReportsFrameMaintenanceEntriesOnReport.fromJson(
                      e,
                    ),
              )
              .toList();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameHealthReportsFrameHealthReports otherTyped =
        other as ListFrameHealthReportsFrameHealthReports;
    return id == otherTyped.id &&
        date == otherTyped.date &&
        machineNumber == otherTyped.machineNumber &&
        shift == otherTyped.shift &&
        totalMaintenanceDurationHours ==
            otherTyped.totalMaintenanceDurationHours &&
        createdBy == otherTyped.createdBy &&
        submittedAt == otherTyped.submittedAt &&
        timestamp == otherTyped.timestamp &&
        frameMaintenanceEntries_on_report ==
            otherTyped.frameMaintenanceEntries_on_report;
  }

  @override
  int get hashCode => Object.hashAll([
    id.hashCode,
    date.hashCode,
    machineNumber.hashCode,
    shift.hashCode,
    totalMaintenanceDurationHours.hashCode,
    createdBy.hashCode,
    submittedAt.hashCode,
    timestamp.hashCode,
    frameMaintenanceEntries_on_report.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalMaintenanceDurationHours'] = nativeToJson<double>(
      totalMaintenanceDurationHours,
    );
    json['createdBy'] = nativeToJson<String>(createdBy);
    if (submittedAt != null) {
      json['submittedAt'] = submittedAt!.toJson();
    }
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    json['frameMaintenanceEntries_on_report'] =
        frameMaintenanceEntries_on_report.map((e) => e.toJson()).toList();
    return json;
  }

  ListFrameHealthReportsFrameHealthReports({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalMaintenanceDurationHours,
    required this.createdBy,
    this.submittedAt,
    this.timestamp,
    required this.frameMaintenanceEntries_on_report,
  });
}

@immutable
class ListFrameHealthReportsFrameHealthReportsFrameMaintenanceEntriesOnReport {
  final String maintenanceItem;
  final Timestamp startTime;
  final Timestamp endTime;
  final String personDoingMaintenance;
  final String description;
  final double durationHours;
  ListFrameHealthReportsFrameHealthReportsFrameMaintenanceEntriesOnReport.fromJson(
    dynamic json,
  ) : maintenanceItem = nativeFromJson<String>(json['maintenanceItem']),
      startTime = Timestamp.fromJson(json['startTime']),
      endTime = Timestamp.fromJson(json['endTime']),
      personDoingMaintenance = nativeFromJson<String>(
        json['personDoingMaintenance'],
      ),
      description = nativeFromJson<String>(json['description']),
      durationHours = nativeFromJson<double>(json['durationHours']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameHealthReportsFrameHealthReportsFrameMaintenanceEntriesOnReport
    otherTyped =
        other
            as ListFrameHealthReportsFrameHealthReportsFrameMaintenanceEntriesOnReport;
    return maintenanceItem == otherTyped.maintenanceItem &&
        startTime == otherTyped.startTime &&
        endTime == otherTyped.endTime &&
        personDoingMaintenance == otherTyped.personDoingMaintenance &&
        description == otherTyped.description &&
        durationHours == otherTyped.durationHours;
  }

  @override
  int get hashCode => Object.hashAll([
    maintenanceItem.hashCode,
    startTime.hashCode,
    endTime.hashCode,
    personDoingMaintenance.hashCode,
    description.hashCode,
    durationHours.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['maintenanceItem'] = nativeToJson<String>(maintenanceItem);
    json['startTime'] = startTime.toJson();
    json['endTime'] = endTime.toJson();
    json['personDoingMaintenance'] = nativeToJson<String>(
      personDoingMaintenance,
    );
    json['description'] = nativeToJson<String>(description);
    json['durationHours'] = nativeToJson<double>(durationHours);
    return json;
  }

  ListFrameHealthReportsFrameHealthReportsFrameMaintenanceEntriesOnReport({
    required this.maintenanceItem,
    required this.startTime,
    required this.endTime,
    required this.personDoingMaintenance,
    required this.description,
    required this.durationHours,
  });
}

@immutable
class ListFrameHealthReportsData {
  final List<ListFrameHealthReportsFrameHealthReports> frameHealthReports;
  ListFrameHealthReportsData.fromJson(dynamic json)
    : frameHealthReports = (json['frameHealthReports'] as List<dynamic>)
          .map((e) => ListFrameHealthReportsFrameHealthReports.fromJson(e))
          .toList();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameHealthReportsData otherTyped =
        other as ListFrameHealthReportsData;
    return frameHealthReports == otherTyped.frameHealthReports;
  }

  @override
  int get hashCode => frameHealthReports.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameHealthReports'] = frameHealthReports
        .map((e) => e.toJson())
        .toList();
    return json;
  }

  ListFrameHealthReportsData({required this.frameHealthReports});
}

@immutable
class ListFrameHealthReportsVariables {
  late final Optional<String> machineNumber;
  late final Optional<DateTime> startDate;
  late final Optional<DateTime> endDate;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  ListFrameHealthReportsVariables.fromJson(Map<String, dynamic> json) {
    machineNumber = Optional.optional(nativeFromJson, nativeToJson);
    machineNumber.value = json['machineNumber'] == null
        ? null
        : nativeFromJson<String>(json['machineNumber']);

    startDate = Optional.optional(nativeFromJson, nativeToJson);
    startDate.value = json['startDate'] == null
        ? null
        : nativeFromJson<DateTime>(json['startDate']);

    endDate = Optional.optional(nativeFromJson, nativeToJson);
    endDate.value = json['endDate'] == null
        ? null
        : nativeFromJson<DateTime>(json['endDate']);
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameHealthReportsVariables otherTyped =
        other as ListFrameHealthReportsVariables;
    return machineNumber == otherTyped.machineNumber &&
        startDate == otherTyped.startDate &&
        endDate == otherTyped.endDate;
  }

  @override
  int get hashCode => Object.hashAll([
    machineNumber.hashCode,
    startDate.hashCode,
    endDate.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (machineNumber.state == OptionalState.set) {
      json['machineNumber'] = machineNumber.toJson();
    }
    if (startDate.state == OptionalState.set) {
      json['startDate'] = startDate.toJson();
    }
    if (endDate.state == OptionalState.set) {
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
