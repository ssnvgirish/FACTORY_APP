part of 'default.dart';

class ListSheetProductionDetailsReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListSheetProductionDetailsReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListSheetProductionDetailsReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListSheetProductionDetailsReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListSheetProductionDetailsReportsVariablesBuilder(this._dataConnect, );
  Deserializer<ListSheetProductionDetailsReportsData> dataDeserializer = (dynamic json)  => ListSheetProductionDetailsReportsData.fromJson(jsonDecode(json));
  Serializer<ListSheetProductionDetailsReportsVariables> varsSerializer = (ListSheetProductionDetailsReportsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListSheetProductionDetailsReportsData, ListSheetProductionDetailsReportsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListSheetProductionDetailsReportsData, ListSheetProductionDetailsReportsVariables> ref() {
    ListSheetProductionDetailsReportsVariables vars= ListSheetProductionDetailsReportsVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListSheetProductionDetailsReports", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListSheetProductionDetailsReportsSheetProductionDetailsReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final int totalQuantity;
  final double totalWeight;
  final double totalRunningFeet;
  final String createdBy;
  final Timestamp? submittedAt;
  final Timestamp? timestamp;
  final List<ListSheetProductionDetailsReportsSheetProductionDetailsReportsSheetProductionLineItemsOnReport> sheetProductionLineItems_on_report;
  ListSheetProductionDetailsReportsSheetProductionDetailsReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalQuantity = nativeFromJson<int>(json['totalQuantity']),
  totalWeight = nativeFromJson<double>(json['totalWeight']),
  totalRunningFeet = nativeFromJson<double>(json['totalRunningFeet']),
  createdBy = nativeFromJson<String>(json['createdBy']),
  submittedAt = json['submittedAt'] == null ? null : Timestamp.fromJson(json['submittedAt']),
  timestamp = json['timestamp'] == null ? null : Timestamp.fromJson(json['timestamp']),
  sheetProductionLineItems_on_report = (json['sheetProductionLineItems_on_report'] as List<dynamic>)
        .map((e) => ListSheetProductionDetailsReportsSheetProductionDetailsReportsSheetProductionLineItemsOnReport.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSheetProductionDetailsReportsSheetProductionDetailsReports otherTyped = other as ListSheetProductionDetailsReportsSheetProductionDetailsReports;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalQuantity == otherTyped.totalQuantity && 
    totalWeight == otherTyped.totalWeight && 
    totalRunningFeet == otherTyped.totalRunningFeet && 
    createdBy == otherTyped.createdBy && 
    submittedAt == otherTyped.submittedAt && 
    timestamp == otherTyped.timestamp && 
    sheetProductionLineItems_on_report == otherTyped.sheetProductionLineItems_on_report;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, machineNumber.hashCode, shift.hashCode, totalQuantity.hashCode, totalWeight.hashCode, totalRunningFeet.hashCode, createdBy.hashCode, submittedAt.hashCode, timestamp.hashCode, sheetProductionLineItems_on_report.hashCode]);
  

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
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    json['sheetProductionLineItems_on_report'] = sheetProductionLineItems_on_report.map((e) => e.toJson()).toList();
    return json;
  }

  ListSheetProductionDetailsReportsSheetProductionDetailsReports({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalQuantity,
    required this.totalWeight,
    required this.totalRunningFeet,
    required this.createdBy,
    this.submittedAt,
    this.timestamp,
    required this.sheetProductionLineItems_on_report,
  });
}

@immutable
class ListSheetProductionDetailsReportsSheetProductionDetailsReportsSheetProductionLineItemsOnReport {
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
  final Timestamp? timeOfChange;
  final double? manualWeightPerSqft;
  ListSheetProductionDetailsReportsSheetProductionDetailsReportsSheetProductionLineItemsOnReport.fromJson(dynamic json):
  
  thickness = nativeFromJson<String>(json['thickness']),
  density = nativeFromJson<String>(json['density']),
  color = nativeFromJson<String>(json['color']),
  length = nativeFromJson<double>(json['length']),
  width = nativeFromJson<double>(json['width']),
  quantity = nativeFromJson<int>(json['quantity']),
  sqft = nativeFromJson<double>(json['sqft']),
  perPieceWeight = nativeFromJson<double>(json['perPieceWeight']),
  totalWeight = nativeFromJson<double>(json['totalWeight']),
  totalRunningFeet = nativeFromJson<double>(json['totalRunningFeet']),
  timeOfChange = json['timeOfChange'] == null ? null : Timestamp.fromJson(json['timeOfChange']),
  manualWeightPerSqft = json['manualWeightPerSqft'] == null ? null : nativeFromJson<double>(json['manualWeightPerSqft']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSheetProductionDetailsReportsSheetProductionDetailsReportsSheetProductionLineItemsOnReport otherTyped = other as ListSheetProductionDetailsReportsSheetProductionDetailsReportsSheetProductionLineItemsOnReport;
    return thickness == otherTyped.thickness && 
    density == otherTyped.density && 
    color == otherTyped.color && 
    length == otherTyped.length && 
    width == otherTyped.width && 
    quantity == otherTyped.quantity && 
    sqft == otherTyped.sqft && 
    perPieceWeight == otherTyped.perPieceWeight && 
    totalWeight == otherTyped.totalWeight && 
    totalRunningFeet == otherTyped.totalRunningFeet && 
    timeOfChange == otherTyped.timeOfChange && 
    manualWeightPerSqft == otherTyped.manualWeightPerSqft;
    
  }
  @override
  int get hashCode => Object.hashAll([thickness.hashCode, density.hashCode, color.hashCode, length.hashCode, width.hashCode, quantity.hashCode, sqft.hashCode, perPieceWeight.hashCode, totalWeight.hashCode, totalRunningFeet.hashCode, timeOfChange.hashCode, manualWeightPerSqft.hashCode]);
  

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
    if (timeOfChange != null) {
      json['timeOfChange'] = timeOfChange!.toJson();
    }
    if (manualWeightPerSqft != null) {
      json['manualWeightPerSqft'] = nativeToJson<double?>(manualWeightPerSqft);
    }
    return json;
  }

  ListSheetProductionDetailsReportsSheetProductionDetailsReportsSheetProductionLineItemsOnReport({
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
    this.timeOfChange,
    this.manualWeightPerSqft,
  });
}

@immutable
class ListSheetProductionDetailsReportsData {
  final List<ListSheetProductionDetailsReportsSheetProductionDetailsReports> sheetProductionDetailsReports;
  ListSheetProductionDetailsReportsData.fromJson(dynamic json):
  
  sheetProductionDetailsReports = (json['sheetProductionDetailsReports'] as List<dynamic>)
        .map((e) => ListSheetProductionDetailsReportsSheetProductionDetailsReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSheetProductionDetailsReportsData otherTyped = other as ListSheetProductionDetailsReportsData;
    return sheetProductionDetailsReports == otherTyped.sheetProductionDetailsReports;
    
  }
  @override
  int get hashCode => sheetProductionDetailsReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetProductionDetailsReports'] = sheetProductionDetailsReports.map((e) => e.toJson()).toList();
    return json;
  }

  ListSheetProductionDetailsReportsData({
    required this.sheetProductionDetailsReports,
  });
}

@immutable
class ListSheetProductionDetailsReportsVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListSheetProductionDetailsReportsVariables.fromJson(Map<String, dynamic> json) {
  
  
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

    final ListSheetProductionDetailsReportsVariables otherTyped = other as ListSheetProductionDetailsReportsVariables;
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

  ListSheetProductionDetailsReportsVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

