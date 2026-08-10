part of 'default.dart';

class DeleteSheetWritingEfficiencyVariablesBuilder {
  DeleteSheetWritingEfficiencyVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteSheetWritingEfficiencyVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteSheetWritingEfficiencyData> dataDeserializer = (dynamic json)  => DeleteSheetWritingEfficiencyData.fromJson(jsonDecode(json));
  Serializer<DeleteSheetWritingEfficiencyVariables> varsSerializer = (DeleteSheetWritingEfficiencyVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteSheetWritingEfficiencyData, DeleteSheetWritingEfficiencyVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteSheetWritingEfficiencyData, DeleteSheetWritingEfficiencyVariables> ref() {
    DeleteSheetWritingEfficiencyVariables vars= DeleteSheetWritingEfficiencyVariables(id: id,);
    return _dataConnect.mutation("DeleteSheetWritingEfficiency", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteSheetWritingEfficiencySheetWritingEfficiencyDelete {
  final String id;
  DeleteSheetWritingEfficiencySheetWritingEfficiencyDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetWritingEfficiencySheetWritingEfficiencyDelete otherTyped = other as DeleteSheetWritingEfficiencySheetWritingEfficiencyDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteSheetWritingEfficiencySheetWritingEfficiencyDelete({
    required this.id,
  });
}

@immutable
class DeleteSheetWritingEfficiencyData {
  final DeleteSheetWritingEfficiencySheetWritingEfficiencyDelete? sheetWritingEfficiency_delete;
  DeleteSheetWritingEfficiencyData.fromJson(dynamic json):
  
  sheetWritingEfficiency_delete = json['sheetWritingEfficiency_delete'] == null ? null : DeleteSheetWritingEfficiencySheetWritingEfficiencyDelete.fromJson(json['sheetWritingEfficiency_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetWritingEfficiencyData otherTyped = other as DeleteSheetWritingEfficiencyData;
    return sheetWritingEfficiency_delete == otherTyped.sheetWritingEfficiency_delete;
    
  }
  @override
  int get hashCode => sheetWritingEfficiency_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (sheetWritingEfficiency_delete != null) {
      json['sheetWritingEfficiency_delete'] = sheetWritingEfficiency_delete!.toJson();
    }
    return json;
  }

  DeleteSheetWritingEfficiencyData({
    this.sheetWritingEfficiency_delete,
  });
}

@immutable
class DeleteSheetWritingEfficiencyVariablesId {
  final String id;
  DeleteSheetWritingEfficiencyVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetWritingEfficiencyVariablesId otherTyped = other as DeleteSheetWritingEfficiencyVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteSheetWritingEfficiencyVariablesId({
    required this.id,
  });
}

@immutable
class DeleteSheetWritingEfficiencyVariables {
  final DeleteSheetWritingEfficiencyVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteSheetWritingEfficiencyVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteSheetWritingEfficiencyVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetWritingEfficiencyVariables otherTyped = other as DeleteSheetWritingEfficiencyVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteSheetWritingEfficiencyVariables({
    required this.id,
  });
}

