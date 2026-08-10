part of 'default.dart';

class DeleteSheetCleaningReportVariablesBuilder {
  DeleteSheetCleaningReportVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteSheetCleaningReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteSheetCleaningReportData> dataDeserializer = (dynamic json)  => DeleteSheetCleaningReportData.fromJson(jsonDecode(json));
  Serializer<DeleteSheetCleaningReportVariables> varsSerializer = (DeleteSheetCleaningReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteSheetCleaningReportData, DeleteSheetCleaningReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteSheetCleaningReportData, DeleteSheetCleaningReportVariables> ref() {
    DeleteSheetCleaningReportVariables vars= DeleteSheetCleaningReportVariables(id: id,);
    return _dataConnect.mutation("DeleteSheetCleaningReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteSheetCleaningReportSheetCleaningReportDelete {
  final String id;
  DeleteSheetCleaningReportSheetCleaningReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetCleaningReportSheetCleaningReportDelete otherTyped = other as DeleteSheetCleaningReportSheetCleaningReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteSheetCleaningReportSheetCleaningReportDelete({
    required this.id,
  });
}

@immutable
class DeleteSheetCleaningReportData {
  final DeleteSheetCleaningReportSheetCleaningReportDelete? sheetCleaningReport_delete;
  DeleteSheetCleaningReportData.fromJson(dynamic json):
  
  sheetCleaningReport_delete = json['sheetCleaningReport_delete'] == null ? null : DeleteSheetCleaningReportSheetCleaningReportDelete.fromJson(json['sheetCleaningReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetCleaningReportData otherTyped = other as DeleteSheetCleaningReportData;
    return sheetCleaningReport_delete == otherTyped.sheetCleaningReport_delete;
    
  }
  @override
  int get hashCode => sheetCleaningReport_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (sheetCleaningReport_delete != null) {
      json['sheetCleaningReport_delete'] = sheetCleaningReport_delete!.toJson();
    }
    return json;
  }

  DeleteSheetCleaningReportData({
    this.sheetCleaningReport_delete,
  });
}

@immutable
class DeleteSheetCleaningReportVariablesId {
  final String id;
  DeleteSheetCleaningReportVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetCleaningReportVariablesId otherTyped = other as DeleteSheetCleaningReportVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteSheetCleaningReportVariablesId({
    required this.id,
  });
}

@immutable
class DeleteSheetCleaningReportVariables {
  final DeleteSheetCleaningReportVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteSheetCleaningReportVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteSheetCleaningReportVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetCleaningReportVariables otherTyped = other as DeleteSheetCleaningReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteSheetCleaningReportVariables({
    required this.id,
  });
}

