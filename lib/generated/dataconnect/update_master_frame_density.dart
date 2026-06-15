part of 'default.dart';

class UpdateMasterFrameDensityVariablesBuilder {
  UpdateMasterFrameDensityVariablesId id;
  String value;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  UpdateMasterFrameDensityVariablesBuilder(this._dataConnect, {required  this.id,required  this.value,required  this.sortOrder,required  this.isActive,});
  Deserializer<UpdateMasterFrameDensityData> dataDeserializer = (dynamic json)  => UpdateMasterFrameDensityData.fromJson(jsonDecode(json));
  Serializer<UpdateMasterFrameDensityVariables> varsSerializer = (UpdateMasterFrameDensityVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMasterFrameDensityData, UpdateMasterFrameDensityVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateMasterFrameDensityData, UpdateMasterFrameDensityVariables> ref() {
    UpdateMasterFrameDensityVariables vars= UpdateMasterFrameDensityVariables(id: id,value: value,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("UpdateMasterFrameDensity", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateMasterFrameDensityMasterFrameDensityUpdate {
  final String id;
  UpdateMasterFrameDensityMasterFrameDensityUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterFrameDensityMasterFrameDensityUpdate otherTyped = other as UpdateMasterFrameDensityMasterFrameDensityUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterFrameDensityMasterFrameDensityUpdate({
    required this.id,
  });
}

@immutable
class UpdateMasterFrameDensityData {
  final UpdateMasterFrameDensityMasterFrameDensityUpdate? masterFrameDensity_update;
  UpdateMasterFrameDensityData.fromJson(dynamic json):
  
  masterFrameDensity_update = json['masterFrameDensity_update'] == null ? null : UpdateMasterFrameDensityMasterFrameDensityUpdate.fromJson(json['masterFrameDensity_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterFrameDensityData otherTyped = other as UpdateMasterFrameDensityData;
    return masterFrameDensity_update == otherTyped.masterFrameDensity_update;
    
  }
  @override
  int get hashCode => masterFrameDensity_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterFrameDensity_update != null) {
      json['masterFrameDensity_update'] = masterFrameDensity_update!.toJson();
    }
    return json;
  }

  UpdateMasterFrameDensityData({
    this.masterFrameDensity_update,
  });
}

@immutable
class UpdateMasterFrameDensityVariablesId {
  final String id;
  UpdateMasterFrameDensityVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterFrameDensityVariablesId otherTyped = other as UpdateMasterFrameDensityVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterFrameDensityVariablesId({
    required this.id,
  });
}

@immutable
class UpdateMasterFrameDensityVariables {
  final UpdateMasterFrameDensityVariablesId id;
  final String value;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateMasterFrameDensityVariables.fromJson(Map<String, dynamic> json):
  
  id = UpdateMasterFrameDensityVariablesId.fromJson(json['id']),
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

    final UpdateMasterFrameDensityVariables otherTyped = other as UpdateMasterFrameDensityVariables;
    return id == otherTyped.id && 
    value == otherTyped.value && 
    sortOrder == otherTyped.sortOrder && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, value.hashCode, sortOrder.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    json['value'] = nativeToJson<String>(value);
    json['sortOrder'] = nativeToJson<int>(sortOrder);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  UpdateMasterFrameDensityVariables({
    required this.id,
    required this.value,
    required this.sortOrder,
    required this.isActive,
  });
}

