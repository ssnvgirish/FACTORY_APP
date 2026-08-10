part of 'default.dart';

class DeleteFrameWritingEfficiencyVariablesBuilder {
  DeleteFrameWritingEfficiencyVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteFrameWritingEfficiencyVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteFrameWritingEfficiencyData> dataDeserializer = (dynamic json)  => DeleteFrameWritingEfficiencyData.fromJson(jsonDecode(json));
  Serializer<DeleteFrameWritingEfficiencyVariables> varsSerializer = (DeleteFrameWritingEfficiencyVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteFrameWritingEfficiencyData, DeleteFrameWritingEfficiencyVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteFrameWritingEfficiencyData, DeleteFrameWritingEfficiencyVariables> ref() {
    DeleteFrameWritingEfficiencyVariables vars= DeleteFrameWritingEfficiencyVariables(id: id,);
    return _dataConnect.mutation("DeleteFrameWritingEfficiency", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteFrameWritingEfficiencyFrameWritingEfficiencyDelete {
  final String id;
  DeleteFrameWritingEfficiencyFrameWritingEfficiencyDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameWritingEfficiencyFrameWritingEfficiencyDelete otherTyped = other as DeleteFrameWritingEfficiencyFrameWritingEfficiencyDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteFrameWritingEfficiencyFrameWritingEfficiencyDelete({
    required this.id,
  });
}

@immutable
class DeleteFrameWritingEfficiencyData {
  final DeleteFrameWritingEfficiencyFrameWritingEfficiencyDelete? frameWritingEfficiency_delete;
  DeleteFrameWritingEfficiencyData.fromJson(dynamic json):
  
  frameWritingEfficiency_delete = json['frameWritingEfficiency_delete'] == null ? null : DeleteFrameWritingEfficiencyFrameWritingEfficiencyDelete.fromJson(json['frameWritingEfficiency_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameWritingEfficiencyData otherTyped = other as DeleteFrameWritingEfficiencyData;
    return frameWritingEfficiency_delete == otherTyped.frameWritingEfficiency_delete;
    
  }
  @override
  int get hashCode => frameWritingEfficiency_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (frameWritingEfficiency_delete != null) {
      json['frameWritingEfficiency_delete'] = frameWritingEfficiency_delete!.toJson();
    }
    return json;
  }

  DeleteFrameWritingEfficiencyData({
    this.frameWritingEfficiency_delete,
  });
}

@immutable
class DeleteFrameWritingEfficiencyVariablesId {
  final String id;
  DeleteFrameWritingEfficiencyVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameWritingEfficiencyVariablesId otherTyped = other as DeleteFrameWritingEfficiencyVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteFrameWritingEfficiencyVariablesId({
    required this.id,
  });
}

@immutable
class DeleteFrameWritingEfficiencyVariables {
  final DeleteFrameWritingEfficiencyVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteFrameWritingEfficiencyVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteFrameWritingEfficiencyVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameWritingEfficiencyVariables otherTyped = other as DeleteFrameWritingEfficiencyVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteFrameWritingEfficiencyVariables({
    required this.id,
  });
}

