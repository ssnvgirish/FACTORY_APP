part of 'default.dart';

class GetUserByIdVariablesBuilder {
  GetUserByIdVariablesId id;

  final FirebaseDataConnect _dataConnect;
  GetUserByIdVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetUserByIdData> dataDeserializer = (dynamic json)  => GetUserByIdData.fromJson(jsonDecode(json));
  Serializer<GetUserByIdVariables> varsSerializer = (GetUserByIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetUserByIdData, GetUserByIdVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetUserByIdData, GetUserByIdVariables> ref() {
    GetUserByIdVariables vars= GetUserByIdVariables(id: id,);
    return _dataConnect.query("GetUserById", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetUserByIdUser {
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
  GetUserByIdUser.fromJson(dynamic json):
  
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

    final GetUserByIdUser otherTyped = other as GetUserByIdUser;
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

  GetUserByIdUser({
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
class GetUserByIdData {
  final GetUserByIdUser? user;
  GetUserByIdData.fromJson(dynamic json):
  
  user = json['user'] == null ? null : GetUserByIdUser.fromJson(json['user']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByIdData otherTyped = other as GetUserByIdData;
    return user == otherTyped.user;
    
  }
  @override
  int get hashCode => user.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user != null) {
      json['user'] = user!.toJson();
    }
    return json;
  }

  GetUserByIdData({
    this.user,
  });
}

@immutable
class GetUserByIdVariablesId {
  final String id;
  GetUserByIdVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByIdVariablesId otherTyped = other as GetUserByIdVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetUserByIdVariablesId({
    required this.id,
  });
}

@immutable
class GetUserByIdVariables {
  final GetUserByIdVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetUserByIdVariables.fromJson(Map<String, dynamic> json):
  
  id = GetUserByIdVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserByIdVariables otherTyped = other as GetUserByIdVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  GetUserByIdVariables({
    required this.id,
  });
}

