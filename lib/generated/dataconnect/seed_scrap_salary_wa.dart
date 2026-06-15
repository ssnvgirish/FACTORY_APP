part of 'default.dart';

class SeedScrapSalaryWaVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapSalaryWaVariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapSalaryWaData> dataDeserializer = (dynamic json)  => SeedScrapSalaryWaData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapSalaryWaData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapSalaryWaData, void> ref() {
    
    return _dataConnect.mutation("SeedScrapSalaryWA", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapSalaryWaMasterSalaryWeightageInsert {
  final String id;
  SeedScrapSalaryWaMasterSalaryWeightageInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapSalaryWaMasterSalaryWeightageInsert otherTyped = other as SeedScrapSalaryWaMasterSalaryWeightageInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapSalaryWaMasterSalaryWeightageInsert({
    required this.id,
  });
}

@immutable
class SeedScrapSalaryWaData {
  final SeedScrapSalaryWaMasterSalaryWeightageInsert masterSalaryWeightage_insert;
  SeedScrapSalaryWaData.fromJson(dynamic json):
  
  masterSalaryWeightage_insert = SeedScrapSalaryWaMasterSalaryWeightageInsert.fromJson(json['masterSalaryWeightage_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapSalaryWaData otherTyped = other as SeedScrapSalaryWaData;
    return masterSalaryWeightage_insert == otherTyped.masterSalaryWeightage_insert;
    
  }
  @override
  int get hashCode => masterSalaryWeightage_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSalaryWeightage_insert'] = masterSalaryWeightage_insert.toJson();
    return json;
  }

  SeedScrapSalaryWaData({
    required this.masterSalaryWeightage_insert,
  });
}

