part of 'default.dart';

class DeleteSheetHealthReportVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteSheetHealthReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteSheetHealthReportData> dataDeserializer = (dynamic json)  => DeleteSheetHealthReportData.fromJson(jsonDecode(json));
  Serializer<DeleteSheetHealthReportVariables> varsSerializer = (DeleteSheetHealthReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteSheetHealthReportData, DeleteSheetHealthReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteSheetHealthReportData, DeleteSheetHealthReportVariables> ref() {
    DeleteSheetHealthReportVariables vars= DeleteSheetHealthReportVariables(id: id,);
    return _dataConnect.mutation("DeleteSheetHealthReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteSheetHealthReportSheetHealthReportDelete {
  final String id;
  DeleteSheetHealthReportSheetHealthReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetHealthReportSheetHealthReportDelete otherTyped = other as DeleteSheetHealthReportSheetHealthReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteSheetHealthReportSheetHealthReportDelete({
    required this.id,
  });
}

@immutable
class DeleteSheetHealthReportData {
  final int sheetMaintenanceEntry_deleteMany;
  final DeleteSheetHealthReportSheetHealthReportDelete? sheetHealthReport_delete;
  DeleteSheetHealthReportData.fromJson(dynamic json):
  
  sheetMaintenanceEntry_deleteMany = nativeFromJson<int>(json['sheetMaintenanceEntry_deleteMany']),
  sheetHealthReport_delete = json['sheetHealthReport_delete'] == null ? null : DeleteSheetHealthReportSheetHealthReportDelete.fromJson(json['sheetHealthReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetHealthReportData otherTyped = other as DeleteSheetHealthReportData;
    return sheetMaintenanceEntry_deleteMany == otherTyped.sheetMaintenanceEntry_deleteMany && 
    sheetHealthReport_delete == otherTyped.sheetHealthReport_delete;
    
  }
  @override
  int get hashCode => Object.hashAll([sheetMaintenanceEntry_deleteMany.hashCode, sheetHealthReport_delete.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetMaintenanceEntry_deleteMany'] = nativeToJson<int>(sheetMaintenanceEntry_deleteMany);
    if (sheetHealthReport_delete != null) {
      json['sheetHealthReport_delete'] = sheetHealthReport_delete!.toJson();
    }
    return json;
  }

  DeleteSheetHealthReportData({
    required this.sheetMaintenanceEntry_deleteMany,
    this.sheetHealthReport_delete,
  });
}

@immutable
class DeleteSheetHealthReportVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteSheetHealthReportVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetHealthReportVariables otherTyped = other as DeleteSheetHealthReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteSheetHealthReportVariables({
    required this.id,
  });
}

