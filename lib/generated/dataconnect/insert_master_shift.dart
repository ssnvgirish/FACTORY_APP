part of 'default.dart';

class InsertMasterShiftVariablesBuilder {
  String name;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  InsertMasterShiftVariablesBuilder(this._dataConnect, {required  this.name,required  this.sortOrder,required  this.isActive,});
  Deserializer<InsertMasterShiftData> dataDeserializer = (dynamic json)  => InsertMasterShiftData.fromJson(jsonDecode(json));
  Serializer<InsertMasterShiftVariables> varsSerializer = (InsertMasterShiftVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMasterShiftData, InsertMasterShiftVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMasterShiftData, InsertMasterShiftVariables> ref() {
    InsertMasterShiftVariables vars= InsertMasterShiftVariables(name: name,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("InsertMasterShift", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMasterShiftMasterShiftInsert {
  final String id;
  InsertMasterShiftMasterShiftInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterShiftMasterShiftInsert otherTyped = other as InsertMasterShiftMasterShiftInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMasterShiftMasterShiftInsert({
    required this.id,
  });
}

@immutable
class InsertMasterShiftData {
  final InsertMasterShiftMasterShiftInsert masterShift_insert;
  InsertMasterShiftData.fromJson(dynamic json):
  
  masterShift_insert = InsertMasterShiftMasterShiftInsert.fromJson(json['masterShift_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterShiftData otherTyped = other as InsertMasterShiftData;
    return masterShift_insert == otherTyped.masterShift_insert;
    
  }
  @override
  int get hashCode => masterShift_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterShift_insert'] = masterShift_insert.toJson();
    return json;
  }

  InsertMasterShiftData({
    required this.masterShift_insert,
  });
}

@immutable
class InsertMasterShiftVariables {
  final String name;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMasterShiftVariables.fromJson(Map<String, dynamic> json):
  
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

    final InsertMasterShiftVariables otherTyped = other as InsertMasterShiftVariables;
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

  InsertMasterShiftVariables({
    required this.name,
    required this.sortOrder,
    required this.isActive,
  });
}

