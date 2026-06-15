part of 'default.dart';

class InsertMasterFrameDensityVariablesBuilder {
  String value;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  InsertMasterFrameDensityVariablesBuilder(this._dataConnect, {required  this.value,required  this.sortOrder,required  this.isActive,});
  Deserializer<InsertMasterFrameDensityData> dataDeserializer = (dynamic json)  => InsertMasterFrameDensityData.fromJson(jsonDecode(json));
  Serializer<InsertMasterFrameDensityVariables> varsSerializer = (InsertMasterFrameDensityVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMasterFrameDensityData, InsertMasterFrameDensityVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMasterFrameDensityData, InsertMasterFrameDensityVariables> ref() {
    InsertMasterFrameDensityVariables vars= InsertMasterFrameDensityVariables(value: value,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("InsertMasterFrameDensity", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMasterFrameDensityMasterFrameDensityInsert {
  final String id;
  InsertMasterFrameDensityMasterFrameDensityInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterFrameDensityMasterFrameDensityInsert otherTyped = other as InsertMasterFrameDensityMasterFrameDensityInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMasterFrameDensityMasterFrameDensityInsert({
    required this.id,
  });
}

@immutable
class InsertMasterFrameDensityData {
  final InsertMasterFrameDensityMasterFrameDensityInsert masterFrameDensity_insert;
  InsertMasterFrameDensityData.fromJson(dynamic json):
  
  masterFrameDensity_insert = InsertMasterFrameDensityMasterFrameDensityInsert.fromJson(json['masterFrameDensity_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterFrameDensityData otherTyped = other as InsertMasterFrameDensityData;
    return masterFrameDensity_insert == otherTyped.masterFrameDensity_insert;
    
  }
  @override
  int get hashCode => masterFrameDensity_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameDensity_insert'] = masterFrameDensity_insert.toJson();
    return json;
  }

  InsertMasterFrameDensityData({
    required this.masterFrameDensity_insert,
  });
}

@immutable
class InsertMasterFrameDensityVariables {
  final String value;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMasterFrameDensityVariables.fromJson(Map<String, dynamic> json):
  
  value = nativeFromJson<String>(json['value']),
  sortOrder = nativeFromJson<int>(json['sortOrder']),
  isActive = nativeFromJson<bool>(json['isActive']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterFrameDensityVariables otherTyped = other as InsertMasterFrameDensityVariables;
    return value == otherTyped.value && 
    sortOrder == otherTyped.sortOrder && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([value.hashCode, sortOrder.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['value'] = nativeToJson<String>(value);
    json['sortOrder'] = nativeToJson<int>(sortOrder);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  InsertMasterFrameDensityVariables({
    required this.value,
    required this.sortOrder,
    required this.isActive,
  });
}

