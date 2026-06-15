part of 'default.dart';

class CreateSheetCustomerRejectionReportVariablesBuilder {
  DateTime originalProductionDate;
  String machineNumber;
  String shift;
  double totalRejectedRunningFeet;
  String createdBy;

  final FirebaseDataConnect _dataConnect;
  CreateSheetCustomerRejectionReportVariablesBuilder(this._dataConnect, {required  this.originalProductionDate,required  this.machineNumber,required  this.shift,required  this.totalRejectedRunningFeet,required  this.createdBy,});
  Deserializer<CreateSheetCustomerRejectionReportData> dataDeserializer = (dynamic json)  => CreateSheetCustomerRejectionReportData.fromJson(jsonDecode(json));
  Serializer<CreateSheetCustomerRejectionReportVariables> varsSerializer = (CreateSheetCustomerRejectionReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateSheetCustomerRejectionReportData, CreateSheetCustomerRejectionReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateSheetCustomerRejectionReportData, CreateSheetCustomerRejectionReportVariables> ref() {
    CreateSheetCustomerRejectionReportVariables vars= CreateSheetCustomerRejectionReportVariables(originalProductionDate: originalProductionDate,machineNumber: machineNumber,shift: shift,totalRejectedRunningFeet: totalRejectedRunningFeet,createdBy: createdBy,);
    return _dataConnect.mutation("CreateSheetCustomerRejectionReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateSheetCustomerRejectionReportSheetCustomerRejectionReportInsert {
  final String id;
  CreateSheetCustomerRejectionReportSheetCustomerRejectionReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetCustomerRejectionReportSheetCustomerRejectionReportInsert otherTyped = other as CreateSheetCustomerRejectionReportSheetCustomerRejectionReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetCustomerRejectionReportSheetCustomerRejectionReportInsert({
    required this.id,
  });
}

@immutable
class CreateSheetCustomerRejectionReportData {
  final CreateSheetCustomerRejectionReportSheetCustomerRejectionReportInsert sheetCustomerRejectionReport_insert;
  CreateSheetCustomerRejectionReportData.fromJson(dynamic json):
  
  sheetCustomerRejectionReport_insert = CreateSheetCustomerRejectionReportSheetCustomerRejectionReportInsert.fromJson(json['sheetCustomerRejectionReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetCustomerRejectionReportData otherTyped = other as CreateSheetCustomerRejectionReportData;
    return sheetCustomerRejectionReport_insert == otherTyped.sheetCustomerRejectionReport_insert;
    
  }
  @override
  int get hashCode => sheetCustomerRejectionReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetCustomerRejectionReport_insert'] = sheetCustomerRejectionReport_insert.toJson();
    return json;
  }

  CreateSheetCustomerRejectionReportData({
    required this.sheetCustomerRejectionReport_insert,
  });
}

@immutable
class CreateSheetCustomerRejectionReportVariables {
  final DateTime originalProductionDate;
  final String machineNumber;
  final String shift;
  final double totalRejectedRunningFeet;
  final String createdBy;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateSheetCustomerRejectionReportVariables.fromJson(Map<String, dynamic> json):
  
  originalProductionDate = nativeFromJson<DateTime>(json['originalProductionDate']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalRejectedRunningFeet = nativeFromJson<double>(json['totalRejectedRunningFeet']),
  createdBy = nativeFromJson<String>(json['createdBy']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetCustomerRejectionReportVariables otherTyped = other as CreateSheetCustomerRejectionReportVariables;
    return originalProductionDate == otherTyped.originalProductionDate && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalRejectedRunningFeet == otherTyped.totalRejectedRunningFeet && 
    createdBy == otherTyped.createdBy;
    
  }
  @override
  int get hashCode => Object.hashAll([originalProductionDate.hashCode, machineNumber.hashCode, shift.hashCode, totalRejectedRunningFeet.hashCode, createdBy.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['originalProductionDate'] = nativeToJson<DateTime>(originalProductionDate);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalRejectedRunningFeet'] = nativeToJson<double>(totalRejectedRunningFeet);
    json['createdBy'] = nativeToJson<String>(createdBy);
    return json;
  }

  CreateSheetCustomerRejectionReportVariables({
    required this.originalProductionDate,
    required this.machineNumber,
    required this.shift,
    required this.totalRejectedRunningFeet,
    required this.createdBy,
  });
}

