part of 'default.dart';

class SeedSalaryWcVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedSalaryWcVariablesBuilder(this._dataConnect, );
  Deserializer<SeedSalaryWcData> dataDeserializer = (dynamic json)  => SeedSalaryWcData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedSalaryWcData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedSalaryWcData, void> ref() {
    
    return _dataConnect.mutation("SeedSalaryWC", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedSalaryWcMasterSalaryWeightageInsert {
  final String id;
  SeedSalaryWcMasterSalaryWeightageInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryWcMasterSalaryWeightageInsert otherTyped = other as SeedSalaryWcMasterSalaryWeightageInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedSalaryWcMasterSalaryWeightageInsert({
    required this.id,
  });
}

@immutable
class SeedSalaryWcData {
  final SeedSalaryWcMasterSalaryWeightageInsert masterSalaryWeightage_insert;
  SeedSalaryWcData.fromJson(dynamic json):
  
  masterSalaryWeightage_insert = SeedSalaryWcMasterSalaryWeightageInsert.fromJson(json['masterSalaryWeightage_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedSalaryWcData otherTyped = other as SeedSalaryWcData;
    return masterSalaryWeightage_insert == otherTyped.masterSalaryWeightage_insert;
    
  }
  @override
  int get hashCode => masterSalaryWeightage_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSalaryWeightage_insert'] = masterSalaryWeightage_insert.toJson();
    return json;
  }

  SeedSalaryWcData({
    required this.masterSalaryWeightage_insert,
  });
}

