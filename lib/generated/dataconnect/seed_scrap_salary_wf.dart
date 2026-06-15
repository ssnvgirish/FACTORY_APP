part of 'default.dart';

class SeedScrapSalaryWfVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapSalaryWfVariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapSalaryWfData> dataDeserializer = (dynamic json)  => SeedScrapSalaryWfData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapSalaryWfData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapSalaryWfData, void> ref() {
    
    return _dataConnect.mutation("SeedScrapSalaryWF", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapSalaryWfMasterSalaryWeightageInsert {
  final String id;
  SeedScrapSalaryWfMasterSalaryWeightageInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapSalaryWfMasterSalaryWeightageInsert otherTyped = other as SeedScrapSalaryWfMasterSalaryWeightageInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapSalaryWfMasterSalaryWeightageInsert({
    required this.id,
  });
}

@immutable
class SeedScrapSalaryWfData {
  final SeedScrapSalaryWfMasterSalaryWeightageInsert masterSalaryWeightage_insert;
  SeedScrapSalaryWfData.fromJson(dynamic json):
  
  masterSalaryWeightage_insert = SeedScrapSalaryWfMasterSalaryWeightageInsert.fromJson(json['masterSalaryWeightage_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapSalaryWfData otherTyped = other as SeedScrapSalaryWfData;
    return masterSalaryWeightage_insert == otherTyped.masterSalaryWeightage_insert;
    
  }
  @override
  int get hashCode => masterSalaryWeightage_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSalaryWeightage_insert'] = masterSalaryWeightage_insert.toJson();
    return json;
  }

  SeedScrapSalaryWfData({
    required this.masterSalaryWeightage_insert,
  });
}

