part of 'default.dart';

class DeleteMasterScrapTargetVariablesBuilder {
  DeleteMasterScrapTargetVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteMasterScrapTargetVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMasterScrapTargetData> dataDeserializer = (dynamic json)  => DeleteMasterScrapTargetData.fromJson(jsonDecode(json));
  Serializer<DeleteMasterScrapTargetVariables> varsSerializer = (DeleteMasterScrapTargetVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMasterScrapTargetData, DeleteMasterScrapTargetVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMasterScrapTargetData, DeleteMasterScrapTargetVariables> ref() {
    DeleteMasterScrapTargetVariables vars= DeleteMasterScrapTargetVariables(id: id,);
    return _dataConnect.mutation("DeleteMasterScrapTarget", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMasterScrapTargetMasterScrapTargetDelete {
  final String id;
  DeleteMasterScrapTargetMasterScrapTargetDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterScrapTargetMasterScrapTargetDelete otherTyped = other as DeleteMasterScrapTargetMasterScrapTargetDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterScrapTargetMasterScrapTargetDelete({
    required this.id,
  });
}

@immutable
class DeleteMasterScrapTargetData {
  final DeleteMasterScrapTargetMasterScrapTargetDelete? masterScrapTarget_delete;
  DeleteMasterScrapTargetData.fromJson(dynamic json):
  
  masterScrapTarget_delete = json['masterScrapTarget_delete'] == null ? null : DeleteMasterScrapTargetMasterScrapTargetDelete.fromJson(json['masterScrapTarget_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterScrapTargetData otherTyped = other as DeleteMasterScrapTargetData;
    return masterScrapTarget_delete == otherTyped.masterScrapTarget_delete;
    
  }
  @override
  int get hashCode => masterScrapTarget_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterScrapTarget_delete != null) {
      json['masterScrapTarget_delete'] = masterScrapTarget_delete!.toJson();
    }
    return json;
  }

  DeleteMasterScrapTargetData({
    this.masterScrapTarget_delete,
  });
}

@immutable
class DeleteMasterScrapTargetVariablesId {
  final String id;
  DeleteMasterScrapTargetVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterScrapTargetVariablesId otherTyped = other as DeleteMasterScrapTargetVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterScrapTargetVariablesId({
    required this.id,
  });
}

@immutable
class DeleteMasterScrapTargetVariables {
  final DeleteMasterScrapTargetVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMasterScrapTargetVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteMasterScrapTargetVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterScrapTargetVariables otherTyped = other as DeleteMasterScrapTargetVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteMasterScrapTargetVariables({
    required this.id,
  });
}

