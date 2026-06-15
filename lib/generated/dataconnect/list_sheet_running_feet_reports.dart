part of 'default.dart';

class ListSheetRunningFeetReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListSheetRunningFeetReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListSheetRunningFeetReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListSheetRunningFeetReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListSheetRunningFeetReportsVariablesBuilder(this._dataConnect, );
  Deserializer<ListSheetRunningFeetReportsData> dataDeserializer = (dynamic json)  => ListSheetRunningFeetReportsData.fromJson(jsonDecode(json));
  Serializer<ListSheetRunningFeetReportsVariables> varsSerializer = (ListSheetRunningFeetReportsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListSheetRunningFeetReportsData, ListSheetRunningFeetReportsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListSheetRunningFeetReportsData, ListSheetRunningFeetReportsVariables> ref() {
    ListSheetRunningFeetReportsVariables vars= ListSheetRunningFeetReportsVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListSheetRunningFeetReports", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListSheetRunningFeetReportsSheetRunningFeetReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final double productionRunningFeet;
  final double maintenanceRunningFeet;
  final double totalProductionRunningFeet;
  final double targetRunningFeet;
  final double efficiencyPercentage;
  final String createdBy;
  final Timestamp? timestamp;
  ListSheetRunningFeetReportsSheetRunningFeetReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  productionRunningFeet = nativeFromJson<double>(json['productionRunningFeet']),
  maintenanceRunningFeet = nativeFromJson<double>(json['maintenanceRunningFeet']),
  totalProductionRunningFeet = nativeFromJson<double>(json['totalProductionRunningFeet']),
  targetRunningFeet = nativeFromJson<double>(json['targetRunningFeet']),
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

    final ListSheetRunningFeetReportsSheetRunningFeetReports otherTyped = other as ListSheetRunningFeetReportsSheetRunningFeetReports;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    productionRunningFeet == otherTyped.productionRunningFeet && 
    maintenanceRunningFeet == otherTyped.maintenanceRunningFeet && 
    totalProductionRunningFeet == otherTyped.totalProductionRunningFeet && 
    targetRunningFeet == otherTyped.targetRunningFeet && 
    efficiencyPercentage == otherTyped.efficiencyPercentage && 
    createdBy == otherTyped.createdBy && 
    timestamp == otherTyped.timestamp;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, machineNumber.hashCode, shift.hashCode, productionRunningFeet.hashCode, maintenanceRunningFeet.hashCode, totalProductionRunningFeet.hashCode, targetRunningFeet.hashCode, efficiencyPercentage.hashCode, createdBy.hashCode, timestamp.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['productionRunningFeet'] = nativeToJson<double>(productionRunningFeet);
    json['maintenanceRunningFeet'] = nativeToJson<double>(maintenanceRunningFeet);
    json['totalProductionRunningFeet'] = nativeToJson<double>(totalProductionRunningFeet);
    json['targetRunningFeet'] = nativeToJson<double>(targetRunningFeet);
    json['efficiencyPercentage'] = nativeToJson<double>(efficiencyPercentage);
    json['createdBy'] = nativeToJson<String>(createdBy);
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    return json;
  }

  ListSheetRunningFeetReportsSheetRunningFeetReports({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.productionRunningFeet,
    required this.maintenanceRunningFeet,
    required this.totalProductionRunningFeet,
    required this.targetRunningFeet,
    required this.efficiencyPercentage,
    required this.createdBy,
    this.timestamp,
  });
}

@immutable
class ListSheetRunningFeetReportsData {
  final List<ListSheetRunningFeetReportsSheetRunningFeetReports> sheetRunningFeetReports;
  ListSheetRunningFeetReportsData.fromJson(dynamic json):
  
  sheetRunningFeetReports = (json['sheetRunningFeetReports'] as List<dynamic>)
        .map((e) => ListSheetRunningFeetReportsSheetRunningFeetReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListSheetRunningFeetReportsData otherTyped = other as ListSheetRunningFeetReportsData;
    return sheetRunningFeetReports == otherTyped.sheetRunningFeetReports;
    
  }
  @override
  int get hashCode => sheetRunningFeetReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetRunningFeetReports'] = sheetRunningFeetReports.map((e) => e.toJson()).toList();
    return json;
  }

  ListSheetRunningFeetReportsData({
    required this.sheetRunningFeetReports,
  });
}

@immutable
class ListSheetRunningFeetReportsVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListSheetRunningFeetReportsVariables.fromJson(Map<String, dynamic> json) {
  
  
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

    final ListSheetRunningFeetReportsVariables otherTyped = other as ListSheetRunningFeetReportsVariables;
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

  ListSheetRunningFeetReportsVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

