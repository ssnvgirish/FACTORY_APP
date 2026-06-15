part of 'default.dart';

class ListMasterMaintenanceItemsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMasterMaintenanceItemsVariablesBuilder(this._dataConnect, );
  Deserializer<ListMasterMaintenanceItemsData> dataDeserializer = (dynamic json)  => ListMasterMaintenanceItemsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMasterMaintenanceItemsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMasterMaintenanceItemsData, void> ref() {
    
    return _dataConnect.query("ListMasterMaintenanceItems", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMasterMaintenanceItemsMasterMaintenanceItems {
  final String id;
  final String name;
  final String category;
  final int sortOrder;
  final bool isActive;
  ListMasterMaintenanceItemsMasterMaintenanceItems.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
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

    final ListMasterMaintenanceItemsMasterMaintenanceItems otherTyped = other as ListMasterMaintenanceItemsMasterMaintenanceItems;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    category == otherTyped.category && 
    sortOrder == otherTyped.sortOrder && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, category.hashCode, sortOrder.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['category'] = nativeToJson<String>(category);
    json['sortOrder'] = nativeToJson<int>(sortOrder);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  ListMasterMaintenanceItemsMasterMaintenanceItems({
    required this.id,
    required this.name,
    required this.category,
    required this.sortOrder,
    required this.isActive,
  });
}

@immutable
class ListMasterMaintenanceItemsData {
  final List<ListMasterMaintenanceItemsMasterMaintenanceItems> masterMaintenanceItems;
  ListMasterMaintenanceItemsData.fromJson(dynamic json):
  
  masterMaintenanceItems = (json['masterMaintenanceItems'] as List<dynamic>)
        .map((e) => ListMasterMaintenanceItemsMasterMaintenanceItems.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterMaintenanceItemsData otherTyped = other as ListMasterMaintenanceItemsData;
    return masterMaintenanceItems == otherTyped.masterMaintenanceItems;
    
  }
  @override
  int get hashCode => masterMaintenanceItems.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMaintenanceItems'] = masterMaintenanceItems.map((e) => e.toJson()).toList();
    return json;
  }

  ListMasterMaintenanceItemsData({
    required this.masterMaintenanceItems,
  });
}

