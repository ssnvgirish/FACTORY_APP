part of 'default.dart';

class InsertMasterMaintenanceItemVariablesBuilder {
  String name;
  String category;
  int sortOrder;
  bool isActive;

  final FirebaseDataConnect _dataConnect;
  InsertMasterMaintenanceItemVariablesBuilder(this._dataConnect, {required  this.name,required  this.category,required  this.sortOrder,required  this.isActive,});
  Deserializer<InsertMasterMaintenanceItemData> dataDeserializer = (dynamic json)  => InsertMasterMaintenanceItemData.fromJson(jsonDecode(json));
  Serializer<InsertMasterMaintenanceItemVariables> varsSerializer = (InsertMasterMaintenanceItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMasterMaintenanceItemData, InsertMasterMaintenanceItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMasterMaintenanceItemData, InsertMasterMaintenanceItemVariables> ref() {
    InsertMasterMaintenanceItemVariables vars= InsertMasterMaintenanceItemVariables(name: name,category: category,sortOrder: sortOrder,isActive: isActive,);
    return _dataConnect.mutation("InsertMasterMaintenanceItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMasterMaintenanceItemMasterMaintenanceItemInsert {
  final String id;
  InsertMasterMaintenanceItemMasterMaintenanceItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterMaintenanceItemMasterMaintenanceItemInsert otherTyped = other as InsertMasterMaintenanceItemMasterMaintenanceItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMasterMaintenanceItemMasterMaintenanceItemInsert({
    required this.id,
  });
}

@immutable
class InsertMasterMaintenanceItemData {
  final InsertMasterMaintenanceItemMasterMaintenanceItemInsert masterMaintenanceItem_insert;
  InsertMasterMaintenanceItemData.fromJson(dynamic json):
  
  masterMaintenanceItem_insert = InsertMasterMaintenanceItemMasterMaintenanceItemInsert.fromJson(json['masterMaintenanceItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterMaintenanceItemData otherTyped = other as InsertMasterMaintenanceItemData;
    return masterMaintenanceItem_insert == otherTyped.masterMaintenanceItem_insert;
    
  }
  @override
  int get hashCode => masterMaintenanceItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItem_insert'] = masterMaintenanceItem_insert.toJson();
    return json;
  }

  InsertMasterMaintenanceItemData({
    required this.masterMaintenanceItem_insert,
  });
}

@immutable
class InsertMasterMaintenanceItemVariables {
  final String name;
  final String category;
  final int sortOrder;
  final bool isActive;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMasterMaintenanceItemVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
  category = nativeFromJson<String>(json['category']),
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

    final InsertMasterMaintenanceItemVariables otherTyped = other as InsertMasterMaintenanceItemVariables;
    return name == otherTyped.name && 
    category == otherTyped.category && 
    sortOrder == otherTyped.sortOrder && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, category.hashCode, sortOrder.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['category'] = nativeToJson<String>(category);
    json['sortOrder'] = nativeToJson<int>(sortOrder);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  InsertMasterMaintenanceItemVariables({
    required this.name,
    required this.category,
    required this.sortOrder,
    required this.isActive,
  });
}

