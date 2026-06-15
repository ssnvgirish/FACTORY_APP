part of 'default.dart';

class ToggleUserActiveVariablesBuilder {
  ToggleUserActiveVariablesId id;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  ToggleUserActiveVariablesBuilder(this._dataConnect, {required  this.id,required  this.isActive,});
  Deserializer<ToggleUserActiveData> dataDeserializer = (dynamic json)  => ToggleUserActiveData.fromJson(jsonDecode(json));
  Serializer<ToggleUserActiveVariables> varsSerializer = (ToggleUserActiveVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<ToggleUserActiveData, ToggleUserActiveVariables>> execute() {
    return ref().execute();
  }

  MutationRef<ToggleUserActiveData, ToggleUserActiveVariables> ref() {
    ToggleUserActiveVariables vars= ToggleUserActiveVariables(id: id,isActive: isActive,);
    return _dataConnect.mutation("ToggleUserActive", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ToggleUserActiveUserUpdate {
  final String id;
  ToggleUserActiveUserUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ToggleUserActiveUserUpdate otherTyped = other as ToggleUserActiveUserUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  ToggleUserActiveUserUpdate({
    required this.id,
  });
}

@immutable
class ToggleUserActiveData {
  final ToggleUserActiveUserUpdate? user_update;
  ToggleUserActiveData.fromJson(dynamic json):
  
  user_update = json['user_update'] == null ? null : ToggleUserActiveUserUpdate.fromJson(json['user_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ToggleUserActiveData otherTyped = other as ToggleUserActiveData;
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

  ToggleUserActiveData({
    this.user_update,
  });
}

@immutable
class ToggleUserActiveVariablesId {
  final String id;
  ToggleUserActiveVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ToggleUserActiveVariablesId otherTyped = other as ToggleUserActiveVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  ToggleUserActiveVariablesId({
    required this.id,
  });
}

@immutable
class ToggleUserActiveVariables {
  final ToggleUserActiveVariablesId id;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ToggleUserActiveVariables.fromJson(Map<String, dynamic> json):
  
  id = ToggleUserActiveVariablesId.fromJson(json['id']),
  isActive = nativeFromJson<bool>(json['isActive']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ToggleUserActiveVariables otherTyped = other as ToggleUserActiveVariables;
    return id == otherTyped.id && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  ToggleUserActiveVariables({
    required this.id,
    required this.isActive,
  });
}

