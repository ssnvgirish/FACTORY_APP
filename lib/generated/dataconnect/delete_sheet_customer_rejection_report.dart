part of 'default.dart';

class DeleteSheetCustomerRejectionReportVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteSheetCustomerRejectionReportVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteSheetCustomerRejectionReportData> dataDeserializer = (dynamic json)  => DeleteSheetCustomerRejectionReportData.fromJson(jsonDecode(json));
  Serializer<DeleteSheetCustomerRejectionReportVariables> varsSerializer = (DeleteSheetCustomerRejectionReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteSheetCustomerRejectionReportData, DeleteSheetCustomerRejectionReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteSheetCustomerRejectionReportData, DeleteSheetCustomerRejectionReportVariables> ref() {
    DeleteSheetCustomerRejectionReportVariables vars= DeleteSheetCustomerRejectionReportVariables(id: id,);
    return _dataConnect.mutation("DeleteSheetCustomerRejectionReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteSheetCustomerRejectionReportSheetCustomerRejectionReportDelete {
  final String id;
  DeleteSheetCustomerRejectionReportSheetCustomerRejectionReportDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetCustomerRejectionReportSheetCustomerRejectionReportDelete otherTyped = other as DeleteSheetCustomerRejectionReportSheetCustomerRejectionReportDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteSheetCustomerRejectionReportSheetCustomerRejectionReportDelete({
    required this.id,
  });
}

@immutable
class DeleteSheetCustomerRejectionReportData {
  final int sheetCustomerRejectionItem_deleteMany;
  final DeleteSheetCustomerRejectionReportSheetCustomerRejectionReportDelete? sheetCustomerRejectionReport_delete;
  DeleteSheetCustomerRejectionReportData.fromJson(dynamic json):
  
  sheetCustomerRejectionItem_deleteMany = nativeFromJson<int>(json['sheetCustomerRejectionItem_deleteMany']),
  sheetCustomerRejectionReport_delete = json['sheetCustomerRejectionReport_delete'] == null ? null : DeleteSheetCustomerRejectionReportSheetCustomerRejectionReportDelete.fromJson(json['sheetCustomerRejectionReport_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetCustomerRejectionReportData otherTyped = other as DeleteSheetCustomerRejectionReportData;
    return sheetCustomerRejectionItem_deleteMany == otherTyped.sheetCustomerRejectionItem_deleteMany && 
    sheetCustomerRejectionReport_delete == otherTyped.sheetCustomerRejectionReport_delete;
    
  }
  @override
  int get hashCode => Object.hashAll([sheetCustomerRejectionItem_deleteMany.hashCode, sheetCustomerRejectionReport_delete.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetCustomerRejectionItem_deleteMany'] = nativeToJson<int>(sheetCustomerRejectionItem_deleteMany);
    if (sheetCustomerRejectionReport_delete != null) {
      json['sheetCustomerRejectionReport_delete'] = sheetCustomerRejectionReport_delete!.toJson();
    }
    return json;
  }

  DeleteSheetCustomerRejectionReportData({
    required this.sheetCustomerRejectionItem_deleteMany,
    this.sheetCustomerRejectionReport_delete,
  });
}

@immutable
class DeleteSheetCustomerRejectionReportVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteSheetCustomerRejectionReportVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteSheetCustomerRejectionReportVariables otherTyped = other as DeleteSheetCustomerRejectionReportVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteSheetCustomerRejectionReportVariables({
    required this.id,
  });
}

