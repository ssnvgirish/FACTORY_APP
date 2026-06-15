part of 'default.dart';

class DeleteMasterSheetDensityVariablesBuilder {
  DeleteMasterSheetDensityVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteMasterSheetDensityVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMasterSheetDensityData> dataDeserializer = (dynamic json)  => DeleteMasterSheetDensityData.fromJson(jsonDecode(json));
  Serializer<DeleteMasterSheetDensityVariables> varsSerializer = (DeleteMasterSheetDensityVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMasterSheetDensityData, DeleteMasterSheetDensityVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMasterSheetDensityData, DeleteMasterSheetDensityVariables> ref() {
    DeleteMasterSheetDensityVariables vars= DeleteMasterSheetDensityVariables(id: id,);
    return _dataConnect.mutation("DeleteMasterSheetDensity", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMasterSheetDensityMasterSheetDensityDelete {
  final String id;
  DeleteMasterSheetDensityMasterSheetDensityDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetDensityMasterSheetDensityDelete otherTyped = other as DeleteMasterSheetDensityMasterSheetDensityDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterSheetDensityMasterSheetDensityDelete({
    required this.id,
  });
}

@immutable
class DeleteMasterSheetDensityData {
  final DeleteMasterSheetDensityMasterSheetDensityDelete? masterSheetDensity_delete;
  DeleteMasterSheetDensityData.fromJson(dynamic json):
  
  masterSheetDensity_delete = json['masterSheetDensity_delete'] == null ? null : DeleteMasterSheetDensityMasterSheetDensityDelete.fromJson(json['masterSheetDensity_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetDensityData otherTyped = other as DeleteMasterSheetDensityData;
    return masterSheetDensity_delete == otherTyped.masterSheetDensity_delete;
    
  }
  @override
  int get hashCode => masterSheetDensity_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterSheetDensity_delete != null) {
      json['masterSheetDensity_delete'] = masterSheetDensity_delete!.toJson();
    }
    return json;
  }

  DeleteMasterSheetDensityData({
    this.masterSheetDensity_delete,
  });
}

@immutable
class DeleteMasterSheetDensityVariablesId {
  final String id;
  DeleteMasterSheetDensityVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetDensityVariablesId otherTyped = other as DeleteMasterSheetDensityVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterSheetDensityVariablesId({
    required this.id,
  });
}

@immutable
class DeleteMasterSheetDensityVariables {
  final DeleteMasterSheetDensityVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMasterSheetDensityVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteMasterSheetDensityVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetDensityVariables otherTyped = other as DeleteMasterSheetDensityVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteMasterSheetDensityVariables({
    required this.id,
  });
}

