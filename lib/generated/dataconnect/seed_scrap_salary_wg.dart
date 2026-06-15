part of 'default.dart';

class SeedScrapSalaryWgVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapSalaryWgVariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapSalaryWgData> dataDeserializer = (dynamic json)  => SeedScrapSalaryWgData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapSalaryWgData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapSalaryWgData, void> ref() {
    
    return _dataConnect.mutation("SeedScrapSalaryWG", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapSalaryWgMasterSalaryWeightageInsert {
  final String id;
  SeedScrapSalaryWgMasterSalaryWeightageInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapSalaryWgMasterSalaryWeightageInsert otherTyped = other as SeedScrapSalaryWgMasterSalaryWeightageInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapSalaryWgMasterSalaryWeightageInsert({
    required this.id,
  });
}

@immutable
class SeedScrapSalaryWgData {
  final SeedScrapSalaryWgMasterSalaryWeightageInsert masterSalaryWeightage_insert;
  SeedScrapSalaryWgData.fromJson(dynamic json):
  
  masterSalaryWeightage_insert = SeedScrapSalaryWgMasterSalaryWeightageInsert.fromJson(json['masterSalaryWeightage_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapSalaryWgData otherTyped = other as SeedScrapSalaryWgData;
    return masterSalaryWeightage_insert == otherTyped.masterSalaryWeightage_insert;
    
  }
  @override
  int get hashCode => masterSalaryWeightage_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSalaryWeightage_insert'] = masterSalaryWeightage_insert.toJson();
    return json;
  }

  SeedScrapSalaryWgData({
    required this.masterSalaryWeightage_insert,
  });
}

