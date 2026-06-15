part of 'default.dart';

class CreateFrameCustomerRejectionItemVariablesBuilder {
  CreateFrameCustomerRejectionItemVariablesReportId reportId;
  String section;
  String density;
  String color;
  double length;
  int quantity;
  double perPieceWeight;
  double totalWeight;

  final FirebaseDataConnect _dataConnect;
  CreateFrameCustomerRejectionItemVariablesBuilder(this._dataConnect, {required  this.reportId,required  this.section,required  this.density,required  this.color,required  this.length,required  this.quantity,required  this.perPieceWeight,required  this.totalWeight,});
  Deserializer<CreateFrameCustomerRejectionItemData> dataDeserializer = (dynamic json)  => CreateFrameCustomerRejectionItemData.fromJson(jsonDecode(json));
  Serializer<CreateFrameCustomerRejectionItemVariables> varsSerializer = (CreateFrameCustomerRejectionItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateFrameCustomerRejectionItemData, CreateFrameCustomerRejectionItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateFrameCustomerRejectionItemData, CreateFrameCustomerRejectionItemVariables> ref() {
    CreateFrameCustomerRejectionItemVariables vars= CreateFrameCustomerRejectionItemVariables(reportId: reportId,section: section,density: density,color: color,length: length,quantity: quantity,perPieceWeight: perPieceWeight,totalWeight: totalWeight,);
    return _dataConnect.mutation("CreateFrameCustomerRejectionItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateFrameCustomerRejectionItemFrameCustomerRejectionItemInsert {
  final String id;
  CreateFrameCustomerRejectionItemFrameCustomerRejectionItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameCustomerRejectionItemFrameCustomerRejectionItemInsert otherTyped = other as CreateFrameCustomerRejectionItemFrameCustomerRejectionItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateFrameCustomerRejectionItemFrameCustomerRejectionItemInsert({
    required this.id,
  });
}

@immutable
class CreateFrameCustomerRejectionItemData {
  final CreateFrameCustomerRejectionItemFrameCustomerRejectionItemInsert frameCustomerRejectionItem_insert;
  CreateFrameCustomerRejectionItemData.fromJson(dynamic json):
  
  frameCustomerRejectionItem_insert = CreateFrameCustomerRejectionItemFrameCustomerRejectionItemInsert.fromJson(json['frameCustomerRejectionItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameCustomerRejectionItemData otherTyped = other as CreateFrameCustomerRejectionItemData;
    return frameCustomerRejectionItem_insert == otherTyped.frameCustomerRejectionItem_insert;
    
  }
  @override
  int get hashCode => frameCustomerRejectionItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameCustomerRejectionItem_insert'] = frameCustomerRejectionItem_insert.toJson();
    return json;
  }

  CreateFrameCustomerRejectionItemData({
    required this.frameCustomerRejectionItem_insert,
  });
}

@immutable
class CreateFrameCustomerRejectionItemVariablesReportId {
  final String id;
  CreateFrameCustomerRejectionItemVariablesReportId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameCustomerRejectionItemVariablesReportId otherTyped = other as CreateFrameCustomerRejectionItemVariablesReportId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateFrameCustomerRejectionItemVariablesReportId({
    required this.id,
  });
}

@immutable
class CreateFrameCustomerRejectionItemVariables {
  final CreateFrameCustomerRejectionItemVariablesReportId reportId;
  final String section;
  final String density;
  final String color;
  final double length;
  final int quantity;
  final double perPieceWeight;
  final double totalWeight;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateFrameCustomerRejectionItemVariables.fromJson(Map<String, dynamic> json):
  
  reportId = CreateFrameCustomerRejectionItemVariablesReportId.fromJson(json['reportId']),
  section = nativeFromJson<String>(json['section']),
  density = nativeFromJson<String>(json['density']),
  color = nativeFromJson<String>(json['color']),
  length = nativeFromJson<double>(json['length']),
  quantity = nativeFromJson<int>(json['quantity']),
  perPieceWeight = nativeFromJson<double>(json['perPieceWeight']),
  totalWeight = nativeFromJson<double>(json['totalWeight']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameCustomerRejectionItemVariables otherTyped = other as CreateFrameCustomerRejectionItemVariables;
    return reportId == otherTyped.reportId && 
    section == otherTyped.section && 
    density == otherTyped.density && 
    color == otherTyped.color && 
    length == otherTyped.length && 
    quantity == otherTyped.quantity && 
    perPieceWeight == otherTyped.perPieceWeight && 
    totalWeight == otherTyped.totalWeight;
    
  }
  @override
  int get hashCode => Object.hashAll([reportId.hashCode, section.hashCode, density.hashCode, color.hashCode, length.hashCode, quantity.hashCode, perPieceWeight.hashCode, totalWeight.hashCode]);
  

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
    return json;
  }

  CreateFrameCustomerRejectionItemVariables({
    required this.reportId,
    required this.section,
    required this.density,
    required this.color,
    required this.length,
    required this.quantity,
    required this.perPieceWeight,
    required this.totalWeight,
  });
}

