part of 'default.dart';

class InsertMasterScrapTargetVariablesBuilder {
  String product;
  double targetKgPerHour;

  final FirebaseDataConnect _dataConnect;
  InsertMasterScrapTargetVariablesBuilder(this._dataConnect, {required  this.product,required  this.targetKgPerHour,});
  Deserializer<InsertMasterScrapTargetData> dataDeserializer = (dynamic json)  => InsertMasterScrapTargetData.fromJson(jsonDecode(json));
  Serializer<InsertMasterScrapTargetVariables> varsSerializer = (InsertMasterScrapTargetVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMasterScrapTargetData, InsertMasterScrapTargetVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMasterScrapTargetData, InsertMasterScrapTargetVariables> ref() {
    InsertMasterScrapTargetVariables vars= InsertMasterScrapTargetVariables(product: product,targetKgPerHour: targetKgPerHour,);
    return _dataConnect.mutation("InsertMasterScrapTarget", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMasterScrapTargetMasterScrapTargetInsert {
  final String id;
  InsertMasterScrapTargetMasterScrapTargetInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterScrapTargetMasterScrapTargetInsert otherTyped = other as InsertMasterScrapTargetMasterScrapTargetInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMasterScrapTargetMasterScrapTargetInsert({
    required this.id,
  });
}

@immutable
class InsertMasterScrapTargetData {
  final InsertMasterScrapTargetMasterScrapTargetInsert masterScrapTarget_insert;
  InsertMasterScrapTargetData.fromJson(dynamic json):
  
  masterScrapTarget_insert = InsertMasterScrapTargetMasterScrapTargetInsert.fromJson(json['masterScrapTarget_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterScrapTargetData otherTyped = other as InsertMasterScrapTargetData;
    return masterScrapTarget_insert == otherTyped.masterScrapTarget_insert;
    
  }
  @override
  int get hashCode => masterScrapTarget_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterScrapTarget_insert'] = masterScrapTarget_insert.toJson();
    return json;
  }

  InsertMasterScrapTargetData({
    required this.masterScrapTarget_insert,
  });
}

@immutable
class InsertMasterScrapTargetVariables {
  final String product;
  final double targetKgPerHour;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMasterScrapTargetVariables.fromJson(Map<String, dynamic> json):
  
  product = nativeFromJson<String>(json['product']),
  targetKgPerHour = nativeFromJson<double>(json['targetKgPerHour']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterScrapTargetVariables otherTyped = other as InsertMasterScrapTargetVariables;
    return product == otherTyped.product && 
    targetKgPerHour == otherTyped.targetKgPerHour;
    
  }
  @override
  int get hashCode => Object.hashAll([product.hashCode, targetKgPerHour.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['product'] = nativeToJson<String>(product);
    json['targetKgPerHour'] = nativeToJson<double>(targetKgPerHour);
    return json;
  }

  InsertMasterScrapTargetVariables({
    required this.product,
    required this.targetKgPerHour,
  });
}

