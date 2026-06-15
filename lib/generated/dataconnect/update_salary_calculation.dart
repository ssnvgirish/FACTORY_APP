part of 'default.dart';

class UpdateSalaryCalculationVariablesBuilder {
  UpdateSalaryCalculationVariablesId id;
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
  UpdateSalaryCalculationVariablesBuilder(this._dataConnect, {required  this.id,required  this.operatorId,required  this.operatorName,required  this.year,required  this.month,required  this.a,required  this.b,required  this.c,required  this.d,required  this.e,required  this.f,required  this.wA,required  this.wB,required  this.wC,required  this.wD,required  this.wE,required  this.wF,required  this.multiplier,required  this.fixedSalary,required  this.calculatedSalary,});
  Deserializer<UpdateSalaryCalculationData> dataDeserializer = (dynamic json)  => UpdateSalaryCalculationData.fromJson(jsonDecode(json));
  Serializer<UpdateSalaryCalculationVariables> varsSerializer = (UpdateSalaryCalculationVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateSalaryCalculationData, UpdateSalaryCalculationVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateSalaryCalculationData, UpdateSalaryCalculationVariables> ref() {
    UpdateSalaryCalculationVariables vars= UpdateSalaryCalculationVariables(id: id,operatorId: operatorId,operatorName: operatorName,year: year,month: month,a: a,b: b,c: c,d: d,e: e,f: f,wA: wA,wB: wB,wC: wC,wD: wD,wE: wE,wF: wF,multiplier: multiplier,fixedSalary: fixedSalary,calculatedSalary: calculatedSalary,);
    return _dataConnect.mutation("UpdateSalaryCalculation", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateSalaryCalculationSalaryCalculationUpdate {
  final String id;
  UpdateSalaryCalculationSalaryCalculationUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateSalaryCalculationSalaryCalculationUpdate otherTyped = other as UpdateSalaryCalculationSalaryCalculationUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateSalaryCalculationSalaryCalculationUpdate({
    required this.id,
  });
}

@immutable
class UpdateSalaryCalculationData {
  final UpdateSalaryCalculationSalaryCalculationUpdate? salaryCalculation_update;
  UpdateSalaryCalculationData.fromJson(dynamic json):
  
  salaryCalculation_update = json['salaryCalculation_update'] == null ? null : UpdateSalaryCalculationSalaryCalculationUpdate.fromJson(json['salaryCalculation_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateSalaryCalculationData otherTyped = other as UpdateSalaryCalculationData;
    return salaryCalculation_update == otherTyped.salaryCalculation_update;
    
  }
  @override
  int get hashCode => salaryCalculation_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (salaryCalculation_update != null) {
      json['salaryCalculation_update'] = salaryCalculation_update!.toJson();
    }
    return json;
  }

  UpdateSalaryCalculationData({
    this.salaryCalculation_update,
  });
}

@immutable
class UpdateSalaryCalculationVariablesId {
  final String id;
  UpdateSalaryCalculationVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateSalaryCalculationVariablesId otherTyped = other as UpdateSalaryCalculationVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateSalaryCalculationVariablesId({
    required this.id,
  });
}

@immutable
class UpdateSalaryCalculationVariables {
  final UpdateSalaryCalculationVariablesId id;
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
  UpdateSalaryCalculationVariables.fromJson(Map<String, dynamic> json):
  
  id = UpdateSalaryCalculationVariablesId.fromJson(json['id']),
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

    final UpdateSalaryCalculationVariables otherTyped = other as UpdateSalaryCalculationVariables;
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
    calculatedSalary == otherTyped.calculatedSalary;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, operatorId.hashCode, operatorName.hashCode, year.hashCode, month.hashCode, a.hashCode, b.hashCode, c.hashCode, d.hashCode, e.hashCode, f.hashCode, wA.hashCode, wB.hashCode, wC.hashCode, wD.hashCode, wE.hashCode, wF.hashCode, multiplier.hashCode, fixedSalary.hashCode, calculatedSalary.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
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

  UpdateSalaryCalculationVariables({
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
  });
}

