part of 'default.dart';

class UpdateMasterFrameSectionVariablesBuilder {
  UpdateMasterFrameSectionVariablesId id;
  String name;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  UpdateMasterFrameSectionVariablesBuilder(this._dataConnect, {required  this.id,required  this.name,required  this.sortOrder,required  this.isActive,});
  Deserializer<UpdateMasterFrameSectionData> dataDeserializer = (dynamic json)  => UpdateMasterFrameSectionData.fromJson(jsonDecode(json));
  Serializer<UpdateMasterFrameSectionVariables> varsSerializer = (UpdateMasterFrameSectionVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMasterFrameSectionData, UpdateMasterFrameSectionVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateMasterFrameSectionData, UpdateMasterFrameSectionVariables> ref() {
    UpdateMasterFrameSectionVariables vars= UpdateMasterFrameSectionVariables(id: id,name: name,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("UpdateMasterFrameSection", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateMasterFrameSectionMasterFrameSectionUpdate {
  final String id;
  UpdateMasterFrameSectionMasterFrameSectionUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterFrameSectionMasterFrameSectionUpdate otherTyped = other as UpdateMasterFrameSectionMasterFrameSectionUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterFrameSectionMasterFrameSectionUpdate({
    required this.id,
  });
}

@immutable
class UpdateMasterFrameSectionData {
  final UpdateMasterFrameSectionMasterFrameSectionUpdate? masterFrameSection_update;
  UpdateMasterFrameSectionData.fromJson(dynamic json):
  
  masterFrameSection_update = json['masterFrameSection_update'] == null ? null : UpdateMasterFrameSectionMasterFrameSectionUpdate.fromJson(json['masterFrameSection_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterFrameSectionData otherTyped = other as UpdateMasterFrameSectionData;
    return masterFrameSection_update == otherTyped.masterFrameSection_update;
    
  }
  @override
  int get hashCode => masterFrameSection_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterFrameSection_update != null) {
      json['masterFrameSection_update'] = masterFrameSection_update!.toJson();
    }
    return json;
  }

  UpdateMasterFrameSectionData({
    this.masterFrameSection_update,
  });
}

@immutable
class UpdateMasterFrameSectionVariablesId {
  final String id;
  UpdateMasterFrameSectionVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterFrameSectionVariablesId otherTyped = other as UpdateMasterFrameSectionVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterFrameSectionVariablesId({
    required this.id,
  });
}

@immutable
class UpdateMasterFrameSectionVariables {
  final UpdateMasterFrameSectionVariablesId id;
  final String name;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateMasterFrameSectionVariables.fromJson(Map<String, dynamic> json):
  
  id = UpdateMasterFrameSectionVariablesId.fromJson(json['id']),
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

    final UpdateMasterFrameSectionVariables otherTyped = other as UpdateMasterFrameSectionVariables;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    sortOrder == otherTyped.sortOrder && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, sortOrder.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    json['name'] = nativeToJson<String>(name);
    json['sortOrder'] = nativeToJson<int>(sortOrder);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  UpdateMasterFrameSectionVariables({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.isActive,
  });
}

