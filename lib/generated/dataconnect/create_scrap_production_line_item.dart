part of 'default.dart';

class CreateScrapProductionLineItemVariablesBuilder {
  CreateScrapProductionLineItemVariablesReportId reportId;
  String product;
  double weightPerBag;
  int totalBags;
  double totalWeight;

  final FirebaseDataConnect _dataConnect;
  CreateScrapProductionLineItemVariablesBuilder(this._dataConnect, {required  this.reportId,required  this.product,required  this.weightPerBag,required  this.totalBags,required  this.totalWeight,});
  Deserializer<CreateScrapProductionLineItemData> dataDeserializer = (dynamic json)  => CreateScrapProductionLineItemData.fromJson(jsonDecode(json));
  Serializer<CreateScrapProductionLineItemVariables> varsSerializer = (CreateScrapProductionLineItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateScrapProductionLineItemData, CreateScrapProductionLineItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateScrapProductionLineItemData, CreateScrapProductionLineItemVariables> ref() {
    CreateScrapProductionLineItemVariables vars= CreateScrapProductionLineItemVariables(reportId: reportId,product: product,weightPerBag: weightPerBag,totalBags: totalBags,totalWeight: totalWeight,);
    return _dataConnect.mutation("CreateScrapProductionLineItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateScrapProductionLineItemScrapProductionLineItemInsert {
  final String id;
  CreateScrapProductionLineItemScrapProductionLineItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapProductionLineItemScrapProductionLineItemInsert otherTyped = other as CreateScrapProductionLineItemScrapProductionLineItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateScrapProductionLineItemScrapProductionLineItemInsert({
    required this.id,
  });
}

@immutable
class CreateScrapProductionLineItemData {
  final CreateScrapProductionLineItemScrapProductionLineItemInsert scrapProductionLineItem_insert;
  CreateScrapProductionLineItemData.fromJson(dynamic json):
  
  scrapProductionLineItem_insert = CreateScrapProductionLineItemScrapProductionLineItemInsert.fromJson(json['scrapProductionLineItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapProductionLineItemData otherTyped = other as CreateScrapProductionLineItemData;
    return scrapProductionLineItem_insert == otherTyped.scrapProductionLineItem_insert;
    
  }
  @override
  int get hashCode => scrapProductionLineItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapProductionLineItem_insert'] = scrapProductionLineItem_insert.toJson();
    return json;
  }

  CreateScrapProductionLineItemData({
    required this.scrapProductionLineItem_insert,
  });
}

@immutable
class CreateScrapProductionLineItemVariablesReportId {
  final String id;
  CreateScrapProductionLineItemVariablesReportId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapProductionLineItemVariablesReportId otherTyped = other as CreateScrapProductionLineItemVariablesReportId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateScrapProductionLineItemVariablesReportId({
    required this.id,
  });
}

@immutable
class CreateScrapProductionLineItemVariables {
  final CreateScrapProductionLineItemVariablesReportId reportId;
  final String product;
  final double weightPerBag;
  final int totalBags;
  final double totalWeight;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateScrapProductionLineItemVariables.fromJson(Map<String, dynamic> json):
  
  reportId = CreateScrapProductionLineItemVariablesReportId.fromJson(json['reportId']),
  product = nativeFromJson<String>(json['product']),
  weightPerBag = nativeFromJson<double>(json['weightPerBag']),
  totalBags = nativeFromJson<int>(json['totalBags']),
  totalWeight = nativeFromJson<double>(json['totalWeight']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapProductionLineItemVariables otherTyped = other as CreateScrapProductionLineItemVariables;
    return reportId == otherTyped.reportId && 
    product == otherTyped.product && 
    weightPerBag == otherTyped.weightPerBag && 
    totalBags == otherTyped.totalBags && 
    totalWeight == otherTyped.totalWeight;
    
  }
  @override
  int get hashCode => Object.hashAll([reportId.hashCode, product.hashCode, weightPerBag.hashCode, totalBags.hashCode, totalWeight.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['reportId'] = reportId.toJson();
    json['product'] = nativeToJson<String>(product);
    json['weightPerBag'] = nativeToJson<double>(weightPerBag);
    json['totalBags'] = nativeToJson<int>(totalBags);
    json['totalWeight'] = nativeToJson<double>(totalWeight);
    return json;
  }

  CreateScrapProductionLineItemVariables({
    required this.reportId,
    required this.product,
    required this.weightPerBag,
    required this.totalBags,
    required this.totalWeight,
  });
}

