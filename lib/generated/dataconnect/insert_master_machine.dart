part of 'default.dart';

class InsertMasterMachineVariablesBuilder {
  String name;
  String type;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  InsertMasterMachineVariablesBuilder(this._dataConnect, {required  this.name,required  this.type,required  this.sortOrder,required  this.isActive,});
  Deserializer<InsertMasterMachineData> dataDeserializer = (dynamic json)  => InsertMasterMachineData.fromJson(jsonDecode(json));
  Serializer<InsertMasterMachineVariables> varsSerializer = (InsertMasterMachineVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMasterMachineData, InsertMasterMachineVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMasterMachineData, InsertMasterMachineVariables> ref() {
    InsertMasterMachineVariables vars= InsertMasterMachineVariables(name: name,type: type,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("InsertMasterMachine", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMasterMachineMasterMachineInsert {
  final String id;
  InsertMasterMachineMasterMachineInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterMachineMasterMachineInsert otherTyped = other as InsertMasterMachineMasterMachineInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMasterMachineMasterMachineInsert({
    required this.id,
  });
}

@immutable
class InsertMasterMachineData {
  final InsertMasterMachineMasterMachineInsert masterMachine_insert;
  InsertMasterMachineData.fromJson(dynamic json):
  
  masterMachine_insert = InsertMasterMachineMasterMachineInsert.fromJson(json['masterMachine_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterMachineData otherTyped = other as InsertMasterMachineData;
    return masterMachine_insert == otherTyped.masterMachine_insert;
    
  }
  @override
  int get hashCode => masterMachine_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMachine_insert'] = masterMachine_insert.toJson();
    return json;
  }

  InsertMasterMachineData({
    required this.masterMachine_insert,
  });
}

@immutable
class InsertMasterMachineVariables {
  final String name;
  final String type;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMasterMachineVariables.fromJson(Map<String, dynamic> json):
  
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

    final InsertMasterMachineVariables otherTyped = other as InsertMasterMachineVariables;
    return name == otherTyped.name && 
    type == otherTyped.type && 
    sortOrder == otherTyped.sortOrder && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, type.hashCode, sortOrder.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['type'] = nativeToJson<String>(type);
    json['sortOrder'] = nativeToJson<int>(sortOrder);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  InsertMasterMachineVariables({
    required this.name,
    required this.type,
    required this.sortOrder,
    required this.isActive,
  });
}

