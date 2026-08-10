part of 'default.dart';

class DeleteScrapProductionWeightReportVariablesBuilder {
  DeleteScrapProductionWeightReportVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteScrapProductionWeightReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteScrapProductionWeightReportData> dataDeserializer = (dynamic json)  => DeleteScrapProductionWeightReportData.fromJson(jsonDecode(json));
  Serializer<DeleteScrapProductionWeightReportVariables> varsSerializer = (DeleteScrapProductionWeightReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteScrapProductionWeightReportData, DeleteScrapProductionWeightReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteScrapProductionWeightReportData, DeleteScrapProductionWeightReportVariables> ref() {
    DeleteScrapProductionWeightReportVariables vars= DeleteScrapProductionWeightReportVariables(id: id,);
    return _dataConnect.mutation("DeleteScrapProductionWeightReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteScrapProductionWeightReportScrapProductionWeightReportDelete {
  final String id;
  DeleteScrapProductionWeightReportScrapProductionWeightReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapProductionWeightReportScrapProductionWeightReportDelete otherTyped = other as DeleteScrapProductionWeightReportScrapProductionWeightReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteScrapProductionWeightReportScrapProductionWeightReportDelete({
    required this.id,
  });
}

@immutable
class DeleteScrapProductionWeightReportData {
  final DeleteScrapProductionWeightReportScrapProductionWeightReportDelete? scrapProductionWeightReport_delete;
  DeleteScrapProductionWeightReportData.fromJson(dynamic json):
  
  scrapProductionWeightReport_delete = json['scrapProductionWeightReport_delete'] == null ? null : DeleteScrapProductionWeightReportScrapProductionWeightReportDelete.fromJson(json['scrapProductionWeightReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapProductionWeightReportData otherTyped = other as DeleteScrapProductionWeightReportData;
    return scrapProductionWeightReport_delete == otherTyped.scrapProductionWeightReport_delete;
    
  }
  @override
  int get hashCode => scrapProductionWeightReport_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (scrapProductionWeightReport_delete != null) {
      json['scrapProductionWeightReport_delete'] = scrapProductionWeightReport_delete!.toJson();
    }
    return json;
  }

  DeleteScrapProductionWeightReportData({
    this.scrapProductionWeightReport_delete,
  });
}

@immutable
class DeleteScrapProductionWeightReportVariablesId {
  final String id;
  DeleteScrapProductionWeightReportVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapProductionWeightReportVariablesId otherTyped = other as DeleteScrapProductionWeightReportVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteScrapProductionWeightReportVariablesId({
    required this.id,
  });
}

@immutable
class DeleteScrapProductionWeightReportVariables {
  final DeleteScrapProductionWeightReportVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteScrapProductionWeightReportVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteScrapProductionWeightReportVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapProductionWeightReportVariables otherTyped = other as DeleteScrapProductionWeightReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteScrapProductionWeightReportVariables({
    required this.id,
  });
}

