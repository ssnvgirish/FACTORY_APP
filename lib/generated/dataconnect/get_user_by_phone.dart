part of 'default.dart';

class GetUserByPhoneVariablesBuilder {
  String phone;

  final FirebaseDataConnect _dataConnect;
  GetUserByPhoneVariablesBuilder(this._dataConnect, {required  this.phone,});
  Deserializer<GetUserByPhoneData> dataDeserializer = (dynamic json)  => GetUserByPhoneData.fromJson(jsonDecode(json));
  Serializer<GetUserByPhoneVariables> varsSerializer = (GetUserByPhoneVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetUserByPhoneData, GetUserByPhoneVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetUserByPhoneData, GetUserByPhoneVariables> ref() {
    GetUserByPhoneVariables vars= GetUserByPhoneVariables(phone: phone,);
    return _dataConnect.query("GetUserByPhone", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetUserByPhoneUsers {
  final String id;
  final String uid;
  final String name;
  final String phone;
  final String password;
  final String email;
  final List<String> roles;
  final List<String> assignedMachines;
  final double fixedSalary;
  final bool isActive;
  GetUserByPhoneUsers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
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

    final GetUserByPhoneUsers otherTyped = other as GetUserByPhoneUsers;
    return id == otherTyped.id && 
    uid == otherTyped.uid && 
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
  int get hashCode => Object.hashAll([id.hashCode, uid.hashCode, name.hashCode, phone.hashCode, password.hashCode, email.hashCode, roles.hashCode, assignedMachines.hashCode, fixedSalary.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
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

  GetUserByPhoneUsers({
    required this.id,
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

@immutable
class GetUserByPhoneData {
  final List<GetUserByPhoneUsers> users;
  GetUserByPhoneData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => GetUserByPhoneUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByPhoneData otherTyped = other as GetUserByPhoneData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  GetUserByPhoneData({
    required this.users,
  });
}

@immutable
class GetUserByPhoneVariables {
  final String phone;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetUserByPhoneVariables.fromJson(Map<String, dynamic> json):
  
  phone = nativeFromJson<String>(json['phone']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByPhoneVariables otherTyped = other as GetUserByPhoneVariables;
    return phone == otherTyped.phone;
    
  }
  @override
  int get hashCode => phone.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['phone'] = nativeToJson<String>(phone);
    return json;
  }

  GetUserByPhoneVariables({
    required this.phone,
  });
}

