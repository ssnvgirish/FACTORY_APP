part of 'default.dart';

class GetSheetProductionDetailsReportVariablesBuilder {
  String machineNumber;
  DateTime date;
  String shift;

  final FirebaseDataConnect _dataConnect;
  GetSheetProductionDetailsReportVariablesBuilder(this._dataConnect, {required  this.machineNumber,required  this.date,required  this.shift,});
  Deserializer<GetSheetProductionDetailsReportData> dataDeserializer = (dynamic json)  => GetSheetProductionDetailsReportData.fromJson(jsonDecode(json));
  Serializer<GetSheetProductionDetailsReportVariables> varsSerializer = (GetSheetProductionDetailsReportVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetSheetProductionDetailsReportData, GetSheetProductionDetailsReportVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetSheetProductionDetailsReportData, GetSheetProductionDetailsReportVariables> ref() {
    GetSheetProductionDetailsReportVariables vars= GetSheetProductionDetailsReportVariables(machineNumber: machineNumber,date: date,shift: shift,);
    return _dataConnect.query("GetSheetProductionDetailsReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetSheetProductionDetailsReportSheetProductionDetailsReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final int totalQuantity;
  final double totalWeight;
  final double totalRunningFeet;
  final String createdBy;
  final Timestamp? submittedAt;
  final List<GetSheetProductionDetailsReportSheetProductionDetailsReportsSheetProductionLineItemsOnReport> sheetProductionLineItems_on_report;
  GetSheetProductionDetailsReportSheetProductionDetailsReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalQuantity = nativeFromJson<int>(json['totalQuantity']),
  totalWeight = nativeFromJson<double>(json['totalWeight']),
  totalRunningFeet = nativeFromJson<double>(json['totalRunningFeet']),
  createdBy = nativeFromJson<String>(json['createdBy']),
  submittedAt = json['submittedAt'] == null ? null : Timestamp.fromJson(json['submittedAt']),
  sheetProductionLineItems_on_report = (json['sheetProductionLineItems_on_report'] as List<dynamic>)
        .map((e) => GetSheetProductionDetailsReportSheetProductionDetailsReportsSheetProductionLineItemsOnReport.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetSheetProductionDetailsReportSheetProductionDetailsReports otherTyped = other as GetSheetProductionDetailsReportSheetProductionDetailsReports;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalQuantity == otherTyped.totalQuantity && 
    totalWeight == otherTyped.totalWeight && 
    totalRunningFeet == otherTyped.totalRunningFeet && 
    createdBy == otherTyped.createdBy && 
    submittedAt == otherTyped.submittedAt && 
    sheetProductionLineItems_on_report == otherTyped.sheetProductionLineItems_on_report;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, machineNumber.hashCode, shift.hashCode, totalQuantity.hashCode, totalWeight.hashCode, totalRunningFeet.hashCode, createdBy.hashCode, submittedAt.hashCode, sheetProductionLineItems_on_report.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalQuantity'] = nativeToJson<int>(totalQuantity);
    json['totalWeight'] = nativeToJson<double>(totalWeight);
    json['totalRunningFeet'] = nativeToJson<double>(totalRunningFeet);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if (submittedAt != null) {
      json['submittedAt'] = submittedAt!.toJson();
    }
    json['sheetProductionLineItems_on_report'] = sheetProductionLineItems_on_report.map((e) => e.toJson()).toList();
    return json;
  }

  GetSheetProductionDetailsReportSheetProductionDetailsReports({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalQuantity,
    required this.totalWeight,
    required this.totalRunningFeet,
    required this.createdBy,
    this.submittedAt,
    required this.sheetProductionLineItems_on_report,
  });
}

@immutable
class GetSheetProductionDetailsReportSheetProductionDetailsReportsSheetProductionLineItemsOnReport {
  final String thickness;
  final String density;
  final String color;
  final double length;
  final double width;
  final int quantity;
  final double sqft;
  final double perPieceWeight;
  final double totalWeight;
  final double totalRunningFeet;
  GetSheetProductionDetailsReportSheetProductionDetailsReportsSheetProductionLineItemsOnReport.fromJson(dynamic json):
  
  thickness = nativeFromJson<String>(json['thickness']),
  density = nativeFromJson<String>(json['density']),
  color = nativeFromJson<String>(json['color']),
  length = nativeFromJson<double>(json['length']),
  width = nativeFromJson<double>(json['width']),
  quantity = nativeFromJson<int>(json['quantity']),
  sqft = nativeFromJson<double>(json['sqft']),
  perPieceWeight = nativeFromJson<double>(json['perPieceWeight']),
  totalWeight = nativeFromJson<double>(json['totalWeight']),
  totalRunningFeet = nativeFromJson<double>(json['totalRunningFeet']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetSheetProductionDetailsReportSheetProductionDetailsReportsSheetProductionLineItemsOnReport otherTyped = other as GetSheetProductionDetailsReportSheetProductionDetailsReportsSheetProductionLineItemsOnReport;
    return thickness == otherTyped.thickness && 
    density == otherTyped.density && 
    color == otherTyped.color && 
    length == otherTyped.length && 
    width == otherTyped.width && 
    quantity == otherTyped.quantity && 
    sqft == otherTyped.sqft && 
    perPieceWeight == otherTyped.perPieceWeight && 
    totalWeight == otherTyped.totalWeight && 
    totalRunningFeet == otherTyped.totalRunningFeet;
    
  }
  @override
  int get hashCode => Object.hashAll([thickness.hashCode, density.hashCode, color.hashCode, length.hashCode, width.hashCode, quantity.hashCode, sqft.hashCode, perPieceWeight.hashCode, totalWeight.hashCode, totalRunningFeet.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['thickness'] = nativeToJson<String>(thickness);
    json['density'] = nativeToJson<String>(density);
    json['color'] = nativeToJson<String>(color);
    json['length'] = nativeToJson<double>(length);
    json['width'] = nativeToJson<double>(width);
    json['quantity'] = nativeToJson<int>(quantity);
    json['sqft'] = nativeToJson<double>(sqft);
    json['perPieceWeight'] = nativeToJson<double>(perPieceWeight);
    json['totalWeight'] = nativeToJson<double>(totalWeight);
    json['totalRunningFeet'] = nativeToJson<double>(totalRunningFeet);
    return json;
  }

  GetSheetProductionDetailsReportSheetProductionDetailsReportsSheetProductionLineItemsOnReport({
    required this.thickness,
    required this.density,
    required this.color,
    required this.length,
    required this.width,
    required this.quantity,
    required this.sqft,
    required this.perPieceWeight,
    required this.totalWeight,
    required this.totalRunningFeet,
  });
}

@immutable
class GetSheetProductionDetailsReportData {
  final List<GetSheetProductionDetailsReportSheetProductionDetailsReports> sheetProductionDetailsReports;
  GetSheetProductionDetailsReportData.fromJson(dynamic json):
  
  sheetProductionDetailsReports = (json['sheetProductionDetailsReports'] as List<dynamic>)
        .map((e) => GetSheetProductionDetailsReportSheetProductionDetailsReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetSheetProductionDetailsReportData otherTyped = other as GetSheetProductionDetailsReportData;
    return sheetProductionDetailsReports == otherTyped.sheetProductionDetailsReports;
    
  }
  @override
  int get hashCode => sheetProductionDetailsReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetProductionDetailsReports'] = sheetProductionDetailsReports.map((e) => e.toJson()).toList();
    return json;
  }

  GetSheetProductionDetailsReportData({
    required this.sheetProductionDetailsReports,
  });
}

@immutable
class GetSheetProductionDetailsReportVariables {
  final String machineNumber;
  final DateTime date;
  final String shift;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetSheetProductionDetailsReportVariables.fromJson(Map<String, dynamic> json):
  
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

    final GetSheetProductionDetailsReportVariables otherTyped = other as GetSheetProductionDetailsReportVariables;
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

  GetSheetProductionDetailsReportVariables({
    required this.machineNumber,
    required this.date,
    required this.shift,
  });
}

