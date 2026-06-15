part of 'default.dart';

class CreateScrapSalaryCalculationVariablesBuilder {
  String operatorId;
  String operatorName;
  int year;
  int month;
  double a;
  double b;
  double e;
  double f;
  double g;
  double wA;
  double wB;
  double wE;
  double wF;
  double wG;
  double multiplier;
  double fixedSalary;
  double calculatedSalary;

  final FirebaseDataConnect _dataConnect;
  CreateScrapSalaryCalculationVariablesBuilder(this._dataConnect, {required  this.operatorId,required  this.operatorName,required  this.year,required  this.month,required  this.a,required  this.b,required  this.e,required  this.f,required  this.g,required  this.wA,required  this.wB,required  this.wE,required  this.wF,required  this.wG,required  this.multiplier,required  this.fixedSalary,required  this.calculatedSalary,});
  Deserializer<CreateScrapSalaryCalculationData> dataDeserializer = (dynamic json)  => CreateScrapSalaryCalculationData.fromJson(jsonDecode(json));
  Serializer<CreateScrapSalaryCalculationVariables> varsSerializer = (CreateScrapSalaryCalculationVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateScrapSalaryCalculationData, CreateScrapSalaryCalculationVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateScrapSalaryCalculationData, CreateScrapSalaryCalculationVariables> ref() {
    CreateScrapSalaryCalculationVariables vars= CreateScrapSalaryCalculationVariables(operatorId: operatorId,operatorName: operatorName,year: year,month: month,a: a,b: b,e: e,f: f,g: g,wA: wA,wB: wB,wE: wE,wF: wF,wG: wG,multiplier: multiplier,fixedSalary: fixedSalary,calculatedSalary: calculatedSalary,);
    return _dataConnect.mutation("CreateScrapSalaryCalculation", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateScrapSalaryCalculationScrapSalaryCalculationInsert {
  final String id;
  CreateScrapSalaryCalculationScrapSalaryCalculationInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapSalaryCalculationScrapSalaryCalculationInsert otherTyped = other as CreateScrapSalaryCalculationScrapSalaryCalculationInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateScrapSalaryCalculationScrapSalaryCalculationInsert({
    required this.id,
  });
}

@immutable
class CreateScrapSalaryCalculationData {
  final CreateScrapSalaryCalculationScrapSalaryCalculationInsert scrapSalaryCalculation_insert;
  CreateScrapSalaryCalculationData.fromJson(dynamic json):
  
  scrapSalaryCalculation_insert = CreateScrapSalaryCalculationScrapSalaryCalculationInsert.fromJson(json['scrapSalaryCalculation_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapSalaryCalculationData otherTyped = other as CreateScrapSalaryCalculationData;
    return scrapSalaryCalculation_insert == otherTyped.scrapSalaryCalculation_insert;
    
  }
  @override
  int get hashCode => scrapSalaryCalculation_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapSalaryCalculation_insert'] = scrapSalaryCalculation_insert.toJson();
    return json;
  }

  CreateScrapSalaryCalculationData({
    required this.scrapSalaryCalculation_insert,
  });
}

@immutable
class CreateScrapSalaryCalculationVariables {
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
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateScrapSalaryCalculationVariables.fromJson(Map<String, dynamic> json):
  
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
  calculatedSalary = nativeFromJson<double>(json['calculatedSalary']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapSalaryCalculationVariables otherTyped = other as CreateScrapSalaryCalculationVariables;
    return operatorId == otherTyped.operatorId && 
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
    calculatedSalary == otherTyped.calculatedSalary;
    
  }
  @override
  int get hashCode => Object.hashAll([operatorId.hashCode, operatorName.hashCode, year.hashCode, month.hashCode, a.hashCode, b.hashCode, e.hashCode, f.hashCode, g.hashCode, wA.hashCode, wB.hashCode, wE.hashCode, wF.hashCode, wG.hashCode, multiplier.hashCode, fixedSalary.hashCode, calculatedSalary.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
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
    return json;
  }

  CreateScrapSalaryCalculationVariables({
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
  });
}

