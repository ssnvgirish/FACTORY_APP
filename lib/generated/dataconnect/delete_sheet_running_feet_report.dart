part of 'default.dart';

class DeleteSheetRunningFeetReportVariablesBuilder {
  DeleteSheetRunningFeetReportVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteSheetRunningFeetReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteSheetRunningFeetReportData> dataDeserializer = (dynamic json)  => DeleteSheetRunningFeetReportData.fromJson(jsonDecode(json));
  Serializer<DeleteSheetRunningFeetReportVariables> varsSerializer = (DeleteSheetRunningFeetReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteSheetRunningFeetReportData, DeleteSheetRunningFeetReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteSheetRunningFeetReportData, DeleteSheetRunningFeetReportVariables> ref() {
    DeleteSheetRunningFeetReportVariables vars= DeleteSheetRunningFeetReportVariables(id: id,);
    return _dataConnect.mutation("DeleteSheetRunningFeetReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteSheetRunningFeetReportSheetRunningFeetReportDelete {
  final String id;
  DeleteSheetRunningFeetReportSheetRunningFeetReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetRunningFeetReportSheetRunningFeetReportDelete otherTyped = other as DeleteSheetRunningFeetReportSheetRunningFeetReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteSheetRunningFeetReportSheetRunningFeetReportDelete({
    required this.id,
  });
}

@immutable
class DeleteSheetRunningFeetReportData {
  final DeleteSheetRunningFeetReportSheetRunningFeetReportDelete? sheetRunningFeetReport_delete;
  DeleteSheetRunningFeetReportData.fromJson(dynamic json):
  
  sheetRunningFeetReport_delete = json['sheetRunningFeetReport_delete'] == null ? null : DeleteSheetRunningFeetReportSheetRunningFeetReportDelete.fromJson(json['sheetRunningFeetReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetRunningFeetReportData otherTyped = other as DeleteSheetRunningFeetReportData;
    return sheetRunningFeetReport_delete == otherTyped.sheetRunningFeetReport_delete;
    
  }
  @override
  int get hashCode => sheetRunningFeetReport_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (sheetRunningFeetReport_delete != null) {
      json['sheetRunningFeetReport_delete'] = sheetRunningFeetReport_delete!.toJson();
    }
    return json;
  }

  DeleteSheetRunningFeetReportData({
    this.sheetRunningFeetReport_delete,
  });
}

@immutable
class DeleteSheetRunningFeetReportVariablesId {
  final String id;
  DeleteSheetRunningFeetReportVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetRunningFeetReportVariablesId otherTyped = other as DeleteSheetRunningFeetReportVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteSheetRunningFeetReportVariablesId({
    required this.id,
  });
}

@immutable
class DeleteSheetRunningFeetReportVariables {
  final DeleteSheetRunningFeetReportVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteSheetRunningFeetReportVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteSheetRunningFeetReportVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetRunningFeetReportVariables otherTyped = other as DeleteSheetRunningFeetReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteSheetRunningFeetReportVariables({
    required this.id,
  });
}

