part of 'default.dart';

class GetSalaryCalculationVariablesBuilder {
  String operatorId;
  int year;
  int month;

  final FirebaseDataConnect _dataConnect;
  GetSalaryCalculationVariablesBuilder(this._dataConnect, {required  this.operatorId,required  this.year,required  this.month,});
  Deserializer<GetSalaryCalculationData> dataDeserializer = (dynamic json)  => GetSalaryCalculationData.fromJson(jsonDecode(json));
  Serializer<GetSalaryCalculationVariables> varsSerializer = (GetSalaryCalculationVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetSalaryCalculationData, GetSalaryCalculationVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetSalaryCalculationData, GetSalaryCalculationVariables> ref() {
    GetSalaryCalculationVariables vars= GetSalaryCalculationVariables(operatorId: operatorId,year: year,month: month,);
    return _dataConnect.query("GetSalaryCalculation", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetSalaryCalculationSalaryCalculations {
  final String id;
  final String operatorId;
  final String operatorName;
  final int year;
  final int month;
  final double a;
  final double b;
  final double c;
  final double d;
  final double e;
  final double f;
  final double wA;
  final double wB;
  final double wC;
  final double wD;
  final double wE;
  final double wF;
  final double multiplier;
  final double fixedSalary;
  final double calculatedSalary;
  final Timestamp? timestamp;
  GetSalaryCalculationSalaryCalculations.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  operatorId = nativeFromJson<String>(json['operatorId']),
  operatorName = nativeFromJson<String>(json['operatorName']),
  year = nativeFromJson<int>(json['year']),
  month = nativeFromJson<int>(json['month']),
  a = nativeFromJson<double>(json['a']),
  b = nativeFromJson<double>(json['b']),
  c = nativeFromJson<double>(json['c']),
  d = nativeFromJson<double>(json['d']),
  e = nativeFromJson<double>(json['e']),
  f = nativeFromJson<double>(json['f']),
  wA = nativeFromJson<double>(json['wA']),
  wB = nativeFromJson<double>(json['wB']),
  wC = nativeFromJson<double>(json['wC']),
  wD = nativeFromJson<double>(json['wD']),
  wE = nativeFromJson<double>(json['wE']),
  wF = nativeFromJson<double>(json['wF']),
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

    final GetSalaryCalculationSalaryCalculations otherTyped = other as GetSalaryCalculationSalaryCalculations;
    return id == otherTyped.id && 
    operatorId == otherTyped.operatorId && 
    operatorName == otherTyped.operatorName && 
    year == otherTyped.year && 
    month == otherTyped.month && 
    a == otherTyped.a && 
    b == otherTyped.b && 
    c == otherTyped.c && 
    d == otherTyped.d && 
    e == otherTyped.e && 
    f == otherTyped.f && 
    wA == otherTyped.wA && 
    wB == otherTyped.wB && 
    wC == otherTyped.wC && 
    wD == otherTyped.wD && 
    wE == otherTyped.wE && 
    wF == otherTyped.wF && 
    multiplier == otherTyped.multiplier && 
    fixedSalary == otherTyped.fixedSalary && 
    calculatedSalary == otherTyped.calculatedSalary && 
    timestamp == otherTyped.timestamp;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, operatorId.hashCode, operatorName.hashCode, year.hashCode, month.hashCode, a.hashCode, b.hashCode, c.hashCode, d.hashCode, e.hashCode, f.hashCode, wA.hashCode, wB.hashCode, wC.hashCode, wD.hashCode, wE.hashCode, wF.hashCode, multiplier.hashCode, fixedSalary.hashCode, calculatedSalary.hashCode, timestamp.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['operatorId'] = nativeToJson<String>(operatorId);
    json['operatorName'] = nativeToJson<String>(operatorName);
    json['year'] = nativeToJson<int>(year);
    json['month'] = nativeToJson<int>(month);
    json['a'] = nativeToJson<double>(a);
    json['b'] = nativeToJson<double>(b);
    json['c'] = nativeToJson<double>(c);
    json['d'] = nativeToJson<double>(d);
    json['e'] = nativeToJson<double>(e);
    json['f'] = nativeToJson<double>(f);
    json['wA'] = nativeToJson<double>(wA);
    json['wB'] = nativeToJson<double>(wB);
    json['wC'] = nativeToJson<double>(wC);
    json['wD'] = nativeToJson<double>(wD);
    json['wE'] = nativeToJson<double>(wE);
    json['wF'] = nativeToJson<double>(wF);
    json['multiplier'] = nativeToJson<double>(multiplier);
    json['fixedSalary'] = nativeToJson<double>(fixedSalary);
    json['calculatedSalary'] = nativeToJson<double>(calculatedSalary);
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    return json;
  }

  GetSalaryCalculationSalaryCalculations({
    required this.id,
    required this.operatorId,
    required this.operatorName,
    required this.year,
    required this.month,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.e,
    required this.f,
    required this.wA,
    required this.wB,
    required this.wC,
    required this.wD,
    required this.wE,
    required this.wF,
    required this.multiplier,
    required this.fixedSalary,
    required this.calculatedSalary,
    this.timestamp,
  });
}

@immutable
class GetSalaryCalculationData {
  final List<GetSalaryCalculationSalaryCalculations> salaryCalculations;
  GetSalaryCalculationData.fromJson(dynamic json):
  
  salaryCalculations = (json['salaryCalculations'] as List<dynamic>)
        .map((e) => GetSalaryCalculationSalaryCalculations.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetSalaryCalculationData otherTyped = other as GetSalaryCalculationData;
    return salaryCalculations == otherTyped.salaryCalculations;
    
  }
  @override
  int get hashCode => salaryCalculations.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['salaryCalculations'] = salaryCalculations.map((e) => e.toJson()).toList();
    return json;
  }

  GetSalaryCalculationData({
    required this.salaryCalculations,
  });
}

@immutable
class GetSalaryCalculationVariables {
  final String operatorId;
  final int year;
  final int month;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetSalaryCalculationVariables.fromJson(Map<String, dynamic> json):
  
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

    final GetSalaryCalculationVariables otherTyped = other as GetSalaryCalculationVariables;
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

  GetSalaryCalculationVariables({
    required this.operatorId,
    required this.year,
    required this.month,
  });
}

