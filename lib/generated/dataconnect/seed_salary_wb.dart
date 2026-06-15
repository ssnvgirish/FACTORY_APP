part of 'default.dart';

class SeedSalaryWbVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSalaryWbVariablesBuilder(this._dataConnect, );
  Deserializer<SeedSalaryWbData> dataDeserializer = (dynamic json)  => SeedSalaryWbData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSalaryWbData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSalaryWbData, void> ref() {
    
    return _dataConnect.mutation("SeedSalaryWB", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSalaryWbMasterSalaryWeightageInsert {
  final String id;
  SeedSalaryWbMasterSalaryWeightageInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryWbMasterSalaryWeightageInsert otherTyped = other as SeedSalaryWbMasterSalaryWeightageInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSalaryWbMasterSalaryWeightageInsert({
    required this.id,
  });
}

@immutable
class SeedSalaryWbData {
  final SeedSalaryWbMasterSalaryWeightageInsert masterSalaryWeightage_insert;
  SeedSalaryWbData.fromJson(dynamic json):
  
  masterSalaryWeightage_insert = SeedSalaryWbMasterSalaryWeightageInsert.fromJson(json['masterSalaryWeightage_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryWbData otherTyped = other as SeedSalaryWbData;
    return masterSalaryWeightage_insert == otherTyped.masterSalaryWeightage_insert;
    
  }
  @override
  int get hashCode => masterSalaryWeightage_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSalaryWeightage_insert'] = masterSalaryWeightage_insert.toJson();
    return json;
  }

  SeedSalaryWbData({
    required this.masterSalaryWeightage_insert,
  });
}

