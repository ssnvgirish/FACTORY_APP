part of 'default.dart';

class DeleteScrapToolsCountReportVariablesBuilder {
  DeleteScrapToolsCountReportVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteScrapToolsCountReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteScrapToolsCountReportData> dataDeserializer = (dynamic json)  => DeleteScrapToolsCountReportData.fromJson(jsonDecode(json));
  Serializer<DeleteScrapToolsCountReportVariables> varsSerializer = (DeleteScrapToolsCountReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteScrapToolsCountReportData, DeleteScrapToolsCountReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteScrapToolsCountReportData, DeleteScrapToolsCountReportVariables> ref() {
    DeleteScrapToolsCountReportVariables vars= DeleteScrapToolsCountReportVariables(id: id,);
    return _dataConnect.mutation("DeleteScrapToolsCountReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteScrapToolsCountReportScrapToolsCountReportDelete {
  final String id;
  DeleteScrapToolsCountReportScrapToolsCountReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapToolsCountReportScrapToolsCountReportDelete otherTyped = other as DeleteScrapToolsCountReportScrapToolsCountReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteScrapToolsCountReportScrapToolsCountReportDelete({
    required this.id,
  });
}

@immutable
class DeleteScrapToolsCountReportData {
  final DeleteScrapToolsCountReportScrapToolsCountReportDelete? scrapToolsCountReport_delete;
  DeleteScrapToolsCountReportData.fromJson(dynamic json):
  
  scrapToolsCountReport_delete = json['scrapToolsCountReport_delete'] == null ? null : DeleteScrapToolsCountReportScrapToolsCountReportDelete.fromJson(json['scrapToolsCountReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapToolsCountReportData otherTyped = other as DeleteScrapToolsCountReportData;
    return scrapToolsCountReport_delete == otherTyped.scrapToolsCountReport_delete;
    
  }
  @override
  int get hashCode => scrapToolsCountReport_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (scrapToolsCountReport_delete != null) {
      json['scrapToolsCountReport_delete'] = scrapToolsCountReport_delete!.toJson();
    }
    return json;
  }

  DeleteScrapToolsCountReportData({
    this.scrapToolsCountReport_delete,
  });
}

@immutable
class DeleteScrapToolsCountReportVariablesId {
  final String id;
  DeleteScrapToolsCountReportVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapToolsCountReportVariablesId otherTyped = other as DeleteScrapToolsCountReportVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteScrapToolsCountReportVariablesId({
    required this.id,
  });
}

@immutable
class DeleteScrapToolsCountReportVariables {
  final DeleteScrapToolsCountReportVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteScrapToolsCountReportVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteScrapToolsCountReportVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapToolsCountReportVariables otherTyped = other as DeleteScrapToolsCountReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteScrapToolsCountReportVariables({
    required this.id,
  });
}

