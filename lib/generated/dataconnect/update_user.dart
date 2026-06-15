part of 'default.dart';

class UpdateUserVariablesBuilder {
  UpdateUserVariablesId id;
  String name;
  String phone;
  List<String> roles;
  List<String> assignedMachines;
  double fixedSalary;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  UpdateUserVariablesBuilder(this._dataConnect, {required  this.id,required  this.name,required  this.phone,required  this.roles,required  this.assignedMachines,required  this.fixedSalary,required  this.isActive,});
  Deserializer<UpdateUserData> dataDeserializer = (dynamic json)  => UpdateUserData.fromJson(jsonDecode(json));
  Serializer<UpdateUserVariables> varsSerializer = (UpdateUserVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateUserData, UpdateUserVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateUserData, UpdateUserVariables> ref() {
    UpdateUserVariables vars= UpdateUserVariables(id: id,name: name,phone: phone,roles: roles,assignedMachines: assignedMachines,fixedSalary: fixedSalary,isActive: isActive,);
    return _dataConnect.mutation("UpdateUser", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateUserUserUpdate {
  final String id;
  UpdateUserUserUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserUserUpdate otherTyped = other as UpdateUserUserUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateUserUserUpdate({
    required this.id,
  });
}

@immutable
class UpdateUserData {
  final UpdateUserUserUpdate? user_update;
  UpdateUserData.fromJson(dynamic json):
  
  user_update = json['user_update'] == null ? null : UpdateUserUserUpdate.fromJson(json['user_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserData otherTyped = other as UpdateUserData;
    return user_update == otherTyped.user_update;
    
  }
  @override
  int get hashCode => user_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user_update != null) {
      json['user_update'] = user_update!.toJson();
    }
    return json;
  }

  UpdateUserData({
    this.user_update,
  });
}

@immutable
class UpdateUserVariablesId {
  final String id;
  UpdateUserVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserVariablesId otherTyped = other as UpdateUserVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateUserVariablesId({
    required this.id,
  });
}

@immutable
class UpdateUserVariables {
  final UpdateUserVariablesId id;
  final String name;
  final String phone;
  final List<String> roles;
  final List<String> assignedMachines;
  final double fixedSalary;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateUserVariables.fromJson(Map<String, dynamic> json):
  
  id = UpdateUserVariablesId.fromJson(json['id']),
  name = nativeFromJson<String>(json['name']),
  phone = nativeFromJson<String>(json['phone']),
  roles = (json['roles'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),
  assignedMachines = (json['assignedMachines'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),
  fixedSalary = nativeFromJson<double>(json['fixedSalary']),
  isActive = nativeFromJson<bool>(json['isActive']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserVariables otherTyped = other as UpdateUserVariables;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    phone == otherTyped.phone && 
    roles == otherTyped.roles && 
    assignedMachines == otherTyped.assignedMachines && 
    fixedSalary == otherTyped.fixedSalary && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, phone.hashCode, roles.hashCode, assignedMachines.hashCode, fixedSalary.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    json['name'] = nativeToJson<String>(name);
    json['phone'] = nativeToJson<String>(phone);
    json['roles'] = roles.map((e) => nativeToJson<String>(e)).toList();
    json['assignedMachines'] = assignedMachines.map((e) => nativeToJson<String>(e)).toList();
    json['fixedSalary'] = nativeToJson<double>(fixedSalary);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  UpdateUserVariables({
    required this.id,
    required this.name,
    required this.phone,
    required this.roles,
    required this.assignedMachines,
    required this.fixedSalary,
    required this.isActive,
  });
}

