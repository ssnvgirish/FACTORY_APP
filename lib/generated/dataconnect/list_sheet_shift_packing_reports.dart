part of 'default.dart';

class ListSheetShiftPackingReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListSheetShiftPackingReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListSheetShiftPackingReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListSheetShiftPackingReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListSheetShiftPackingReportsVariablesBuilder(this._dataConnect, );
  Deserializer<ListSheetShiftPackingReportsData> dataDeserializer = (dynamic json)  => ListSheetShiftPackingReportsData.fromJson(jsonDecode(json));
  Serializer<ListSheetShiftPackingReportsVariables> varsSerializer = (ListSheetShiftPackingReportsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListSheetShiftPackingReportsData, ListSheetShiftPackingReportsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListSheetShiftPackingReportsData, ListSheetShiftPackingReportsVariables> ref() {
    ListSheetShiftPackingReportsVariables vars= ListSheetShiftPackingReportsVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListSheetShiftPackingReports", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListSheetShiftPackingReportsSheetShiftPackingReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final double totalRejectedRunningFeet;
  final double qualityAcceptancePercentage;
  final double packingEfficiency;
  final String createdBy;
  final Timestamp? timestamp;
  final List<ListSheetShiftPackingReportsSheetShiftPackingReportsSheetPackingLineItemsOnReport> sheetPackingLineItems_on_report;
  ListSheetShiftPackingReportsSheetShiftPackingReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalRejectedRunningFeet = nativeFromJson<double>(json['totalRejectedRunningFeet']),
  qualityAcceptancePercentage = nativeFromJson<double>(json['qualityAcceptancePercentage']),
  packingEfficiency = nativeFromJson<double>(json['packingEfficiency']),
  createdBy = nativeFromJson<String>(json['createdBy']),
  timestamp = json['timestamp'] == null ? null : Timestamp.fromJson(json['timestamp']),
  sheetPackingLineItems_on_report = (json['sheetPackingLineItems_on_report'] as List<dynamic>)
        .map((e) => ListSheetShiftPackingReportsSheetShiftPackingReportsSheetPackingLineItemsOnReport.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSheetShiftPackingReportsSheetShiftPackingReports otherTyped = other as ListSheetShiftPackingReportsSheetShiftPackingReports;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalRejectedRunningFeet == otherTyped.totalRejectedRunningFeet && 
    qualityAcceptancePercentage == otherTyped.qualityAcceptancePercentage && 
    packingEfficiency == otherTyped.packingEfficiency && 
    createdBy == otherTyped.createdBy && 
    timestamp == otherTyped.timestamp && 
    sheetPackingLineItems_on_report == otherTyped.sheetPackingLineItems_on_report;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, machineNumber.hashCode, shift.hashCode, totalRejectedRunningFeet.hashCode, qualityAcceptancePercentage.hashCode, packingEfficiency.hashCode, createdBy.hashCode, timestamp.hashCode, sheetPackingLineItems_on_report.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalRejectedRunningFeet'] = nativeToJson<double>(totalRejectedRunningFeet);
    json['qualityAcceptancePercentage'] = nativeToJson<double>(qualityAcceptancePercentage);
    json['packingEfficiency'] = nativeToJson<double>(packingEfficiency);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    json['sheetPackingLineItems_on_report'] = sheetPackingLineItems_on_report.map((e) => e.toJson()).toList();
    return json;
  }

  ListSheetShiftPackingReportsSheetShiftPackingReports({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalRejectedRunningFeet,
    required this.qualityAcceptancePercentage,
    required this.packingEfficiency,
    required this.createdBy,
    this.timestamp,
    required this.sheetPackingLineItems_on_report,
  });
}

@immutable
class ListSheetShiftPackingReportsSheetShiftPackingReportsSheetPackingLineItemsOnReport {
  final String thickness;
  final String density;
  final String color;
  final double length;
  final double width;
  final int productionQuantity;
  final double perPieceWeight;
  final double runningFeetPerItem;
  final int packed;
  final int onlySanding;
  final int sandingAndPacked;
  final int rejectedQuality;
  ListSheetShiftPackingReportsSheetShiftPackingReportsSheetPackingLineItemsOnReport.fromJson(dynamic json):
  
  thickness = nativeFromJson<String>(json['thickness']),
  density = nativeFromJson<String>(json['density']),
  color = nativeFromJson<String>(json['color']),
  length = nativeFromJson<double>(json['length']),
  width = nativeFromJson<double>(json['width']),
  productionQuantity = nativeFromJson<int>(json['productionQuantity']),
  perPieceWeight = nativeFromJson<double>(json['perPieceWeight']),
  runningFeetPerItem = nativeFromJson<double>(json['runningFeetPerItem']),
  packed = nativeFromJson<int>(json['packed']),
  onlySanding = nativeFromJson<int>(json['onlySanding']),
  sandingAndPacked = nativeFromJson<int>(json['sandingAndPacked']),
  rejectedQuality = nativeFromJson<int>(json['rejectedQuality']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSheetShiftPackingReportsSheetShiftPackingReportsSheetPackingLineItemsOnReport otherTyped = other as ListSheetShiftPackingReportsSheetShiftPackingReportsSheetPackingLineItemsOnReport;
    return thickness == otherTyped.thickness && 
    density == otherTyped.density && 
    color == otherTyped.color && 
    length == otherTyped.length && 
    width == otherTyped.width && 
    productionQuantity == otherTyped.productionQuantity && 
    perPieceWeight == otherTyped.perPieceWeight && 
    runningFeetPerItem == otherTyped.runningFeetPerItem && 
    packed == otherTyped.packed && 
    onlySanding == otherTyped.onlySanding && 
    sandingAndPacked == otherTyped.sandingAndPacked && 
    rejectedQuality == otherTyped.rejectedQuality;
    
  }
  @override
  int get hashCode => Object.hashAll([thickness.hashCode, density.hashCode, color.hashCode, length.hashCode, width.hashCode, productionQuantity.hashCode, perPieceWeight.hashCode, runningFeetPerItem.hashCode, packed.hashCode, onlySanding.hashCode, sandingAndPacked.hashCode, rejectedQuality.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['thickness'] = nativeToJson<String>(thickness);
    json['density'] = nativeToJson<String>(density);
    json['color'] = nativeToJson<String>(color);
    json['length'] = nativeToJson<double>(length);
    json['width'] = nativeToJson<double>(width);
    json['productionQuantity'] = nativeToJson<int>(productionQuantity);
    json['perPieceWeight'] = nativeToJson<double>(perPieceWeight);
    json['runningFeetPerItem'] = nativeToJson<double>(runningFeetPerItem);
    json['packed'] = nativeToJson<int>(packed);
    json['onlySanding'] = nativeToJson<int>(onlySanding);
    json['sandingAndPacked'] = nativeToJson<int>(sandingAndPacked);
    json['rejectedQuality'] = nativeToJson<int>(rejectedQuality);
    return json;
  }

  ListSheetShiftPackingReportsSheetShiftPackingReportsSheetPackingLineItemsOnReport({
    required this.thickness,
    required this.density,
    required this.color,
    required this.length,
    required this.width,
    required this.productionQuantity,
    required this.perPieceWeight,
    required this.runningFeetPerItem,
    required this.packed,
    required this.onlySanding,
    required this.sandingAndPacked,
    required this.rejectedQuality,
  });
}

@immutable
class ListSheetShiftPackingReportsData {
  final List<ListSheetShiftPackingReportsSheetShiftPackingReports> sheetShiftPackingReports;
  ListSheetShiftPackingReportsData.fromJson(dynamic json):
  
  sheetShiftPackingReports = (json['sheetShiftPackingReports'] as List<dynamic>)
        .map((e) => ListSheetShiftPackingReportsSheetShiftPackingReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSheetShiftPackingReportsData otherTyped = other as ListSheetShiftPackingReportsData;
    return sheetShiftPackingReports == otherTyped.sheetShiftPackingReports;
    
  }
  @override
  int get hashCode => sheetShiftPackingReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetShiftPackingReports'] = sheetShiftPackingReports.map((e) => e.toJson()).toList();
    return json;
  }

  ListSheetShiftPackingReportsData({
    required this.sheetShiftPackingReports,
  });
}

@immutable
class ListSheetShiftPackingReportsVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListSheetShiftPackingReportsVariables.fromJson(Map<String, dynamic> json) {
  
  
    machineNumber = Optional.optional(nativeFromJson, nativeToJson);
    machineNumber.value = json['machineNumber'] == null ? null : nativeFromJson<String>(json['machineNumber']);
  
  
    startDate = Optional.optional(nativeFromJson, nativeToJson);
    startDate.value = json['startDate'] == null ? null : nativeFromJson<DateTime>(json['startDate']);
  
  
    endDate = Optional.optional(nativeFromJson, nativeToJson);
    endDate.value = json['endDate'] == null ? null : nativeFromJson<DateTime>(json['endDate']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSheetShiftPackingReportsVariables otherTyped = other as ListSheetShiftPackingReportsVariables;
    return machineNumber == otherTyped.machineNumber && 
    startDate == otherTyped.startDate && 
    endDate == otherTyped.endDate;
    
  }
  @override
  int get hashCode => Object.hashAll([machineNumber.hashCode, startDate.hashCode, endDate.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(machineNumber.state == OptionalState.set) {
      json['machineNumber'] = machineNumber.toJson();
    }
    if(startDate.state == OptionalState.set) {
      json['startDate'] = startDate.toJson();
    }
    if(endDate.state == OptionalState.set) {
      json['endDate'] = endDate.toJson();
    }
    return json;
  }

  ListSheetShiftPackingReportsVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

