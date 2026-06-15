part of 'default.dart';

class InsertMasterSheetDensityVariablesBuilder {
  String value;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  InsertMasterSheetDensityVariablesBuilder(this._dataConnect, {required  this.value,required  this.sortOrder,required  this.isActive,});
  Deserializer<InsertMasterSheetDensityData> dataDeserializer = (dynamic json)  => InsertMasterSheetDensityData.fromJson(jsonDecode(json));
  Serializer<InsertMasterSheetDensityVariables> varsSerializer = (InsertMasterSheetDensityVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMasterSheetDensityData, InsertMasterSheetDensityVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMasterSheetDensityData, InsertMasterSheetDensityVariables> ref() {
    InsertMasterSheetDensityVariables vars= InsertMasterSheetDensityVariables(value: value,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("InsertMasterSheetDensity", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMasterSheetDensityMasterSheetDensityInsert {
  final String id;
  InsertMasterSheetDensityMasterSheetDensityInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterSheetDensityMasterSheetDensityInsert otherTyped = other as InsertMasterSheetDensityMasterSheetDensityInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMasterSheetDensityMasterSheetDensityInsert({
    required this.id,
  });
}

@immutable
class InsertMasterSheetDensityData {
  final InsertMasterSheetDensityMasterSheetDensityInsert masterSheetDensity_insert;
  InsertMasterSheetDensityData.fromJson(dynamic json):
  
  masterSheetDensity_insert = InsertMasterSheetDensityMasterSheetDensityInsert.fromJson(json['masterSheetDensity_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterSheetDensityData otherTyped = other as InsertMasterSheetDensityData;
    return masterSheetDensity_insert == otherTyped.masterSheetDensity_insert;
    
  }
  @override
  int get hashCode => masterSheetDensity_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetDensity_insert'] = masterSheetDensity_insert.toJson();
    return json;
  }

  InsertMasterSheetDensityData({
    required this.masterSheetDensity_insert,
  });
}

@immutable
class InsertMasterSheetDensityVariables {
  final String value;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMasterSheetDensityVariables.fromJson(Map<String, dynamic> json):
  
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

    final InsertMasterSheetDensityVariables otherTyped = other as InsertMasterSheetDensityVariables;
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

  InsertMasterSheetDensityVariables({
    required this.value,
    required this.sortOrder,
    required this.isActive,
  });
}

