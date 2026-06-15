part of 'default.dart';

class CreateSheetProductionLineItemVariablesBuilder {
  CreateSheetProductionLineItemVariablesReportId reportId;
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
  Optional<Timestamp> _timeOfChange = Optional.optional((json) => json['timeOfChange'] = Timestamp.fromJson(json['timeOfChange']), defaultSerializer);
  Optional<double> _manualWeightPerSqft = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CreateSheetProductionLineItemVariablesBuilder timeOfChange(Timestamp? t) {
   _timeOfChange.value = t;
   return this;
  }
  CreateSheetProductionLineItemVariablesBuilder manualWeightPerSqft(double? t) {
   _manualWeightPerSqft.value = t;
   return this;
  }

  CreateSheetProductionLineItemVariablesBuilder(this._dataConnect, {required  this.reportId,required  this.thickness,required  this.density,required  this.color,required  this.length,required  this.width,required  this.quantity,required  this.sqft,required  this.perPieceWeight,required  this.totalWeight,required  this.totalRunningFeet,});
  Deserializer<CreateSheetProductionLineItemData> dataDeserializer = (dynamic json)  => CreateSheetProductionLineItemData.fromJson(jsonDecode(json));
  Serializer<CreateSheetProductionLineItemVariables> varsSerializer = (CreateSheetProductionLineItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateSheetProductionLineItemData, CreateSheetProductionLineItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateSheetProductionLineItemData, CreateSheetProductionLineItemVariables> ref() {
    CreateSheetProductionLineItemVariables vars= CreateSheetProductionLineItemVariables(reportId: reportId,thickness: thickness,density: density,color: color,length: length,width: width,quantity: quantity,sqft: sqft,perPieceWeight: perPieceWeight,totalWeight: totalWeight,totalRunningFeet: totalRunningFeet,timeOfChange: _timeOfChange,manualWeightPerSqft: _manualWeightPerSqft,);
    return _dataConnect.mutation("CreateSheetProductionLineItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateSheetProductionLineItemSheetProductionLineItemInsert {
  final String id;
  CreateSheetProductionLineItemSheetProductionLineItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetProductionLineItemSheetProductionLineItemInsert otherTyped = other as CreateSheetProductionLineItemSheetProductionLineItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetProductionLineItemSheetProductionLineItemInsert({
    required this.id,
  });
}

@immutable
class CreateSheetProductionLineItemData {
  final CreateSheetProductionLineItemSheetProductionLineItemInsert sheetProductionLineItem_insert;
  CreateSheetProductionLineItemData.fromJson(dynamic json):
  
  sheetProductionLineItem_insert = CreateSheetProductionLineItemSheetProductionLineItemInsert.fromJson(json['sheetProductionLineItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetProductionLineItemData otherTyped = other as CreateSheetProductionLineItemData;
    return sheetProductionLineItem_insert == otherTyped.sheetProductionLineItem_insert;
    
  }
  @override
  int get hashCode => sheetProductionLineItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetProductionLineItem_insert'] = sheetProductionLineItem_insert.toJson();
    return json;
  }

  CreateSheetProductionLineItemData({
    required this.sheetProductionLineItem_insert,
  });
}

@immutable
class CreateSheetProductionLineItemVariablesReportId {
  final String id;
  CreateSheetProductionLineItemVariablesReportId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetProductionLineItemVariablesReportId otherTyped = other as CreateSheetProductionLineItemVariablesReportId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetProductionLineItemVariablesReportId({
    required this.id,
  });
}

@immutable
class CreateSheetProductionLineItemVariables {
  final CreateSheetProductionLineItemVariablesReportId reportId;
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
  late final Optional<Timestamp>timeOfChange;
  late final Optional<double>manualWeightPerSqft;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateSheetProductionLineItemVariables.fromJson(Map<String, dynamic> json):
  
  reportId = CreateSheetProductionLineItemVariablesReportId.fromJson(json['reportId']),
  thickness = nativeFromJson<String>(json['thickness']),
  density = nativeFromJson<String>(json['density']),
  color = nativeFromJson<String>(json['color']),
  length = nativeFromJson<double>(json['length']),
  width = nativeFromJson<double>(json['width']),
  quantity = nativeFromJson<int>(json['quantity']),
  sqft = nativeFromJson<double>(json['sqft']),
  perPieceWeight = nativeFromJson<double>(json['perPieceWeight']),
  totalWeight = nativeFromJson<double>(json['totalWeight']),
  totalRunningFeet = nativeFromJson<double>(json['totalRunningFeet']) {
  
  
  
  
  
  
  
  
  
  
  
  
  
    timeOfChange = Optional.optional((json) => json['timeOfChange'] = Timestamp.fromJson(json['timeOfChange']), defaultSerializer);
    timeOfChange.value = json['timeOfChange'] == null ? null : Timestamp.fromJson(json['timeOfChange']);
  
  
    manualWeightPerSqft = Optional.optional(nativeFromJson, nativeToJson);
    manualWeightPerSqft.value = json['manualWeightPerSqft'] == null ? null : nativeFromJson<double>(json['manualWeightPerSqft']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetProductionLineItemVariables otherTyped = other as CreateSheetProductionLineItemVariables;
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
    totalRunningFeet == otherTyped.totalRunningFeet && 
    timeOfChange == otherTyped.timeOfChange && 
    manualWeightPerSqft == otherTyped.manualWeightPerSqft;
    
  }
  @override
  int get hashCode => Object.hashAll([reportId.hashCode, thickness.hashCode, density.hashCode, color.hashCode, length.hashCode, width.hashCode, quantity.hashCode, sqft.hashCode, perPieceWeight.hashCode, totalWeight.hashCode, totalRunningFeet.hashCode, timeOfChange.hashCode, manualWeightPerSqft.hashCode]);
  

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
    if(timeOfChange.state == OptionalState.set) {
      json['timeOfChange'] = timeOfChange.toJson();
    }
    if(manualWeightPerSqft.state == OptionalState.set) {
      json['manualWeightPerSqft'] = manualWeightPerSqft.toJson();
    }
    return json;
  }

  CreateSheetProductionLineItemVariables({
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
    required this.timeOfChange,
    required this.manualWeightPerSqft,
  });
}

