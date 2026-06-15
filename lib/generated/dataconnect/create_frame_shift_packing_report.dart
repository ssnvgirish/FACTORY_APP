part of 'default.dart';

class CreateFrameShiftPackingReportVariablesBuilder {
  DateTime date;
  String machineNumber;
  String shift;
  double totalRejectedWeight;
  double qualityAcceptancePercentage;
  double packingEfficiency;
  String createdBy;

  final FirebaseDataConnect _dataConnect;
  CreateFrameShiftPackingReportVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.shift,required  this.totalRejectedWeight,required  this.qualityAcceptancePercentage,required  this.packingEfficiency,required  this.createdBy,});
  Deserializer<CreateFrameShiftPackingReportData> dataDeserializer = (dynamic json)  => CreateFrameShiftPackingReportData.fromJson(jsonDecode(json));
  Serializer<CreateFrameShiftPackingReportVariables> varsSerializer = (CreateFrameShiftPackingReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateFrameShiftPackingReportData, CreateFrameShiftPackingReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateFrameShiftPackingReportData, CreateFrameShiftPackingReportVariables> ref() {
    CreateFrameShiftPackingReportVariables vars= CreateFrameShiftPackingReportVariables(date: date,machineNumber: machineNumber,shift: shift,totalRejectedWeight: totalRejectedWeight,qualityAcceptancePercentage: qualityAcceptancePercentage,packingEfficiency: packingEfficiency,createdBy: createdBy,);
    return _dataConnect.mutation("CreateFrameShiftPackingReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateFrameShiftPackingReportFrameShiftPackingReportInsert {
  final String id;
  CreateFrameShiftPackingReportFrameShiftPackingReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameShiftPackingReportFrameShiftPackingReportInsert otherTyped = other as CreateFrameShiftPackingReportFrameShiftPackingReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateFrameShiftPackingReportFrameShiftPackingReportInsert({
    required this.id,
  });
}

@immutable
class CreateFrameShiftPackingReportData {
  final CreateFrameShiftPackingReportFrameShiftPackingReportInsert frameShiftPackingReport_insert;
  CreateFrameShiftPackingReportData.fromJson(dynamic json):
  
  frameShiftPackingReport_insert = CreateFrameShiftPackingReportFrameShiftPackingReportInsert.fromJson(json['frameShiftPackingReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameShiftPackingReportData otherTyped = other as CreateFrameShiftPackingReportData;
    return frameShiftPackingReport_insert == otherTyped.frameShiftPackingReport_insert;
    
  }
  @override
  int get hashCode => frameShiftPackingReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameShiftPackingReport_insert'] = frameShiftPackingReport_insert.toJson();
    return json;
  }

  CreateFrameShiftPackingReportData({
    required this.frameShiftPackingReport_insert,
  });
}

@immutable
class CreateFrameShiftPackingReportVariables {
  final DateTime date;
  final String machineNumber;
  final String shift;
  final double totalRejectedWeight;
  final double qualityAcceptancePercentage;
  final double packingEfficiency;
  final String createdBy;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateFrameShiftPackingReportVariables.fromJson(Map<String, dynamic> json):
  
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalRejectedWeight = nativeFromJson<double>(json['totalRejectedWeight']),
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

    final CreateFrameShiftPackingReportVariables otherTyped = other as CreateFrameShiftPackingReportVariables;
    return date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalRejectedWeight == otherTyped.totalRejectedWeight && 
    qualityAcceptancePercentage == otherTyped.qualityAcceptancePercentage && 
    packingEfficiency == otherTyped.packingEfficiency && 
    createdBy == otherTyped.createdBy;
    
  }
  @override
  int get hashCode => Object.hashAll([date.hashCode, machineNumber.hashCode, shift.hashCode, totalRejectedWeight.hashCode, qualityAcceptancePercentage.hashCode, packingEfficiency.hashCode, createdBy.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalRejectedWeight'] = nativeToJson<double>(totalRejectedWeight);
    json['qualityAcceptancePercentage'] = nativeToJson<double>(qualityAcceptancePercentage);
    json['packingEfficiency'] = nativeToJson<double>(packingEfficiency);
    json['createdBy'] = nativeToJson<String>(createdBy);
    return json;
  }

  CreateFrameShiftPackingReportVariables({
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalRejectedWeight,
    required this.qualityAcceptancePercentage,
    required this.packingEfficiency,
    required this.createdBy,
  });
}

