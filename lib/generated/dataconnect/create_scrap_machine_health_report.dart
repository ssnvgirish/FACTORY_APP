part of 'default.dart';

class CreateScrapMachineHealthReportVariablesBuilder {
  DateTime date;
  String machineNumber;
  String shift;
  double totalMaintenanceDurationHours;
  String createdBy;
  Optional<Timestamp> _submittedAt = Optional.optional((json) => json['submittedAt'] = Timestamp.fromJson(json['submittedAt']), defaultSerializer);

  final FirebaseDataConnect _dataConnect;  CreateScrapMachineHealthReportVariablesBuilder submittedAt(Timestamp? t) {
   _submittedAt.value = t;
   return this;
  }

  CreateScrapMachineHealthReportVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.shift,required  this.totalMaintenanceDurationHours,required  this.createdBy,});
  Deserializer<CreateScrapMachineHealthReportData> dataDeserializer = (dynamic json)  => CreateScrapMachineHealthReportData.fromJson(jsonDecode(json));
  Serializer<CreateScrapMachineHealthReportVariables> varsSerializer = (CreateScrapMachineHealthReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateScrapMachineHealthReportData, CreateScrapMachineHealthReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateScrapMachineHealthReportData, CreateScrapMachineHealthReportVariables> ref() {
    CreateScrapMachineHealthReportVariables vars= CreateScrapMachineHealthReportVariables(date: date,machineNumber: machineNumber,shift: shift,totalMaintenanceDurationHours: totalMaintenanceDurationHours,createdBy: createdBy,submittedAt: _submittedAt,);
    return _dataConnect.mutation("CreateScrapMachineHealthReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateScrapMachineHealthReportScrapMachineHealthReportInsert {
  final String id;
  CreateScrapMachineHealthReportScrapMachineHealthReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapMachineHealthReportScrapMachineHealthReportInsert otherTyped = other as CreateScrapMachineHealthReportScrapMachineHealthReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateScrapMachineHealthReportScrapMachineHealthReportInsert({
    required this.id,
  });
}

@immutable
class CreateScrapMachineHealthReportData {
  final CreateScrapMachineHealthReportScrapMachineHealthReportInsert scrapMachineHealthReport_insert;
  CreateScrapMachineHealthReportData.fromJson(dynamic json):
  
  scrapMachineHealthReport_insert = CreateScrapMachineHealthReportScrapMachineHealthReportInsert.fromJson(json['scrapMachineHealthReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapMachineHealthReportData otherTyped = other as CreateScrapMachineHealthReportData;
    return scrapMachineHealthReport_insert == otherTyped.scrapMachineHealthReport_insert;
    
  }
  @override
  int get hashCode => scrapMachineHealthReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapMachineHealthReport_insert'] = scrapMachineHealthReport_insert.toJson();
    return json;
  }

  CreateScrapMachineHealthReportData({
    required this.scrapMachineHealthReport_insert,
  });
}

@immutable
class CreateScrapMachineHealthReportVariables {
  final DateTime date;
  final String machineNumber;
  final String shift;
  final double totalMaintenanceDurationHours;
  final String createdBy;
  late final Optional<Timestamp>submittedAt;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateScrapMachineHealthReportVariables.fromJson(Map<String, dynamic> json):
  
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalMaintenanceDurationHours = nativeFromJson<double>(json['totalMaintenanceDurationHours']),
  createdBy = nativeFromJson<String>(json['createdBy']) {
  
  
  
  
  
  
  
    submittedAt = Optional.optional((json) => json['submittedAt'] = Timestamp.fromJson(json['submittedAt']), defaultSerializer);
    submittedAt.value = json['submittedAt'] == null ? null : Timestamp.fromJson(json['submittedAt']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapMachineHealthReportVariables otherTyped = other as CreateScrapMachineHealthReportVariables;
    return date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalMaintenanceDurationHours == otherTyped.totalMaintenanceDurationHours && 
    createdBy == otherTyped.createdBy && 
    submittedAt == otherTyped.submittedAt;
    
  }
  @override
  int get hashCode => Object.hashAll([date.hashCode, machineNumber.hashCode, shift.hashCode, totalMaintenanceDurationHours.hashCode, createdBy.hashCode, submittedAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalMaintenanceDurationHours'] = nativeToJson<double>(totalMaintenanceDurationHours);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if(submittedAt.state == OptionalState.set) {
      json['submittedAt'] = submittedAt.toJson();
    }
    return json;
  }

  CreateScrapMachineHealthReportVariables({
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalMaintenanceDurationHours,
    required this.createdBy,
    required this.submittedAt,
  });
}

