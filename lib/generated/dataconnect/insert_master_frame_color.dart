part of 'default.dart';

class InsertMasterFrameColorVariablesBuilder {
  String name;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  InsertMasterFrameColorVariablesBuilder(this._dataConnect, {required  this.name,required  this.sortOrder,required  this.isActive,});
  Deserializer<InsertMasterFrameColorData> dataDeserializer = (dynamic json)  => InsertMasterFrameColorData.fromJson(jsonDecode(json));
  Serializer<InsertMasterFrameColorVariables> varsSerializer = (InsertMasterFrameColorVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMasterFrameColorData, InsertMasterFrameColorVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMasterFrameColorData, InsertMasterFrameColorVariables> ref() {
    InsertMasterFrameColorVariables vars= InsertMasterFrameColorVariables(name: name,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("InsertMasterFrameColor", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMasterFrameColorMasterFrameColorInsert {
  final String id;
  InsertMasterFrameColorMasterFrameColorInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterFrameColorMasterFrameColorInsert otherTyped = other as InsertMasterFrameColorMasterFrameColorInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMasterFrameColorMasterFrameColorInsert({
    required this.id,
  });
}

@immutable
class InsertMasterFrameColorData {
  final InsertMasterFrameColorMasterFrameColorInsert masterFrameColor_insert;
  InsertMasterFrameColorData.fromJson(dynamic json):
  
  masterFrameColor_insert = InsertMasterFrameColorMasterFrameColorInsert.fromJson(json['masterFrameColor_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterFrameColorData otherTyped = other as InsertMasterFrameColorData;
    return masterFrameColor_insert == otherTyped.masterFrameColor_insert;
    
  }
  @override
  int get hashCode => masterFrameColor_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameColor_insert'] = masterFrameColor_insert.toJson();
    return json;
  }

  InsertMasterFrameColorData({
    required this.masterFrameColor_insert,
  });
}

@immutable
class InsertMasterFrameColorVariables {
  final String name;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMasterFrameColorVariables.fromJson(Map<String, dynamic> json):
  
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

    final InsertMasterFrameColorVariables otherTyped = other as InsertMasterFrameColorVariables;
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

  InsertMasterFrameColorVariables({
    required this.name,
    required this.sortOrder,
    required this.isActive,
  });
}

