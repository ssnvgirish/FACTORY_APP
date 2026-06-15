part of 'default.dart';

class SeedSalaryWeVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSalaryWeVariablesBuilder(this._dataConnect, );
  Deserializer<SeedSalaryWeData> dataDeserializer = (dynamic json)  => SeedSalaryWeData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSalaryWeData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSalaryWeData, void> ref() {
    
    return _dataConnect.mutation("SeedSalaryWE", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSalaryWeMasterSalaryWeightageInsert {
  final String id;
  SeedSalaryWeMasterSalaryWeightageInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryWeMasterSalaryWeightageInsert otherTyped = other as SeedSalaryWeMasterSalaryWeightageInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSalaryWeMasterSalaryWeightageInsert({
    required this.id,
  });
}

@immutable
class SeedSalaryWeData {
  final SeedSalaryWeMasterSalaryWeightageInsert masterSalaryWeightage_insert;
  SeedSalaryWeData.fromJson(dynamic json):
  
  masterSalaryWeightage_insert = SeedSalaryWeMasterSalaryWeightageInsert.fromJson(json['masterSalaryWeightage_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryWeData otherTyped = other as SeedSalaryWeData;
    return masterSalaryWeightage_insert == otherTyped.masterSalaryWeightage_insert;
    
  }
  @override
  int get hashCode => masterSalaryWeightage_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSalaryWeightage_insert'] = masterSalaryWeightage_insert.toJson();
    return json;
  }

  SeedSalaryWeData({
    required this.masterSalaryWeightage_insert,
  });
}

