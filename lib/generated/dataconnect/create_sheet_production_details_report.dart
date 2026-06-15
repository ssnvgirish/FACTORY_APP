part of 'default.dart';

class CreateSheetProductionDetailsReportVariablesBuilder {
  DateTime date;
  String machineNumber;
  String shift;
  int totalQuantity;
  double totalWeight;
  double totalRunningFeet;
  String createdBy;
  Optional<Timestamp> _submittedAt = Optional.optional((json) => json['submittedAt'] = Timestamp.fromJson(json['submittedAt']), defaultSerializer);

  final FirebaseDataConnect _dataConnect;  CreateSheetProductionDetailsReportVariablesBuilder submittedAt(Timestamp? t) {
   _submittedAt.value = t;
   return this;
  }

  CreateSheetProductionDetailsReportVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.shift,required  this.totalQuantity,required  this.totalWeight,required  this.totalRunningFeet,required  this.createdBy,});
  Deserializer<CreateSheetProductionDetailsReportData> dataDeserializer = (dynamic json)  => CreateSheetProductionDetailsReportData.fromJson(jsonDecode(json));
  Serializer<CreateSheetProductionDetailsReportVariables> varsSerializer = (CreateSheetProductionDetailsReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateSheetProductionDetailsReportData, CreateSheetProductionDetailsReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateSheetProductionDetailsReportData, CreateSheetProductionDetailsReportVariables> ref() {
    CreateSheetProductionDetailsReportVariables vars= CreateSheetProductionDetailsReportVariables(date: date,machineNumber: machineNumber,shift: shift,totalQuantity: totalQuantity,totalWeight: totalWeight,totalRunningFeet: totalRunningFeet,createdBy: createdBy,submittedAt: _submittedAt,);
    return _dataConnect.mutation("CreateSheetProductionDetailsReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateSheetProductionDetailsReportSheetProductionDetailsReportInsert {
  final String id;
  CreateSheetProductionDetailsReportSheetProductionDetailsReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetProductionDetailsReportSheetProductionDetailsReportInsert otherTyped = other as CreateSheetProductionDetailsReportSheetProductionDetailsReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetProductionDetailsReportSheetProductionDetailsReportInsert({
    required this.id,
  });
}

@immutable
class CreateSheetProductionDetailsReportData {
  final CreateSheetProductionDetailsReportSheetProductionDetailsReportInsert sheetProductionDetailsReport_insert;
  CreateSheetProductionDetailsReportData.fromJson(dynamic json):
  
  sheetProductionDetailsReport_insert = CreateSheetProductionDetailsReportSheetProductionDetailsReportInsert.fromJson(json['sheetProductionDetailsReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetProductionDetailsReportData otherTyped = other as CreateSheetProductionDetailsReportData;
    return sheetProductionDetailsReport_insert == otherTyped.sheetProductionDetailsReport_insert;
    
  }
  @override
  int get hashCode => sheetProductionDetailsReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetProductionDetailsReport_insert'] = sheetProductionDetailsReport_insert.toJson();
    return json;
  }

  CreateSheetProductionDetailsReportData({
    required this.sheetProductionDetailsReport_insert,
  });
}

@immutable
class CreateSheetProductionDetailsReportVariables {
  final DateTime date;
  final String machineNumber;
  final String shift;
  final int totalQuantity;
  final double totalWeight;
  final double totalRunningFeet;
  final String createdBy;
  late final Optional<Timestamp>submittedAt;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateSheetProductionDetailsReportVariables.fromJson(Map<String, dynamic> json):
  
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalQuantity = nativeFromJson<int>(json['totalQuantity']),
  totalWeight = nativeFromJson<double>(json['totalWeight']),
  totalRunningFeet = nativeFromJson<double>(json['totalRunningFeet']),
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

    final CreateSheetProductionDetailsReportVariables otherTyped = other as CreateSheetProductionDetailsReportVariables;
    return date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalQuantity == otherTyped.totalQuantity && 
    totalWeight == otherTyped.totalWeight && 
    totalRunningFeet == otherTyped.totalRunningFeet && 
    createdBy == otherTyped.createdBy && 
    submittedAt == otherTyped.submittedAt;
    
  }
  @override
  int get hashCode => Object.hashAll([date.hashCode, machineNumber.hashCode, shift.hashCode, totalQuantity.hashCode, totalWeight.hashCode, totalRunningFeet.hashCode, createdBy.hashCode, submittedAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalQuantity'] = nativeToJson<int>(totalQuantity);
    json['totalWeight'] = nativeToJson<double>(totalWeight);
    json['totalRunningFeet'] = nativeToJson<double>(totalRunningFeet);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if(submittedAt.state == OptionalState.set) {
      json['submittedAt'] = submittedAt.toJson();
    }
    return json;
  }

  CreateSheetProductionDetailsReportVariables({
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalQuantity,
    required this.totalWeight,
    required this.totalRunningFeet,
    required this.createdBy,
    required this.submittedAt,
  });
}

