part of 'default.dart';

class DeleteScrapProductionDetailsReportVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteScrapProductionDetailsReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteScrapProductionDetailsReportData> dataDeserializer = (dynamic json)  => DeleteScrapProductionDetailsReportData.fromJson(jsonDecode(json));
  Serializer<DeleteScrapProductionDetailsReportVariables> varsSerializer = (DeleteScrapProductionDetailsReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteScrapProductionDetailsReportData, DeleteScrapProductionDetailsReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteScrapProductionDetailsReportData, DeleteScrapProductionDetailsReportVariables> ref() {
    DeleteScrapProductionDetailsReportVariables vars= DeleteScrapProductionDetailsReportVariables(id: id,);
    return _dataConnect.mutation("DeleteScrapProductionDetailsReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteScrapProductionDetailsReportScrapProductionDetailsReportDelete {
  final String id;
  DeleteScrapProductionDetailsReportScrapProductionDetailsReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapProductionDetailsReportScrapProductionDetailsReportDelete otherTyped = other as DeleteScrapProductionDetailsReportScrapProductionDetailsReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteScrapProductionDetailsReportScrapProductionDetailsReportDelete({
    required this.id,
  });
}

@immutable
class DeleteScrapProductionDetailsReportData {
  final int scrapProductionLineItem_deleteMany;
  final DeleteScrapProductionDetailsReportScrapProductionDetailsReportDelete? scrapProductionDetailsReport_delete;
  DeleteScrapProductionDetailsReportData.fromJson(dynamic json):
  
  scrapProductionLineItem_deleteMany = nativeFromJson<int>(json['scrapProductionLineItem_deleteMany']),
  scrapProductionDetailsReport_delete = json['scrapProductionDetailsReport_delete'] == null ? null : DeleteScrapProductionDetailsReportScrapProductionDetailsReportDelete.fromJson(json['scrapProductionDetailsReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapProductionDetailsReportData otherTyped = other as DeleteScrapProductionDetailsReportData;
    return scrapProductionLineItem_deleteMany == otherTyped.scrapProductionLineItem_deleteMany && 
    scrapProductionDetailsReport_delete == otherTyped.scrapProductionDetailsReport_delete;
    
  }
  @override
  int get hashCode => Object.hashAll([scrapProductionLineItem_deleteMany.hashCode, scrapProductionDetailsReport_delete.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapProductionLineItem_deleteMany'] = nativeToJson<int>(scrapProductionLineItem_deleteMany);
    if (scrapProductionDetailsReport_delete != null) {
      json['scrapProductionDetailsReport_delete'] = scrapProductionDetailsReport_delete!.toJson();
    }
    return json;
  }

  DeleteScrapProductionDetailsReportData({
    required this.scrapProductionLineItem_deleteMany,
    this.scrapProductionDetailsReport_delete,
  });
}

@immutable
class DeleteScrapProductionDetailsReportVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteScrapProductionDetailsReportVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteScrapProductionDetailsReportVariables otherTyped = other as DeleteScrapProductionDetailsReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteScrapProductionDetailsReportVariables({
    required this.id,
  });
}

