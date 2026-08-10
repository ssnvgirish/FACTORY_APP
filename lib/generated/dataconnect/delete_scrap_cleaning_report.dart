part of 'default.dart';

class DeleteScrapCleaningReportVariablesBuilder {
  DeleteScrapCleaningReportVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteScrapCleaningReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteScrapCleaningReportData> dataDeserializer = (dynamic json)  => DeleteScrapCleaningReportData.fromJson(jsonDecode(json));
  Serializer<DeleteScrapCleaningReportVariables> varsSerializer = (DeleteScrapCleaningReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteScrapCleaningReportData, DeleteScrapCleaningReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteScrapCleaningReportData, DeleteScrapCleaningReportVariables> ref() {
    DeleteScrapCleaningReportVariables vars= DeleteScrapCleaningReportVariables(id: id,);
    return _dataConnect.mutation("DeleteScrapCleaningReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteScrapCleaningReportScrapCleaningReportDelete {
  final String id;
  DeleteScrapCleaningReportScrapCleaningReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapCleaningReportScrapCleaningReportDelete otherTyped = other as DeleteScrapCleaningReportScrapCleaningReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteScrapCleaningReportScrapCleaningReportDelete({
    required this.id,
  });
}

@immutable
class DeleteScrapCleaningReportData {
  final DeleteScrapCleaningReportScrapCleaningReportDelete? scrapCleaningReport_delete;
  DeleteScrapCleaningReportData.fromJson(dynamic json):
  
  scrapCleaningReport_delete = json['scrapCleaningReport_delete'] == null ? null : DeleteScrapCleaningReportScrapCleaningReportDelete.fromJson(json['scrapCleaningReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapCleaningReportData otherTyped = other as DeleteScrapCleaningReportData;
    return scrapCleaningReport_delete == otherTyped.scrapCleaningReport_delete;
    
  }
  @override
  int get hashCode => scrapCleaningReport_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (scrapCleaningReport_delete != null) {
      json['scrapCleaningReport_delete'] = scrapCleaningReport_delete!.toJson();
    }
    return json;
  }

  DeleteScrapCleaningReportData({
    this.scrapCleaningReport_delete,
  });
}

@immutable
class DeleteScrapCleaningReportVariablesId {
  final String id;
  DeleteScrapCleaningReportVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapCleaningReportVariablesId otherTyped = other as DeleteScrapCleaningReportVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteScrapCleaningReportVariablesId({
    required this.id,
  });
}

@immutable
class DeleteScrapCleaningReportVariables {
  final DeleteScrapCleaningReportVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteScrapCleaningReportVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteScrapCleaningReportVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapCleaningReportVariables otherTyped = other as DeleteScrapCleaningReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteScrapCleaningReportVariables({
    required this.id,
  });
}

