part of 'default.dart';

class DeleteMasterSalaryWeightageVariablesBuilder {
  DeleteMasterSalaryWeightageVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteMasterSalaryWeightageVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMasterSalaryWeightageData> dataDeserializer = (dynamic json)  => DeleteMasterSalaryWeightageData.fromJson(jsonDecode(json));
  Serializer<DeleteMasterSalaryWeightageVariables> varsSerializer = (DeleteMasterSalaryWeightageVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMasterSalaryWeightageData, DeleteMasterSalaryWeightageVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMasterSalaryWeightageData, DeleteMasterSalaryWeightageVariables> ref() {
    DeleteMasterSalaryWeightageVariables vars= DeleteMasterSalaryWeightageVariables(id: id,);
    return _dataConnect.mutation("DeleteMasterSalaryWeightage", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMasterSalaryWeightageMasterSalaryWeightageDelete {
  final String id;
  DeleteMasterSalaryWeightageMasterSalaryWeightageDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSalaryWeightageMasterSalaryWeightageDelete otherTyped = other as DeleteMasterSalaryWeightageMasterSalaryWeightageDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterSalaryWeightageMasterSalaryWeightageDelete({
    required this.id,
  });
}

@immutable
class DeleteMasterSalaryWeightageData {
  final DeleteMasterSalaryWeightageMasterSalaryWeightageDelete? masterSalaryWeightage_delete;
  DeleteMasterSalaryWeightageData.fromJson(dynamic json):
  
  masterSalaryWeightage_delete = json['masterSalaryWeightage_delete'] == null ? null : DeleteMasterSalaryWeightageMasterSalaryWeightageDelete.fromJson(json['masterSalaryWeightage_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSalaryWeightageData otherTyped = other as DeleteMasterSalaryWeightageData;
    return masterSalaryWeightage_delete == otherTyped.masterSalaryWeightage_delete;
    
  }
  @override
  int get hashCode => masterSalaryWeightage_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterSalaryWeightage_delete != null) {
      json['masterSalaryWeightage_delete'] = masterSalaryWeightage_delete!.toJson();
    }
    return json;
  }

  DeleteMasterSalaryWeightageData({
    this.masterSalaryWeightage_delete,
  });
}

@immutable
class DeleteMasterSalaryWeightageVariablesId {
  final String id;
  DeleteMasterSalaryWeightageVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSalaryWeightageVariablesId otherTyped = other as DeleteMasterSalaryWeightageVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterSalaryWeightageVariablesId({
    required this.id,
  });
}

@immutable
class DeleteMasterSalaryWeightageVariables {
  final DeleteMasterSalaryWeightageVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMasterSalaryWeightageVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteMasterSalaryWeightageVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterSalaryWeightageVariables otherTyped = other as DeleteMasterSalaryWeightageVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteMasterSalaryWeightageVariables({
    required this.id,
  });
}

