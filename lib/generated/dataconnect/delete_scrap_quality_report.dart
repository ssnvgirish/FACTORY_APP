part of 'default.dart';

class DeleteScrapQualityReportVariablesBuilder {
  DeleteScrapQualityReportVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteScrapQualityReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteScrapQualityReportData> dataDeserializer = (dynamic json)  => DeleteScrapQualityReportData.fromJson(jsonDecode(json));
  Serializer<DeleteScrapQualityReportVariables> varsSerializer = (DeleteScrapQualityReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteScrapQualityReportData, DeleteScrapQualityReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteScrapQualityReportData, DeleteScrapQualityReportVariables> ref() {
    DeleteScrapQualityReportVariables vars= DeleteScrapQualityReportVariables(id: id,);
    return _dataConnect.mutation("DeleteScrapQualityReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteScrapQualityReportScrapQualityReportDelete {
  final String id;
  DeleteScrapQualityReportScrapQualityReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapQualityReportScrapQualityReportDelete otherTyped = other as DeleteScrapQualityReportScrapQualityReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteScrapQualityReportScrapQualityReportDelete({
    required this.id,
  });
}

@immutable
class DeleteScrapQualityReportData {
  final DeleteScrapQualityReportScrapQualityReportDelete? scrapQualityReport_delete;
  DeleteScrapQualityReportData.fromJson(dynamic json):
  
  scrapQualityReport_delete = json['scrapQualityReport_delete'] == null ? null : DeleteScrapQualityReportScrapQualityReportDelete.fromJson(json['scrapQualityReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapQualityReportData otherTyped = other as DeleteScrapQualityReportData;
    return scrapQualityReport_delete == otherTyped.scrapQualityReport_delete;
    
  }
  @override
  int get hashCode => scrapQualityReport_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (scrapQualityReport_delete != null) {
      json['scrapQualityReport_delete'] = scrapQualityReport_delete!.toJson();
    }
    return json;
  }

  DeleteScrapQualityReportData({
    this.scrapQualityReport_delete,
  });
}

@immutable
class DeleteScrapQualityReportVariablesId {
  final String id;
  DeleteScrapQualityReportVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapQualityReportVariablesId otherTyped = other as DeleteScrapQualityReportVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteScrapQualityReportVariablesId({
    required this.id,
  });
}

@immutable
class DeleteScrapQualityReportVariables {
  final DeleteScrapQualityReportVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteScrapQualityReportVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteScrapQualityReportVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapQualityReportVariables otherTyped = other as DeleteScrapQualityReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteScrapQualityReportVariables({
    required this.id,
  });
}

