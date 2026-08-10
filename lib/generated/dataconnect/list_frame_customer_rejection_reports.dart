part of 'default.dart';

class ListFrameCustomerRejectionReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListFrameCustomerRejectionReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListFrameCustomerRejectionReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListFrameCustomerRejectionReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListFrameCustomerRejectionReportsVariablesBuilder(this._dataConnect, );
  Deserializer<ListFrameCustomerRejectionReportsData> dataDeserializer = (dynamic json)  => ListFrameCustomerRejectionReportsData.fromJson(jsonDecode(json));
  Serializer<ListFrameCustomerRejectionReportsVariables> varsSerializer = (ListFrameCustomerRejectionReportsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListFrameCustomerRejectionReportsData, ListFrameCustomerRejectionReportsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListFrameCustomerRejectionReportsData, ListFrameCustomerRejectionReportsVariables> ref() {
    ListFrameCustomerRejectionReportsVariables vars= ListFrameCustomerRejectionReportsVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListFrameCustomerRejectionReports", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListFrameCustomerRejectionReportsFrameCustomerRejectionReports {
  final String id;
  final DateTime originalProductionDate;
  final DateTime rejectionDate;
  final String machineNumber;
  final String shift;
  final double totalRejectedWeight;
  final String createdBy;
  final Timestamp? timestamp;
  final List<ListFrameCustomerRejectionReportsFrameCustomerRejectionReportsFrameCustomerRejectionItemsOnReport> frameCustomerRejectionItems_on_report;
  ListFrameCustomerRejectionReportsFrameCustomerRejectionReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  originalProductionDate = nativeFromJson<DateTime>(json['originalProductionDate']),
  rejectionDate = nativeFromJson<DateTime>(json['rejectionDate']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalRejectedWeight = nativeFromJson<double>(json['totalRejectedWeight']),
  createdBy = nativeFromJson<String>(json['createdBy']),
  timestamp = json['timestamp'] == null ? null : Timestamp.fromJson(json['timestamp']),
  frameCustomerRejectionItems_on_report = (json['frameCustomerRejectionItems_on_report'] as List<dynamic>)
        .map((e) => ListFrameCustomerRejectionReportsFrameCustomerRejectionReportsFrameCustomerRejectionItemsOnReport.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameCustomerRejectionReportsFrameCustomerRejectionReports otherTyped = other as ListFrameCustomerRejectionReportsFrameCustomerRejectionReports;
    return id == otherTyped.id && 
    originalProductionDate == otherTyped.originalProductionDate && 
    rejectionDate == otherTyped.rejectionDate && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalRejectedWeight == otherTyped.totalRejectedWeight && 
    createdBy == otherTyped.createdBy && 
    timestamp == otherTyped.timestamp && 
    frameCustomerRejectionItems_on_report == otherTyped.frameCustomerRejectionItems_on_report;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, originalProductionDate.hashCode, rejectionDate.hashCode, machineNumber.hashCode, shift.hashCode, totalRejectedWeight.hashCode, createdBy.hashCode, timestamp.hashCode, frameCustomerRejectionItems_on_report.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['originalProductionDate'] = nativeToJson<DateTime>(originalProductionDate);
    json['rejectionDate'] = nativeToJson<DateTime>(rejectionDate);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalRejectedWeight'] = nativeToJson<double>(totalRejectedWeight);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    json['frameCustomerRejectionItems_on_report'] = frameCustomerRejectionItems_on_report.map((e) => e.toJson()).toList();
    return json;
  }

  ListFrameCustomerRejectionReportsFrameCustomerRejectionReports({
    required this.id,
    required this.originalProductionDate,
    required this.rejectionDate,
    required this.machineNumber,
    required this.shift,
    required this.totalRejectedWeight,
    required this.createdBy,
    this.timestamp,
    required this.frameCustomerRejectionItems_on_report,
  });
}

@immutable
class ListFrameCustomerRejectionReportsFrameCustomerRejectionReportsFrameCustomerRejectionItemsOnReport {
  final String section;
  final String density;
  final String color;
  final double length;
  final int quantity;
  final double perPieceWeight;
  final double totalWeight;
  ListFrameCustomerRejectionReportsFrameCustomerRejectionReportsFrameCustomerRejectionItemsOnReport.fromJson(dynamic json):
  
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

    final ListFrameCustomerRejectionReportsFrameCustomerRejectionReportsFrameCustomerRejectionItemsOnReport otherTyped = other as ListFrameCustomerRejectionReportsFrameCustomerRejectionReportsFrameCustomerRejectionItemsOnReport;
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

  ListFrameCustomerRejectionReportsFrameCustomerRejectionReportsFrameCustomerRejectionItemsOnReport({
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
class ListFrameCustomerRejectionReportsData {
  final List<ListFrameCustomerRejectionReportsFrameCustomerRejectionReports> frameCustomerRejectionReports;
  ListFrameCustomerRejectionReportsData.fromJson(dynamic json):
  
  frameCustomerRejectionReports = (json['frameCustomerRejectionReports'] as List<dynamic>)
        .map((e) => ListFrameCustomerRejectionReportsFrameCustomerRejectionReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameCustomerRejectionReportsData otherTyped = other as ListFrameCustomerRejectionReportsData;
    return frameCustomerRejectionReports == otherTyped.frameCustomerRejectionReports;
    
  }
  @override
  int get hashCode => frameCustomerRejectionReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameCustomerRejectionReports'] = frameCustomerRejectionReports.map((e) => e.toJson()).toList();
    return json;
  }

  ListFrameCustomerRejectionReportsData({
    required this.frameCustomerRejectionReports,
  });
}

@immutable
class ListFrameCustomerRejectionReportsVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListFrameCustomerRejectionReportsVariables.fromJson(Map<String, dynamic> json) {
  
  
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

    final ListFrameCustomerRejectionReportsVariables otherTyped = other as ListFrameCustomerRejectionReportsVariables;
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

  ListFrameCustomerRejectionReportsVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

