part of 'default.dart';

class DeleteSheetShiftPackingReportVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteSheetShiftPackingReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteSheetShiftPackingReportData> dataDeserializer = (dynamic json)  => DeleteSheetShiftPackingReportData.fromJson(jsonDecode(json));
  Serializer<DeleteSheetShiftPackingReportVariables> varsSerializer = (DeleteSheetShiftPackingReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteSheetShiftPackingReportData, DeleteSheetShiftPackingReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteSheetShiftPackingReportData, DeleteSheetShiftPackingReportVariables> ref() {
    DeleteSheetShiftPackingReportVariables vars= DeleteSheetShiftPackingReportVariables(id: id,);
    return _dataConnect.mutation("DeleteSheetShiftPackingReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteSheetShiftPackingReportSheetShiftPackingReportDelete {
  final String id;
  DeleteSheetShiftPackingReportSheetShiftPackingReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetShiftPackingReportSheetShiftPackingReportDelete otherTyped = other as DeleteSheetShiftPackingReportSheetShiftPackingReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteSheetShiftPackingReportSheetShiftPackingReportDelete({
    required this.id,
  });
}

@immutable
class DeleteSheetShiftPackingReportData {
  final int sheetPackingLineItem_deleteMany;
  final DeleteSheetShiftPackingReportSheetShiftPackingReportDelete? sheetShiftPackingReport_delete;
  DeleteSheetShiftPackingReportData.fromJson(dynamic json):
  
  sheetPackingLineItem_deleteMany = nativeFromJson<int>(json['sheetPackingLineItem_deleteMany']),
  sheetShiftPackingReport_delete = json['sheetShiftPackingReport_delete'] == null ? null : DeleteSheetShiftPackingReportSheetShiftPackingReportDelete.fromJson(json['sheetShiftPackingReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetShiftPackingReportData otherTyped = other as DeleteSheetShiftPackingReportData;
    return sheetPackingLineItem_deleteMany == otherTyped.sheetPackingLineItem_deleteMany && 
    sheetShiftPackingReport_delete == otherTyped.sheetShiftPackingReport_delete;
    
  }
  @override
  int get hashCode => Object.hashAll([sheetPackingLineItem_deleteMany.hashCode, sheetShiftPackingReport_delete.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetPackingLineItem_deleteMany'] = nativeToJson<int>(sheetPackingLineItem_deleteMany);
    if (sheetShiftPackingReport_delete != null) {
      json['sheetShiftPackingReport_delete'] = sheetShiftPackingReport_delete!.toJson();
    }
    return json;
  }

  DeleteSheetShiftPackingReportData({
    required this.sheetPackingLineItem_deleteMany,
    this.sheetShiftPackingReport_delete,
  });
}

@immutable
class DeleteSheetShiftPackingReportVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteSheetShiftPackingReportVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetShiftPackingReportVariables otherTyped = other as DeleteSheetShiftPackingReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteSheetShiftPackingReportVariables({
    required this.id,
  });
}

