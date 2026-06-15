part of 'default.dart';

class UpdateMasterShiftVariablesBuilder {
  UpdateMasterShiftVariablesId id;
  String name;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  UpdateMasterShiftVariablesBuilder(this._dataConnect, {required  this.id,required  this.name,required  this.sortOrder,required  this.isActive,});
  Deserializer<UpdateMasterShiftData> dataDeserializer = (dynamic json)  => UpdateMasterShiftData.fromJson(jsonDecode(json));
  Serializer<UpdateMasterShiftVariables> varsSerializer = (UpdateMasterShiftVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMasterShiftData, UpdateMasterShiftVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateMasterShiftData, UpdateMasterShiftVariables> ref() {
    UpdateMasterShiftVariables vars= UpdateMasterShiftVariables(id: id,name: name,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("UpdateMasterShift", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateMasterShiftMasterShiftUpdate {
  final String id;
  UpdateMasterShiftMasterShiftUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterShiftMasterShiftUpdate otherTyped = other as UpdateMasterShiftMasterShiftUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterShiftMasterShiftUpdate({
    required this.id,
  });
}

@immutable
class UpdateMasterShiftData {
  final UpdateMasterShiftMasterShiftUpdate? masterShift_update;
  UpdateMasterShiftData.fromJson(dynamic json):
  
  masterShift_update = json['masterShift_update'] == null ? null : UpdateMasterShiftMasterShiftUpdate.fromJson(json['masterShift_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterShiftData otherTyped = other as UpdateMasterShiftData;
    return masterShift_update == otherTyped.masterShift_update;
    
  }
  @override
  int get hashCode => masterShift_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterShift_update != null) {
      json['masterShift_update'] = masterShift_update!.toJson();
    }
    return json;
  }

  UpdateMasterShiftData({
    this.masterShift_update,
  });
}

@immutable
class UpdateMasterShiftVariablesId {
  final String id;
  UpdateMasterShiftVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterShiftVariablesId otherTyped = other as UpdateMasterShiftVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterShiftVariablesId({
    required this.id,
  });
}

@immutable
class UpdateMasterShiftVariables {
  final UpdateMasterShiftVariablesId id;
  final String name;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateMasterShiftVariables.fromJson(Map<String, dynamic> json):
  
  id = UpdateMasterShiftVariablesId.fromJson(json['id']),
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

    final UpdateMasterShiftVariables otherTyped = other as UpdateMasterShiftVariables;
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

  UpdateMasterShiftVariables({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.isActive,
  });
}

