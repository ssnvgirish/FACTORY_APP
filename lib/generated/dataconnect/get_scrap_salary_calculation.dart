part of 'default.dart';

class GetScrapSalaryCalculationVariablesBuilder {
  String operatorId;
  int year;
  int month;

  final FirebaseDataConnect _dataConnect;
  GetScrapSalaryCalculationVariablesBuilder(this._dataConnect, {required  this.operatorId,required  this.year,required  this.month,});
  Deserializer<GetScrapSalaryCalculationData> dataDeserializer = (dynamic json)  => GetScrapSalaryCalculationData.fromJson(jsonDecode(json));
  Serializer<GetScrapSalaryCalculationVariables> varsSerializer = (GetScrapSalaryCalculationVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetScrapSalaryCalculationData, GetScrapSalaryCalculationVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetScrapSalaryCalculationData, GetScrapSalaryCalculationVariables> ref() {
    GetScrapSalaryCalculationVariables vars= GetScrapSalaryCalculationVariables(operatorId: operatorId,year: year,month: month,);
    return _dataConnect.query("GetScrapSalaryCalculation", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetScrapSalaryCalculationScrapSalaryCalculations {
  final String id;
  final String operatorId;
  final String operatorName;
  final int year;
  final int month;
  final double a;
  final double b;
  final double e;
  final double f;
  final double g;
  final double wA;
  final double wB;
  final double wE;
  final double wF;
  final double wG;
  final double multiplier;
  final double fixedSalary;
  final double calculatedSalary;
  final Timestamp? timestamp;
  GetScrapSalaryCalculationScrapSalaryCalculations.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  operatorId = nativeFromJson<String>(json['operatorId']),
  operatorName = nativeFromJson<String>(json['operatorName']),
  year = nativeFromJson<int>(json['year']),
  month = nativeFromJson<int>(json['month']),
  a = nativeFromJson<double>(json['a']),
  b = nativeFromJson<double>(json['b']),
  e = nativeFromJson<double>(json['e']),
  f = nativeFromJson<double>(json['f']),
  g = nativeFromJson<double>(json['g']),
  wA = nativeFromJson<double>(json['wA']),
  wB = nativeFromJson<double>(json['wB']),
  wE = nativeFromJson<double>(json['wE']),
  wF = nativeFromJson<double>(json['wF']),
  wG = nativeFromJson<double>(json['wG']),
  multiplier = nativeFromJson<double>(json['multiplier']),
  fixedSalary = nativeFromJson<double>(json['fixedSalary']),
  calculatedSalary = nativeFromJson<double>(json['calculatedSalary']),
  timestamp = json['timestamp'] == null ? null : Timestamp.fromJson(json['timestamp']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetScrapSalaryCalculationScrapSalaryCalculations otherTyped = other as GetScrapSalaryCalculationScrapSalaryCalculations;
    return id == otherTyped.id && 
    operatorId == otherTyped.operatorId && 
    operatorName == otherTyped.operatorName && 
    year == otherTyped.year && 
    month == otherTyped.month && 
    a == otherTyped.a && 
    b == otherTyped.b && 
    e == otherTyped.e && 
    f == otherTyped.f && 
    g == otherTyped.g && 
    wA == otherTyped.wA && 
    wB == otherTyped.wB && 
    wE == otherTyped.wE && 
    wF == otherTyped.wF && 
    wG == otherTyped.wG && 
    multiplier == otherTyped.multiplier && 
    fixedSalary == otherTyped.fixedSalary && 
    calculatedSalary == otherTyped.calculatedSalary && 
    timestamp == otherTyped.timestamp;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, operatorId.hashCode, operatorName.hashCode, year.hashCode, month.hashCode, a.hashCode, b.hashCode, e.hashCode, f.hashCode, g.hashCode, wA.hashCode, wB.hashCode, wE.hashCode, wF.hashCode, wG.hashCode, multiplier.hashCode, fixedSalary.hashCode, calculatedSalary.hashCode, timestamp.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['operatorId'] = nativeToJson<String>(operatorId);
    json['operatorName'] = nativeToJson<String>(operatorName);
    json['year'] = nativeToJson<int>(year);
    json['month'] = nativeToJson<int>(month);
    json['a'] = nativeToJson<double>(a);
    json['b'] = nativeToJson<double>(b);
    json['e'] = nativeToJson<double>(e);
    json['f'] = nativeToJson<double>(f);
    json['g'] = nativeToJson<double>(g);
    json['wA'] = nativeToJson<double>(wA);
    json['wB'] = nativeToJson<double>(wB);
    json['wE'] = nativeToJson<double>(wE);
    json['wF'] = nativeToJson<double>(wF);
    json['wG'] = nativeToJson<double>(wG);
    json['multiplier'] = nativeToJson<double>(multiplier);
    json['fixedSalary'] = nativeToJson<double>(fixedSalary);
    json['calculatedSalary'] = nativeToJson<double>(calculatedSalary);
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    return json;
  }

  GetScrapSalaryCalculationScrapSalaryCalculations({
    required this.id,
    required this.operatorId,
    required this.operatorName,
    required this.year,
    required this.month,
    required this.a,
    required this.b,
    required this.e,
    required this.f,
    required this.g,
    required this.wA,
    required this.wB,
    required this.wE,
    required this.wF,
    required this.wG,
    required this.multiplier,
    required this.fixedSalary,
    required this.calculatedSalary,
    this.timestamp,
  });
}

@immutable
class GetScrapSalaryCalculationData {
  final List<GetScrapSalaryCalculationScrapSalaryCalculations> scrapSalaryCalculations;
  GetScrapSalaryCalculationData.fromJson(dynamic json):
  
  scrapSalaryCalculations = (json['scrapSalaryCalculations'] as List<dynamic>)
        .map((e) => GetScrapSalaryCalculationScrapSalaryCalculations.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetScrapSalaryCalculationData otherTyped = other as GetScrapSalaryCalculationData;
    return scrapSalaryCalculations == otherTyped.scrapSalaryCalculations;
    
  }
  @override
  int get hashCode => scrapSalaryCalculations.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapSalaryCalculations'] = scrapSalaryCalculations.map((e) => e.toJson()).toList();
    return json;
  }

  GetScrapSalaryCalculationData({
    required this.scrapSalaryCalculations,
  });
}

@immutable
class GetScrapSalaryCalculationVariables {
  final String operatorId;
  final int year;
  final int month;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetScrapSalaryCalculationVariables.fromJson(Map<String, dynamic> json):
  
  operatorId = nativeFromJson<String>(json['operatorId']),
  year = nativeFromJson<int>(json['year']),
  month = nativeFromJson<int>(json['month']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetScrapSalaryCalculationVariables otherTyped = other as GetScrapSalaryCalculationVariables;
    return operatorId == otherTyped.operatorId && 
    year == otherTyped.year && 
    month == otherTyped.month;
    
  }
  @override
  int get hashCode => Object.hashAll([operatorId.hashCode, year.hashCode, month.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['operatorId'] = nativeToJson<String>(operatorId);
    json['year'] = nativeToJson<int>(year);
    json['month'] = nativeToJson<int>(month);
    return json;
  }

  GetScrapSalaryCalculationVariables({
    required this.operatorId,
    required this.year,
    required this.month,
  });
}

