part of 'default.dart';

class UpdateMasterFrameColorVariablesBuilder {
  UpdateMasterFrameColorVariablesId id;
  String name;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  UpdateMasterFrameColorVariablesBuilder(this._dataConnect, {required  this.id,required  this.name,required  this.sortOrder,required  this.isActive,});
  Deserializer<UpdateMasterFrameColorData> dataDeserializer = (dynamic json)  => UpdateMasterFrameColorData.fromJson(jsonDecode(json));
  Serializer<UpdateMasterFrameColorVariables> varsSerializer = (UpdateMasterFrameColorVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMasterFrameColorData, UpdateMasterFrameColorVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateMasterFrameColorData, UpdateMasterFrameColorVariables> ref() {
    UpdateMasterFrameColorVariables vars= UpdateMasterFrameColorVariables(id: id,name: name,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("UpdateMasterFrameColor", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateMasterFrameColorMasterFrameColorUpdate {
  final String id;
  UpdateMasterFrameColorMasterFrameColorUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterFrameColorMasterFrameColorUpdate otherTyped = other as UpdateMasterFrameColorMasterFrameColorUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterFrameColorMasterFrameColorUpdate({
    required this.id,
  });
}

@immutable
class UpdateMasterFrameColorData {
  final UpdateMasterFrameColorMasterFrameColorUpdate? masterFrameColor_update;
  UpdateMasterFrameColorData.fromJson(dynamic json):
  
  masterFrameColor_update = json['masterFrameColor_update'] == null ? null : UpdateMasterFrameColorMasterFrameColorUpdate.fromJson(json['masterFrameColor_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterFrameColorData otherTyped = other as UpdateMasterFrameColorData;
    return masterFrameColor_update == otherTyped.masterFrameColor_update;
    
  }
  @override
  int get hashCode => masterFrameColor_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterFrameColor_update != null) {
      json['masterFrameColor_update'] = masterFrameColor_update!.toJson();
    }
    return json;
  }

  UpdateMasterFrameColorData({
    this.masterFrameColor_update,
  });
}

@immutable
class UpdateMasterFrameColorVariablesId {
  final String id;
  UpdateMasterFrameColorVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterFrameColorVariablesId otherTyped = other as UpdateMasterFrameColorVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterFrameColorVariablesId({
    required this.id,
  });
}

@immutable
class UpdateMasterFrameColorVariables {
  final UpdateMasterFrameColorVariablesId id;
  final String name;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateMasterFrameColorVariables.fromJson(Map<String, dynamic> json):
  
  id = UpdateMasterFrameColorVariablesId.fromJson(json['id']),
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

    final UpdateMasterFrameColorVariables otherTyped = other as UpdateMasterFrameColorVariables;
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

  UpdateMasterFrameColorVariables({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.isActive,
  });
}

