part of 'default.dart';

class CreateSheetShiftPackingReportVariablesBuilder {
  DateTime date;
  String machineNumber;
  String shift;
  double totalRejectedRunningFeet;
  double qualityAcceptancePercentage;
  double packingEfficiency;
  String createdBy;

  final FirebaseDataConnect _dataConnect;
  CreateSheetShiftPackingReportVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.shift,required  this.totalRejectedRunningFeet,required  this.qualityAcceptancePercentage,required  this.packingEfficiency,required  this.createdBy,});
  Deserializer<CreateSheetShiftPackingReportData> dataDeserializer = (dynamic json)  => CreateSheetShiftPackingReportData.fromJson(jsonDecode(json));
  Serializer<CreateSheetShiftPackingReportVariables> varsSerializer = (CreateSheetShiftPackingReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateSheetShiftPackingReportData, CreateSheetShiftPackingReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateSheetShiftPackingReportData, CreateSheetShiftPackingReportVariables> ref() {
    CreateSheetShiftPackingReportVariables vars= CreateSheetShiftPackingReportVariables(date: date,machineNumber: machineNumber,shift: shift,totalRejectedRunningFeet: totalRejectedRunningFeet,qualityAcceptancePercentage: qualityAcceptancePercentage,packingEfficiency: packingEfficiency,createdBy: createdBy,);
    return _dataConnect.mutation("CreateSheetShiftPackingReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateSheetShiftPackingReportSheetShiftPackingReportInsert {
  final String id;
  CreateSheetShiftPackingReportSheetShiftPackingReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetShiftPackingReportSheetShiftPackingReportInsert otherTyped = other as CreateSheetShiftPackingReportSheetShiftPackingReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetShiftPackingReportSheetShiftPackingReportInsert({
    required this.id,
  });
}

@immutable
class CreateSheetShiftPackingReportData {
  final CreateSheetShiftPackingReportSheetShiftPackingReportInsert sheetShiftPackingReport_insert;
  CreateSheetShiftPackingReportData.fromJson(dynamic json):
  
  sheetShiftPackingReport_insert = CreateSheetShiftPackingReportSheetShiftPackingReportInsert.fromJson(json['sheetShiftPackingReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetShiftPackingReportData otherTyped = other as CreateSheetShiftPackingReportData;
    return sheetShiftPackingReport_insert == otherTyped.sheetShiftPackingReport_insert;
    
  }
  @override
  int get hashCode => sheetShiftPackingReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetShiftPackingReport_insert'] = sheetShiftPackingReport_insert.toJson();
    return json;
  }

  CreateSheetShiftPackingReportData({
    required this.sheetShiftPackingReport_insert,
  });
}

@immutable
class CreateSheetShiftPackingReportVariables {
  final DateTime date;
  final String machineNumber;
  final String shift;
  final double totalRejectedRunningFeet;
  final double qualityAcceptancePercentage;
  final double packingEfficiency;
  final String createdBy;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateSheetShiftPackingReportVariables.fromJson(Map<String, dynamic> json):
  
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalRejectedRunningFeet = nativeFromJson<double>(json['totalRejectedRunningFeet']),
  qualityAcceptancePercentage = nativeFromJson<double>(json['qualityAcceptancePercentage']),
  packingEfficiency = nativeFromJson<double>(json['packingEfficiency']),
  createdBy = nativeFromJson<String>(json['createdBy']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetShiftPackingReportVariables otherTyped = other as CreateSheetShiftPackingReportVariables;
    return date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalRejectedRunningFeet == otherTyped.totalRejectedRunningFeet && 
    qualityAcceptancePercentage == otherTyped.qualityAcceptancePercentage && 
    packingEfficiency == otherTyped.packingEfficiency && 
    createdBy == otherTyped.createdBy;
    
  }
  @override
  int get hashCode => Object.hashAll([date.hashCode, machineNumber.hashCode, shift.hashCode, totalRejectedRunningFeet.hashCode, qualityAcceptancePercentage.hashCode, packingEfficiency.hashCode, createdBy.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalRejectedRunningFeet'] = nativeToJson<double>(totalRejectedRunningFeet);
    json['qualityAcceptancePercentage'] = nativeToJson<double>(qualityAcceptancePercentage);
    json['packingEfficiency'] = nativeToJson<double>(packingEfficiency);
    json['createdBy'] = nativeToJson<String>(createdBy);
    return json;
  }

  CreateSheetShiftPackingReportVariables({
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalRejectedRunningFeet,
    required this.qualityAcceptancePercentage,
    required this.packingEfficiency,
    required this.createdBy,
  });
}

