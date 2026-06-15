part of 'default.dart';

class CreateScrapToolsCountReportVariablesBuilder {
  DateTime date;
  String machineNumber;
  int totalToolsGiven;
  int totalToolsAvailable;
  double percentageAvailable;
  String createdBy;

  final FirebaseDataConnect _dataConnect;
  CreateScrapToolsCountReportVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.totalToolsGiven,required  this.totalToolsAvailable,required  this.percentageAvailable,required  this.createdBy,});
  Deserializer<CreateScrapToolsCountReportData> dataDeserializer = (dynamic json)  => CreateScrapToolsCountReportData.fromJson(jsonDecode(json));
  Serializer<CreateScrapToolsCountReportVariables> varsSerializer = (CreateScrapToolsCountReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateScrapToolsCountReportData, CreateScrapToolsCountReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateScrapToolsCountReportData, CreateScrapToolsCountReportVariables> ref() {
    CreateScrapToolsCountReportVariables vars= CreateScrapToolsCountReportVariables(date: date,machineNumber: machineNumber,totalToolsGiven: totalToolsGiven,totalToolsAvailable: totalToolsAvailable,percentageAvailable: percentageAvailable,createdBy: createdBy,);
    return _dataConnect.mutation("CreateScrapToolsCountReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateScrapToolsCountReportScrapToolsCountReportInsert {
  final String id;
  CreateScrapToolsCountReportScrapToolsCountReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapToolsCountReportScrapToolsCountReportInsert otherTyped = other as CreateScrapToolsCountReportScrapToolsCountReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateScrapToolsCountReportScrapToolsCountReportInsert({
    required this.id,
  });
}

@immutable
class CreateScrapToolsCountReportData {
  final CreateScrapToolsCountReportScrapToolsCountReportInsert scrapToolsCountReport_insert;
  CreateScrapToolsCountReportData.fromJson(dynamic json):
  
  scrapToolsCountReport_insert = CreateScrapToolsCountReportScrapToolsCountReportInsert.fromJson(json['scrapToolsCountReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapToolsCountReportData otherTyped = other as CreateScrapToolsCountReportData;
    return scrapToolsCountReport_insert == otherTyped.scrapToolsCountReport_insert;
    
  }
  @override
  int get hashCode => scrapToolsCountReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapToolsCountReport_insert'] = scrapToolsCountReport_insert.toJson();
    return json;
  }

  CreateScrapToolsCountReportData({
    required this.scrapToolsCountReport_insert,
  });
}

@immutable
class CreateScrapToolsCountReportVariables {
  final DateTime date;
  final String machineNumber;
  final int totalToolsGiven;
  final int totalToolsAvailable;
  final double percentageAvailable;
  final String createdBy;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateScrapToolsCountReportVariables.fromJson(Map<String, dynamic> json):
  
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

    final CreateScrapToolsCountReportVariables otherTyped = other as CreateScrapToolsCountReportVariables;
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

  CreateScrapToolsCountReportVariables({
    required this.date,
    required this.machineNumber,
    required this.totalToolsGiven,
    required this.totalToolsAvailable,
    required this.percentageAvailable,
    required this.createdBy,
  });
}

