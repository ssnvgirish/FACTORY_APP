part of 'default.dart';

class DeleteSheetToolsCountReportVariablesBuilder {
  DeleteSheetToolsCountReportVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteSheetToolsCountReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteSheetToolsCountReportData> dataDeserializer = (dynamic json)  => DeleteSheetToolsCountReportData.fromJson(jsonDecode(json));
  Serializer<DeleteSheetToolsCountReportVariables> varsSerializer = (DeleteSheetToolsCountReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteSheetToolsCountReportData, DeleteSheetToolsCountReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteSheetToolsCountReportData, DeleteSheetToolsCountReportVariables> ref() {
    DeleteSheetToolsCountReportVariables vars= DeleteSheetToolsCountReportVariables(id: id,);
    return _dataConnect.mutation("DeleteSheetToolsCountReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteSheetToolsCountReportSheetToolsCountReportDelete {
  final String id;
  DeleteSheetToolsCountReportSheetToolsCountReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetToolsCountReportSheetToolsCountReportDelete otherTyped = other as DeleteSheetToolsCountReportSheetToolsCountReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteSheetToolsCountReportSheetToolsCountReportDelete({
    required this.id,
  });
}

@immutable
class DeleteSheetToolsCountReportData {
  final DeleteSheetToolsCountReportSheetToolsCountReportDelete? sheetToolsCountReport_delete;
  DeleteSheetToolsCountReportData.fromJson(dynamic json):
  
  sheetToolsCountReport_delete = json['sheetToolsCountReport_delete'] == null ? null : DeleteSheetToolsCountReportSheetToolsCountReportDelete.fromJson(json['sheetToolsCountReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetToolsCountReportData otherTyped = other as DeleteSheetToolsCountReportData;
    return sheetToolsCountReport_delete == otherTyped.sheetToolsCountReport_delete;
    
  }
  @override
  int get hashCode => sheetToolsCountReport_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (sheetToolsCountReport_delete != null) {
      json['sheetToolsCountReport_delete'] = sheetToolsCountReport_delete!.toJson();
    }
    return json;
  }

  DeleteSheetToolsCountReportData({
    this.sheetToolsCountReport_delete,
  });
}

@immutable
class DeleteSheetToolsCountReportVariablesId {
  final String id;
  DeleteSheetToolsCountReportVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetToolsCountReportVariablesId otherTyped = other as DeleteSheetToolsCountReportVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteSheetToolsCountReportVariablesId({
    required this.id,
  });
}

@immutable
class DeleteSheetToolsCountReportVariables {
  final DeleteSheetToolsCountReportVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteSheetToolsCountReportVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteSheetToolsCountReportVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetToolsCountReportVariables otherTyped = other as DeleteSheetToolsCountReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteSheetToolsCountReportVariables({
    required this.id,
  });
}

