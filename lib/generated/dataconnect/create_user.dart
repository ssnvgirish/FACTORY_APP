part of 'default.dart';

class CreateUserVariablesBuilder {
  String uid;
  String name;
  String phone;
  String password;
  String email;
  List<String> roles;
  List<String> assignedMachines;
  double fixedSalary;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  CreateUserVariablesBuilder(this._dataConnect, {required  this.uid,required  this.name,required  this.phone,required  this.password,required  this.email,required  this.roles,required  this.assignedMachines,required  this.fixedSalary,required  this.isActive,});
  Deserializer<CreateUserData> dataDeserializer = (dynamic json)  => CreateUserData.fromJson(jsonDecode(json));
  Serializer<CreateUserVariables> varsSerializer = (CreateUserVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateUserData, CreateUserVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateUserData, CreateUserVariables> ref() {
    CreateUserVariables vars= CreateUserVariables(uid: uid,name: name,phone: phone,password: password,email: email,roles: roles,assignedMachines: assignedMachines,fixedSalary: fixedSalary,isActive: isActive,);
    return _dataConnect.mutation("CreateUser", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateUserUserInsert {
  final String id;
  CreateUserUserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateUserUserInsert otherTyped = other as CreateUserUserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateUserUserInsert({
    required this.id,
  });
}

@immutable
class CreateUserData {
  final CreateUserUserInsert user_insert;
  CreateUserData.fromJson(dynamic json):
  
  user_insert = CreateUserUserInsert.fromJson(json['user_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateUserData otherTyped = other as CreateUserData;
    return user_insert == otherTyped.user_insert;
    
  }
  @override
  int get hashCode => user_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    return json;
  }

  CreateUserData({
    required this.user_insert,
  });
}

@immutable
class CreateUserVariables {
  final String uid;
  final String name;
  final String phone;
  final String password;
  final String email;
  final List<String> roles;
  final List<String> assignedMachines;
  final double fixedSalary;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateUserVariables.fromJson(Map<String, dynamic> json):
  
  uid = nativeFromJson<String>(json['uid']),
  name = nativeFromJson<String>(json['name']),
  phone = nativeFromJson<String>(json['phone']),
  password = nativeFromJson<String>(json['password']),
  email = nativeFromJson<String>(json['email']),
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

    final CreateUserVariables otherTyped = other as CreateUserVariables;
    return uid == otherTyped.uid && 
    name == otherTyped.name && 
    phone == otherTyped.phone && 
    password == otherTyped.password && 
    email == otherTyped.email && 
    roles == otherTyped.roles && 
    assignedMachines == otherTyped.assignedMachines && 
    fixedSalary == otherTyped.fixedSalary && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([uid.hashCode, name.hashCode, phone.hashCode, password.hashCode, email.hashCode, roles.hashCode, assignedMachines.hashCode, fixedSalary.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['uid'] = nativeToJson<String>(uid);
    json['name'] = nativeToJson<String>(name);
    json['phone'] = nativeToJson<String>(phone);
    json['password'] = nativeToJson<String>(password);
    json['email'] = nativeToJson<String>(email);
    json['roles'] = roles.map((e) => nativeToJson<String>(e)).toList();
    json['assignedMachines'] = assignedMachines.map((e) => nativeToJson<String>(e)).toList();
    json['fixedSalary'] = nativeToJson<double>(fixedSalary);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  CreateUserVariables({
    required this.uid,
    required this.name,
    required this.phone,
    required this.password,
    required this.email,
    required this.roles,
    required this.assignedMachines,
    required this.fixedSalary,
    required this.isActive,
  });
}

