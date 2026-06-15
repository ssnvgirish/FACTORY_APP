part of 'default.dart';

class CreateFrameProductionLineItemVariablesBuilder {
  CreateFrameProductionLineItemVariablesReportId reportId;
  String section;
  String density;
  String color;
  double length;
  int quantity;
  double perPieceWeight;
  double totalWeight;
  Optional<double> _manualWeightPerFoot = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CreateFrameProductionLineItemVariablesBuilder manualWeightPerFoot(double? t) {
   _manualWeightPerFoot.value = t;
   return this;
  }

  CreateFrameProductionLineItemVariablesBuilder(this._dataConnect, {required  this.reportId,required  this.section,required  this.density,required  this.color,required  this.length,required  this.quantity,required  this.perPieceWeight,required  this.totalWeight,});
  Deserializer<CreateFrameProductionLineItemData> dataDeserializer = (dynamic json)  => CreateFrameProductionLineItemData.fromJson(jsonDecode(json));
  Serializer<CreateFrameProductionLineItemVariables> varsSerializer = (CreateFrameProductionLineItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateFrameProductionLineItemData, CreateFrameProductionLineItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateFrameProductionLineItemData, CreateFrameProductionLineItemVariables> ref() {
    CreateFrameProductionLineItemVariables vars= CreateFrameProductionLineItemVariables(reportId: reportId,section: section,density: density,color: color,length: length,quantity: quantity,perPieceWeight: perPieceWeight,totalWeight: totalWeight,manualWeightPerFoot: _manualWeightPerFoot,);
    return _dataConnect.mutation("CreateFrameProductionLineItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateFrameProductionLineItemFrameProductionLineItemInsert {
  final String id;
  CreateFrameProductionLineItemFrameProductionLineItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameProductionLineItemFrameProductionLineItemInsert otherTyped = other as CreateFrameProductionLineItemFrameProductionLineItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateFrameProductionLineItemFrameProductionLineItemInsert({
    required this.id,
  });
}

@immutable
class CreateFrameProductionLineItemData {
  final CreateFrameProductionLineItemFrameProductionLineItemInsert frameProductionLineItem_insert;
  CreateFrameProductionLineItemData.fromJson(dynamic json):
  
  frameProductionLineItem_insert = CreateFrameProductionLineItemFrameProductionLineItemInsert.fromJson(json['frameProductionLineItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameProductionLineItemData otherTyped = other as CreateFrameProductionLineItemData;
    return frameProductionLineItem_insert == otherTyped.frameProductionLineItem_insert;
    
  }
  @override
  int get hashCode => frameProductionLineItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameProductionLineItem_insert'] = frameProductionLineItem_insert.toJson();
    return json;
  }

  CreateFrameProductionLineItemData({
    required this.frameProductionLineItem_insert,
  });
}

@immutable
class CreateFrameProductionLineItemVariablesReportId {
  final String id;
  CreateFrameProductionLineItemVariablesReportId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameProductionLineItemVariablesReportId otherTyped = other as CreateFrameProductionLineItemVariablesReportId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateFrameProductionLineItemVariablesReportId({
    required this.id,
  });
}

@immutable
class CreateFrameProductionLineItemVariables {
  final CreateFrameProductionLineItemVariablesReportId reportId;
  final String section;
  final String density;
  final String color;
  final double length;
  final int quantity;
  final double perPieceWeight;
  final double totalWeight;
  late final Optional<double>manualWeightPerFoot;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateFrameProductionLineItemVariables.fromJson(Map<String, dynamic> json):
  
  reportId = CreateFrameProductionLineItemVariablesReportId.fromJson(json['reportId']),
  section = nativeFromJson<String>(json['section']),
  density = nativeFromJson<String>(json['density']),
  color = nativeFromJson<String>(json['color']),
  length = nativeFromJson<double>(json['length']),
  quantity = nativeFromJson<int>(json['quantity']),
  perPieceWeight = nativeFromJson<double>(json['perPieceWeight']),
  totalWeight = nativeFromJson<double>(json['totalWeight']) {
  
  
  
  
  
  
  
  
  
  
    manualWeightPerFoot = Optional.optional(nativeFromJson, nativeToJson);
    manualWeightPerFoot.value = json['manualWeightPerFoot'] == null ? null : nativeFromJson<double>(json['manualWeightPerFoot']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameProductionLineItemVariables otherTyped = other as CreateFrameProductionLineItemVariables;
    return reportId == otherTyped.reportId && 
    section == otherTyped.section && 
    density == otherTyped.density && 
    color == otherTyped.color && 
    length == otherTyped.length && 
    quantity == otherTyped.quantity && 
    perPieceWeight == otherTyped.perPieceWeight && 
    totalWeight == otherTyped.totalWeight && 
    manualWeightPerFoot == otherTyped.manualWeightPerFoot;
    
  }
  @override
  int get hashCode => Object.hashAll([reportId.hashCode, section.hashCode, density.hashCode, color.hashCode, length.hashCode, quantity.hashCode, perPieceWeight.hashCode, totalWeight.hashCode, manualWeightPerFoot.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['reportId'] = reportId.toJson();
    json['section'] = nativeToJson<String>(section);
    json['density'] = nativeToJson<String>(density);
    json['color'] = nativeToJson<String>(color);
    json['length'] = nativeToJson<double>(length);
    json['quantity'] = nativeToJson<int>(quantity);
    json['perPieceWeight'] = nativeToJson<double>(perPieceWeight);
    json['totalWeight'] = nativeToJson<double>(totalWeight);
    if(manualWeightPerFoot.state == OptionalState.set) {
      json['manualWeightPerFoot'] = manualWeightPerFoot.toJson();
    }
    return json;
  }

  CreateFrameProductionLineItemVariables({
    required this.reportId,
    required this.section,
    required this.density,
    required this.color,
    required this.length,
    required this.quantity,
    required this.perPieceWeight,
    required this.totalWeight,
    required this.manualWeightPerFoot,
  });
}

