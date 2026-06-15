part of 'default.dart';

class SeedScrapSalaryWeVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapSalaryWeVariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapSalaryWeData> dataDeserializer = (dynamic json)  => SeedScrapSalaryWeData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapSalaryWeData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapSalaryWeData, void> ref() {
    
    return _dataConnect.mutation("SeedScrapSalaryWE", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapSalaryWeMasterSalaryWeightageInsert {
  final String id;
  SeedScrapSalaryWeMasterSalaryWeightageInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapSalaryWeMasterSalaryWeightageInsert otherTyped = other as SeedScrapSalaryWeMasterSalaryWeightageInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapSalaryWeMasterSalaryWeightageInsert({
    required this.id,
  });
}

@immutable
class SeedScrapSalaryWeData {
  final SeedScrapSalaryWeMasterSalaryWeightageInsert masterSalaryWeightage_insert;
  SeedScrapSalaryWeData.fromJson(dynamic json):
  
  masterSalaryWeightage_insert = SeedScrapSalaryWeMasterSalaryWeightageInsert.fromJson(json['masterSalaryWeightage_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapSalaryWeData otherTyped = other as SeedScrapSalaryWeData;
    return masterSalaryWeightage_insert == otherTyped.masterSalaryWeightage_insert;
    
  }
  @override
  int get hashCode => masterSalaryWeightage_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSalaryWeightage_insert'] = masterSalaryWeightage_insert.toJson();
    return json;
  }

  SeedScrapSalaryWeData({
    required this.masterSalaryWeightage_insert,
  });
}

