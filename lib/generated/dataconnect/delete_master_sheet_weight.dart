part of 'default.dart';

class DeleteMasterSheetWeightVariablesBuilder {
  DeleteMasterSheetWeightVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteMasterSheetWeightVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMasterSheetWeightData> dataDeserializer = (dynamic json)  => DeleteMasterSheetWeightData.fromJson(jsonDecode(json));
  Serializer<DeleteMasterSheetWeightVariables> varsSerializer = (DeleteMasterSheetWeightVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMasterSheetWeightData, DeleteMasterSheetWeightVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMasterSheetWeightData, DeleteMasterSheetWeightVariables> ref() {
    DeleteMasterSheetWeightVariables vars= DeleteMasterSheetWeightVariables(id: id,);
    return _dataConnect.mutation("DeleteMasterSheetWeight", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMasterSheetWeightMasterSheetWeightDelete {
  final String id;
  DeleteMasterSheetWeightMasterSheetWeightDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetWeightMasterSheetWeightDelete otherTyped = other as DeleteMasterSheetWeightMasterSheetWeightDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterSheetWeightMasterSheetWeightDelete({
    required this.id,
  });
}

@immutable
class DeleteMasterSheetWeightData {
  final DeleteMasterSheetWeightMasterSheetWeightDelete? masterSheetWeight_delete;
  DeleteMasterSheetWeightData.fromJson(dynamic json):
  
  masterSheetWeight_delete = json['masterSheetWeight_delete'] == null ? null : DeleteMasterSheetWeightMasterSheetWeightDelete.fromJson(json['masterSheetWeight_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetWeightData otherTyped = other as DeleteMasterSheetWeightData;
    return masterSheetWeight_delete == otherTyped.masterSheetWeight_delete;
    
  }
  @override
  int get hashCode => masterSheetWeight_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterSheetWeight_delete != null) {
      json['masterSheetWeight_delete'] = masterSheetWeight_delete!.toJson();
    }
    return json;
  }

  DeleteMasterSheetWeightData({
    this.masterSheetWeight_delete,
  });
}

@immutable
class DeleteMasterSheetWeightVariablesId {
  final String id;
  DeleteMasterSheetWeightVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetWeightVariablesId otherTyped = other as DeleteMasterSheetWeightVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterSheetWeightVariablesId({
    required this.id,
  });
}

@immutable
class DeleteMasterSheetWeightVariables {
  final DeleteMasterSheetWeightVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMasterSheetWeightVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteMasterSheetWeightVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetWeightVariables otherTyped = other as DeleteMasterSheetWeightVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteMasterSheetWeightVariables({
    required this.id,
  });
}

