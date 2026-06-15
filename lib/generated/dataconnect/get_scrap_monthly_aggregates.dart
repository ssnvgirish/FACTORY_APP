part of 'default.dart';

class GetScrapMonthlyAggregatesVariablesBuilder {
  String machineNumber;
  DateTime startDate;
  DateTime endDate;

  final FirebaseDataConnect _dataConnect;
  GetScrapMonthlyAggregatesVariablesBuilder(this._dataConnect, {required  this.machineNumber,required  this.startDate,required  this.endDate,});
  Deserializer<GetScrapMonthlyAggregatesData> dataDeserializer = (dynamic json)  => GetScrapMonthlyAggregatesData.fromJson(jsonDecode(json));
  Serializer<GetScrapMonthlyAggregatesVariables> varsSerializer = (GetScrapMonthlyAggregatesVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetScrapMonthlyAggregatesData, GetScrapMonthlyAggregatesVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetScrapMonthlyAggregatesData, GetScrapMonthlyAggregatesVariables> ref() {
    GetScrapMonthlyAggregatesVariables vars= GetScrapMonthlyAggregatesVariables(machineNumber: machineNumber,startDate: startDate,endDate: endDate,);
    return _dataConnect.query("GetScrapMonthlyAggregates", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetScrapMonthlyAggregatesScrapCleaningReports {
  final double percentage;
  GetScrapMonthlyAggregatesScrapCleaningReports.fromJson(dynamic json):
  
  percentage = nativeFromJson<double>(json['percentage']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetScrapMonthlyAggregatesScrapCleaningReports otherTyped = other as GetScrapMonthlyAggregatesScrapCleaningReports;
    return percentage == otherTyped.percentage;
    
  }
  @override
  int get hashCode => percentage.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['percentage'] = nativeToJson<double>(percentage);
    return json;
  }

  GetScrapMonthlyAggregatesScrapCleaningReports({
    required this.percentage,
  });
}

@immutable
class GetScrapMonthlyAggregatesScrapToolsCountReports {
  final double percentageAvailable;
  GetScrapMonthlyAggregatesScrapToolsCountReports.fromJson(dynamic json):
  
  percentageAvailable = nativeFromJson<double>(json['percentageAvailable']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetScrapMonthlyAggregatesScrapToolsCountReports otherTyped = other as GetScrapMonthlyAggregatesScrapToolsCountReports;
    return percentageAvailable == otherTyped.percentageAvailable;
    
  }
  @override
  int get hashCode => percentageAvailable.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['percentageAvailable'] = nativeToJson<double>(percentageAvailable);
    return json;
  }

  GetScrapMonthlyAggregatesScrapToolsCountReports({
    required this.percentageAvailable,
  });
}

@immutable
class GetScrapMonthlyAggregatesScrapProductionWeightReports {
  final double efficiencyPercentage;
  GetScrapMonthlyAggregatesScrapProductionWeightReports.fromJson(dynamic json):
  
  efficiencyPercentage = nativeFromJson<double>(json['efficiencyPercentage']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetScrapMonthlyAggregatesScrapProductionWeightReports otherTyped = other as GetScrapMonthlyAggregatesScrapProductionWeightReports;
    return efficiencyPercentage == otherTyped.efficiencyPercentage;
    
  }
  @override
  int get hashCode => efficiencyPercentage.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['efficiencyPercentage'] = nativeToJson<double>(efficiencyPercentage);
    return json;
  }

  GetScrapMonthlyAggregatesScrapProductionWeightReports({
    required this.efficiencyPercentage,
  });
}

@immutable
class GetScrapMonthlyAggregatesScrapWritingEfficiencies {
  final int score;
  GetScrapMonthlyAggregatesScrapWritingEfficiencies.fromJson(dynamic json):
  
  score = nativeFromJson<int>(json['score']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetScrapMonthlyAggregatesScrapWritingEfficiencies otherTyped = other as GetScrapMonthlyAggregatesScrapWritingEfficiencies;
    return score == otherTyped.score;
    
  }
  @override
  int get hashCode => score.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['score'] = nativeToJson<int>(score);
    return json;
  }

  GetScrapMonthlyAggregatesScrapWritingEfficiencies({
    required this.score,
  });
}

@immutable
class GetScrapMonthlyAggregatesScrapQualityReports {
  final int qualityRating;
  GetScrapMonthlyAggregatesScrapQualityReports.fromJson(dynamic json):
  
  qualityRating = nativeFromJson<int>(json['qualityRating']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetScrapMonthlyAggregatesScrapQualityReports otherTyped = other as GetScrapMonthlyAggregatesScrapQualityReports;
    return qualityRating == otherTyped.qualityRating;
    
  }
  @override
  int get hashCode => qualityRating.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['qualityRating'] = nativeToJson<int>(qualityRating);
    return json;
  }

  GetScrapMonthlyAggregatesScrapQualityReports({
    required this.qualityRating,
  });
}

@immutable
class GetScrapMonthlyAggregatesData {
  final List<GetScrapMonthlyAggregatesScrapCleaningReports> scrapCleaningReports;
  final List<GetScrapMonthlyAggregatesScrapToolsCountReports> scrapToolsCountReports;
  final List<GetScrapMonthlyAggregatesScrapProductionWeightReports> scrapProductionWeightReports;
  final List<GetScrapMonthlyAggregatesScrapWritingEfficiencies> scrapWritingEfficiencies;
  final List<GetScrapMonthlyAggregatesScrapQualityReports> scrapQualityReports;
  GetScrapMonthlyAggregatesData.fromJson(dynamic json):
  
  scrapCleaningReports = (json['scrapCleaningReports'] as List<dynamic>)
        .map((e) => GetScrapMonthlyAggregatesScrapCleaningReports.fromJson(e))
        .toList(),
  scrapToolsCountReports = (json['scrapToolsCountReports'] as List<dynamic>)
        .map((e) => GetScrapMonthlyAggregatesScrapToolsCountReports.fromJson(e))
        .toList(),
  scrapProductionWeightReports = (json['scrapProductionWeightReports'] as List<dynamic>)
        .map((e) => GetScrapMonthlyAggregatesScrapProductionWeightReports.fromJson(e))
        .toList(),
  scrapWritingEfficiencies = (json['scrapWritingEfficiencies'] as List<dynamic>)
        .map((e) => GetScrapMonthlyAggregatesScrapWritingEfficiencies.fromJson(e))
        .toList(),
  scrapQualityReports = (json['scrapQualityReports'] as List<dynamic>)
        .map((e) => GetScrapMonthlyAggregatesScrapQualityReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetScrapMonthlyAggregatesData otherTyped = other as GetScrapMonthlyAggregatesData;
    return scrapCleaningReports == otherTyped.scrapCleaningReports && 
    scrapToolsCountReports == otherTyped.scrapToolsCountReports && 
    scrapProductionWeightReports == otherTyped.scrapProductionWeightReports && 
    scrapWritingEfficiencies == otherTyped.scrapWritingEfficiencies && 
    scrapQualityReports == otherTyped.scrapQualityReports;
    
  }
  @override
  int get hashCode => Object.hashAll([scrapCleaningReports.hashCode, scrapToolsCountReports.hashCode, scrapProductionWeightReports.hashCode, scrapWritingEfficiencies.hashCode, scrapQualityReports.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapCleaningReports'] = scrapCleaningReports.map((e) => e.toJson()).toList();
    json['scrapToolsCountReports'] = scrapToolsCountReports.map((e) => e.toJson()).toList();
    json['scrapProductionWeightReports'] = scrapProductionWeightReports.map((e) => e.toJson()).toList();
    json['scrapWritingEfficiencies'] = scrapWritingEfficiencies.map((e) => e.toJson()).toList();
    json['scrapQualityReports'] = scrapQualityReports.map((e) => e.toJson()).toList();
    return json;
  }

  GetScrapMonthlyAggregatesData({
    required this.scrapCleaningReports,
    required this.scrapToolsCountReports,
    required this.scrapProductionWeightReports,
    required this.scrapWritingEfficiencies,
    required this.scrapQualityReports,
  });
}

@immutable
class GetScrapMonthlyAggregatesVariables {
  final String machineNumber;
  final DateTime startDate;
  final DateTime endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetScrapMonthlyAggregatesVariables.fromJson(Map<String, dynamic> json):
  
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  startDate = nativeFromJson<DateTime>(json['startDate']),
  endDate = nativeFromJson<DateTime>(json['endDate']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetScrapMonthlyAggregatesVariables otherTyped = other as GetScrapMonthlyAggregatesVariables;
    return machineNumber == otherTyped.machineNumber && 
    startDate == otherTyped.startDate && 
    endDate == otherTyped.endDate;
    
  }
  @override
  int get hashCode => Object.hashAll([machineNumber.hashCode, startDate.hashCode, endDate.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['startDate'] = nativeToJson<DateTime>(startDate);
    json['endDate'] = nativeToJson<DateTime>(endDate);
    return json;
  }

  GetScrapMonthlyAggregatesVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

