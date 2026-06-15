part of 'default.dart';

class SeedScrapSalary1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapSalary1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapSalary1Data> dataDeserializer = (dynamic json)  => SeedScrapSalary1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapSalary1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapSalary1Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapSalary1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapSalary1ScrapSalaryCalculationInsert {
  final String id;
  SeedScrapSalary1ScrapSalaryCalculationInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapSalary1ScrapSalaryCalculationInsert otherTyped = other as SeedScrapSalary1ScrapSalaryCalculationInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapSalary1ScrapSalaryCalculationInsert({
    required this.id,
  });
}

@immutable
class SeedScrapSalary1Data {
  final SeedScrapSalary1ScrapSalaryCalculationInsert scrapSalaryCalculation_insert;
  SeedScrapSalary1Data.fromJson(dynamic json):
  
  scrapSalaryCalculation_insert = SeedScrapSalary1ScrapSalaryCalculationInsert.fromJson(json['scrapSalaryCalculation_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapSalary1Data otherTyped = other as SeedScrapSalary1Data;
    return scrapSalaryCalculation_insert == otherTyped.scrapSalaryCalculation_insert;
    
  }
  @override
  int get hashCode => scrapSalaryCalculation_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapSalaryCalculation_insert'] = scrapSalaryCalculation_insert.toJson();
    return json;
  }

  SeedScrapSalary1Data({
    required this.scrapSalaryCalculation_insert,
  });
}

