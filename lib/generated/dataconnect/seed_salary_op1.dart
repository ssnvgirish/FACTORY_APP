part of 'default.dart';

class SeedSalaryOp1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSalaryOp1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSalaryOp1Data> dataDeserializer = (dynamic json)  => SeedSalaryOp1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSalaryOp1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSalaryOp1Data, void> ref() {
    
    return _dataConnect.mutation("SeedSalaryOp1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSalaryOp1SalaryCalculationInsert {
  final String id;
  SeedSalaryOp1SalaryCalculationInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryOp1SalaryCalculationInsert otherTyped = other as SeedSalaryOp1SalaryCalculationInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSalaryOp1SalaryCalculationInsert({
    required this.id,
  });
}

@immutable
class SeedSalaryOp1Data {
  final SeedSalaryOp1SalaryCalculationInsert salaryCalculation_insert;
  SeedSalaryOp1Data.fromJson(dynamic json):
  
  salaryCalculation_insert = SeedSalaryOp1SalaryCalculationInsert.fromJson(json['salaryCalculation_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryOp1Data otherTyped = other as SeedSalaryOp1Data;
    return salaryCalculation_insert == otherTyped.salaryCalculation_insert;
    
  }
  @override
  int get hashCode => salaryCalculation_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['salaryCalculation_insert'] = salaryCalculation_insert.toJson();
    return json;
  }

  SeedSalaryOp1Data({
    required this.salaryCalculation_insert,
  });
}

