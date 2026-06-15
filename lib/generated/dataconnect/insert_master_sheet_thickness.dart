part of 'default.dart';

class InsertMasterSheetThicknessVariablesBuilder {
  String value;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  InsertMasterSheetThicknessVariablesBuilder(this._dataConnect, {required  this.value,required  this.sortOrder,required  this.isActive,});
  Deserializer<InsertMasterSheetThicknessData> dataDeserializer = (dynamic json)  => InsertMasterSheetThicknessData.fromJson(jsonDecode(json));
  Serializer<InsertMasterSheetThicknessVariables> varsSerializer = (InsertMasterSheetThicknessVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMasterSheetThicknessData, InsertMasterSheetThicknessVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMasterSheetThicknessData, InsertMasterSheetThicknessVariables> ref() {
    InsertMasterSheetThicknessVariables vars= InsertMasterSheetThicknessVariables(value: value,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("InsertMasterSheetThickness", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMasterSheetThicknessMasterSheetThicknessInsert {
  final String id;
  InsertMasterSheetThicknessMasterSheetThicknessInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterSheetThicknessMasterSheetThicknessInsert otherTyped = other as InsertMasterSheetThicknessMasterSheetThicknessInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMasterSheetThicknessMasterSheetThicknessInsert({
    required this.id,
  });
}

@immutable
class InsertMasterSheetThicknessData {
  final InsertMasterSheetThicknessMasterSheetThicknessInsert masterSheetThickness_insert;
  InsertMasterSheetThicknessData.fromJson(dynamic json):
  
  masterSheetThickness_insert = InsertMasterSheetThicknessMasterSheetThicknessInsert.fromJson(json['masterSheetThickness_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterSheetThicknessData otherTyped = other as InsertMasterSheetThicknessData;
    return masterSheetThickness_insert == otherTyped.masterSheetThickness_insert;
    
  }
  @override
  int get hashCode => masterSheetThickness_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThickness_insert'] = masterSheetThickness_insert.toJson();
    return json;
  }

  InsertMasterSheetThicknessData({
    required this.masterSheetThickness_insert,
  });
}

@immutable
class InsertMasterSheetThicknessVariables {
  final String value;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMasterSheetThicknessVariables.fromJson(Map<String, dynamic> json):
  
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

    final InsertMasterSheetThicknessVariables otherTyped = other as InsertMasterSheetThicknessVariables;
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

  InsertMasterSheetThicknessVariables({
    required this.value,
    required this.sortOrder,
    required this.isActive,
  });
}

