part of 'default.dart';

class DeleteFrameProductionWeightReportVariablesBuilder {
  DeleteFrameProductionWeightReportVariablesId id;

  final FirebaseDataConnect _dataConnect;
  DeleteFrameProductionWeightReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteFrameProductionWeightReportData> dataDeserializer = (dynamic json)  => DeleteFrameProductionWeightReportData.fromJson(jsonDecode(json));
  Serializer<DeleteFrameProductionWeightReportVariables> varsSerializer = (DeleteFrameProductionWeightReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteFrameProductionWeightReportData, DeleteFrameProductionWeightReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteFrameProductionWeightReportData, DeleteFrameProductionWeightReportVariables> ref() {
    DeleteFrameProductionWeightReportVariables vars= DeleteFrameProductionWeightReportVariables(id: id,);
    return _dataConnect.mutation("DeleteFrameProductionWeightReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteFrameProductionWeightReportFrameProductionWeightReportDelete {
  final String id;
  DeleteFrameProductionWeightReportFrameProductionWeightReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameProductionWeightReportFrameProductionWeightReportDelete otherTyped = other as DeleteFrameProductionWeightReportFrameProductionWeightReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteFrameProductionWeightReportFrameProductionWeightReportDelete({
    required this.id,
  });
}

@immutable
class DeleteFrameProductionWeightReportData {
  final DeleteFrameProductionWeightReportFrameProductionWeightReportDelete? frameProductionWeightReport_delete;
  DeleteFrameProductionWeightReportData.fromJson(dynamic json):
  
  frameProductionWeightReport_delete = json['frameProductionWeightReport_delete'] == null ? null : DeleteFrameProductionWeightReportFrameProductionWeightReportDelete.fromJson(json['frameProductionWeightReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameProductionWeightReportData otherTyped = other as DeleteFrameProductionWeightReportData;
    return frameProductionWeightReport_delete == otherTyped.frameProductionWeightReport_delete;
    
  }
  @override
  int get hashCode => frameProductionWeightReport_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (frameProductionWeightReport_delete != null) {
      json['frameProductionWeightReport_delete'] = frameProductionWeightReport_delete!.toJson();
    }
    return json;
  }

  DeleteFrameProductionWeightReportData({
    this.frameProductionWeightReport_delete,
  });
}

@immutable
class DeleteFrameProductionWeightReportVariablesId {
  final String id;
  DeleteFrameProductionWeightReportVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameProductionWeightReportVariablesId otherTyped = other as DeleteFrameProductionWeightReportVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteFrameProductionWeightReportVariablesId({
    required this.id,
  });
}

@immutable
class DeleteFrameProductionWeightReportVariables {
  final DeleteFrameProductionWeightReportVariablesId id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteFrameProductionWeightReportVariables.fromJson(Map<String, dynamic> json):
  
  id = DeleteFrameProductionWeightReportVariablesId.fromJson(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteFrameProductionWeightReportVariables otherTyped = other as DeleteFrameProductionWeightReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    return json;
  }

  DeleteFrameProductionWeightReportVariables({
    required this.id,
  });
}

