part of 'default.dart';

class ListScrapProductionDetailsReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListScrapProductionDetailsReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListScrapProductionDetailsReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListScrapProductionDetailsReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListScrapProductionDetailsReportsVariablesBuilder(this._dataConnect, );
  Deserializer<ListScrapProductionDetailsReportsData> dataDeserializer = (dynamic json)  => ListScrapProductionDetailsReportsData.fromJson(jsonDecode(json));
  Serializer<ListScrapProductionDetailsReportsVariables> varsSerializer = (ListScrapProductionDetailsReportsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListScrapProductionDetailsReportsData, ListScrapProductionDetailsReportsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListScrapProductionDetailsReportsData, ListScrapProductionDetailsReportsVariables> ref() {
    ListScrapProductionDetailsReportsVariables vars= ListScrapProductionDetailsReportsVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListScrapProductionDetailsReports", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListScrapProductionDetailsReportsScrapProductionDetailsReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final double totalProductionWeight;
  final String createdBy;
  final Timestamp? submittedAt;
  final Timestamp? timestamp;
  final List<ListScrapProductionDetailsReportsScrapProductionDetailsReportsScrapProductionLineItemsOnReport> scrapProductionLineItems_on_report;
  ListScrapProductionDetailsReportsScrapProductionDetailsReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalProductionWeight = nativeFromJson<double>(json['totalProductionWeight']),
  createdBy = nativeFromJson<String>(json['createdBy']),
  submittedAt = json['submittedAt'] == null ? null : Timestamp.fromJson(json['submittedAt']),
  timestamp = json['timestamp'] == null ? null : Timestamp.fromJson(json['timestamp']),
  scrapProductionLineItems_on_report = (json['scrapProductionLineItems_on_report'] as List<dynamic>)
        .map((e) => ListScrapProductionDetailsReportsScrapProductionDetailsReportsScrapProductionLineItemsOnReport.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListScrapProductionDetailsReportsScrapProductionDetailsReports otherTyped = other as ListScrapProductionDetailsReportsScrapProductionDetailsReports;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalProductionWeight == otherTyped.totalProductionWeight && 
    createdBy == otherTyped.createdBy && 
    submittedAt == otherTyped.submittedAt && 
    timestamp == otherTyped.timestamp && 
    scrapProductionLineItems_on_report == otherTyped.scrapProductionLineItems_on_report;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, machineNumber.hashCode, shift.hashCode, totalProductionWeight.hashCode, createdBy.hashCode, submittedAt.hashCode, timestamp.hashCode, scrapProductionLineItems_on_report.hashCode]);
  

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
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    json['scrapProductionLineItems_on_report'] = scrapProductionLineItems_on_report.map((e) => e.toJson()).toList();
    return json;
  }

  ListScrapProductionDetailsReportsScrapProductionDetailsReports({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalProductionWeight,
    required this.createdBy,
    this.submittedAt,
    this.timestamp,
    required this.scrapProductionLineItems_on_report,
  });
}

@immutable
class ListScrapProductionDetailsReportsScrapProductionDetailsReportsScrapProductionLineItemsOnReport {
  final String product;
  final double weightPerBag;
  final int totalBags;
  final double totalWeight;
  ListScrapProductionDetailsReportsScrapProductionDetailsReportsScrapProductionLineItemsOnReport.fromJson(dynamic json):
  
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

    final ListScrapProductionDetailsReportsScrapProductionDetailsReportsScrapProductionLineItemsOnReport otherTyped = other as ListScrapProductionDetailsReportsScrapProductionDetailsReportsScrapProductionLineItemsOnReport;
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

  ListScrapProductionDetailsReportsScrapProductionDetailsReportsScrapProductionLineItemsOnReport({
    required this.product,
    required this.weightPerBag,
    required this.totalBags,
    required this.totalWeight,
  });
}

@immutable
class ListScrapProductionDetailsReportsData {
  final List<ListScrapProductionDetailsReportsScrapProductionDetailsReports> scrapProductionDetailsReports;
  ListScrapProductionDetailsReportsData.fromJson(dynamic json):
  
  scrapProductionDetailsReports = (json['scrapProductionDetailsReports'] as List<dynamic>)
        .map((e) => ListScrapProductionDetailsReportsScrapProductionDetailsReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListScrapProductionDetailsReportsData otherTyped = other as ListScrapProductionDetailsReportsData;
    return scrapProductionDetailsReports == otherTyped.scrapProductionDetailsReports;
    
  }
  @override
  int get hashCode => scrapProductionDetailsReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapProductionDetailsReports'] = scrapProductionDetailsReports.map((e) => e.toJson()).toList();
    return json;
  }

  ListScrapProductionDetailsReportsData({
    required this.scrapProductionDetailsReports,
  });
}

@immutable
class ListScrapProductionDetailsReportsVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListScrapProductionDetailsReportsVariables.fromJson(Map<String, dynamic> json) {
  
  
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

    final ListScrapProductionDetailsReportsVariables otherTyped = other as ListScrapProductionDetailsReportsVariables;
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

  ListScrapProductionDetailsReportsVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

