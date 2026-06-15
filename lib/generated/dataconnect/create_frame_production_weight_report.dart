part of 'default.dart';

class CreateFrameProductionWeightReportVariablesBuilder {
  DateTime date;
  String machineNumber;
  String shift;
  double productionWeight;
  double maintenanceWeight;
  double totalProductionWeight;
  double targetWeight;
  double efficiencyPercentage;
  String createdBy;

  final FirebaseDataConnect _dataConnect;
  CreateFrameProductionWeightReportVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.shift,required  this.productionWeight,required  this.maintenanceWeight,required  this.totalProductionWeight,required  this.targetWeight,required  this.efficiencyPercentage,required  this.createdBy,});
  Deserializer<CreateFrameProductionWeightReportData> dataDeserializer = (dynamic json)  => CreateFrameProductionWeightReportData.fromJson(jsonDecode(json));
  Serializer<CreateFrameProductionWeightReportVariables> varsSerializer = (CreateFrameProductionWeightReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateFrameProductionWeightReportData, CreateFrameProductionWeightReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateFrameProductionWeightReportData, CreateFrameProductionWeightReportVariables> ref() {
    CreateFrameProductionWeightReportVariables vars= CreateFrameProductionWeightReportVariables(date: date,machineNumber: machineNumber,shift: shift,productionWeight: productionWeight,maintenanceWeight: maintenanceWeight,totalProductionWeight: totalProductionWeight,targetWeight: targetWeight,efficiencyPercentage: efficiencyPercentage,createdBy: createdBy,);
    return _dataConnect.mutation("CreateFrameProductionWeightReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateFrameProductionWeightReportFrameProductionWeightReportInsert {
  final String id;
  CreateFrameProductionWeightReportFrameProductionWeightReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameProductionWeightReportFrameProductionWeightReportInsert otherTyped = other as CreateFrameProductionWeightReportFrameProductionWeightReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateFrameProductionWeightReportFrameProductionWeightReportInsert({
    required this.id,
  });
}

@immutable
class CreateFrameProductionWeightReportData {
  final CreateFrameProductionWeightReportFrameProductionWeightReportInsert frameProductionWeightReport_insert;
  CreateFrameProductionWeightReportData.fromJson(dynamic json):
  
  frameProductionWeightReport_insert = CreateFrameProductionWeightReportFrameProductionWeightReportInsert.fromJson(json['frameProductionWeightReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameProductionWeightReportData otherTyped = other as CreateFrameProductionWeightReportData;
    return frameProductionWeightReport_insert == otherTyped.frameProductionWeightReport_insert;
    
  }
  @override
  int get hashCode => frameProductionWeightReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameProductionWeightReport_insert'] = frameProductionWeightReport_insert.toJson();
    return json;
  }

  CreateFrameProductionWeightReportData({
    required this.frameProductionWeightReport_insert,
  });
}

@immutable
class CreateFrameProductionWeightReportVariables {
  final DateTime date;
  final String machineNumber;
  final String shift;
  final double productionWeight;
  final double maintenanceWeight;
  final double totalProductionWeight;
  final double targetWeight;
  final double efficiencyPercentage;
  final String createdBy;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateFrameProductionWeightReportVariables.fromJson(Map<String, dynamic> json):
  
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  productionWeight = nativeFromJson<double>(json['productionWeight']),
  maintenanceWeight = nativeFromJson<double>(json['maintenanceWeight']),
  totalProductionWeight = nativeFromJson<double>(json['totalProductionWeight']),
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

    final CreateFrameProductionWeightReportVariables otherTyped = other as CreateFrameProductionWeightReportVariables;
    return date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    productionWeight == otherTyped.productionWeight && 
    maintenanceWeight == otherTyped.maintenanceWeight && 
    totalProductionWeight == otherTyped.totalProductionWeight && 
    targetWeight == otherTyped.targetWeight && 
    efficiencyPercentage == otherTyped.efficiencyPercentage && 
    createdBy == otherTyped.createdBy;
    
  }
  @override
  int get hashCode => Object.hashAll([date.hashCode, machineNumber.hashCode, shift.hashCode, productionWeight.hashCode, maintenanceWeight.hashCode, totalProductionWeight.hashCode, targetWeight.hashCode, efficiencyPercentage.hashCode, createdBy.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['productionWeight'] = nativeToJson<double>(productionWeight);
    json['maintenanceWeight'] = nativeToJson<double>(maintenanceWeight);
    json['totalProductionWeight'] = nativeToJson<double>(totalProductionWeight);
    json['targetWeight'] = nativeToJson<double>(targetWeight);
    json['efficiencyPercentage'] = nativeToJson<double>(efficiencyPercentage);
    json['createdBy'] = nativeToJson<String>(createdBy);
    return json;
  }

  CreateFrameProductionWeightReportVariables({
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.productionWeight,
    required this.maintenanceWeight,
    required this.totalProductionWeight,
    required this.targetWeight,
    required this.efficiencyPercentage,
    required this.createdBy,
  });
}

