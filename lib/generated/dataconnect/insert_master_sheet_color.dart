part of 'default.dart';

class InsertMasterSheetColorVariablesBuilder {
  String name;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  InsertMasterSheetColorVariablesBuilder(this._dataConnect, {required  this.name,required  this.sortOrder,required  this.isActive,});
  Deserializer<InsertMasterSheetColorData> dataDeserializer = (dynamic json)  => InsertMasterSheetColorData.fromJson(jsonDecode(json));
  Serializer<InsertMasterSheetColorVariables> varsSerializer = (InsertMasterSheetColorVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMasterSheetColorData, InsertMasterSheetColorVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMasterSheetColorData, InsertMasterSheetColorVariables> ref() {
    InsertMasterSheetColorVariables vars= InsertMasterSheetColorVariables(name: name,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("InsertMasterSheetColor", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMasterSheetColorMasterSheetColorInsert {
  final String id;
  InsertMasterSheetColorMasterSheetColorInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterSheetColorMasterSheetColorInsert otherTyped = other as InsertMasterSheetColorMasterSheetColorInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMasterSheetColorMasterSheetColorInsert({
    required this.id,
  });
}

@immutable
class InsertMasterSheetColorData {
  final InsertMasterSheetColorMasterSheetColorInsert masterSheetColor_insert;
  InsertMasterSheetColorData.fromJson(dynamic json):
  
  masterSheetColor_insert = InsertMasterSheetColorMasterSheetColorInsert.fromJson(json['masterSheetColor_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterSheetColorData otherTyped = other as InsertMasterSheetColorData;
    return masterSheetColor_insert == otherTyped.masterSheetColor_insert;
    
  }
  @override
  int get hashCode => masterSheetColor_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetColor_insert'] = masterSheetColor_insert.toJson();
    return json;
  }

  InsertMasterSheetColorData({
    required this.masterSheetColor_insert,
  });
}

@immutable
class InsertMasterSheetColorVariables {
  final String name;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMasterSheetColorVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
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

    final InsertMasterSheetColorVariables otherTyped = other as InsertMasterSheetColorVariables;
    return name == otherTyped.name && 
    sortOrder == otherTyped.sortOrder && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, sortOrder.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['sortOrder'] = nativeToJson<int>(sortOrder);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  InsertMasterSheetColorVariables({
    required this.name,
    required this.sortOrder,
    required this.isActive,
  });
}

