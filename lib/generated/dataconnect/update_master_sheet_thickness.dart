part of 'default.dart';

class UpdateMasterSheetThicknessVariablesBuilder {
  UpdateMasterSheetThicknessVariablesId id;
  String value;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  UpdateMasterSheetThicknessVariablesBuilder(this._dataConnect, {required  this.id,required  this.value,required  this.sortOrder,required  this.isActive,});
  Deserializer<UpdateMasterSheetThicknessData> dataDeserializer = (dynamic json)  => UpdateMasterSheetThicknessData.fromJson(jsonDecode(json));
  Serializer<UpdateMasterSheetThicknessVariables> varsSerializer = (UpdateMasterSheetThicknessVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMasterSheetThicknessData, UpdateMasterSheetThicknessVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateMasterSheetThicknessData, UpdateMasterSheetThicknessVariables> ref() {
    UpdateMasterSheetThicknessVariables vars= UpdateMasterSheetThicknessVariables(id: id,value: value,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("UpdateMasterSheetThickness", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateMasterSheetThicknessMasterSheetThicknessUpdate {
  final String id;
  UpdateMasterSheetThicknessMasterSheetThicknessUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSheetThicknessMasterSheetThicknessUpdate otherTyped = other as UpdateMasterSheetThicknessMasterSheetThicknessUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterSheetThicknessMasterSheetThicknessUpdate({
    required this.id,
  });
}

@immutable
class UpdateMasterSheetThicknessData {
  final UpdateMasterSheetThicknessMasterSheetThicknessUpdate? masterSheetThickness_update;
  UpdateMasterSheetThicknessData.fromJson(dynamic json):
  
  masterSheetThickness_update = json['masterSheetThickness_update'] == null ? null : UpdateMasterSheetThicknessMasterSheetThicknessUpdate.fromJson(json['masterSheetThickness_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSheetThicknessData otherTyped = other as UpdateMasterSheetThicknessData;
    return masterSheetThickness_update == otherTyped.masterSheetThickness_update;
    
  }
  @override
  int get hashCode => masterSheetThickness_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterSheetThickness_update != null) {
      json['masterSheetThickness_update'] = masterSheetThickness_update!.toJson();
    }
    return json;
  }

  UpdateMasterSheetThicknessData({
    this.masterSheetThickness_update,
  });
}

@immutable
class UpdateMasterSheetThicknessVariablesId {
  final String id;
  UpdateMasterSheetThicknessVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSheetThicknessVariablesId otherTyped = other as UpdateMasterSheetThicknessVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterSheetThicknessVariablesId({
    required this.id,
  });
}

@immutable
class UpdateMasterSheetThicknessVariables {
  final UpdateMasterSheetThicknessVariablesId id;
  final String value;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateMasterSheetThicknessVariables.fromJson(Map<String, dynamic> json):
  
  id = UpdateMasterSheetThicknessVariablesId.fromJson(json['id']),
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

    final UpdateMasterSheetThicknessVariables otherTyped = other as UpdateMasterSheetThicknessVariables;
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

  UpdateMasterSheetThicknessVariables({
    required this.id,
    required this.value,
    required this.sortOrder,
    required this.isActive,
  });
}

