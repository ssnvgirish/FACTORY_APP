part of 'default.dart';

class DeleteMasterSheetThicknessVariablesBuilder {
  DeleteMasterSheetThicknessVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteMasterSheetThicknessVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMasterSheetThicknessData> dataDeserializer = (dynamic json)  => DeleteMasterSheetThicknessData.fromJson(jsonDecode(json));
  Serializer<DeleteMasterSheetThicknessVariables> varsSerializer = (DeleteMasterSheetThicknessVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMasterSheetThicknessData, DeleteMasterSheetThicknessVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMasterSheetThicknessData, DeleteMasterSheetThicknessVariables> ref() {
    DeleteMasterSheetThicknessVariables vars= DeleteMasterSheetThicknessVariables(id: id,);
    return _dataConnect.mutation("DeleteMasterSheetThickness", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMasterSheetThicknessMasterSheetThicknessDelete {
  final String id;
  DeleteMasterSheetThicknessMasterSheetThicknessDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetThicknessMasterSheetThicknessDelete otherTyped = other as DeleteMasterSheetThicknessMasterSheetThicknessDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterSheetThicknessMasterSheetThicknessDelete({
    required this.id,
  });
}

@immutable
class DeleteMasterSheetThicknessData {
  final DeleteMasterSheetThicknessMasterSheetThicknessDelete? masterSheetThickness_delete;
  DeleteMasterSheetThicknessData.fromJson(dynamic json):
  
  masterSheetThickness_delete = json['masterSheetThickness_delete'] == null ? null : DeleteMasterSheetThicknessMasterSheetThicknessDelete.fromJson(json['masterSheetThickness_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetThicknessData otherTyped = other as DeleteMasterSheetThicknessData;
    return masterSheetThickness_delete == otherTyped.masterSheetThickness_delete;
    
  }
  @override
  int get hashCode => masterSheetThickness_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterSheetThickness_delete != null) {
      json['masterSheetThickness_delete'] = masterSheetThickness_delete!.toJson();
    }
    return json;
  }

  DeleteMasterSheetThicknessData({
    this.masterSheetThickness_delete,
  });
}

@immutable
class DeleteMasterSheetThicknessVariablesId {
  final String id;
  DeleteMasterSheetThicknessVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetThicknessVariablesId otherTyped = other as DeleteMasterSheetThicknessVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterSheetThicknessVariablesId({
    required this.id,
  });
}

@immutable
class DeleteMasterSheetThicknessVariables {
  final DeleteMasterSheetThicknessVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMasterSheetThicknessVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteMasterSheetThicknessVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSheetThicknessVariables otherTyped = other as DeleteMasterSheetThicknessVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteMasterSheetThicknessVariables({
    required this.id,
  });
}

