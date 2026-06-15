part of 'default.dart';

class CreateScrapProductionDetailsReportVariablesBuilder {
  DateTime date;
  String machineNumber;
  String shift;
  double totalProductionWeight;
  String createdBy;
  Optional<Timestamp> _submittedAt = Optional.optional((json) => json['submittedAt'] = Timestamp.fromJson(json['submittedAt']), defaultSerializer);

  final FirebaseDataConnect _dataConnect;  CreateScrapProductionDetailsReportVariablesBuilder submittedAt(Timestamp? t) {
   _submittedAt.value = t;
   return this;
  }

  CreateScrapProductionDetailsReportVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.shift,required  this.totalProductionWeight,required  this.createdBy,});
  Deserializer<CreateScrapProductionDetailsReportData> dataDeserializer = (dynamic json)  => CreateScrapProductionDetailsReportData.fromJson(jsonDecode(json));
  Serializer<CreateScrapProductionDetailsReportVariables> varsSerializer = (CreateScrapProductionDetailsReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateScrapProductionDetailsReportData, CreateScrapProductionDetailsReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateScrapProductionDetailsReportData, CreateScrapProductionDetailsReportVariables> ref() {
    CreateScrapProductionDetailsReportVariables vars= CreateScrapProductionDetailsReportVariables(date: date,machineNumber: machineNumber,shift: shift,totalProductionWeight: totalProductionWeight,createdBy: createdBy,submittedAt: _submittedAt,);
    return _dataConnect.mutation("CreateScrapProductionDetailsReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateScrapProductionDetailsReportScrapProductionDetailsReportInsert {
  final String id;
  CreateScrapProductionDetailsReportScrapProductionDetailsReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapProductionDetailsReportScrapProductionDetailsReportInsert otherTyped = other as CreateScrapProductionDetailsReportScrapProductionDetailsReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateScrapProductionDetailsReportScrapProductionDetailsReportInsert({
    required this.id,
  });
}

@immutable
class CreateScrapProductionDetailsReportData {
  final CreateScrapProductionDetailsReportScrapProductionDetailsReportInsert scrapProductionDetailsReport_insert;
  CreateScrapProductionDetailsReportData.fromJson(dynamic json):
  
  scrapProductionDetailsReport_insert = CreateScrapProductionDetailsReportScrapProductionDetailsReportInsert.fromJson(json['scrapProductionDetailsReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapProductionDetailsReportData otherTyped = other as CreateScrapProductionDetailsReportData;
    return scrapProductionDetailsReport_insert == otherTyped.scrapProductionDetailsReport_insert;
    
  }
  @override
  int get hashCode => scrapProductionDetailsReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapProductionDetailsReport_insert'] = scrapProductionDetailsReport_insert.toJson();
    return json;
  }

  CreateScrapProductionDetailsReportData({
    required this.scrapProductionDetailsReport_insert,
  });
}

@immutable
class CreateScrapProductionDetailsReportVariables {
  final DateTime date;
  final String machineNumber;
  final String shift;
  final double totalProductionWeight;
  final String createdBy;
  late final Optional<Timestamp>submittedAt;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateScrapProductionDetailsReportVariables.fromJson(Map<String, dynamic> json):
  
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalProductionWeight = nativeFromJson<double>(json['totalProductionWeight']),
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

    final CreateScrapProductionDetailsReportVariables otherTyped = other as CreateScrapProductionDetailsReportVariables;
    return date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalProductionWeight == otherTyped.totalProductionWeight && 
    createdBy == otherTyped.createdBy && 
    submittedAt == otherTyped.submittedAt;
    
  }
  @override
  int get hashCode => Object.hashAll([date.hashCode, machineNumber.hashCode, shift.hashCode, totalProductionWeight.hashCode, createdBy.hashCode, submittedAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalProductionWeight'] = nativeToJson<double>(totalProductionWeight);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if(submittedAt.state == OptionalState.set) {
      json['submittedAt'] = submittedAt.toJson();
    }
    return json;
  }

  CreateScrapProductionDetailsReportVariables({
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalProductionWeight,
    required this.createdBy,
    required this.submittedAt,
  });
}

