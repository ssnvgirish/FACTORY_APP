part of 'default.dart';

class DeleteMasterMaintenanceItemVariablesBuilder {
  DeleteMasterMaintenanceItemVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteMasterMaintenanceItemVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMasterMaintenanceItemData> dataDeserializer = (dynamic json)  => DeleteMasterMaintenanceItemData.fromJson(jsonDecode(json));
  Serializer<DeleteMasterMaintenanceItemVariables> varsSerializer = (DeleteMasterMaintenanceItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMasterMaintenanceItemData, DeleteMasterMaintenanceItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMasterMaintenanceItemData, DeleteMasterMaintenanceItemVariables> ref() {
    DeleteMasterMaintenanceItemVariables vars= DeleteMasterMaintenanceItemVariables(id: id,);
    return _dataConnect.mutation("DeleteMasterMaintenanceItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMasterMaintenanceItemMasterMaintenanceItemDelete {
  final String id;
  DeleteMasterMaintenanceItemMasterMaintenanceItemDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterMaintenanceItemMasterMaintenanceItemDelete otherTyped = other as DeleteMasterMaintenanceItemMasterMaintenanceItemDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterMaintenanceItemMasterMaintenanceItemDelete({
    required this.id,
  });
}

@immutable
class DeleteMasterMaintenanceItemData {
  final DeleteMasterMaintenanceItemMasterMaintenanceItemDelete? masterMaintenanceItem_delete;
  DeleteMasterMaintenanceItemData.fromJson(dynamic json):
  
  masterMaintenanceItem_delete = json['masterMaintenanceItem_delete'] == null ? null : DeleteMasterMaintenanceItemMasterMaintenanceItemDelete.fromJson(json['masterMaintenanceItem_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterMaintenanceItemData otherTyped = other as DeleteMasterMaintenanceItemData;
    return masterMaintenanceItem_delete == otherTyped.masterMaintenanceItem_delete;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterMaintenanceItem_delete != null) {
      json['masterMaintenanceItem_delete'] = masterMaintenanceItem_delete!.toJson();
    }
    return json;
  }

  DeleteMasterMaintenanceItemData({
    this.masterMaintenanceItem_delete,
  });
}

@immutable
class DeleteMasterMaintenanceItemVariablesId {
  final String id;
  DeleteMasterMaintenanceItemVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterMaintenanceItemVariablesId otherTyped = other as DeleteMasterMaintenanceItemVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterMaintenanceItemVariablesId({
    required this.id,
  });
}

@immutable
class DeleteMasterMaintenanceItemVariables {
  final DeleteMasterMaintenanceItemVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMasterMaintenanceItemVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteMasterMaintenanceItemVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterMaintenanceItemVariables otherTyped = other as DeleteMasterMaintenanceItemVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteMasterMaintenanceItemVariables({
    required this.id,
  });
}

