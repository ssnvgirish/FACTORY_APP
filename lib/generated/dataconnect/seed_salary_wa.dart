part of 'default.dart';

class SeedSalaryWaVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSalaryWaVariablesBuilder(this._dataConnect, );
  Deserializer<SeedSalaryWaData> dataDeserializer = (dynamic json)  => SeedSalaryWaData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSalaryWaData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSalaryWaData, void> ref() {
    
    return _dataConnect.mutation("SeedSalaryWA", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSalaryWaMasterSalaryWeightageInsert {
  final String id;
  SeedSalaryWaMasterSalaryWeightageInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryWaMasterSalaryWeightageInsert otherTyped = other as SeedSalaryWaMasterSalaryWeightageInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSalaryWaMasterSalaryWeightageInsert({
    required this.id,
  });
}

@immutable
class SeedSalaryWaData {
  final SeedSalaryWaMasterSalaryWeightageInsert masterSalaryWeightage_insert;
  SeedSalaryWaData.fromJson(dynamic json):
  
  masterSalaryWeightage_insert = SeedSalaryWaMasterSalaryWeightageInsert.fromJson(json['masterSalaryWeightage_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryWaData otherTyped = other as SeedSalaryWaData;
    return masterSalaryWeightage_insert == otherTyped.masterSalaryWeightage_insert;
    
  }
  @override
  int get hashCode => masterSalaryWeightage_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSalaryWeightage_insert'] = masterSalaryWeightage_insert.toJson();
    return json;
  }

  SeedSalaryWaData({
    required this.masterSalaryWeightage_insert,
  });
}

