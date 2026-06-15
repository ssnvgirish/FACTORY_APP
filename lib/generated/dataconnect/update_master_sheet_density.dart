part of 'default.dart';

class UpdateMasterSheetDensityVariablesBuilder {
  UpdateMasterSheetDensityVariablesId id;
  String value;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  UpdateMasterSheetDensityVariablesBuilder(this._dataConnect, {required  this.id,required  this.value,required  this.sortOrder,required  this.isActive,});
  Deserializer<UpdateMasterSheetDensityData> dataDeserializer = (dynamic json)  => UpdateMasterSheetDensityData.fromJson(jsonDecode(json));
  Serializer<UpdateMasterSheetDensityVariables> varsSerializer = (UpdateMasterSheetDensityVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMasterSheetDensityData, UpdateMasterSheetDensityVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateMasterSheetDensityData, UpdateMasterSheetDensityVariables> ref() {
    UpdateMasterSheetDensityVariables vars= UpdateMasterSheetDensityVariables(id: id,value: value,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("UpdateMasterSheetDensity", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateMasterSheetDensityMasterSheetDensityUpdate {
  final String id;
  UpdateMasterSheetDensityMasterSheetDensityUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSheetDensityMasterSheetDensityUpdate otherTyped = other as UpdateMasterSheetDensityMasterSheetDensityUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterSheetDensityMasterSheetDensityUpdate({
    required this.id,
  });
}

@immutable
class UpdateMasterSheetDensityData {
  final UpdateMasterSheetDensityMasterSheetDensityUpdate? masterSheetDensity_update;
  UpdateMasterSheetDensityData.fromJson(dynamic json):
  
  masterSheetDensity_update = json['masterSheetDensity_update'] == null ? null : UpdateMasterSheetDensityMasterSheetDensityUpdate.fromJson(json['masterSheetDensity_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSheetDensityData otherTyped = other as UpdateMasterSheetDensityData;
    return masterSheetDensity_update == otherTyped.masterSheetDensity_update;
    
  }
  @override
  int get hashCode => masterSheetDensity_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterSheetDensity_update != null) {
      json['masterSheetDensity_update'] = masterSheetDensity_update!.toJson();
    }
    return json;
  }

  UpdateMasterSheetDensityData({
    this.masterSheetDensity_update,
  });
}

@immutable
class UpdateMasterSheetDensityVariablesId {
  final String id;
  UpdateMasterSheetDensityVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSheetDensityVariablesId otherTyped = other as UpdateMasterSheetDensityVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterSheetDensityVariablesId({
    required this.id,
  });
}

@immutable
class UpdateMasterSheetDensityVariables {
  final UpdateMasterSheetDensityVariablesId id;
  final String value;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateMasterSheetDensityVariables.fromJson(Map<String, dynamic> json):
  
  id = UpdateMasterSheetDensityVariablesId.fromJson(json['id']),
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

    final UpdateMasterSheetDensityVariables otherTyped = other as UpdateMasterSheetDensityVariables;
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

  UpdateMasterSheetDensityVariables({
    required this.id,
    required this.value,
    required this.sortOrder,
    required this.isActive,
  });
}

