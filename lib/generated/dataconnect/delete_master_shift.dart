part of 'default.dart';

class DeleteMasterShiftVariablesBuilder {
  DeleteMasterShiftVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteMasterShiftVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMasterShiftData> dataDeserializer = (dynamic json)  => DeleteMasterShiftData.fromJson(jsonDecode(json));
  Serializer<DeleteMasterShiftVariables> varsSerializer = (DeleteMasterShiftVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMasterShiftData, DeleteMasterShiftVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMasterShiftData, DeleteMasterShiftVariables> ref() {
    DeleteMasterShiftVariables vars= DeleteMasterShiftVariables(id: id,);
    return _dataConnect.mutation("DeleteMasterShift", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMasterShiftMasterShiftDelete {
  final String id;
  DeleteMasterShiftMasterShiftDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterShiftMasterShiftDelete otherTyped = other as DeleteMasterShiftMasterShiftDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterShiftMasterShiftDelete({
    required this.id,
  });
}

@immutable
class DeleteMasterShiftData {
  final DeleteMasterShiftMasterShiftDelete? masterShift_delete;
  DeleteMasterShiftData.fromJson(dynamic json):
  
  masterShift_delete = json['masterShift_delete'] == null ? null : DeleteMasterShiftMasterShiftDelete.fromJson(json['masterShift_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterShiftData otherTyped = other as DeleteMasterShiftData;
    return masterShift_delete == otherTyped.masterShift_delete;
    
  }
  @override
  int get hashCode => masterShift_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterShift_delete != null) {
      json['masterShift_delete'] = masterShift_delete!.toJson();
    }
    return json;
  }

  DeleteMasterShiftData({
    this.masterShift_delete,
  });
}

@immutable
class DeleteMasterShiftVariablesId {
  final String id;
  DeleteMasterShiftVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterShiftVariablesId otherTyped = other as DeleteMasterShiftVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterShiftVariablesId({
    required this.id,
  });
}

@immutable
class DeleteMasterShiftVariables {
  final DeleteMasterShiftVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMasterShiftVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteMasterShiftVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterShiftVariables otherTyped = other as DeleteMasterShiftVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteMasterShiftVariables({
    required this.id,
  });
}

