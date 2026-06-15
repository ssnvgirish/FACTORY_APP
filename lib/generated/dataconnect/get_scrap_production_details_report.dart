part of 'default.dart';

class GetScrapProductionDetailsReportVariablesBuilder {
  String machineNumber;
  DateTime date;
  String shift;

  final FirebaseDataConnect _dataConnect;
  GetScrapProductionDetailsReportVariablesBuilder(this._dataConnect, {required  this.machineNumber,required  this.date,required  this.shift,});
  Deserializer<GetScrapProductionDetailsReportData> dataDeserializer = (dynamic json)  => GetScrapProductionDetailsReportData.fromJson(jsonDecode(json));
  Serializer<GetScrapProductionDetailsReportVariables> varsSerializer = (GetScrapProductionDetailsReportVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetScrapProductionDetailsReportData, GetScrapProductionDetailsReportVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetScrapProductionDetailsReportData, GetScrapProductionDetailsReportVariables> ref() {
    GetScrapProductionDetailsReportVariables vars= GetScrapProductionDetailsReportVariables(machineNumber: machineNumber,date: date,shift: shift,);
    return _dataConnect.query("GetScrapProductionDetailsReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetScrapProductionDetailsReportScrapProductionDetailsReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final double totalProductionWeight;
  final String createdBy;
  final Timestamp? submittedAt;
  final List<GetScrapProductionDetailsReportScrapProductionDetailsReportsScrapProductionLineItemsOnReport> scrapProductionLineItems_on_report;
  GetScrapProductionDetailsReportScrapProductionDetailsReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalProductionWeight = nativeFromJson<double>(json['totalProductionWeight']),
  createdBy = nativeFromJson<String>(json['createdBy']),
  submittedAt = json['submittedAt'] == null ? null : Timestamp.fromJson(json['submittedAt']),
  scrapProductionLineItems_on_report = (json['scrapProductionLineItems_on_report'] as List<dynamic>)
        .map((e) => GetScrapProductionDetailsReportScrapProductionDetailsReportsScrapProductionLineItemsOnReport.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetScrapProductionDetailsReportScrapProductionDetailsReports otherTyped = other as GetScrapProductionDetailsReportScrapProductionDetailsReports;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalProductionWeight == otherTyped.totalProductionWeight && 
    createdBy == otherTyped.createdBy && 
    submittedAt == otherTyped.submittedAt && 
    scrapProductionLineItems_on_report == otherTyped.scrapProductionLineItems_on_report;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, machineNumber.hashCode, shift.hashCode, totalProductionWeight.hashCode, createdBy.hashCode, submittedAt.hashCode, scrapProductionLineItems_on_report.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalProductionWeight'] = nativeToJson<double>(totalProductionWeight);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if (submittedAt != null) {
      json['submittedAt'] = submittedAt!.toJson();
    }
    json['scrapProductionLineItems_on_report'] = scrapProductionLineItems_on_report.map((e) => e.toJson()).toList();
    return json;
  }

  GetScrapProductionDetailsReportScrapProductionDetailsReports({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalProductionWeight,
    required this.createdBy,
    this.submittedAt,
    required this.scrapProductionLineItems_on_report,
  });
}

@immutable
class GetScrapProductionDetailsReportScrapProductionDetailsReportsScrapProductionLineItemsOnReport {
  final String product;
  final double weightPerBag;
  final int totalBags;
  final double totalWeight;
  GetScrapProductionDetailsReportScrapProductionDetailsReportsScrapProductionLineItemsOnReport.fromJson(dynamic json):
  
  product = nativeFromJson<String>(json['product']),
  weightPerBag = nativeFromJson<double>(json['weightPerBag']),
  totalBags = nativeFromJson<int>(json['totalBags']),
  totalWeight = nativeFromJson<double>(json['totalWeight']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetScrapProductionDetailsReportScrapProductionDetailsReportsScrapProductionLineItemsOnReport otherTyped = other as GetScrapProductionDetailsReportScrapProductionDetailsReportsScrapProductionLineItemsOnReport;
    return product == otherTyped.product && 
    weightPerBag == otherTyped.weightPerBag && 
    totalBags == otherTyped.totalBags && 
    totalWeight == otherTyped.totalWeight;
    
  }
  @override
  int get hashCode => Object.hashAll([product.hashCode, weightPerBag.hashCode, totalBags.hashCode, totalWeight.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['product'] = nativeToJson<String>(product);
    json['weightPerBag'] = nativeToJson<double>(weightPerBag);
    json['totalBags'] = nativeToJson<int>(totalBags);
    json['totalWeight'] = nativeToJson<double>(totalWeight);
    return json;
  }

  GetScrapProductionDetailsReportScrapProductionDetailsReportsScrapProductionLineItemsOnReport({
    required this.product,
    required this.weightPerBag,
    required this.totalBags,
    required this.totalWeight,
  });
}

@immutable
class GetScrapProductionDetailsReportData {
  final List<GetScrapProductionDetailsReportScrapProductionDetailsReports> scrapProductionDetailsReports;
  GetScrapProductionDetailsReportData.fromJson(dynamic json):
  
  scrapProductionDetailsReports = (json['scrapProductionDetailsReports'] as List<dynamic>)
        .map((e) => GetScrapProductionDetailsReportScrapProductionDetailsReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetScrapProductionDetailsReportData otherTyped = other as GetScrapProductionDetailsReportData;
    return scrapProductionDetailsReports == otherTyped.scrapProductionDetailsReports;
    
  }
  @override
  int get hashCode => scrapProductionDetailsReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapProductionDetailsReports'] = scrapProductionDetailsReports.map((e) => e.toJson()).toList();
    return json;
  }

  GetScrapProductionDetailsReportData({
    required this.scrapProductionDetailsReports,
  });
}

@immutable
class GetScrapProductionDetailsReportVariables {
  final String machineNumber;
  final DateTime date;
  final String shift;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetScrapProductionDetailsReportVariables.fromJson(Map<String, dynamic> json):
  
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  date = nativeFromJson<DateTime>(json['date']),
  shift = nativeFromJson<String>(json['shift']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetScrapProductionDetailsReportVariables otherTyped = other as GetScrapProductionDetailsReportVariables;
    return machineNumber == otherTyped.machineNumber && 
    date == otherTyped.date && 
    shift == otherTyped.shift;
    
  }
  @override
  int get hashCode => Object.hashAll([machineNumber.hashCode, date.hashCode, shift.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['date'] = nativeToJson<DateTime>(date);
    json['shift'] = nativeToJson<String>(shift);
    return json;
  }

  GetScrapProductionDetailsReportVariables({
    required this.machineNumber,
    required this.date,
    required this.shift,
  });
}

