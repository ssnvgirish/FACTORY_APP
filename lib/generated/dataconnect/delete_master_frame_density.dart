part of 'default.dart';

class DeleteMasterFrameDensityVariablesBuilder {
  DeleteMasterFrameDensityVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteMasterFrameDensityVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMasterFrameDensityData> dataDeserializer = (dynamic json)  => DeleteMasterFrameDensityData.fromJson(jsonDecode(json));
  Serializer<DeleteMasterFrameDensityVariables> varsSerializer = (DeleteMasterFrameDensityVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMasterFrameDensityData, DeleteMasterFrameDensityVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMasterFrameDensityData, DeleteMasterFrameDensityVariables> ref() {
    DeleteMasterFrameDensityVariables vars= DeleteMasterFrameDensityVariables(id: id,);
    return _dataConnect.mutation("DeleteMasterFrameDensity", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMasterFrameDensityMasterFrameDensityDelete {
  final String id;
  DeleteMasterFrameDensityMasterFrameDensityDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameDensityMasterFrameDensityDelete otherTyped = other as DeleteMasterFrameDensityMasterFrameDensityDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterFrameDensityMasterFrameDensityDelete({
    required this.id,
  });
}

@immutable
class DeleteMasterFrameDensityData {
  final DeleteMasterFrameDensityMasterFrameDensityDelete? masterFrameDensity_delete;
  DeleteMasterFrameDensityData.fromJson(dynamic json):
  
  masterFrameDensity_delete = json['masterFrameDensity_delete'] == null ? null : DeleteMasterFrameDensityMasterFrameDensityDelete.fromJson(json['masterFrameDensity_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameDensityData otherTyped = other as DeleteMasterFrameDensityData;
    return masterFrameDensity_delete == otherTyped.masterFrameDensity_delete;
    
  }
  @override
  int get hashCode => masterFrameDensity_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterFrameDensity_delete != null) {
      json['masterFrameDensity_delete'] = masterFrameDensity_delete!.toJson();
    }
    return json;
  }

  DeleteMasterFrameDensityData({
    this.masterFrameDensity_delete,
  });
}

@immutable
class DeleteMasterFrameDensityVariablesId {
  final String id;
  DeleteMasterFrameDensityVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameDensityVariablesId otherTyped = other as DeleteMasterFrameDensityVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterFrameDensityVariablesId({
    required this.id,
  });
}

@immutable
class DeleteMasterFrameDensityVariables {
  final DeleteMasterFrameDensityVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMasterFrameDensityVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteMasterFrameDensityVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterFrameDensityVariables otherTyped = other as DeleteMasterFrameDensityVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteMasterFrameDensityVariables({
    required this.id,
  });
}

