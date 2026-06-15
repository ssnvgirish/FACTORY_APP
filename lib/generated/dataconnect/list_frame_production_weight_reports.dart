part of 'default.dart';

class ListFrameProductionWeightReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListFrameProductionWeightReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListFrameProductionWeightReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListFrameProductionWeightReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListFrameProductionWeightReportsVariablesBuilder(this._dataConnect, );
  Deserializer<ListFrameProductionWeightReportsData> dataDeserializer = (dynamic json)  => ListFrameProductionWeightReportsData.fromJson(jsonDecode(json));
  Serializer<ListFrameProductionWeightReportsVariables> varsSerializer = (ListFrameProductionWeightReportsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListFrameProductionWeightReportsData, ListFrameProductionWeightReportsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListFrameProductionWeightReportsData, ListFrameProductionWeightReportsVariables> ref() {
    ListFrameProductionWeightReportsVariables vars= ListFrameProductionWeightReportsVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListFrameProductionWeightReports", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListFrameProductionWeightReportsFrameProductionWeightReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final double productionWeight;
  final double maintenanceWeight;
  final double totalProductionWeight;
  final double targetWeight;
  final double efficiencyPercentage;
  final String createdBy;
  final Timestamp? timestamp;
  ListFrameProductionWeightReportsFrameProductionWeightReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  productionWeight = nativeFromJson<double>(json['productionWeight']),
  maintenanceWeight = nativeFromJson<double>(json['maintenanceWeight']),
  totalProductionWeight = nativeFromJson<double>(json['totalProductionWeight']),
  targetWeight = nativeFromJson<double>(json['targetWeight']),
  efficiencyPercentage = nativeFromJson<double>(json['efficiencyPercentage']),
  createdBy = nativeFromJson<String>(json['createdBy']),
  timestamp = json['timestamp'] == null ? null : Timestamp.fromJson(json['timestamp']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameProductionWeightReportsFrameProductionWeightReports otherTyped = other as ListFrameProductionWeightReportsFrameProductionWeightReports;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    productionWeight == otherTyped.productionWeight && 
    maintenanceWeight == otherTyped.maintenanceWeight && 
    totalProductionWeight == otherTyped.totalProductionWeight && 
    targetWeight == otherTyped.targetWeight && 
    efficiencyPercentage == otherTyped.efficiencyPercentage && 
    createdBy == otherTyped.createdBy && 
    timestamp == otherTyped.timestamp;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, machineNumber.hashCode, shift.hashCode, productionWeight.hashCode, maintenanceWeight.hashCode, totalProductionWeight.hashCode, targetWeight.hashCode, efficiencyPercentage.hashCode, createdBy.hashCode, timestamp.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['productionWeight'] = nativeToJson<double>(productionWeight);
    json['maintenanceWeight'] = nativeToJson<double>(maintenanceWeight);
    json['totalProductionWeight'] = nativeToJson<double>(totalProductionWeight);
    json['targetWeight'] = nativeToJson<double>(targetWeight);
    json['efficiencyPercentage'] = nativeToJson<double>(efficiencyPercentage);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    return json;
  }

  ListFrameProductionWeightReportsFrameProductionWeightReports({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.productionWeight,
    required this.maintenanceWeight,
    required this.totalProductionWeight,
    required this.targetWeight,
    required this.efficiencyPercentage,
    required this.createdBy,
    this.timestamp,
  });
}

@immutable
class ListFrameProductionWeightReportsData {
  final List<ListFrameProductionWeightReportsFrameProductionWeightReports> frameProductionWeightReports;
  ListFrameProductionWeightReportsData.fromJson(dynamic json):
  
  frameProductionWeightReports = (json['frameProductionWeightReports'] as List<dynamic>)
        .map((e) => ListFrameProductionWeightReportsFrameProductionWeightReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListFrameProductionWeightReportsData otherTyped = other as ListFrameProductionWeightReportsData;
    return frameProductionWeightReports == otherTyped.frameProductionWeightReports;
    
  }
  @override
  int get hashCode => frameProductionWeightReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameProductionWeightReports'] = frameProductionWeightReports.map((e) => e.toJson()).toList();
    return json;
  }

  ListFrameProductionWeightReportsData({
    required this.frameProductionWeightReports,
  });
}

@immutable
class ListFrameProductionWeightReportsVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListFrameProductionWeightReportsVariables.fromJson(Map<String, dynamic> json) {
  
  
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

    final ListFrameProductionWeightReportsVariables otherTyped = other as ListFrameProductionWeightReportsVariables;
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

  ListFrameProductionWeightReportsVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

