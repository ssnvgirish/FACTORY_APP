part of 'default.dart';

class SeedSalaryWdVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSalaryWdVariablesBuilder(this._dataConnect, );
  Deserializer<SeedSalaryWdData> dataDeserializer = (dynamic json)  => SeedSalaryWdData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSalaryWdData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSalaryWdData, void> ref() {
    
    return _dataConnect.mutation("SeedSalaryWD", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSalaryWdMasterSalaryWeightageInsert {
  final String id;
  SeedSalaryWdMasterSalaryWeightageInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryWdMasterSalaryWeightageInsert otherTyped = other as SeedSalaryWdMasterSalaryWeightageInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSalaryWdMasterSalaryWeightageInsert({
    required this.id,
  });
}

@immutable
class SeedSalaryWdData {
  final SeedSalaryWdMasterSalaryWeightageInsert masterSalaryWeightage_insert;
  SeedSalaryWdData.fromJson(dynamic json):
  
  masterSalaryWeightage_insert = SeedSalaryWdMasterSalaryWeightageInsert.fromJson(json['masterSalaryWeightage_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryWdData otherTyped = other as SeedSalaryWdData;
    return masterSalaryWeightage_insert == otherTyped.masterSalaryWeightage_insert;
    
  }
  @override
  int get hashCode => masterSalaryWeightage_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSalaryWeightage_insert'] = masterSalaryWeightage_insert.toJson();
    return json;
  }

  SeedSalaryWdData({
    required this.masterSalaryWeightage_insert,
  });
}

