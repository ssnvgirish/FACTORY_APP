part of 'default.dart';

class SeedSalaryOp4VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSalaryOp4VariablesBuilder(this._dataConnect, );
  Deserializer<SeedSalaryOp4Data> dataDeserializer = (dynamic json)  => SeedSalaryOp4Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSalaryOp4Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSalaryOp4Data, void> ref() {
    
    return _dataConnect.mutation("SeedSalaryOp4", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSalaryOp4SalaryCalculationInsert {
  final String id;
  SeedSalaryOp4SalaryCalculationInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryOp4SalaryCalculationInsert otherTyped = other as SeedSalaryOp4SalaryCalculationInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSalaryOp4SalaryCalculationInsert({
    required this.id,
  });
}

@immutable
class SeedSalaryOp4Data {
  final SeedSalaryOp4SalaryCalculationInsert salaryCalculation_insert;
  SeedSalaryOp4Data.fromJson(dynamic json):
  
  salaryCalculation_insert = SeedSalaryOp4SalaryCalculationInsert.fromJson(json['salaryCalculation_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryOp4Data otherTyped = other as SeedSalaryOp4Data;
    return salaryCalculation_insert == otherTyped.salaryCalculation_insert;
    
  }
  @override
  int get hashCode => salaryCalculation_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['salaryCalculation_insert'] = salaryCalculation_insert.toJson();
    return json;
  }

  SeedSalaryOp4Data({
    required this.salaryCalculation_insert,
  });
}

