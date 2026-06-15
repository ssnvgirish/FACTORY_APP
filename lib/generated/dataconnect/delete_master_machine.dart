part of 'default.dart';

class DeleteMasterMachineVariablesBuilder {
  DeleteMasterMachineVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteMasterMachineVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMasterMachineData> dataDeserializer = (dynamic json)  => DeleteMasterMachineData.fromJson(jsonDecode(json));
  Serializer<DeleteMasterMachineVariables> varsSerializer = (DeleteMasterMachineVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMasterMachineData, DeleteMasterMachineVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMasterMachineData, DeleteMasterMachineVariables> ref() {
    DeleteMasterMachineVariables vars= DeleteMasterMachineVariables(id: id,);
    return _dataConnect.mutation("DeleteMasterMachine", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMasterMachineMasterMachineDelete {
  final String id;
  DeleteMasterMachineMasterMachineDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterMachineMasterMachineDelete otherTyped = other as DeleteMasterMachineMasterMachineDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterMachineMasterMachineDelete({
    required this.id,
  });
}

@immutable
class DeleteMasterMachineData {
  final DeleteMasterMachineMasterMachineDelete? masterMachine_delete;
  DeleteMasterMachineData.fromJson(dynamic json):
  
  masterMachine_delete = json['masterMachine_delete'] == null ? null : DeleteMasterMachineMasterMachineDelete.fromJson(json['masterMachine_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterMachineData otherTyped = other as DeleteMasterMachineData;
    return masterMachine_delete == otherTyped.masterMachine_delete;
    
  }
  @override
  int get hashCode => masterMachine_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterMachine_delete != null) {
      json['masterMachine_delete'] = masterMachine_delete!.toJson();
    }
    return json;
  }

  DeleteMasterMachineData({
    this.masterMachine_delete,
  });
}

@immutable
class DeleteMasterMachineVariablesId {
  final String id;
  DeleteMasterMachineVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterMachineVariablesId otherTyped = other as DeleteMasterMachineVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterMachineVariablesId({
    required this.id,
  });
}

@immutable
class DeleteMasterMachineVariables {
  final DeleteMasterMachineVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMasterMachineVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteMasterMachineVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterMachineVariables otherTyped = other as DeleteMasterMachineVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteMasterMachineVariables({
    required this.id,
  });
}

