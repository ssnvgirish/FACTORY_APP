part of 'default.dart';

class CreateFrameHealthReportVariablesBuilder {
  DateTime date;
  String machineNumber;
  String shift;
  double totalMaintenanceDurationHours;
  String createdBy;
  Optional<Timestamp> _submittedAt = Optional.optional(
    (json) => json['submittedAt'] = Timestamp.fromJson(json['submittedAt']),
    defaultSerializer,
  );

  final FirebaseDataConnect _dataConnect;
  CreateFrameHealthReportVariablesBuilder submittedAt(Timestamp? t) {
    _submittedAt.value = t;
    return this;
  }

  CreateFrameHealthReportVariablesBuilder(
    this._dataConnect, {
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalMaintenanceDurationHours,
    required this.createdBy,
  });
  Deserializer<CreateFrameHealthReportData> dataDeserializer = (dynamic json) =>
      CreateFrameHealthReportData.fromJson(jsonDecode(json));
  Serializer<CreateFrameHealthReportVariables> varsSerializer =
      (CreateFrameHealthReportVariables vars) => jsonEncode(vars.toJson());
  Future<
    OperationResult<
      CreateFrameHealthReportData,
      CreateFrameHealthReportVariables
    >
  >
  execute() {
    return ref().execute();
  }

  MutationRef<CreateFrameHealthReportData, CreateFrameHealthReportVariables>
  ref() {
    CreateFrameHealthReportVariables vars = CreateFrameHealthReportVariables(
      date: date,
      machineNumber: machineNumber,
      shift: shift,
      totalMaintenanceDurationHours: totalMaintenanceDurationHours,
      createdBy: createdBy,
      submittedAt: _submittedAt,
    );
    return _dataConnect.mutation(
      "CreateFrameHealthReport",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class CreateFrameHealthReportFrameHealthReportInsert {
  final String id;
  CreateFrameHealthReportFrameHealthReportInsert.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameHealthReportFrameHealthReportInsert otherTyped =
        other as CreateFrameHealthReportFrameHealthReportInsert;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateFrameHealthReportFrameHealthReportInsert({required this.id});
}

@immutable
class CreateFrameHealthReportData {
  final CreateFrameHealthReportFrameHealthReportInsert frameHealthReport_insert;
  CreateFrameHealthReportData.fromJson(dynamic json)
    : frameHealthReport_insert =
          CreateFrameHealthReportFrameHealthReportInsert.fromJson(
            json['frameHealthReport_insert'],
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameHealthReportData otherTyped =
        other as CreateFrameHealthReportData;
    return frameHealthReport_insert == otherTyped.frameHealthReport_insert;
  }

  @override
  int get hashCode => frameHealthReport_insert.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameHealthReport_insert'] = frameHealthReport_insert.toJson();
    return json;
  }

  CreateFrameHealthReportData({required this.frameHealthReport_insert});
}

@immutable
class CreateFrameHealthReportVariables {
  final DateTime date;
  final String machineNumber;
  final String shift;
  final double totalMaintenanceDurationHours;
  final String createdBy;
  late final Optional<Timestamp> submittedAt;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  CreateFrameHealthReportVariables.fromJson(Map<String, dynamic> json)
    : date = nativeFromJson<DateTime>(json['date']),
      machineNumber = nativeFromJson<String>(json['machineNumber']),
      shift = nativeFromJson<String>(json['shift']),
      totalMaintenanceDurationHours = nativeFromJson<double>(
        json['totalMaintenanceDurationHours'],
      ),
      createdBy = nativeFromJson<String>(json['createdBy']) {
    submittedAt = Optional.optional(
      (json) => json['submittedAt'] = Timestamp.fromJson(json['submittedAt']),
      defaultSerializer,
    );
    submittedAt.value = json['submittedAt'] == null
        ? null
        : Timestamp.fromJson(json['submittedAt']);
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameHealthReportVariables otherTyped =
        other as CreateFrameHealthReportVariables;
    return date == otherTyped.date &&
        machineNumber == otherTyped.machineNumber &&
        shift == otherTyped.shift &&
        totalMaintenanceDurationHours ==
            otherTyped.totalMaintenanceDurationHours &&
        createdBy == otherTyped.createdBy &&
        submittedAt == otherTyped.submittedAt;
  }

  @override
  int get hashCode => Object.hashAll([
    date.hashCode,
    machineNumber.hashCode,
    shift.hashCode,
    totalMaintenanceDurationHours.hashCode,
    createdBy.hashCode,
    submittedAt.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalMaintenanceDurationHours'] = nativeToJson<double>(
      totalMaintenanceDurationHours,
    );
    json['createdBy'] = nativeToJson<String>(createdBy);
    if (submittedAt.state == OptionalState.set) {
      json['submittedAt'] = submittedAt.toJson();
    }
    return json;
  }

  CreateFrameHealthReportVariables({
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalMaintenanceDurationHours,
    required this.createdBy,
    required this.submittedAt,
  });
}
