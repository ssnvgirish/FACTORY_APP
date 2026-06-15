part of 'default.dart';

class InsertMasterScrapProductVariablesBuilder {
  String name;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  InsertMasterScrapProductVariablesBuilder(this._dataConnect, {required  this.name,required  this.sortOrder,required  this.isActive,});
  Deserializer<InsertMasterScrapProductData> dataDeserializer = (dynamic json)  => InsertMasterScrapProductData.fromJson(jsonDecode(json));
  Serializer<InsertMasterScrapProductVariables> varsSerializer = (InsertMasterScrapProductVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMasterScrapProductData, InsertMasterScrapProductVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMasterScrapProductData, InsertMasterScrapProductVariables> ref() {
    InsertMasterScrapProductVariables vars= InsertMasterScrapProductVariables(name: name,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("InsertMasterScrapProduct", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMasterScrapProductMasterScrapProductInsert {
  final String id;
  InsertMasterScrapProductMasterScrapProductInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterScrapProductMasterScrapProductInsert otherTyped = other as InsertMasterScrapProductMasterScrapProductInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMasterScrapProductMasterScrapProductInsert({
    required this.id,
  });
}

@immutable
class InsertMasterScrapProductData {
  final InsertMasterScrapProductMasterScrapProductInsert masterScrapProduct_insert;
  InsertMasterScrapProductData.fromJson(dynamic json):
  
  masterScrapProduct_insert = InsertMasterScrapProductMasterScrapProductInsert.fromJson(json['masterScrapProduct_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterScrapProductData otherTyped = other as InsertMasterScrapProductData;
    return masterScrapProduct_insert == otherTyped.masterScrapProduct_insert;
    
  }
  @override
  int get hashCode => masterScrapProduct_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterScrapProduct_insert'] = masterScrapProduct_insert.toJson();
    return json;
  }

  InsertMasterScrapProductData({
    required this.masterScrapProduct_insert,
  });
}

@immutable
class InsertMasterScrapProductVariables {
  final String name;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMasterScrapProductVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
  sortOrder = nativeFromJson<int>(json['sortOrder']),
  isActive = nativeFromJson<bool>(json['isActive']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterScrapProductVariables otherTyped = other as InsertMasterScrapProductVariables;
    return name == otherTyped.name && 
    sortOrder == otherTyped.sortOrder && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, sortOrder.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['sortOrder'] = nativeToJson<int>(sortOrder);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  InsertMasterScrapProductVariables({
    required this.name,
    required this.sortOrder,
    required this.isActive,
  });
}

