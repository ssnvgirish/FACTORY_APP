part of 'default.dart';

class ListAllUsersVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListAllUsersVariablesBuilder(this._dataConnect, );
  Deserializer<ListAllUsersData> dataDeserializer = (dynamic json)  => ListAllUsersData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListAllUsersData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListAllUsersData, void> ref() {
    
    return _dataConnect.query("ListAllUsers", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListAllUsersUsers {
  final String id;
  final String uid;
  final String name;
  final String phone;
  final String email;
  final List<String> roles;
  final List<String> assignedMachines;
  final double fixedSalary;
  final bool isActive;
  ListAllUsersUsers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  uid = nativeFromJson<String>(json['uid']),
  name = nativeFromJson<String>(json['name']),
  phone = nativeFromJson<String>(json['phone']),
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

    final ListAllUsersUsers otherTyped = other as ListAllUsersUsers;
    return id == otherTyped.id && 
    uid == otherTyped.uid && 
    name == otherTyped.name && 
    phone == otherTyped.phone && 
    email == otherTyped.email && 
    roles == otherTyped.roles && 
    assignedMachines == otherTyped.assignedMachines && 
    fixedSalary == otherTyped.fixedSalary && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, uid.hashCode, name.hashCode, phone.hashCode, email.hashCode, roles.hashCode, assignedMachines.hashCode, fixedSalary.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['uid'] = nativeToJson<String>(uid);
    json['name'] = nativeToJson<String>(name);
    json['phone'] = nativeToJson<String>(phone);
    json['email'] = nativeToJson<String>(email);
    json['roles'] = roles.map((e) => nativeToJson<String>(e)).toList();
    json['assignedMachines'] = assignedMachines.map((e) => nativeToJson<String>(e)).toList();
    json['fixedSalary'] = nativeToJson<double>(fixedSalary);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  ListAllUsersUsers({
    required this.id,
    required this.uid,
    required this.name,
    required this.phone,
    required this.email,
    required this.roles,
    required this.assignedMachines,
    required this.fixedSalary,
    required this.isActive,
  });
}

@immutable
class ListAllUsersData {
  final List<ListAllUsersUsers> users;
  ListAllUsersData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => ListAllUsersUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAllUsersData otherTyped = other as ListAllUsersData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  ListAllUsersData({
    required this.users,
  });
}

