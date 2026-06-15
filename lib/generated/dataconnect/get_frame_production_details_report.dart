part of 'default.dart';

class GetFrameProductionDetailsReportVariablesBuilder {
  String machineNumber;
  DateTime date;
  String shift;

  final FirebaseDataConnect _dataConnect;
  GetFrameProductionDetailsReportVariablesBuilder(this._dataConnect, {required  this.machineNumber,required  this.date,required  this.shift,});
  Deserializer<GetFrameProductionDetailsReportData> dataDeserializer = (dynamic json)  => GetFrameProductionDetailsReportData.fromJson(jsonDecode(json));
  Serializer<GetFrameProductionDetailsReportVariables> varsSerializer = (GetFrameProductionDetailsReportVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetFrameProductionDetailsReportData, GetFrameProductionDetailsReportVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetFrameProductionDetailsReportData, GetFrameProductionDetailsReportVariables> ref() {
    GetFrameProductionDetailsReportVariables vars= GetFrameProductionDetailsReportVariables(machineNumber: machineNumber,date: date,shift: shift,);
    return _dataConnect.query("GetFrameProductionDetailsReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetFrameProductionDetailsReportFrameProductionDetailsReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final int totalQuantity;
  final double totalWeight;
  final String createdBy;
  final Timestamp? submittedAt;
  final List<GetFrameProductionDetailsReportFrameProductionDetailsReportsFrameProductionLineItemsOnReport> frameProductionLineItems_on_report;
  GetFrameProductionDetailsReportFrameProductionDetailsReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalQuantity = nativeFromJson<int>(json['totalQuantity']),
  totalWeight = nativeFromJson<double>(json['totalWeight']),
  createdBy = nativeFromJson<String>(json['createdBy']),
  submittedAt = json['submittedAt'] == null ? null : Timestamp.fromJson(json['submittedAt']),
  frameProductionLineItems_on_report = (json['frameProductionLineItems_on_report'] as List<dynamic>)
        .map((e) => GetFrameProductionDetailsReportFrameProductionDetailsReportsFrameProductionLineItemsOnReport.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetFrameProductionDetailsReportFrameProductionDetailsReports otherTyped = other as GetFrameProductionDetailsReportFrameProductionDetailsReports;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalQuantity == otherTyped.totalQuantity && 
    totalWeight == otherTyped.totalWeight && 
    createdBy == otherTyped.createdBy && 
    submittedAt == otherTyped.submittedAt && 
    frameProductionLineItems_on_report == otherTyped.frameProductionLineItems_on_report;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, machineNumber.hashCode, shift.hashCode, totalQuantity.hashCode, totalWeight.hashCode, createdBy.hashCode, submittedAt.hashCode, frameProductionLineItems_on_report.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalQuantity'] = nativeToJson<int>(totalQuantity);
    json['totalWeight'] = nativeToJson<double>(totalWeight);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if (submittedAt != null) {
      json['submittedAt'] = submittedAt!.toJson();
    }
    json['frameProductionLineItems_on_report'] = frameProductionLineItems_on_report.map((e) => e.toJson()).toList();
    return json;
  }

  GetFrameProductionDetailsReportFrameProductionDetailsReports({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalQuantity,
    required this.totalWeight,
    required this.createdBy,
    this.submittedAt,
    required this.frameProductionLineItems_on_report,
  });
}

@immutable
class GetFrameProductionDetailsReportFrameProductionDetailsReportsFrameProductionLineItemsOnReport {
  final String section;
  final String density;
  final String color;
  final double length;
  final int quantity;
  final double perPieceWeight;
  final double totalWeight;
  GetFrameProductionDetailsReportFrameProductionDetailsReportsFrameProductionLineItemsOnReport.fromJson(dynamic json):
  
  section = nativeFromJson<String>(json['section']),
  density = nativeFromJson<String>(json['density']),
  color = nativeFromJson<String>(json['color']),
  length = nativeFromJson<double>(json['length']),
  quantity = nativeFromJson<int>(json['quantity']),
  perPieceWeight = nativeFromJson<double>(json['perPieceWeight']),
  totalWeight = nativeFromJson<double>(json['totalWeight']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetFrameProductionDetailsReportFrameProductionDetailsReportsFrameProductionLineItemsOnReport otherTyped = other as GetFrameProductionDetailsReportFrameProductionDetailsReportsFrameProductionLineItemsOnReport;
    return section == otherTyped.section && 
    density == otherTyped.density && 
    color == otherTyped.color && 
    length == otherTyped.length && 
    quantity == otherTyped.quantity && 
    perPieceWeight == otherTyped.perPieceWeight && 
    totalWeight == otherTyped.totalWeight;
    
  }
  @override
  int get hashCode => Object.hashAll([section.hashCode, density.hashCode, color.hashCode, length.hashCode, quantity.hashCode, perPieceWeight.hashCode, totalWeight.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['section'] = nativeToJson<String>(section);
    json['density'] = nativeToJson<String>(density);
    json['color'] = nativeToJson<String>(color);
    json['length'] = nativeToJson<double>(length);
    json['quantity'] = nativeToJson<int>(quantity);
    json['perPieceWeight'] = nativeToJson<double>(perPieceWeight);
    json['totalWeight'] = nativeToJson<double>(totalWeight);
    return json;
  }

  GetFrameProductionDetailsReportFrameProductionDetailsReportsFrameProductionLineItemsOnReport({
    required this.section,
    required this.density,
    required this.color,
    required this.length,
    required this.quantity,
    required this.perPieceWeight,
    required this.totalWeight,
  });
}

@immutable
class GetFrameProductionDetailsReportData {
  final List<GetFrameProductionDetailsReportFrameProductionDetailsReports> frameProductionDetailsReports;
  GetFrameProductionDetailsReportData.fromJson(dynamic json):
  
  frameProductionDetailsReports = (json['frameProductionDetailsReports'] as List<dynamic>)
        .map((e) => GetFrameProductionDetailsReportFrameProductionDetailsReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetFrameProductionDetailsReportData otherTyped = other as GetFrameProductionDetailsReportData;
    return frameProductionDetailsReports == otherTyped.frameProductionDetailsReports;
    
  }
  @override
  int get hashCode => frameProductionDetailsReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameProductionDetailsReports'] = frameProductionDetailsReports.map((e) => e.toJson()).toList();
    return json;
  }

  GetFrameProductionDetailsReportData({
    required this.frameProductionDetailsReports,
  });
}

@immutable
class GetFrameProductionDetailsReportVariables {
  final String machineNumber;
  final DateTime date;
  final String shift;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetFrameProductionDetailsReportVariables.fromJson(Map<String, dynamic> json):
  
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

    final GetFrameProductionDetailsReportVariables otherTyped = other as GetFrameProductionDetailsReportVariables;
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

  GetFrameProductionDetailsReportVariables({
    required this.machineNumber,
    required this.date,
    required this.shift,
  });
}

