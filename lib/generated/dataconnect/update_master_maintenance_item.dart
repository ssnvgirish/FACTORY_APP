part of 'default.dart';

class UpdateMasterMaintenanceItemVariablesBuilder {
  UpdateMasterMaintenanceItemVariablesId id;
  String name;
  String category;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  UpdateMasterMaintenanceItemVariablesBuilder(this._dataConnect, {required  this.id,required  this.name,required  this.category,required  this.sortOrder,required  this.isActive,});
  Deserializer<UpdateMasterMaintenanceItemData> dataDeserializer = (dynamic json)  => UpdateMasterMaintenanceItemData.fromJson(jsonDecode(json));
  Serializer<UpdateMasterMaintenanceItemVariables> varsSerializer = (UpdateMasterMaintenanceItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMasterMaintenanceItemData, UpdateMasterMaintenanceItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateMasterMaintenanceItemData, UpdateMasterMaintenanceItemVariables> ref() {
    UpdateMasterMaintenanceItemVariables vars= UpdateMasterMaintenanceItemVariables(id: id,name: name,category: category,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("UpdateMasterMaintenanceItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateMasterMaintenanceItemMasterMaintenanceItemUpdate {
  final String id;
  UpdateMasterMaintenanceItemMasterMaintenanceItemUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterMaintenanceItemMasterMaintenanceItemUpdate otherTyped = other as UpdateMasterMaintenanceItemMasterMaintenanceItemUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterMaintenanceItemMasterMaintenanceItemUpdate({
    required this.id,
  });
}

@immutable
class UpdateMasterMaintenanceItemData {
  final UpdateMasterMaintenanceItemMasterMaintenanceItemUpdate? masterMaintenanceItem_update;
  UpdateMasterMaintenanceItemData.fromJson(dynamic json):
  
  masterMaintenanceItem_update = json['masterMaintenanceItem_update'] == null ? null : UpdateMasterMaintenanceItemMasterMaintenanceItemUpdate.fromJson(json['masterMaintenanceItem_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterMaintenanceItemData otherTyped = other as UpdateMasterMaintenanceItemData;
    return masterMaintenanceItem_update == otherTyped.masterMaintenanceItem_update;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterMaintenanceItem_update != null) {
      json['masterMaintenanceItem_update'] = masterMaintenanceItem_update!.toJson();
    }
    return json;
  }

  UpdateMasterMaintenanceItemData({
    this.masterMaintenanceItem_update,
  });
}

@immutable
class UpdateMasterMaintenanceItemVariablesId {
  final String id;
  UpdateMasterMaintenanceItemVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterMaintenanceItemVariablesId otherTyped = other as UpdateMasterMaintenanceItemVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterMaintenanceItemVariablesId({
    required this.id,
  });
}

@immutable
class UpdateMasterMaintenanceItemVariables {
  final UpdateMasterMaintenanceItemVariablesId id;
  final String name;
  final String category;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateMasterMaintenanceItemVariables.fromJson(Map<String, dynamic> json):
  
  id = UpdateMasterMaintenanceItemVariablesId.fromJson(json['id']),
  name = nativeFromJson<String>(json['name']),
  category = nativeFromJson<String>(json['category']),
  sortOrder = nativeFromJson<int>(json['sortOrder']),
  isActive = nativeFromJson<bool>(json['isActive']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterMaintenanceItemVariables otherTyped = other as UpdateMasterMaintenanceItemVariables;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    category == otherTyped.category && 
    sortOrder == otherTyped.sortOrder && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, category.hashCode, sortOrder.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    json['name'] = nativeToJson<String>(name);
    json['category'] = nativeToJson<String>(category);
    json['sortOrder'] = nativeToJson<int>(sortOrder);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  UpdateMasterMaintenanceItemVariables({
    required this.id,
    required this.name,
    required this.category,
    required this.sortOrder,
    required this.isActive,
  });
}

