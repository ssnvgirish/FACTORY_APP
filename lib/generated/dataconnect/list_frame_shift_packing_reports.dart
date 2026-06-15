part of 'default.dart';

class ListFrameShiftPackingReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListFrameShiftPackingReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListFrameShiftPackingReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListFrameShiftPackingReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListFrameShiftPackingReportsVariablesBuilder(this._dataConnect, );
  Deserializer<ListFrameShiftPackingReportsData> dataDeserializer = (dynamic json)  => ListFrameShiftPackingReportsData.fromJson(jsonDecode(json));
  Serializer<ListFrameShiftPackingReportsVariables> varsSerializer = (ListFrameShiftPackingReportsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListFrameShiftPackingReportsData, ListFrameShiftPackingReportsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListFrameShiftPackingReportsData, ListFrameShiftPackingReportsVariables> ref() {
    ListFrameShiftPackingReportsVariables vars= ListFrameShiftPackingReportsVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListFrameShiftPackingReports", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListFrameShiftPackingReportsFrameShiftPackingReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final double totalRejectedWeight;
  final double qualityAcceptancePercentage;
  final double packingEfficiency;
  final String createdBy;
  final Timestamp? timestamp;
  final List<ListFrameShiftPackingReportsFrameShiftPackingReportsFramePackingLineItemsOnReport> framePackingLineItems_on_report;
  ListFrameShiftPackingReportsFrameShiftPackingReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalRejectedWeight = nativeFromJson<double>(json['totalRejectedWeight']),
  qualityAcceptancePercentage = nativeFromJson<double>(json['qualityAcceptancePercentage']),
  packingEfficiency = nativeFromJson<double>(json['packingEfficiency']),
  createdBy = nativeFromJson<String>(json['createdBy']),
  timestamp = json['timestamp'] == null ? null : Timestamp.fromJson(json['timestamp']),
  framePackingLineItems_on_report = (json['framePackingLineItems_on_report'] as List<dynamic>)
        .map((e) => ListFrameShiftPackingReportsFrameShiftPackingReportsFramePackingLineItemsOnReport.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameShiftPackingReportsFrameShiftPackingReports otherTyped = other as ListFrameShiftPackingReportsFrameShiftPackingReports;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalRejectedWeight == otherTyped.totalRejectedWeight && 
    qualityAcceptancePercentage == otherTyped.qualityAcceptancePercentage && 
    packingEfficiency == otherTyped.packingEfficiency && 
    createdBy == otherTyped.createdBy && 
    timestamp == otherTyped.timestamp && 
    framePackingLineItems_on_report == otherTyped.framePackingLineItems_on_report;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, machineNumber.hashCode, shift.hashCode, totalRejectedWeight.hashCode, qualityAcceptancePercentage.hashCode, packingEfficiency.hashCode, createdBy.hashCode, timestamp.hashCode, framePackingLineItems_on_report.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalRejectedWeight'] = nativeToJson<double>(totalRejectedWeight);
    json['qualityAcceptancePercentage'] = nativeToJson<double>(qualityAcceptancePercentage);
    json['packingEfficiency'] = nativeToJson<double>(packingEfficiency);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    json['framePackingLineItems_on_report'] = framePackingLineItems_on_report.map((e) => e.toJson()).toList();
    return json;
  }

  ListFrameShiftPackingReportsFrameShiftPackingReports({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalRejectedWeight,
    required this.qualityAcceptancePercentage,
    required this.packingEfficiency,
    required this.createdBy,
    this.timestamp,
    required this.framePackingLineItems_on_report,
  });
}

@immutable
class ListFrameShiftPackingReportsFrameShiftPackingReportsFramePackingLineItemsOnReport {
  final String section;
  final String density;
  final String color;
  final double length;
  final int productionQuantity;
  final double perPieceWeight;
  final int packed;
  final int rejectedQuality;
  ListFrameShiftPackingReportsFrameShiftPackingReportsFramePackingLineItemsOnReport.fromJson(dynamic json):
  
  section = nativeFromJson<String>(json['section']),
  density = nativeFromJson<String>(json['density']),
  color = nativeFromJson<String>(json['color']),
  length = nativeFromJson<double>(json['length']),
  productionQuantity = nativeFromJson<int>(json['productionQuantity']),
  perPieceWeight = nativeFromJson<double>(json['perPieceWeight']),
  packed = nativeFromJson<int>(json['packed']),
  rejectedQuality = nativeFromJson<int>(json['rejectedQuality']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameShiftPackingReportsFrameShiftPackingReportsFramePackingLineItemsOnReport otherTyped = other as ListFrameShiftPackingReportsFrameShiftPackingReportsFramePackingLineItemsOnReport;
    return section == otherTyped.section && 
    density == otherTyped.density && 
    color == otherTyped.color && 
    length == otherTyped.length && 
    productionQuantity == otherTyped.productionQuantity && 
    perPieceWeight == otherTyped.perPieceWeight && 
    packed == otherTyped.packed && 
    rejectedQuality == otherTyped.rejectedQuality;
    
  }
  @override
  int get hashCode => Object.hashAll([section.hashCode, density.hashCode, color.hashCode, length.hashCode, productionQuantity.hashCode, perPieceWeight.hashCode, packed.hashCode, rejectedQuality.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['section'] = nativeToJson<String>(section);
    json['density'] = nativeToJson<String>(density);
    json['color'] = nativeToJson<String>(color);
    json['length'] = nativeToJson<double>(length);
    json['productionQuantity'] = nativeToJson<int>(productionQuantity);
    json['perPieceWeight'] = nativeToJson<double>(perPieceWeight);
    json['packed'] = nativeToJson<int>(packed);
    json['rejectedQuality'] = nativeToJson<int>(rejectedQuality);
    return json;
  }

  ListFrameShiftPackingReportsFrameShiftPackingReportsFramePackingLineItemsOnReport({
    required this.section,
    required this.density,
    required this.color,
    required this.length,
    required this.productionQuantity,
    required this.perPieceWeight,
    required this.packed,
    required this.rejectedQuality,
  });
}

@immutable
class ListFrameShiftPackingReportsData {
  final List<ListFrameShiftPackingReportsFrameShiftPackingReports> frameShiftPackingReports;
  ListFrameShiftPackingReportsData.fromJson(dynamic json):
  
  frameShiftPackingReports = (json['frameShiftPackingReports'] as List<dynamic>)
        .map((e) => ListFrameShiftPackingReportsFrameShiftPackingReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameShiftPackingReportsData otherTyped = other as ListFrameShiftPackingReportsData;
    return frameShiftPackingReports == otherTyped.frameShiftPackingReports;
    
  }
  @override
  int get hashCode => frameShiftPackingReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameShiftPackingReports'] = frameShiftPackingReports.map((e) => e.toJson()).toList();
    return json;
  }

  ListFrameShiftPackingReportsData({
    required this.frameShiftPackingReports,
  });
}

@immutable
class ListFrameShiftPackingReportsVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListFrameShiftPackingReportsVariables.fromJson(Map<String, dynamic> json) {
  
  
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

    final ListFrameShiftPackingReportsVariables otherTyped = other as ListFrameShiftPackingReportsVariables;
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

  ListFrameShiftPackingReportsVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

