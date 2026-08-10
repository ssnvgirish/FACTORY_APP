part of 'default.dart';

class DeleteScrapWritingEfficiencyVariablesBuilder {
  DeleteScrapWritingEfficiencyVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteScrapWritingEfficiencyVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteScrapWritingEfficiencyData> dataDeserializer = (dynamic json)  => DeleteScrapWritingEfficiencyData.fromJson(jsonDecode(json));
  Serializer<DeleteScrapWritingEfficiencyVariables> varsSerializer = (DeleteScrapWritingEfficiencyVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteScrapWritingEfficiencyData, DeleteScrapWritingEfficiencyVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteScrapWritingEfficiencyData, DeleteScrapWritingEfficiencyVariables> ref() {
    DeleteScrapWritingEfficiencyVariables vars= DeleteScrapWritingEfficiencyVariables(id: id,);
    return _dataConnect.mutation("DeleteScrapWritingEfficiency", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteScrapWritingEfficiencyScrapWritingEfficiencyDelete {
  final String id;
  DeleteScrapWritingEfficiencyScrapWritingEfficiencyDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapWritingEfficiencyScrapWritingEfficiencyDelete otherTyped = other as DeleteScrapWritingEfficiencyScrapWritingEfficiencyDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteScrapWritingEfficiencyScrapWritingEfficiencyDelete({
    required this.id,
  });
}

@immutable
class DeleteScrapWritingEfficiencyData {
  final DeleteScrapWritingEfficiencyScrapWritingEfficiencyDelete? scrapWritingEfficiency_delete;
  DeleteScrapWritingEfficiencyData.fromJson(dynamic json):
  
  scrapWritingEfficiency_delete = json['scrapWritingEfficiency_delete'] == null ? null : DeleteScrapWritingEfficiencyScrapWritingEfficiencyDelete.fromJson(json['scrapWritingEfficiency_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapWritingEfficiencyData otherTyped = other as DeleteScrapWritingEfficiencyData;
    return scrapWritingEfficiency_delete == otherTyped.scrapWritingEfficiency_delete;
    
  }
  @override
  int get hashCode => scrapWritingEfficiency_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (scrapWritingEfficiency_delete != null) {
      json['scrapWritingEfficiency_delete'] = scrapWritingEfficiency_delete!.toJson();
    }
    return json;
  }

  DeleteScrapWritingEfficiencyData({
    this.scrapWritingEfficiency_delete,
  });
}

@immutable
class DeleteScrapWritingEfficiencyVariablesId {
  final String id;
  DeleteScrapWritingEfficiencyVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapWritingEfficiencyVariablesId otherTyped = other as DeleteScrapWritingEfficiencyVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteScrapWritingEfficiencyVariablesId({
    required this.id,
  });
}

@immutable
class DeleteScrapWritingEfficiencyVariables {
  final DeleteScrapWritingEfficiencyVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteScrapWritingEfficiencyVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteScrapWritingEfficiencyVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapWritingEfficiencyVariables otherTyped = other as DeleteScrapWritingEfficiencyVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteScrapWritingEfficiencyVariables({
    required this.id,
  });
}

