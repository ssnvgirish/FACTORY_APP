part of 'default.dart';

class ListSheetCustomerRejectionReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListSheetCustomerRejectionReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListSheetCustomerRejectionReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListSheetCustomerRejectionReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListSheetCustomerRejectionReportsVariablesBuilder(this._dataConnect, );
  Deserializer<ListSheetCustomerRejectionReportsData> dataDeserializer = (dynamic json)  => ListSheetCustomerRejectionReportsData.fromJson(jsonDecode(json));
  Serializer<ListSheetCustomerRejectionReportsVariables> varsSerializer = (ListSheetCustomerRejectionReportsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListSheetCustomerRejectionReportsData, ListSheetCustomerRejectionReportsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListSheetCustomerRejectionReportsData, ListSheetCustomerRejectionReportsVariables> ref() {
    ListSheetCustomerRejectionReportsVariables vars= ListSheetCustomerRejectionReportsVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListSheetCustomerRejectionReports", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListSheetCustomerRejectionReportsSheetCustomerRejectionReports {
  final String id;
  final DateTime originalProductionDate;
  final String machineNumber;
  final String shift;
  final double totalRejectedRunningFeet;
  final String createdBy;
  final Timestamp? timestamp;
  final List<ListSheetCustomerRejectionReportsSheetCustomerRejectionReportsSheetCustomerRejectionItemsOnReport> sheetCustomerRejectionItems_on_report;
  ListSheetCustomerRejectionReportsSheetCustomerRejectionReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  originalProductionDate = nativeFromJson<DateTime>(json['originalProductionDate']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalRejectedRunningFeet = nativeFromJson<double>(json['totalRejectedRunningFeet']),
  createdBy = nativeFromJson<String>(json['createdBy']),
  timestamp = json['timestamp'] == null ? null : Timestamp.fromJson(json['timestamp']),
  sheetCustomerRejectionItems_on_report = (json['sheetCustomerRejectionItems_on_report'] as List<dynamic>)
        .map((e) => ListSheetCustomerRejectionReportsSheetCustomerRejectionReportsSheetCustomerRejectionItemsOnReport.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSheetCustomerRejectionReportsSheetCustomerRejectionReports otherTyped = other as ListSheetCustomerRejectionReportsSheetCustomerRejectionReports;
    return id == otherTyped.id && 
    originalProductionDate == otherTyped.originalProductionDate && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalRejectedRunningFeet == otherTyped.totalRejectedRunningFeet && 
    createdBy == otherTyped.createdBy && 
    timestamp == otherTyped.timestamp && 
    sheetCustomerRejectionItems_on_report == otherTyped.sheetCustomerRejectionItems_on_report;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, originalProductionDate.hashCode, machineNumber.hashCode, shift.hashCode, totalRejectedRunningFeet.hashCode, createdBy.hashCode, timestamp.hashCode, sheetCustomerRejectionItems_on_report.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['originalProductionDate'] = nativeToJson<DateTime>(originalProductionDate);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalRejectedRunningFeet'] = nativeToJson<double>(totalRejectedRunningFeet);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    json['sheetCustomerRejectionItems_on_report'] = sheetCustomerRejectionItems_on_report.map((e) => e.toJson()).toList();
    return json;
  }

  ListSheetCustomerRejectionReportsSheetCustomerRejectionReports({
    required this.id,
    required this.originalProductionDate,
    required this.machineNumber,
    required this.shift,
    required this.totalRejectedRunningFeet,
    required this.createdBy,
    this.timestamp,
    required this.sheetCustomerRejectionItems_on_report,
  });
}

@immutable
class ListSheetCustomerRejectionReportsSheetCustomerRejectionReportsSheetCustomerRejectionItemsOnReport {
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
  ListSheetCustomerRejectionReportsSheetCustomerRejectionReportsSheetCustomerRejectionItemsOnReport.fromJson(dynamic json):
  
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

    final ListSheetCustomerRejectionReportsSheetCustomerRejectionReportsSheetCustomerRejectionItemsOnReport otherTyped = other as ListSheetCustomerRejectionReportsSheetCustomerRejectionReportsSheetCustomerRejectionItemsOnReport;
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

  ListSheetCustomerRejectionReportsSheetCustomerRejectionReportsSheetCustomerRejectionItemsOnReport({
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
class ListSheetCustomerRejectionReportsData {
  final List<ListSheetCustomerRejectionReportsSheetCustomerRejectionReports> sheetCustomerRejectionReports;
  ListSheetCustomerRejectionReportsData.fromJson(dynamic json):
  
  sheetCustomerRejectionReports = (json['sheetCustomerRejectionReports'] as List<dynamic>)
        .map((e) => ListSheetCustomerRejectionReportsSheetCustomerRejectionReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSheetCustomerRejectionReportsData otherTyped = other as ListSheetCustomerRejectionReportsData;
    return sheetCustomerRejectionReports == otherTyped.sheetCustomerRejectionReports;
    
  }
  @override
  int get hashCode => sheetCustomerRejectionReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetCustomerRejectionReports'] = sheetCustomerRejectionReports.map((e) => e.toJson()).toList();
    return json;
  }

  ListSheetCustomerRejectionReportsData({
    required this.sheetCustomerRejectionReports,
  });
}

@immutable
class ListSheetCustomerRejectionReportsVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListSheetCustomerRejectionReportsVariables.fromJson(Map<String, dynamic> json) {
  
  
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

    final ListSheetCustomerRejectionReportsVariables otherTyped = other as ListSheetCustomerRejectionReportsVariables;
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

  ListSheetCustomerRejectionReportsVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

