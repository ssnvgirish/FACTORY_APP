part of 'default.dart';

class SeedSalaryOp2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSalaryOp2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSalaryOp2Data> dataDeserializer = (dynamic json)  => SeedSalaryOp2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSalaryOp2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSalaryOp2Data, void> ref() {
    
    return _dataConnect.mutation("SeedSalaryOp2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSalaryOp2SalaryCalculationInsert {
  final String id;
  SeedSalaryOp2SalaryCalculationInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryOp2SalaryCalculationInsert otherTyped = other as SeedSalaryOp2SalaryCalculationInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSalaryOp2SalaryCalculationInsert({
    required this.id,
  });
}

@immutable
class SeedSalaryOp2Data {
  final SeedSalaryOp2SalaryCalculationInsert salaryCalculation_insert;
  SeedSalaryOp2Data.fromJson(dynamic json):
  
  salaryCalculation_insert = SeedSalaryOp2SalaryCalculationInsert.fromJson(json['salaryCalculation_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryOp2Data otherTyped = other as SeedSalaryOp2Data;
    return salaryCalculation_insert == otherTyped.salaryCalculation_insert;
    
  }
  @override
  int get hashCode => salaryCalculation_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['salaryCalculation_insert'] = salaryCalculation_insert.toJson();
    return json;
  }

  SeedSalaryOp2Data({
    required this.salaryCalculation_insert,
  });
}

