part of 'default.dart';

class DeleteSheetProductionDetailsReportVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteSheetProductionDetailsReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteSheetProductionDetailsReportData> dataDeserializer = (dynamic json)  => DeleteSheetProductionDetailsReportData.fromJson(jsonDecode(json));
  Serializer<DeleteSheetProductionDetailsReportVariables> varsSerializer = (DeleteSheetProductionDetailsReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteSheetProductionDetailsReportData, DeleteSheetProductionDetailsReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteSheetProductionDetailsReportData, DeleteSheetProductionDetailsReportVariables> ref() {
    DeleteSheetProductionDetailsReportVariables vars= DeleteSheetProductionDetailsReportVariables(id: id,);
    return _dataConnect.mutation("DeleteSheetProductionDetailsReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteSheetProductionDetailsReportSheetProductionDetailsReportDelete {
  final String id;
  DeleteSheetProductionDetailsReportSheetProductionDetailsReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetProductionDetailsReportSheetProductionDetailsReportDelete otherTyped = other as DeleteSheetProductionDetailsReportSheetProductionDetailsReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteSheetProductionDetailsReportSheetProductionDetailsReportDelete({
    required this.id,
  });
}

@immutable
class DeleteSheetProductionDetailsReportData {
  final int sheetProductionLineItem_deleteMany;
  final DeleteSheetProductionDetailsReportSheetProductionDetailsReportDelete? sheetProductionDetailsReport_delete;
  DeleteSheetProductionDetailsReportData.fromJson(dynamic json):
  
  sheetProductionLineItem_deleteMany = nativeFromJson<int>(json['sheetProductionLineItem_deleteMany']),
  sheetProductionDetailsReport_delete = json['sheetProductionDetailsReport_delete'] == null ? null : DeleteSheetProductionDetailsReportSheetProductionDetailsReportDelete.fromJson(json['sheetProductionDetailsReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetProductionDetailsReportData otherTyped = other as DeleteSheetProductionDetailsReportData;
    return sheetProductionLineItem_deleteMany == otherTyped.sheetProductionLineItem_deleteMany && 
    sheetProductionDetailsReport_delete == otherTyped.sheetProductionDetailsReport_delete;
    
  }
  @override
  int get hashCode => Object.hashAll([sheetProductionLineItem_deleteMany.hashCode, sheetProductionDetailsReport_delete.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetProductionLineItem_deleteMany'] = nativeToJson<int>(sheetProductionLineItem_deleteMany);
    if (sheetProductionDetailsReport_delete != null) {
      json['sheetProductionDetailsReport_delete'] = sheetProductionDetailsReport_delete!.toJson();
    }
    return json;
  }

  DeleteSheetProductionDetailsReportData({
    required this.sheetProductionLineItem_deleteMany,
    this.sheetProductionDetailsReport_delete,
  });
}

@immutable
class DeleteSheetProductionDetailsReportVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteSheetProductionDetailsReportVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetProductionDetailsReportVariables otherTyped = other as DeleteSheetProductionDetailsReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteSheetProductionDetailsReportVariables({
    required this.id,
  });
}

