part of 'default.dart';

class UpdateMasterMachineVariablesBuilder {
  UpdateMasterMachineVariablesId id;
  String name;
  String type;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  UpdateMasterMachineVariablesBuilder(this._dataConnect, {required  this.id,required  this.name,required  this.type,required  this.sortOrder,required  this.isActive,});
  Deserializer<UpdateMasterMachineData> dataDeserializer = (dynamic json)  => UpdateMasterMachineData.fromJson(jsonDecode(json));
  Serializer<UpdateMasterMachineVariables> varsSerializer = (UpdateMasterMachineVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMasterMachineData, UpdateMasterMachineVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateMasterMachineData, UpdateMasterMachineVariables> ref() {
    UpdateMasterMachineVariables vars= UpdateMasterMachineVariables(id: id,name: name,type: type,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("UpdateMasterMachine", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateMasterMachineMasterMachineUpdate {
  final String id;
  UpdateMasterMachineMasterMachineUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterMachineMasterMachineUpdate otherTyped = other as UpdateMasterMachineMasterMachineUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterMachineMasterMachineUpdate({
    required this.id,
  });
}

@immutable
class UpdateMasterMachineData {
  final UpdateMasterMachineMasterMachineUpdate? masterMachine_update;
  UpdateMasterMachineData.fromJson(dynamic json):
  
  masterMachine_update = json['masterMachine_update'] == null ? null : UpdateMasterMachineMasterMachineUpdate.fromJson(json['masterMachine_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterMachineData otherTyped = other as UpdateMasterMachineData;
    return masterMachine_update == otherTyped.masterMachine_update;
    
  }
  @override
  int get hashCode => masterMachine_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterMachine_update != null) {
      json['masterMachine_update'] = masterMachine_update!.toJson();
    }
    return json;
  }

  UpdateMasterMachineData({
    this.masterMachine_update,
  });
}

@immutable
class UpdateMasterMachineVariablesId {
  final String id;
  UpdateMasterMachineVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterMachineVariablesId otherTyped = other as UpdateMasterMachineVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterMachineVariablesId({
    required this.id,
  });
}

@immutable
class UpdateMasterMachineVariables {
  final UpdateMasterMachineVariablesId id;
  final String name;
  final String type;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateMasterMachineVariables.fromJson(Map<String, dynamic> json):
  
  id = UpdateMasterMachineVariablesId.fromJson(json['id']),
  name = nativeFromJson<String>(json['name']),
  type = nativeFromJson<String>(json['type']),
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

    final UpdateMasterMachineVariables otherTyped = other as UpdateMasterMachineVariables;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    type == otherTyped.type && 
    sortOrder == otherTyped.sortOrder && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, type.hashCode, sortOrder.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    json['name'] = nativeToJson<String>(name);
    json['type'] = nativeToJson<String>(type);
    json['sortOrder'] = nativeToJson<int>(sortOrder);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  UpdateMasterMachineVariables({
    required this.id,
    required this.name,
    required this.type,
    required this.sortOrder,
    required this.isActive,
  });
}

