part of 'default.dart';

class CreateSheetCustomerRejectionItemVariablesBuilder {
  CreateSheetCustomerRejectionItemVariablesReportId reportId;
  String thickness;
  String density;
  String color;
  double length;
  double width;
  int quantity;
  double sqft;
  double perPieceWeight;
  double totalWeight;
  double totalRunningFeet;

  final FirebaseDataConnect _dataConnect;
  CreateSheetCustomerRejectionItemVariablesBuilder(this._dataConnect, {required  this.reportId,required  this.thickness,required  this.density,required  this.color,required  this.length,required  this.width,required  this.quantity,required  this.sqft,required  this.perPieceWeight,required  this.totalWeight,required  this.totalRunningFeet,});
  Deserializer<CreateSheetCustomerRejectionItemData> dataDeserializer = (dynamic json)  => CreateSheetCustomerRejectionItemData.fromJson(jsonDecode(json));
  Serializer<CreateSheetCustomerRejectionItemVariables> varsSerializer = (CreateSheetCustomerRejectionItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateSheetCustomerRejectionItemData, CreateSheetCustomerRejectionItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateSheetCustomerRejectionItemData, CreateSheetCustomerRejectionItemVariables> ref() {
    CreateSheetCustomerRejectionItemVariables vars= CreateSheetCustomerRejectionItemVariables(reportId: reportId,thickness: thickness,density: density,color: color,length: length,width: width,quantity: quantity,sqft: sqft,perPieceWeight: perPieceWeight,totalWeight: totalWeight,totalRunningFeet: totalRunningFeet,);
    return _dataConnect.mutation("CreateSheetCustomerRejectionItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateSheetCustomerRejectionItemSheetCustomerRejectionItemInsert {
  final String id;
  CreateSheetCustomerRejectionItemSheetCustomerRejectionItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetCustomerRejectionItemSheetCustomerRejectionItemInsert otherTyped = other as CreateSheetCustomerRejectionItemSheetCustomerRejectionItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetCustomerRejectionItemSheetCustomerRejectionItemInsert({
    required this.id,
  });
}

@immutable
class CreateSheetCustomerRejectionItemData {
  final CreateSheetCustomerRejectionItemSheetCustomerRejectionItemInsert sheetCustomerRejectionItem_insert;
  CreateSheetCustomerRejectionItemData.fromJson(dynamic json):
  
  sheetCustomerRejectionItem_insert = CreateSheetCustomerRejectionItemSheetCustomerRejectionItemInsert.fromJson(json['sheetCustomerRejectionItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetCustomerRejectionItemData otherTyped = other as CreateSheetCustomerRejectionItemData;
    return sheetCustomerRejectionItem_insert == otherTyped.sheetCustomerRejectionItem_insert;
    
  }
  @override
  int get hashCode => sheetCustomerRejectionItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetCustomerRejectionItem_insert'] = sheetCustomerRejectionItem_insert.toJson();
    return json;
  }

  CreateSheetCustomerRejectionItemData({
    required this.sheetCustomerRejectionItem_insert,
  });
}

@immutable
class CreateSheetCustomerRejectionItemVariablesReportId {
  final String id;
  CreateSheetCustomerRejectionItemVariablesReportId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetCustomerRejectionItemVariablesReportId otherTyped = other as CreateSheetCustomerRejectionItemVariablesReportId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetCustomerRejectionItemVariablesReportId({
    required this.id,
  });
}

@immutable
class CreateSheetCustomerRejectionItemVariables {
  final CreateSheetCustomerRejectionItemVariablesReportId reportId;
  final String thickness;
  final String density;
  final String color;
  final double length;
  final double width;
  final int quantity;
  final double sqft;
  final double perPieceWeight;
  final double totalWeight;
  final double totalRunningFeet;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateSheetCustomerRejectionItemVariables.fromJson(Map<String, dynamic> json):
  
  reportId = CreateSheetCustomerRejectionItemVariablesReportId.fromJson(json['reportId']),
  thickness = nativeFromJson<String>(json['thickness']),
  density = nativeFromJson<String>(json['density']),
  color = nativeFromJson<String>(json['color']),
  length = nativeFromJson<double>(json['length']),
  width = nativeFromJson<double>(json['width']),
  quantity = nativeFromJson<int>(json['quantity']),
  sqft = nativeFromJson<double>(json['sqft']),
  perPieceWeight = nativeFromJson<double>(json['perPieceWeight']),
  totalWeight = nativeFromJson<double>(json['totalWeight']),
  totalRunningFeet = nativeFromJson<double>(json['totalRunningFeet']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetCustomerRejectionItemVariables otherTyped = other as CreateSheetCustomerRejectionItemVariables;
    return reportId == otherTyped.reportId && 
    thickness == otherTyped.thickness && 
    density == otherTyped.density && 
    color == otherTyped.color && 
    length == otherTyped.length && 
    width == otherTyped.width && 
    quantity == otherTyped.quantity && 
    sqft == otherTyped.sqft && 
    perPieceWeight == otherTyped.perPieceWeight && 
    totalWeight == otherTyped.totalWeight && 
    totalRunningFeet == otherTyped.totalRunningFeet;
    
  }
  @override
  int get hashCode => Object.hashAll([reportId.hashCode, thickness.hashCode, density.hashCode, color.hashCode, length.hashCode, width.hashCode, quantity.hashCode, sqft.hashCode, perPieceWeight.hashCode, totalWeight.hashCode, totalRunningFeet.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['reportId'] = reportId.toJson();
    json['thickness'] = nativeToJson<String>(thickness);
    json['density'] = nativeToJson<String>(density);
    json['color'] = nativeToJson<String>(color);
    json['length'] = nativeToJson<double>(length);
    json['width'] = nativeToJson<double>(width);
    json['quantity'] = nativeToJson<int>(quantity);
    json['sqft'] = nativeToJson<double>(sqft);
    json['perPieceWeight'] = nativeToJson<double>(perPieceWeight);
    json['totalWeight'] = nativeToJson<double>(totalWeight);
    json['totalRunningFeet'] = nativeToJson<double>(totalRunningFeet);
    return json;
  }

  CreateSheetCustomerRejectionItemVariables({
    required this.reportId,
    required this.thickness,
    required this.density,
    required this.color,
    required this.length,
    required this.width,
    required this.quantity,
    required this.sqft,
    required this.perPieceWeight,
    required this.totalWeight,
    required this.totalRunningFeet,
  });
}

