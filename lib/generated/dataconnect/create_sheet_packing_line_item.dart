part of 'default.dart';

class CreateSheetPackingLineItemVariablesBuilder {
  CreateSheetPackingLineItemVariablesReportId reportId;
  String thickness;
  String density;
  String color;
  double length;
  double width;
  int productionQuantity;
  double perPieceWeight;
  double runningFeetPerItem;
  int packed;
  int onlySanding;
  int sandingAndPacked;
  int rejectedQuality;

  final FirebaseDataConnect _dataConnect;
  CreateSheetPackingLineItemVariablesBuilder(this._dataConnect, {required  this.reportId,required  this.thickness,required  this.density,required  this.color,required  this.length,required  this.width,required  this.productionQuantity,required  this.perPieceWeight,required  this.runningFeetPerItem,required  this.packed,required  this.onlySanding,required  this.sandingAndPacked,required  this.rejectedQuality,});
  Deserializer<CreateSheetPackingLineItemData> dataDeserializer = (dynamic json)  => CreateSheetPackingLineItemData.fromJson(jsonDecode(json));
  Serializer<CreateSheetPackingLineItemVariables> varsSerializer = (CreateSheetPackingLineItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateSheetPackingLineItemData, CreateSheetPackingLineItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateSheetPackingLineItemData, CreateSheetPackingLineItemVariables> ref() {
    CreateSheetPackingLineItemVariables vars= CreateSheetPackingLineItemVariables(reportId: reportId,thickness: thickness,density: density,color: color,length: length,width: width,productionQuantity: productionQuantity,perPieceWeight: perPieceWeight,runningFeetPerItem: runningFeetPerItem,packed: packed,onlySanding: onlySanding,sandingAndPacked: sandingAndPacked,rejectedQuality: rejectedQuality,);
    return _dataConnect.mutation("CreateSheetPackingLineItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateSheetPackingLineItemSheetPackingLineItemInsert {
  final String id;
  CreateSheetPackingLineItemSheetPackingLineItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetPackingLineItemSheetPackingLineItemInsert otherTyped = other as CreateSheetPackingLineItemSheetPackingLineItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetPackingLineItemSheetPackingLineItemInsert({
    required this.id,
  });
}

@immutable
class CreateSheetPackingLineItemData {
  final CreateSheetPackingLineItemSheetPackingLineItemInsert sheetPackingLineItem_insert;
  CreateSheetPackingLineItemData.fromJson(dynamic json):
  
  sheetPackingLineItem_insert = CreateSheetPackingLineItemSheetPackingLineItemInsert.fromJson(json['sheetPackingLineItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetPackingLineItemData otherTyped = other as CreateSheetPackingLineItemData;
    return sheetPackingLineItem_insert == otherTyped.sheetPackingLineItem_insert;
    
  }
  @override
  int get hashCode => sheetPackingLineItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetPackingLineItem_insert'] = sheetPackingLineItem_insert.toJson();
    return json;
  }

  CreateSheetPackingLineItemData({
    required this.sheetPackingLineItem_insert,
  });
}

@immutable
class CreateSheetPackingLineItemVariablesReportId {
  final String id;
  CreateSheetPackingLineItemVariablesReportId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetPackingLineItemVariablesReportId otherTyped = other as CreateSheetPackingLineItemVariablesReportId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetPackingLineItemVariablesReportId({
    required this.id,
  });
}

@immutable
class CreateSheetPackingLineItemVariables {
  final CreateSheetPackingLineItemVariablesReportId reportId;
  final String thickness;
  final String density;
  final String color;
  final double length;
  final double width;
  final int productionQuantity;
  final double perPieceWeight;
  final double runningFeetPerItem;
  final int packed;
  final int onlySanding;
  final int sandingAndPacked;
  final int rejectedQuality;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateSheetPackingLineItemVariables.fromJson(Map<String, dynamic> json):
  
  reportId = CreateSheetPackingLineItemVariablesReportId.fromJson(json['reportId']),
  thickness = nativeFromJson<String>(json['thickness']),
  density = nativeFromJson<String>(json['density']),
  color = nativeFromJson<String>(json['color']),
  length = nativeFromJson<double>(json['length']),
  width = nativeFromJson<double>(json['width']),
  productionQuantity = nativeFromJson<int>(json['productionQuantity']),
  perPieceWeight = nativeFromJson<double>(json['perPieceWeight']),
  runningFeetPerItem = nativeFromJson<double>(json['runningFeetPerItem']),
  packed = nativeFromJson<int>(json['packed']),
  onlySanding = nativeFromJson<int>(json['onlySanding']),
  sandingAndPacked = nativeFromJson<int>(json['sandingAndPacked']),
  rejectedQuality = nativeFromJson<int>(json['rejectedQuality']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetPackingLineItemVariables otherTyped = other as CreateSheetPackingLineItemVariables;
    return reportId == otherTyped.reportId && 
    thickness == otherTyped.thickness && 
    density == otherTyped.density && 
    color == otherTyped.color && 
    length == otherTyped.length && 
    width == otherTyped.width && 
    productionQuantity == otherTyped.productionQuantity && 
    perPieceWeight == otherTyped.perPieceWeight && 
    runningFeetPerItem == otherTyped.runningFeetPerItem && 
    packed == otherTyped.packed && 
    onlySanding == otherTyped.onlySanding && 
    sandingAndPacked == otherTyped.sandingAndPacked && 
    rejectedQuality == otherTyped.rejectedQuality;
    
  }
  @override
  int get hashCode => Object.hashAll([reportId.hashCode, thickness.hashCode, density.hashCode, color.hashCode, length.hashCode, width.hashCode, productionQuantity.hashCode, perPieceWeight.hashCode, runningFeetPerItem.hashCode, packed.hashCode, onlySanding.hashCode, sandingAndPacked.hashCode, rejectedQuality.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['reportId'] = reportId.toJson();
    json['thickness'] = nativeToJson<String>(thickness);
    json['density'] = nativeToJson<String>(density);
    json['color'] = nativeToJson<String>(color);
    json['length'] = nativeToJson<double>(length);
    json['width'] = nativeToJson<double>(width);
    json['productionQuantity'] = nativeToJson<int>(productionQuantity);
    json['perPieceWeight'] = nativeToJson<double>(perPieceWeight);
    json['runningFeetPerItem'] = nativeToJson<double>(runningFeetPerItem);
    json['packed'] = nativeToJson<int>(packed);
    json['onlySanding'] = nativeToJson<int>(onlySanding);
    json['sandingAndPacked'] = nativeToJson<int>(sandingAndPacked);
    json['rejectedQuality'] = nativeToJson<int>(rejectedQuality);
    return json;
  }

  CreateSheetPackingLineItemVariables({
    required this.reportId,
    required this.thickness,
    required this.density,
    required this.color,
    required this.length,
    required this.width,
    required this.productionQuantity,
    required this.perPieceWeight,
    required this.runningFeetPerItem,
    required this.packed,
    required this.onlySanding,
    required this.sandingAndPacked,
    required this.rejectedQuality,
  });
}

