part of 'default.dart';

class DeleteMasterScrapProductVariablesBuilder {
  DeleteMasterScrapProductVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteMasterScrapProductVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteMasterScrapProductData> dataDeserializer = (dynamic json)  => DeleteMasterScrapProductData.fromJson(jsonDecode(json));
  Serializer<DeleteMasterScrapProductVariables> varsSerializer = (DeleteMasterScrapProductVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteMasterScrapProductData, DeleteMasterScrapProductVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteMasterScrapProductData, DeleteMasterScrapProductVariables> ref() {
    DeleteMasterScrapProductVariables vars= DeleteMasterScrapProductVariables(id: id,);
    return _dataConnect.mutation("DeleteMasterScrapProduct", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteMasterScrapProductMasterScrapProductDelete {
  final String id;
  DeleteMasterScrapProductMasterScrapProductDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterScrapProductMasterScrapProductDelete otherTyped = other as DeleteMasterScrapProductMasterScrapProductDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterScrapProductMasterScrapProductDelete({
    required this.id,
  });
}

@immutable
class DeleteMasterScrapProductData {
  final DeleteMasterScrapProductMasterScrapProductDelete? masterScrapProduct_delete;
  DeleteMasterScrapProductData.fromJson(dynamic json):
  
  masterScrapProduct_delete = json['masterScrapProduct_delete'] == null ? null : DeleteMasterScrapProductMasterScrapProductDelete.fromJson(json['masterScrapProduct_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterScrapProductData otherTyped = other as DeleteMasterScrapProductData;
    return masterScrapProduct_delete == otherTyped.masterScrapProduct_delete;
    
  }
  @override
  int get hashCode => masterScrapProduct_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterScrapProduct_delete != null) {
      json['masterScrapProduct_delete'] = masterScrapProduct_delete!.toJson();
    }
    return json;
  }

  DeleteMasterScrapProductData({
    this.masterScrapProduct_delete,
  });
}

@immutable
class DeleteMasterScrapProductVariablesId {
  final String id;
  DeleteMasterScrapProductVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterScrapProductVariablesId otherTyped = other as DeleteMasterScrapProductVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteMasterScrapProductVariablesId({
    required this.id,
  });
}

@immutable
class DeleteMasterScrapProductVariables {
  final DeleteMasterScrapProductVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteMasterScrapProductVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteMasterScrapProductVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteMasterScrapProductVariables otherTyped = other as DeleteMasterScrapProductVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteMasterScrapProductVariables({
    required this.id,
  });
}

