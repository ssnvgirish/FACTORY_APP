part of 'default.dart';

class SeedScrapSalary2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapSalary2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapSalary2Data> dataDeserializer = (dynamic json)  => SeedScrapSalary2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapSalary2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapSalary2Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapSalary2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapSalary2ScrapSalaryCalculationInsert {
  final String id;
  SeedScrapSalary2ScrapSalaryCalculationInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapSalary2ScrapSalaryCalculationInsert otherTyped = other as SeedScrapSalary2ScrapSalaryCalculationInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapSalary2ScrapSalaryCalculationInsert({
    required this.id,
  });
}

@immutable
class SeedScrapSalary2Data {
  final SeedScrapSalary2ScrapSalaryCalculationInsert scrapSalaryCalculation_insert;
  SeedScrapSalary2Data.fromJson(dynamic json):
  
  scrapSalaryCalculation_insert = SeedScrapSalary2ScrapSalaryCalculationInsert.fromJson(json['scrapSalaryCalculation_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapSalary2Data otherTyped = other as SeedScrapSalary2Data;
    return scrapSalaryCalculation_insert == otherTyped.scrapSalaryCalculation_insert;
    
  }
  @override
  int get hashCode => scrapSalaryCalculation_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapSalaryCalculation_insert'] = scrapSalaryCalculation_insert.toJson();
    return json;
  }

  SeedScrapSalary2Data({
    required this.scrapSalaryCalculation_insert,
  });
}

