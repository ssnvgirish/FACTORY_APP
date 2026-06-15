part of 'default.dart';

class CreateFrameCustomerRejectionReportVariablesBuilder {
  DateTime originalProductionDate;
  DateTime rejectionDate;
  String machineNumber;
  String shift;
  double totalRejectedWeight;
  String createdBy;

  final FirebaseDataConnect _dataConnect;
  CreateFrameCustomerRejectionReportVariablesBuilder(this._dataConnect, {required  this.originalProductionDate,required  this.rejectionDate,required  this.machineNumber,required  this.shift,required  this.totalRejectedWeight,required  this.createdBy,});
  Deserializer<CreateFrameCustomerRejectionReportData> dataDeserializer = (dynamic json)  => CreateFrameCustomerRejectionReportData.fromJson(jsonDecode(json));
  Serializer<CreateFrameCustomerRejectionReportVariables> varsSerializer = (CreateFrameCustomerRejectionReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateFrameCustomerRejectionReportData, CreateFrameCustomerRejectionReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateFrameCustomerRejectionReportData, CreateFrameCustomerRejectionReportVariables> ref() {
    CreateFrameCustomerRejectionReportVariables vars= CreateFrameCustomerRejectionReportVariables(originalProductionDate: originalProductionDate,rejectionDate: rejectionDate,machineNumber: machineNumber,shift: shift,totalRejectedWeight: totalRejectedWeight,createdBy: createdBy,);
    return _dataConnect.mutation("CreateFrameCustomerRejectionReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateFrameCustomerRejectionReportFrameCustomerRejectionReportInsert {
  final String id;
  CreateFrameCustomerRejectionReportFrameCustomerRejectionReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameCustomerRejectionReportFrameCustomerRejectionReportInsert otherTyped = other as CreateFrameCustomerRejectionReportFrameCustomerRejectionReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateFrameCustomerRejectionReportFrameCustomerRejectionReportInsert({
    required this.id,
  });
}

@immutable
class CreateFrameCustomerRejectionReportData {
  final CreateFrameCustomerRejectionReportFrameCustomerRejectionReportInsert frameCustomerRejectionReport_insert;
  CreateFrameCustomerRejectionReportData.fromJson(dynamic json):
  
  frameCustomerRejectionReport_insert = CreateFrameCustomerRejectionReportFrameCustomerRejectionReportInsert.fromJson(json['frameCustomerRejectionReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameCustomerRejectionReportData otherTyped = other as CreateFrameCustomerRejectionReportData;
    return frameCustomerRejectionReport_insert == otherTyped.frameCustomerRejectionReport_insert;
    
  }
  @override
  int get hashCode => frameCustomerRejectionReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameCustomerRejectionReport_insert'] = frameCustomerRejectionReport_insert.toJson();
    return json;
  }

  CreateFrameCustomerRejectionReportData({
    required this.frameCustomerRejectionReport_insert,
  });
}

@immutable
class CreateFrameCustomerRejectionReportVariables {
  final DateTime originalProductionDate;
  final DateTime rejectionDate;
  final String machineNumber;
  final String shift;
  final double totalRejectedWeight;
  final String createdBy;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateFrameCustomerRejectionReportVariables.fromJson(Map<String, dynamic> json):
  
  originalProductionDate = nativeFromJson<DateTime>(json['originalProductionDate']),
  rejectionDate = nativeFromJson<DateTime>(json['rejectionDate']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalRejectedWeight = nativeFromJson<double>(json['totalRejectedWeight']),
  createdBy = nativeFromJson<String>(json['createdBy']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameCustomerRejectionReportVariables otherTyped = other as CreateFrameCustomerRejectionReportVariables;
    return originalProductionDate == otherTyped.originalProductionDate && 
    rejectionDate == otherTyped.rejectionDate && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalRejectedWeight == otherTyped.totalRejectedWeight && 
    createdBy == otherTyped.createdBy;
    
  }
  @override
  int get hashCode => Object.hashAll([originalProductionDate.hashCode, rejectionDate.hashCode, machineNumber.hashCode, shift.hashCode, totalRejectedWeight.hashCode, createdBy.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['originalProductionDate'] = nativeToJson<DateTime>(originalProductionDate);
    json['rejectionDate'] = nativeToJson<DateTime>(rejectionDate);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalRejectedWeight'] = nativeToJson<double>(totalRejectedWeight);
    json['createdBy'] = nativeToJson<String>(createdBy);
    return json;
  }

  CreateFrameCustomerRejectionReportVariables({
    required this.originalProductionDate,
    required this.rejectionDate,
    required this.machineNumber,
    required this.shift,
    required this.totalRejectedWeight,
    required this.createdBy,
  });
}

