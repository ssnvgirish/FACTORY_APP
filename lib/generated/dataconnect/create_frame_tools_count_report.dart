part of 'default.dart';

class CreateFrameToolsCountReportVariablesBuilder {
  DateTime date;
  String machineNumber;
  int totalToolsGiven;
  int totalToolsAvailable;
  double percentageAvailable;
  String createdBy;

  final FirebaseDataConnect _dataConnect;
  CreateFrameToolsCountReportVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.totalToolsGiven,required  this.totalToolsAvailable,required  this.percentageAvailable,required  this.createdBy,});
  Deserializer<CreateFrameToolsCountReportData> dataDeserializer = (dynamic json)  => CreateFrameToolsCountReportData.fromJson(jsonDecode(json));
  Serializer<CreateFrameToolsCountReportVariables> varsSerializer = (CreateFrameToolsCountReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateFrameToolsCountReportData, CreateFrameToolsCountReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateFrameToolsCountReportData, CreateFrameToolsCountReportVariables> ref() {
    CreateFrameToolsCountReportVariables vars= CreateFrameToolsCountReportVariables(date: date,machineNumber: machineNumber,totalToolsGiven: totalToolsGiven,totalToolsAvailable: totalToolsAvailable,percentageAvailable: percentageAvailable,createdBy: createdBy,);
    return _dataConnect.mutation("CreateFrameToolsCountReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateFrameToolsCountReportFrameToolsCountReportInsert {
  final String id;
  CreateFrameToolsCountReportFrameToolsCountReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameToolsCountReportFrameToolsCountReportInsert otherTyped = other as CreateFrameToolsCountReportFrameToolsCountReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateFrameToolsCountReportFrameToolsCountReportInsert({
    required this.id,
  });
}

@immutable
class CreateFrameToolsCountReportData {
  final CreateFrameToolsCountReportFrameToolsCountReportInsert frameToolsCountReport_insert;
  CreateFrameToolsCountReportData.fromJson(dynamic json):
  
  frameToolsCountReport_insert = CreateFrameToolsCountReportFrameToolsCountReportInsert.fromJson(json['frameToolsCountReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameToolsCountReportData otherTyped = other as CreateFrameToolsCountReportData;
    return frameToolsCountReport_insert == otherTyped.frameToolsCountReport_insert;
    
  }
  @override
  int get hashCode => frameToolsCountReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameToolsCountReport_insert'] = frameToolsCountReport_insert.toJson();
    return json;
  }

  CreateFrameToolsCountReportData({
    required this.frameToolsCountReport_insert,
  });
}

@immutable
class CreateFrameToolsCountReportVariables {
  final DateTime date;
  final String machineNumber;
  final int totalToolsGiven;
  final int totalToolsAvailable;
  final double percentageAvailable;
  final String createdBy;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateFrameToolsCountReportVariables.fromJson(Map<String, dynamic> json):
  
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  totalToolsGiven = nativeFromJson<int>(json['totalToolsGiven']),
  totalToolsAvailable = nativeFromJson<int>(json['totalToolsAvailable']),
  percentageAvailable = nativeFromJson<double>(json['percentageAvailable']),
  createdBy = nativeFromJson<String>(json['createdBy']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameToolsCountReportVariables otherTyped = other as CreateFrameToolsCountReportVariables;
    return date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    totalToolsGiven == otherTyped.totalToolsGiven && 
    totalToolsAvailable == otherTyped.totalToolsAvailable && 
    percentageAvailable == otherTyped.percentageAvailable && 
    createdBy == otherTyped.createdBy;
    
  }
  @override
  int get hashCode => Object.hashAll([date.hashCode, machineNumber.hashCode, totalToolsGiven.hashCode, totalToolsAvailable.hashCode, percentageAvailable.hashCode, createdBy.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['totalToolsGiven'] = nativeToJson<int>(totalToolsGiven);
    json['totalToolsAvailable'] = nativeToJson<int>(totalToolsAvailable);
    json['percentageAvailable'] = nativeToJson<double>(percentageAvailable);
    json['createdBy'] = nativeToJson<String>(createdBy);
    return json;
  }

  CreateFrameToolsCountReportVariables({
    required this.date,
    required this.machineNumber,
    required this.totalToolsGiven,
    required this.totalToolsAvailable,
    required this.percentageAvailable,
    required this.createdBy,
  });
}

