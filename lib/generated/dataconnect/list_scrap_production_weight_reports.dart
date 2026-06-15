part of 'default.dart';

class ListScrapProductionWeightReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListScrapProductionWeightReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListScrapProductionWeightReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListScrapProductionWeightReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListScrapProductionWeightReportsVariablesBuilder(this._dataConnect, );
  Deserializer<ListScrapProductionWeightReportsData> dataDeserializer = (dynamic json)  => ListScrapProductionWeightReportsData.fromJson(jsonDecode(json));
  Serializer<ListScrapProductionWeightReportsVariables> varsSerializer = (ListScrapProductionWeightReportsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListScrapProductionWeightReportsData, ListScrapProductionWeightReportsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListScrapProductionWeightReportsData, ListScrapProductionWeightReportsVariables> ref() {
    ListScrapProductionWeightReportsVariables vars= ListScrapProductionWeightReportsVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListScrapProductionWeightReports", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListScrapProductionWeightReportsScrapProductionWeightReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final double totalProductionWeight;
  final double maintenanceWeight;
  final double totalWeight;
  final double targetWeight;
  final double efficiencyPercentage;
  final String createdBy;
  final Timestamp? timestamp;
  ListScrapProductionWeightReportsScrapProductionWeightReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  totalProductionWeight = nativeFromJson<double>(json['totalProductionWeight']),
  maintenanceWeight = nativeFromJson<double>(json['maintenanceWeight']),
  totalWeight = nativeFromJson<double>(json['totalWeight']),
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

    final ListScrapProductionWeightReportsScrapProductionWeightReports otherTyped = other as ListScrapProductionWeightReportsScrapProductionWeightReports;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    totalProductionWeight == otherTyped.totalProductionWeight && 
    maintenanceWeight == otherTyped.maintenanceWeight && 
    totalWeight == otherTyped.totalWeight && 
    targetWeight == otherTyped.targetWeight && 
    efficiencyPercentage == otherTyped.efficiencyPercentage && 
    createdBy == otherTyped.createdBy && 
    timestamp == otherTyped.timestamp;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, machineNumber.hashCode, shift.hashCode, totalProductionWeight.hashCode, maintenanceWeight.hashCode, totalWeight.hashCode, targetWeight.hashCode, efficiencyPercentage.hashCode, createdBy.hashCode, timestamp.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['totalProductionWeight'] = nativeToJson<double>(totalProductionWeight);
    json['maintenanceWeight'] = nativeToJson<double>(maintenanceWeight);
    json['totalWeight'] = nativeToJson<double>(totalWeight);
    json['targetWeight'] = nativeToJson<double>(targetWeight);
    json['efficiencyPercentage'] = nativeToJson<double>(efficiencyPercentage);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    return json;
  }

  ListScrapProductionWeightReportsScrapProductionWeightReports({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.totalProductionWeight,
    required this.maintenanceWeight,
    required this.totalWeight,
    required this.targetWeight,
    required this.efficiencyPercentage,
    required this.createdBy,
    this.timestamp,
  });
}

@immutable
class ListScrapProductionWeightReportsData {
  final List<ListScrapProductionWeightReportsScrapProductionWeightReports> scrapProductionWeightReports;
  ListScrapProductionWeightReportsData.fromJson(dynamic json):
  
  scrapProductionWeightReports = (json['scrapProductionWeightReports'] as List<dynamic>)
        .map((e) => ListScrapProductionWeightReportsScrapProductionWeightReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListScrapProductionWeightReportsData otherTyped = other as ListScrapProductionWeightReportsData;
    return scrapProductionWeightReports == otherTyped.scrapProductionWeightReports;
    
  }
  @override
  int get hashCode => scrapProductionWeightReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapProductionWeightReports'] = scrapProductionWeightReports.map((e) => e.toJson()).toList();
    return json;
  }

  ListScrapProductionWeightReportsData({
    required this.scrapProductionWeightReports,
  });
}

@immutable
class ListScrapProductionWeightReportsVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListScrapProductionWeightReportsVariables.fromJson(Map<String, dynamic> json) {
  
  
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

    final ListScrapProductionWeightReportsVariables otherTyped = other as ListScrapProductionWeightReportsVariables;
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

  ListScrapProductionWeightReportsVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

