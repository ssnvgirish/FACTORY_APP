part of 'default.dart';

class DeleteMasterSheetTargetVariablesBuilder {
  DeleteMasterSheetTargetVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteMasterSheetTargetVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMasterSheetTargetData> dataDeserializer = (dynamic json)  => DeleteMasterSheetTargetData.fromJson(jsonDecode(json));
  Serializer<DeleteMasterSheetTargetVariables> varsSerializer = (DeleteMasterSheetTargetVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMasterSheetTargetData, DeleteMasterSheetTargetVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMasterSheetTargetData, DeleteMasterSheetTargetVariables> ref() {
    DeleteMasterSheetTargetVariables vars= DeleteMasterSheetTargetVariables(id: id,);
    return _dataConnect.mutation("DeleteMasterSheetTarget", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMasterSheetTargetMasterSheetTargetDelete {
  final String id;
  DeleteMasterSheetTargetMasterSheetTargetDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetTargetMasterSheetTargetDelete otherTyped = other as DeleteMasterSheetTargetMasterSheetTargetDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterSheetTargetMasterSheetTargetDelete({
    required this.id,
  });
}

@immutable
class DeleteMasterSheetTargetData {
  final DeleteMasterSheetTargetMasterSheetTargetDelete? masterSheetTarget_delete;
  DeleteMasterSheetTargetData.fromJson(dynamic json):
  
  masterSheetTarget_delete = json['masterSheetTarget_delete'] == null ? null : DeleteMasterSheetTargetMasterSheetTargetDelete.fromJson(json['masterSheetTarget_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetTargetData otherTyped = other as DeleteMasterSheetTargetData;
    return masterSheetTarget_delete == otherTyped.masterSheetTarget_delete;
    
  }
  @override
  int get hashCode => masterSheetTarget_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterSheetTarget_delete != null) {
      json['masterSheetTarget_delete'] = masterSheetTarget_delete!.toJson();
    }
    return json;
  }

  DeleteMasterSheetTargetData({
    this.masterSheetTarget_delete,
  });
}

@immutable
class DeleteMasterSheetTargetVariablesId {
  final String id;
  DeleteMasterSheetTargetVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetTargetVariablesId otherTyped = other as DeleteMasterSheetTargetVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterSheetTargetVariablesId({
    required this.id,
  });
}

@immutable
class DeleteMasterSheetTargetVariables {
  final DeleteMasterSheetTargetVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMasterSheetTargetVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteMasterSheetTargetVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetTargetVariables otherTyped = other as DeleteMasterSheetTargetVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteMasterSheetTargetVariables({
    required this.id,
  });
}

