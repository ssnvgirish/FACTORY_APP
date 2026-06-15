part of 'default.dart';

class CreateFramePackingLineItemVariablesBuilder {
  CreateFramePackingLineItemVariablesReportId reportId;
  String section;
  String density;
  String color;
  double length;
  int productionQuantity;
  double perPieceWeight;
  int packed;
  int rejectedQuality;

  final FirebaseDataConnect _dataConnect;
  CreateFramePackingLineItemVariablesBuilder(this._dataConnect, {required  this.reportId,required  this.section,required  this.density,required  this.color,required  this.length,required  this.productionQuantity,required  this.perPieceWeight,required  this.packed,required  this.rejectedQuality,});
  Deserializer<CreateFramePackingLineItemData> dataDeserializer = (dynamic json)  => CreateFramePackingLineItemData.fromJson(jsonDecode(json));
  Serializer<CreateFramePackingLineItemVariables> varsSerializer = (CreateFramePackingLineItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateFramePackingLineItemData, CreateFramePackingLineItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateFramePackingLineItemData, CreateFramePackingLineItemVariables> ref() {
    CreateFramePackingLineItemVariables vars= CreateFramePackingLineItemVariables(reportId: reportId,section: section,density: density,color: color,length: length,productionQuantity: productionQuantity,perPieceWeight: perPieceWeight,packed: packed,rejectedQuality: rejectedQuality,);
    return _dataConnect.mutation("CreateFramePackingLineItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateFramePackingLineItemFramePackingLineItemInsert {
  final String id;
  CreateFramePackingLineItemFramePackingLineItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFramePackingLineItemFramePackingLineItemInsert otherTyped = other as CreateFramePackingLineItemFramePackingLineItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateFramePackingLineItemFramePackingLineItemInsert({
    required this.id,
  });
}

@immutable
class CreateFramePackingLineItemData {
  final CreateFramePackingLineItemFramePackingLineItemInsert framePackingLineItem_insert;
  CreateFramePackingLineItemData.fromJson(dynamic json):
  
  framePackingLineItem_insert = CreateFramePackingLineItemFramePackingLineItemInsert.fromJson(json['framePackingLineItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFramePackingLineItemData otherTyped = other as CreateFramePackingLineItemData;
    return framePackingLineItem_insert == otherTyped.framePackingLineItem_insert;
    
  }
  @override
  int get hashCode => framePackingLineItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['framePackingLineItem_insert'] = framePackingLineItem_insert.toJson();
    return json;
  }

  CreateFramePackingLineItemData({
    required this.framePackingLineItem_insert,
  });
}

@immutable
class CreateFramePackingLineItemVariablesReportId {
  final String id;
  CreateFramePackingLineItemVariablesReportId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFramePackingLineItemVariablesReportId otherTyped = other as CreateFramePackingLineItemVariablesReportId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateFramePackingLineItemVariablesReportId({
    required this.id,
  });
}

@immutable
class CreateFramePackingLineItemVariables {
  final CreateFramePackingLineItemVariablesReportId reportId;
  final String section;
  final String density;
  final String color;
  final double length;
  final int productionQuantity;
  final double perPieceWeight;
  final int packed;
  final int rejectedQuality;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateFramePackingLineItemVariables.fromJson(Map<String, dynamic> json):
  
  reportId = CreateFramePackingLineItemVariablesReportId.fromJson(json['reportId']),
  section = nativeFromJson<String>(json['section']),
  density = nativeFromJson<String>(json['density']),
  color = nativeFromJson<String>(json['color']),
  length = nativeFromJson<double>(json['length']),
  productionQuantity = nativeFromJson<int>(json['productionQuantity']),
  perPieceWeight = nativeFromJson<double>(json['perPieceWeight']),
  packed = nativeFromJson<int>(json['packed']),
  rejectedQuality = nativeFromJson<int>(json['rejectedQuality']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFramePackingLineItemVariables otherTyped = other as CreateFramePackingLineItemVariables;
    return reportId == otherTyped.reportId && 
    section == otherTyped.section && 
    density == otherTyped.density && 
    color == otherTyped.color && 
    length == otherTyped.length && 
    productionQuantity == otherTyped.productionQuantity && 
    perPieceWeight == otherTyped.perPieceWeight && 
    packed == otherTyped.packed && 
    rejectedQuality == otherTyped.rejectedQuality;
    
  }
  @override
  int get hashCode => Object.hashAll([reportId.hashCode, section.hashCode, density.hashCode, color.hashCode, length.hashCode, productionQuantity.hashCode, perPieceWeight.hashCode, packed.hashCode, rejectedQuality.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['reportId'] = reportId.toJson();
    json['section'] = nativeToJson<String>(section);
    json['density'] = nativeToJson<String>(density);
    json['color'] = nativeToJson<String>(color);
    json['length'] = nativeToJson<double>(length);
    json['productionQuantity'] = nativeToJson<int>(productionQuantity);
    json['perPieceWeight'] = nativeToJson<double>(perPieceWeight);
    json['packed'] = nativeToJson<int>(packed);
    json['rejectedQuality'] = nativeToJson<int>(rejectedQuality);
    return json;
  }

  CreateFramePackingLineItemVariables({
    required this.reportId,
    required this.section,
    required this.density,
    required this.color,
    required this.length,
    required this.productionQuantity,
    required this.perPieceWeight,
    required this.packed,
    required this.rejectedQuality,
  });
}

