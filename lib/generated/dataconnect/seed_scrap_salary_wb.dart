part of 'default.dart';

class SeedScrapSalaryWbVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapSalaryWbVariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapSalaryWbData> dataDeserializer = (dynamic json)  => SeedScrapSalaryWbData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapSalaryWbData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapSalaryWbData, void> ref() {
    
    return _dataConnect.mutation("SeedScrapSalaryWB", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapSalaryWbMasterSalaryWeightageInsert {
  final String id;
  SeedScrapSalaryWbMasterSalaryWeightageInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapSalaryWbMasterSalaryWeightageInsert otherTyped = other as SeedScrapSalaryWbMasterSalaryWeightageInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapSalaryWbMasterSalaryWeightageInsert({
    required this.id,
  });
}

@immutable
class SeedScrapSalaryWbData {
  final SeedScrapSalaryWbMasterSalaryWeightageInsert masterSalaryWeightage_insert;
  SeedScrapSalaryWbData.fromJson(dynamic json):
  
  masterSalaryWeightage_insert = SeedScrapSalaryWbMasterSalaryWeightageInsert.fromJson(json['masterSalaryWeightage_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapSalaryWbData otherTyped = other as SeedScrapSalaryWbData;
    return masterSalaryWeightage_insert == otherTyped.masterSalaryWeightage_insert;
    
  }
  @override
  int get hashCode => masterSalaryWeightage_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSalaryWeightage_insert'] = masterSalaryWeightage_insert.toJson();
    return json;
  }

  SeedScrapSalaryWbData({
    required this.masterSalaryWeightage_insert,
  });
}

