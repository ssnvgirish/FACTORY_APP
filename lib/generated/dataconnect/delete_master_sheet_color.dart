part of 'default.dart';

class DeleteMasterSheetColorVariablesBuilder {
  DeleteMasterSheetColorVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteMasterSheetColorVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMasterSheetColorData> dataDeserializer = (dynamic json)  => DeleteMasterSheetColorData.fromJson(jsonDecode(json));
  Serializer<DeleteMasterSheetColorVariables> varsSerializer = (DeleteMasterSheetColorVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMasterSheetColorData, DeleteMasterSheetColorVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMasterSheetColorData, DeleteMasterSheetColorVariables> ref() {
    DeleteMasterSheetColorVariables vars= DeleteMasterSheetColorVariables(id: id,);
    return _dataConnect.mutation("DeleteMasterSheetColor", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMasterSheetColorMasterSheetColorDelete {
  final String id;
  DeleteMasterSheetColorMasterSheetColorDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetColorMasterSheetColorDelete otherTyped = other as DeleteMasterSheetColorMasterSheetColorDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterSheetColorMasterSheetColorDelete({
    required this.id,
  });
}

@immutable
class DeleteMasterSheetColorData {
  final DeleteMasterSheetColorMasterSheetColorDelete? masterSheetColor_delete;
  DeleteMasterSheetColorData.fromJson(dynamic json):
  
  masterSheetColor_delete = json['masterSheetColor_delete'] == null ? null : DeleteMasterSheetColorMasterSheetColorDelete.fromJson(json['masterSheetColor_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetColorData otherTyped = other as DeleteMasterSheetColorData;
    return masterSheetColor_delete == otherTyped.masterSheetColor_delete;
    
  }
  @override
  int get hashCode => masterSheetColor_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterSheetColor_delete != null) {
      json['masterSheetColor_delete'] = masterSheetColor_delete!.toJson();
    }
    return json;
  }

  DeleteMasterSheetColorData({
    this.masterSheetColor_delete,
  });
}

@immutable
class DeleteMasterSheetColorVariablesId {
  final String id;
  DeleteMasterSheetColorVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetColorVariablesId otherTyped = other as DeleteMasterSheetColorVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterSheetColorVariablesId({
    required this.id,
  });
}

@immutable
class DeleteMasterSheetColorVariables {
  final DeleteMasterSheetColorVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMasterSheetColorVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteMasterSheetColorVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetColorVariables otherTyped = other as DeleteMasterSheetColorVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteMasterSheetColorVariables({
    required this.id,
  });
}

