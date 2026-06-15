part of 'default.dart';

class CreateSalaryCalculationVariablesBuilder {
  String operatorId;
  String operatorName;
  int year;
  int month;
  double a;
  double b;
  double c;
  double d;
  double e;
  double f;
  double wA;
  double wB;
  double wC;
  double wD;
  double wE;
  double wF;
  double multiplier;
  double fixedSalary;
  double calculatedSalary;

  final FirebaseDataConnect _dataConnect;
  CreateSalaryCalculationVariablesBuilder(this._dataConnect, {required  this.operatorId,required  this.operatorName,required  this.year,required  this.month,required  this.a,required  this.b,required  this.c,required  this.d,required  this.e,required  this.f,required  this.wA,required  this.wB,required  this.wC,required  this.wD,required  this.wE,required  this.wF,required  this.multiplier,required  this.fixedSalary,required  this.calculatedSalary,});
  Deserializer<CreateSalaryCalculationData> dataDeserializer = (dynamic json)  => CreateSalaryCalculationData.fromJson(jsonDecode(json));
  Serializer<CreateSalaryCalculationVariables> varsSerializer = (CreateSalaryCalculationVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateSalaryCalculationData, CreateSalaryCalculationVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateSalaryCalculationData, CreateSalaryCalculationVariables> ref() {
    CreateSalaryCalculationVariables vars= CreateSalaryCalculationVariables(operatorId: operatorId,operatorName: operatorName,year: year,month: month,a: a,b: b,c: c,d: d,e: e,f: f,wA: wA,wB: wB,wC: wC,wD: wD,wE: wE,wF: wF,multiplier: multiplier,fixedSalary: fixedSalary,calculatedSalary: calculatedSalary,);
    return _dataConnect.mutation("CreateSalaryCalculation", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateSalaryCalculationSalaryCalculationInsert {
  final String id;
  CreateSalaryCalculationSalaryCalculationInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSalaryCalculationSalaryCalculationInsert otherTyped = other as CreateSalaryCalculationSalaryCalculationInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSalaryCalculationSalaryCalculationInsert({
    required this.id,
  });
}

@immutable
class CreateSalaryCalculationData {
  final CreateSalaryCalculationSalaryCalculationInsert salaryCalculation_insert;
  CreateSalaryCalculationData.fromJson(dynamic json):
  
  salaryCalculation_insert = CreateSalaryCalculationSalaryCalculationInsert.fromJson(json['salaryCalculation_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSalaryCalculationData otherTyped = other as CreateSalaryCalculationData;
    return salaryCalculation_insert == otherTyped.salaryCalculation_insert;
    
  }
  @override
  int get hashCode => salaryCalculation_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['salaryCalculation_insert'] = salaryCalculation_insert.toJson();
    return json;
  }

  CreateSalaryCalculationData({
    required this.salaryCalculation_insert,
  });
}

@immutable
class CreateSalaryCalculationVariables {
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
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateSalaryCalculationVariables.fromJson(Map<String, dynamic> json):
  
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
  calculatedSalary = nativeFromJson<double>(json['calculatedSalary']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSalaryCalculationVariables otherTyped = other as CreateSalaryCalculationVariables;
    return operatorId == otherTyped.operatorId && 
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
    calculatedSalary == otherTyped.calculatedSalary;
    
  }
  @override
  int get hashCode => Object.hashAll([operatorId.hashCode, operatorName.hashCode, year.hashCode, month.hashCode, a.hashCode, b.hashCode, c.hashCode, d.hashCode, e.hashCode, f.hashCode, wA.hashCode, wB.hashCode, wC.hashCode, wD.hashCode, wE.hashCode, wF.hashCode, multiplier.hashCode, fixedSalary.hashCode, calculatedSalary.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
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
    return json;
  }

  CreateSalaryCalculationVariables({
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
  });
}

