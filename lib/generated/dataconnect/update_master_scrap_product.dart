part of 'default.dart';

class UpdateMasterScrapProductVariablesBuilder {
  UpdateMasterScrapProductVariablesId id;
  String name;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  UpdateMasterScrapProductVariablesBuilder(this._dataConnect, {required  this.id,required  this.name,required  this.sortOrder,required  this.isActive,});
  Deserializer<UpdateMasterScrapProductData> dataDeserializer = (dynamic json)  => UpdateMasterScrapProductData.fromJson(jsonDecode(json));
  Serializer<UpdateMasterScrapProductVariables> varsSerializer = (UpdateMasterScrapProductVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMasterScrapProductData, UpdateMasterScrapProductVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateMasterScrapProductData, UpdateMasterScrapProductVariables> ref() {
    UpdateMasterScrapProductVariables vars= UpdateMasterScrapProductVariables(id: id,name: name,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("UpdateMasterScrapProduct", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateMasterScrapProductMasterScrapProductUpdate {
  final String id;
  UpdateMasterScrapProductMasterScrapProductUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterScrapProductMasterScrapProductUpdate otherTyped = other as UpdateMasterScrapProductMasterScrapProductUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterScrapProductMasterScrapProductUpdate({
    required this.id,
  });
}

@immutable
class UpdateMasterScrapProductData {
  final UpdateMasterScrapProductMasterScrapProductUpdate? masterScrapProduct_update;
  UpdateMasterScrapProductData.fromJson(dynamic json):
  
  masterScrapProduct_update = json['masterScrapProduct_update'] == null ? null : UpdateMasterScrapProductMasterScrapProductUpdate.fromJson(json['masterScrapProduct_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterScrapProductData otherTyped = other as UpdateMasterScrapProductData;
    return masterScrapProduct_update == otherTyped.masterScrapProduct_update;
    
  }
  @override
  int get hashCode => masterScrapProduct_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterScrapProduct_update != null) {
      json['masterScrapProduct_update'] = masterScrapProduct_update!.toJson();
    }
    return json;
  }

  UpdateMasterScrapProductData({
    this.masterScrapProduct_update,
  });
}

@immutable
class UpdateMasterScrapProductVariablesId {
  final String id;
  UpdateMasterScrapProductVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterScrapProductVariablesId otherTyped = other as UpdateMasterScrapProductVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterScrapProductVariablesId({
    required this.id,
  });
}

@immutable
class UpdateMasterScrapProductVariables {
  final UpdateMasterScrapProductVariablesId id;
  final String name;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateMasterScrapProductVariables.fromJson(Map<String, dynamic> json):
  
  id = UpdateMasterScrapProductVariablesId.fromJson(json['id']),
  name = nativeFromJson<String>(json['name']),
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

    final UpdateMasterScrapProductVariables otherTyped = other as UpdateMasterScrapProductVariables;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    sortOrder == otherTyped.sortOrder && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, sortOrder.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    json['name'] = nativeToJson<String>(name);
    json['sortOrder'] = nativeToJson<int>(sortOrder);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  UpdateMasterScrapProductVariables({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.isActive,
  });
}

