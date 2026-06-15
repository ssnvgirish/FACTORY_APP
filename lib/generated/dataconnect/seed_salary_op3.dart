part of 'default.dart';

class SeedSalaryOp3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSalaryOp3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSalaryOp3Data> dataDeserializer = (dynamic json)  => SeedSalaryOp3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSalaryOp3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSalaryOp3Data, void> ref() {
    
    return _dataConnect.mutation("SeedSalaryOp3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSalaryOp3SalaryCalculationInsert {
  final String id;
  SeedSalaryOp3SalaryCalculationInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryOp3SalaryCalculationInsert otherTyped = other as SeedSalaryOp3SalaryCalculationInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSalaryOp3SalaryCalculationInsert({
    required this.id,
  });
}

@immutable
class SeedSalaryOp3Data {
  final SeedSalaryOp3SalaryCalculationInsert salaryCalculation_insert;
  SeedSalaryOp3Data.fromJson(dynamic json):
  
  salaryCalculation_insert = SeedSalaryOp3SalaryCalculationInsert.fromJson(json['salaryCalculation_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryOp3Data otherTyped = other as SeedSalaryOp3Data;
    return salaryCalculation_insert == otherTyped.salaryCalculation_insert;
    
  }
  @override
  int get hashCode => salaryCalculation_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['salaryCalculation_insert'] = salaryCalculation_insert.toJson();
    return json;
  }

  SeedSalaryOp3Data({
    required this.salaryCalculation_insert,
  });
}

