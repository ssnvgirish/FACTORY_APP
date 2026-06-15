part of 'default.dart';

class SeedSalaryWfVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSalaryWfVariablesBuilder(this._dataConnect, );
  Deserializer<SeedSalaryWfData> dataDeserializer = (dynamic json)  => SeedSalaryWfData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSalaryWfData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSalaryWfData, void> ref() {
    
    return _dataConnect.mutation("SeedSalaryWF", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSalaryWfMasterSalaryWeightageInsert {
  final String id;
  SeedSalaryWfMasterSalaryWeightageInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryWfMasterSalaryWeightageInsert otherTyped = other as SeedSalaryWfMasterSalaryWeightageInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSalaryWfMasterSalaryWeightageInsert({
    required this.id,
  });
}

@immutable
class SeedSalaryWfData {
  final SeedSalaryWfMasterSalaryWeightageInsert masterSalaryWeightage_insert;
  SeedSalaryWfData.fromJson(dynamic json):
  
  masterSalaryWeightage_insert = SeedSalaryWfMasterSalaryWeightageInsert.fromJson(json['masterSalaryWeightage_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryWfData otherTyped = other as SeedSalaryWfData;
    return masterSalaryWeightage_insert == otherTyped.masterSalaryWeightage_insert;
    
  }
  @override
  int get hashCode => masterSalaryWeightage_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSalaryWeightage_insert'] = masterSalaryWeightage_insert.toJson();
    return json;
  }

  SeedSalaryWfData({
    required this.masterSalaryWeightage_insert,
  });
}

