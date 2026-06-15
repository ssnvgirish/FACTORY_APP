part of 'default.dart';

class CreateFrameProductionDetailsReportVariablesBuilder {
  DateTime date;
  String machineNumber;
  String shift;
  int totalQuantity;
  double totalWeight;
  String createdBy;
  Optional<Timestamp> _submittedAt = Optional.optional((json) => json['submittedAt'] = Timestamp.fromJson(json['submittedAt']), defaultSerializer);

  final FirebaseDataConnect _dataConnect;  CreateFrameProductionDetailsReportVariablesBuilder submittedAt(Timestamp? t) {
   _submittedAt.value = t;
   return this;
  }

  CreateFrameProductionDetailsReportVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.shift,required  this.totalQuantity,required  this.totalWeight,required  this.createdBy,});
  Deserializer<CreateFrameProductionDetailsReportData> dataDeserializer = (dynamic json)  => CreateFrameProductionDetailsReportData.fromJson(jsonDecode(json));
  Serializer<CreateFrameProductionDetailsReportVariables> varsSerializer = (CreateFrameProductionDetailsReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateFrameProductionDetailsReportData, CreateFrameProductionDetailsReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateFrameProductionDetailsReportData, CreateFrameProductionDetailsReportVariables> ref() {
    CreateFrameProductionDetailsReportVariables vars= CreateFrameProductionDetailsReportVariables(date: date,machineNumber: machineNumber,shift: shift,totalQuantity: totalQuantity,totalWeight: totalWeight,createdBy: createdBy,submittedAt: _submittedAt,);
    return _dataConnect.mutation("CreateFrameProductionDetailsReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateFrameProductionDetailsReportFrameProductionDetailsReportInsert {
  final String id;
  CreateFrameProductionDetailsReportFrameProductionDetailsReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameProductionDetailsReportFrameProductionDetailsReportInsert otherTyped = other as CreateFrameProductionDetailsReportFrameProductionDetailsReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateFrameProductionDetailsReportFrameProductionDetailsReportInsert({
    required this.id,
  });
}

@immutable
class CreateFrameProductionDetailsReportData {
  final CreateFrameProductionDetailsReportFrameProductionDetailsReportInsert frameProductionDetailsReport_insert;
  CreateFrameProductionDetailsReportData.fromJson(dynamic json):
  
  frameProductionDetailsReport_insert = CreateFrameProductionDetailsReportFrameProductionDetailsReportInsert.fromJson(json['frameProductionDetailsReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameProductionDetailsReportData otherTyped = other as CreateFrameProductionDetailsReportData;
    return frameProductionDetailsReport_insert == otherTyped.frameProductionDetailsReport_insert;
    
  }
  @override
  int get hashCode => frameProductionDetailsReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameProductionDetailsReport_insert'] = frameProductionDetailsReport_insert.toJson();
    return json;
  }

  CreateFrameProductionDetailsReportData({
    required this.frameProductionDetailsReport_insert,
  });
}

@immutable
class CreateFrameProductionDetailsReportVariables {
  final DateTime date;
  final String machineNumber;
  final String shift;
  final int totalQuantity;
  final double totalWeight;
  final String createdBy;
  late final Optional<Timestamp>submittedAt;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateFrameProductionDetailsReportVariables.fromJson(Map<String, dynamic> json):
  
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalQuantity = nativeFromJson<int>(json['totalQuantity']),
  totalWeight = nativeFromJson<double>(json['totalWeight']),
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

    final CreateFrameProductionDetailsReportVariables otherTyped = other as CreateFrameProductionDetailsReportVariables;
    return date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalQuantity == otherTyped.totalQuantity && 
    totalWeight == otherTyped.totalWeight && 
    createdBy == otherTyped.createdBy && 
    submittedAt == otherTyped.submittedAt;
    
  }
  @override
  int get hashCode => Object.hashAll([date.hashCode, machineNumber.hashCode, shift.hashCode, totalQuantity.hashCode, totalWeight.hashCode, createdBy.hashCode, submittedAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalQuantity'] = nativeToJson<int>(totalQuantity);
    json['totalWeight'] = nativeToJson<double>(totalWeight);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if(submittedAt.state == OptionalState.set) {
      json['submittedAt'] = submittedAt.toJson();
    }
    return json;
  }

  CreateFrameProductionDetailsReportVariables({
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalQuantity,
    required this.totalWeight,
    required this.createdBy,
    required this.submittedAt,
  });
}

