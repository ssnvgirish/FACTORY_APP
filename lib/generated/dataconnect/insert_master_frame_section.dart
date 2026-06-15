part of 'default.dart';

class InsertMasterFrameSectionVariablesBuilder {
  String name;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  InsertMasterFrameSectionVariablesBuilder(this._dataConnect, {required  this.name,required  this.sortOrder,required  this.isActive,});
  Deserializer<InsertMasterFrameSectionData> dataDeserializer = (dynamic json)  => InsertMasterFrameSectionData.fromJson(jsonDecode(json));
  Serializer<InsertMasterFrameSectionVariables> varsSerializer = (InsertMasterFrameSectionVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMasterFrameSectionData, InsertMasterFrameSectionVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMasterFrameSectionData, InsertMasterFrameSectionVariables> ref() {
    InsertMasterFrameSectionVariables vars= InsertMasterFrameSectionVariables(name: name,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("InsertMasterFrameSection", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMasterFrameSectionMasterFrameSectionInsert {
  final String id;
  InsertMasterFrameSectionMasterFrameSectionInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterFrameSectionMasterFrameSectionInsert otherTyped = other as InsertMasterFrameSectionMasterFrameSectionInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMasterFrameSectionMasterFrameSectionInsert({
    required this.id,
  });
}

@immutable
class InsertMasterFrameSectionData {
  final InsertMasterFrameSectionMasterFrameSectionInsert masterFrameSection_insert;
  InsertMasterFrameSectionData.fromJson(dynamic json):
  
  masterFrameSection_insert = InsertMasterFrameSectionMasterFrameSectionInsert.fromJson(json['masterFrameSection_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterFrameSectionData otherTyped = other as InsertMasterFrameSectionData;
    return masterFrameSection_insert == otherTyped.masterFrameSection_insert;
    
  }
  @override
  int get hashCode => masterFrameSection_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameSection_insert'] = masterFrameSection_insert.toJson();
    return json;
  }

  InsertMasterFrameSectionData({
    required this.masterFrameSection_insert,
  });
}

@immutable
class InsertMasterFrameSectionVariables {
  final String name;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMasterFrameSectionVariables.fromJson(Map<String, dynamic> json):
  
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

    final InsertMasterFrameSectionVariables otherTyped = other as InsertMasterFrameSectionVariables;
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

  InsertMasterFrameSectionVariables({
    required this.name,
    required this.sortOrder,
    required this.isActive,
  });
}

