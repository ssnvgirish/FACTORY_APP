part of 'default.dart';

class CreateScrapProductionWeightReportVariablesBuilder {
  DateTime date;
  String machineNumber;
  String shift;
  double totalProductionWeight;
  double maintenanceWeight;
  double totalWeight;
  double targetWeight;
  double efficiencyPercentage;
  String createdBy;

  final FirebaseDataConnect _dataConnect;
  CreateScrapProductionWeightReportVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.shift,required  this.totalProductionWeight,required  this.maintenanceWeight,required  this.totalWeight,required  this.targetWeight,required  this.efficiencyPercentage,required  this.createdBy,});
  Deserializer<CreateScrapProductionWeightReportData> dataDeserializer = (dynamic json)  => CreateScrapProductionWeightReportData.fromJson(jsonDecode(json));
  Serializer<CreateScrapProductionWeightReportVariables> varsSerializer = (CreateScrapProductionWeightReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateScrapProductionWeightReportData, CreateScrapProductionWeightReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateScrapProductionWeightReportData, CreateScrapProductionWeightReportVariables> ref() {
    CreateScrapProductionWeightReportVariables vars= CreateScrapProductionWeightReportVariables(date: date,machineNumber: machineNumber,shift: shift,totalProductionWeight: totalProductionWeight,maintenanceWeight: maintenanceWeight,totalWeight: totalWeight,targetWeight: targetWeight,efficiencyPercentage: efficiencyPercentage,createdBy: createdBy,);
    return _dataConnect.mutation("CreateScrapProductionWeightReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateScrapProductionWeightReportScrapProductionWeightReportInsert {
  final String id;
  CreateScrapProductionWeightReportScrapProductionWeightReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapProductionWeightReportScrapProductionWeightReportInsert otherTyped = other as CreateScrapProductionWeightReportScrapProductionWeightReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateScrapProductionWeightReportScrapProductionWeightReportInsert({
    required this.id,
  });
}

@immutable
class CreateScrapProductionWeightReportData {
  final CreateScrapProductionWeightReportScrapProductionWeightReportInsert scrapProductionWeightReport_insert;
  CreateScrapProductionWeightReportData.fromJson(dynamic json):
  
  scrapProductionWeightReport_insert = CreateScrapProductionWeightReportScrapProductionWeightReportInsert.fromJson(json['scrapProductionWeightReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapProductionWeightReportData otherTyped = other as CreateScrapProductionWeightReportData;
    return scrapProductionWeightReport_insert == otherTyped.scrapProductionWeightReport_insert;
    
  }
  @override
  int get hashCode => scrapProductionWeightReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapProductionWeightReport_insert'] = scrapProductionWeightReport_insert.toJson();
    return json;
  }

  CreateScrapProductionWeightReportData({
    required this.scrapProductionWeightReport_insert,
  });
}

@immutable
class CreateScrapProductionWeightReportVariables {
  final DateTime date;
  final String machineNumber;
  final String shift;
  final double totalProductionWeight;
  final double maintenanceWeight;
  final double totalWeight;
  final double targetWeight;
  final double efficiencyPercentage;
  final String createdBy;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateScrapProductionWeightReportVariables.fromJson(Map<String, dynamic> json):
  
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalProductionWeight = nativeFromJson<double>(json['totalProductionWeight']),
  maintenanceWeight = nativeFromJson<double>(json['maintenanceWeight']),
  totalWeight = nativeFromJson<double>(json['totalWeight']),
  targetWeight = nativeFromJson<double>(json['targetWeight']),
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

    final CreateScrapProductionWeightReportVariables otherTyped = other as CreateScrapProductionWeightReportVariables;
    return date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalProductionWeight == otherTyped.totalProductionWeight && 
    maintenanceWeight == otherTyped.maintenanceWeight && 
    totalWeight == otherTyped.totalWeight && 
    targetWeight == otherTyped.targetWeight && 
    efficiencyPercentage == otherTyped.efficiencyPercentage && 
    createdBy == otherTyped.createdBy;
    
  }
  @override
  int get hashCode => Object.hashAll([date.hashCode, machineNumber.hashCode, shift.hashCode, totalProductionWeight.hashCode, maintenanceWeight.hashCode, totalWeight.hashCode, targetWeight.hashCode, efficiencyPercentage.hashCode, createdBy.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalProductionWeight'] = nativeToJson<double>(totalProductionWeight);
    json['maintenanceWeight'] = nativeToJson<double>(maintenanceWeight);
    json['totalWeight'] = nativeToJson<double>(totalWeight);
    json['targetWeight'] = nativeToJson<double>(targetWeight);
    json['efficiencyPercentage'] = nativeToJson<double>(efficiencyPercentage);
    json['createdBy'] = nativeToJson<String>(createdBy);
    return json;
  }

  CreateScrapProductionWeightReportVariables({
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalProductionWeight,
    required this.maintenanceWeight,
    required this.totalWeight,
    required this.targetWeight,
    required this.efficiencyPercentage,
    required this.createdBy,
  });
}

