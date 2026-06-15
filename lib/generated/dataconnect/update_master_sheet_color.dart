part of 'default.dart';

class UpdateMasterSheetColorVariablesBuilder {
  UpdateMasterSheetColorVariablesId id;
  String name;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  UpdateMasterSheetColorVariablesBuilder(this._dataConnect, {required  this.id,required  this.name,required  this.sortOrder,required  this.isActive,});
  Deserializer<UpdateMasterSheetColorData> dataDeserializer = (dynamic json)  => UpdateMasterSheetColorData.fromJson(jsonDecode(json));
  Serializer<UpdateMasterSheetColorVariables> varsSerializer = (UpdateMasterSheetColorVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMasterSheetColorData, UpdateMasterSheetColorVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateMasterSheetColorData, UpdateMasterSheetColorVariables> ref() {
    UpdateMasterSheetColorVariables vars= UpdateMasterSheetColorVariables(id: id,name: name,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("UpdateMasterSheetColor", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateMasterSheetColorMasterSheetColorUpdate {
  final String id;
  UpdateMasterSheetColorMasterSheetColorUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSheetColorMasterSheetColorUpdate otherTyped = other as UpdateMasterSheetColorMasterSheetColorUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterSheetColorMasterSheetColorUpdate({
    required this.id,
  });
}

@immutable
class UpdateMasterSheetColorData {
  final UpdateMasterSheetColorMasterSheetColorUpdate? masterSheetColor_update;
  UpdateMasterSheetColorData.fromJson(dynamic json):
  
  masterSheetColor_update = json['masterSheetColor_update'] == null ? null : UpdateMasterSheetColorMasterSheetColorUpdate.fromJson(json['masterSheetColor_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSheetColorData otherTyped = other as UpdateMasterSheetColorData;
    return masterSheetColor_update == otherTyped.masterSheetColor_update;
    
  }
  @override
  int get hashCode => masterSheetColor_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterSheetColor_update != null) {
      json['masterSheetColor_update'] = masterSheetColor_update!.toJson();
    }
    return json;
  }

  UpdateMasterSheetColorData({
    this.masterSheetColor_update,
  });
}

@immutable
class UpdateMasterSheetColorVariablesId {
  final String id;
  UpdateMasterSheetColorVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSheetColorVariablesId otherTyped = other as UpdateMasterSheetColorVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterSheetColorVariablesId({
    required this.id,
  });
}

@immutable
class UpdateMasterSheetColorVariables {
  final UpdateMasterSheetColorVariablesId id;
  final String name;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateMasterSheetColorVariables.fromJson(Map<String, dynamic> json):
  
  id = UpdateMasterSheetColorVariablesId.fromJson(json['id']),
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

    final UpdateMasterSheetColorVariables otherTyped = other as UpdateMasterSheetColorVariables;
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

  UpdateMasterSheetColorVariables({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.isActive,
  });
}

