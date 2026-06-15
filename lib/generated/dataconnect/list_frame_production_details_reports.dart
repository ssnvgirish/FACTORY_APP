part of 'default.dart';

class ListFrameProductionDetailsReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListFrameProductionDetailsReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListFrameProductionDetailsReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListFrameProductionDetailsReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListFrameProductionDetailsReportsVariablesBuilder(this._dataConnect, );
  Deserializer<ListFrameProductionDetailsReportsData> dataDeserializer = (dynamic json)  => ListFrameProductionDetailsReportsData.fromJson(jsonDecode(json));
  Serializer<ListFrameProductionDetailsReportsVariables> varsSerializer = (ListFrameProductionDetailsReportsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListFrameProductionDetailsReportsData, ListFrameProductionDetailsReportsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListFrameProductionDetailsReportsData, ListFrameProductionDetailsReportsVariables> ref() {
    ListFrameProductionDetailsReportsVariables vars= ListFrameProductionDetailsReportsVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListFrameProductionDetailsReports", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListFrameProductionDetailsReportsFrameProductionDetailsReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final int totalQuantity;
  final double totalWeight;
  final String createdBy;
  final Timestamp? submittedAt;
  final Timestamp? timestamp;
  final List<ListFrameProductionDetailsReportsFrameProductionDetailsReportsFrameProductionLineItemsOnReport> frameProductionLineItems_on_report;
  ListFrameProductionDetailsReportsFrameProductionDetailsReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalQuantity = nativeFromJson<int>(json['totalQuantity']),
  totalWeight = nativeFromJson<double>(json['totalWeight']),
  createdBy = nativeFromJson<String>(json['createdBy']),
  submittedAt = json['submittedAt'] == null ? null : Timestamp.fromJson(json['submittedAt']),
  timestamp = json['timestamp'] == null ? null : Timestamp.fromJson(json['timestamp']),
  frameProductionLineItems_on_report = (json['frameProductionLineItems_on_report'] as List<dynamic>)
        .map((e) => ListFrameProductionDetailsReportsFrameProductionDetailsReportsFrameProductionLineItemsOnReport.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameProductionDetailsReportsFrameProductionDetailsReports otherTyped = other as ListFrameProductionDetailsReportsFrameProductionDetailsReports;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalQuantity == otherTyped.totalQuantity && 
    totalWeight == otherTyped.totalWeight && 
    createdBy == otherTyped.createdBy && 
    submittedAt == otherTyped.submittedAt && 
    timestamp == otherTyped.timestamp && 
    frameProductionLineItems_on_report == otherTyped.frameProductionLineItems_on_report;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, machineNumber.hashCode, shift.hashCode, totalQuantity.hashCode, totalWeight.hashCode, createdBy.hashCode, submittedAt.hashCode, timestamp.hashCode, frameProductionLineItems_on_report.hashCode]);
  

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
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    json['frameProductionLineItems_on_report'] = frameProductionLineItems_on_report.map((e) => e.toJson()).toList();
    return json;
  }

  ListFrameProductionDetailsReportsFrameProductionDetailsReports({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalQuantity,
    required this.totalWeight,
    required this.createdBy,
    this.submittedAt,
    this.timestamp,
    required this.frameProductionLineItems_on_report,
  });
}

@immutable
class ListFrameProductionDetailsReportsFrameProductionDetailsReportsFrameProductionLineItemsOnReport {
  final String section;
  final String density;
  final String color;
  final double length;
  final int quantity;
  final double perPieceWeight;
  final double totalWeight;
  final double? manualWeightPerFoot;
  ListFrameProductionDetailsReportsFrameProductionDetailsReportsFrameProductionLineItemsOnReport.fromJson(dynamic json):
  
  section = nativeFromJson<String>(json['section']),
  density = nativeFromJson<String>(json['density']),
  color = nativeFromJson<String>(json['color']),
  length = nativeFromJson<double>(json['length']),
  quantity = nativeFromJson<int>(json['quantity']),
  perPieceWeight = nativeFromJson<double>(json['perPieceWeight']),
  totalWeight = nativeFromJson<double>(json['totalWeight']),
  manualWeightPerFoot = json['manualWeightPerFoot'] == null ? null : nativeFromJson<double>(json['manualWeightPerFoot']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameProductionDetailsReportsFrameProductionDetailsReportsFrameProductionLineItemsOnReport otherTyped = other as ListFrameProductionDetailsReportsFrameProductionDetailsReportsFrameProductionLineItemsOnReport;
    return section == otherTyped.section && 
    density == otherTyped.density && 
    color == otherTyped.color && 
    length == otherTyped.length && 
    quantity == otherTyped.quantity && 
    perPieceWeight == otherTyped.perPieceWeight && 
    totalWeight == otherTyped.totalWeight && 
    manualWeightPerFoot == otherTyped.manualWeightPerFoot;
    
  }
  @override
  int get hashCode => Object.hashAll([section.hashCode, density.hashCode, color.hashCode, length.hashCode, quantity.hashCode, perPieceWeight.hashCode, totalWeight.hashCode, manualWeightPerFoot.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['section'] = nativeToJson<String>(section);
    json['density'] = nativeToJson<String>(density);
    json['color'] = nativeToJson<String>(color);
    json['length'] = nativeToJson<double>(length);
    json['quantity'] = nativeToJson<int>(quantity);
    json['perPieceWeight'] = nativeToJson<double>(perPieceWeight);
    json['totalWeight'] = nativeToJson<double>(totalWeight);
    if (manualWeightPerFoot != null) {
      json['manualWeightPerFoot'] = nativeToJson<double?>(manualWeightPerFoot);
    }
    return json;
  }

  ListFrameProductionDetailsReportsFrameProductionDetailsReportsFrameProductionLineItemsOnReport({
    required this.section,
    required this.density,
    required this.color,
    required this.length,
    required this.quantity,
    required this.perPieceWeight,
    required this.totalWeight,
    this.manualWeightPerFoot,
  });
}

@immutable
class ListFrameProductionDetailsReportsData {
  final List<ListFrameProductionDetailsReportsFrameProductionDetailsReports> frameProductionDetailsReports;
  ListFrameProductionDetailsReportsData.fromJson(dynamic json):
  
  frameProductionDetailsReports = (json['frameProductionDetailsReports'] as List<dynamic>)
        .map((e) => ListFrameProductionDetailsReportsFrameProductionDetailsReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameProductionDetailsReportsData otherTyped = other as ListFrameProductionDetailsReportsData;
    return frameProductionDetailsReports == otherTyped.frameProductionDetailsReports;
    
  }
  @override
  int get hashCode => frameProductionDetailsReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameProductionDetailsReports'] = frameProductionDetailsReports.map((e) => e.toJson()).toList();
    return json;
  }

  ListFrameProductionDetailsReportsData({
    required this.frameProductionDetailsReports,
  });
}

@immutable
class ListFrameProductionDetailsReportsVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListFrameProductionDetailsReportsVariables.fromJson(Map<String, dynamic> json) {
  
  
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

    final ListFrameProductionDetailsReportsVariables otherTyped = other as ListFrameProductionDetailsReportsVariables;
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

  ListFrameProductionDetailsReportsVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

