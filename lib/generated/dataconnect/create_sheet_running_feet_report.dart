part of 'default.dart';

class CreateSheetRunningFeetReportVariablesBuilder {
  DateTime date;
  String machineNumber;
  String shift;
  double productionRunningFeet;
  double maintenanceRunningFeet;
  double totalProductionRunningFeet;
  double targetRunningFeet;
  double efficiencyPercentage;
  String createdBy;

  final FirebaseDataConnect _dataConnect;
  CreateSheetRunningFeetReportVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.shift,required  this.productionRunningFeet,required  this.maintenanceRunningFeet,required  this.totalProductionRunningFeet,required  this.targetRunningFeet,required  this.efficiencyPercentage,required  this.createdBy,});
  Deserializer<CreateSheetRunningFeetReportData> dataDeserializer = (dynamic json)  => CreateSheetRunningFeetReportData.fromJson(jsonDecode(json));
  Serializer<CreateSheetRunningFeetReportVariables> varsSerializer = (CreateSheetRunningFeetReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateSheetRunningFeetReportData, CreateSheetRunningFeetReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateSheetRunningFeetReportData, CreateSheetRunningFeetReportVariables> ref() {
    CreateSheetRunningFeetReportVariables vars= CreateSheetRunningFeetReportVariables(date: date,machineNumber: machineNumber,shift: shift,productionRunningFeet: productionRunningFeet,maintenanceRunningFeet: maintenanceRunningFeet,totalProductionRunningFeet: totalProductionRunningFeet,targetRunningFeet: targetRunningFeet,efficiencyPercentage: efficiencyPercentage,createdBy: createdBy,);
    return _dataConnect.mutation("CreateSheetRunningFeetReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateSheetRunningFeetReportSheetRunningFeetReportInsert {
  final String id;
  CreateSheetRunningFeetReportSheetRunningFeetReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetRunningFeetReportSheetRunningFeetReportInsert otherTyped = other as CreateSheetRunningFeetReportSheetRunningFeetReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetRunningFeetReportSheetRunningFeetReportInsert({
    required this.id,
  });
}

@immutable
class CreateSheetRunningFeetReportData {
  final CreateSheetRunningFeetReportSheetRunningFeetReportInsert sheetRunningFeetReport_insert;
  CreateSheetRunningFeetReportData.fromJson(dynamic json):
  
  sheetRunningFeetReport_insert = CreateSheetRunningFeetReportSheetRunningFeetReportInsert.fromJson(json['sheetRunningFeetReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetRunningFeetReportData otherTyped = other as CreateSheetRunningFeetReportData;
    return sheetRunningFeetReport_insert == otherTyped.sheetRunningFeetReport_insert;
    
  }
  @override
  int get hashCode => sheetRunningFeetReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetRunningFeetReport_insert'] = sheetRunningFeetReport_insert.toJson();
    return json;
  }

  CreateSheetRunningFeetReportData({
    required this.sheetRunningFeetReport_insert,
  });
}

@immutable
class CreateSheetRunningFeetReportVariables {
  final DateTime date;
  final String machineNumber;
  final String shift;
  final double productionRunningFeet;
  final double maintenanceRunningFeet;
  final double totalProductionRunningFeet;
  final double targetRunningFeet;
  final double efficiencyPercentage;
  final String createdBy;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateSheetRunningFeetReportVariables.fromJson(Map<String, dynamic> json):
  
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  productionRunningFeet = nativeFromJson<double>(json['productionRunningFeet']),
  maintenanceRunningFeet = nativeFromJson<double>(json['maintenanceRunningFeet']),
  totalProductionRunningFeet = nativeFromJson<double>(json['totalProductionRunningFeet']),
  targetRunningFeet = nativeFromJson<double>(json['targetRunningFeet']),
  efficiencyPercentage = nativeFromJson<double>(json['efficiencyPercentage']),
  createdBy = nativeFromJson<String>(json['createdBy']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetRunningFeetReportVariables otherTyped = other as CreateSheetRunningFeetReportVariables;
    return date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    productionRunningFeet == otherTyped.productionRunningFeet && 
    maintenanceRunningFeet == otherTyped.maintenanceRunningFeet && 
    totalProductionRunningFeet == otherTyped.totalProductionRunningFeet && 
    targetRunningFeet == otherTyped.targetRunningFeet && 
    efficiencyPercentage == otherTyped.efficiencyPercentage && 
    createdBy == otherTyped.createdBy;
    
  }
  @override
  int get hashCode => Object.hashAll([date.hashCode, machineNumber.hashCode, shift.hashCode, productionRunningFeet.hashCode, maintenanceRunningFeet.hashCode, totalProductionRunningFeet.hashCode, targetRunningFeet.hashCode, efficiencyPercentage.hashCode, createdBy.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['productionRunningFeet'] = nativeToJson<double>(productionRunningFeet);
    json['maintenanceRunningFeet'] = nativeToJson<double>(maintenanceRunningFeet);
    json['totalProductionRunningFeet'] = nativeToJson<double>(totalProductionRunningFeet);
    json['targetRunningFeet'] = nativeToJson<double>(targetRunningFeet);
    json['efficiencyPercentage'] = nativeToJson<double>(efficiencyPercentage);
    json['createdBy'] = nativeToJson<String>(createdBy);
    return json;
  }

  CreateSheetRunningFeetReportVariables({
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.productionRunningFeet,
    required this.maintenanceRunningFeet,
    required this.totalProductionRunningFeet,
    required this.targetRunningFeet,
    required this.efficiencyPercentage,
    required this.createdBy,
  });
}

