part of 'default.dart';

class ListMasterScrapProductsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMasterScrapProductsVariablesBuilder(this._dataConnect, );
  Deserializer<ListMasterScrapProductsData> dataDeserializer = (dynamic json)  => ListMasterScrapProductsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMasterScrapProductsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMasterScrapProductsData, void> ref() {
    
    return _dataConnect.query("ListMasterScrapProducts", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMasterScrapProductsMasterScrapProducts {
  final String id;
  final String name;
  final int sortOrder;
  final bool isActive;
  ListMasterScrapProductsMasterScrapProducts.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
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

    final ListMasterScrapProductsMasterScrapProducts otherTyped = other as ListMasterScrapProductsMasterScrapProducts;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    sortOrder == otherTyped.sortOrder && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, sortOrder.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['sortOrder'] = nativeToJson<int>(sortOrder);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  ListMasterScrapProductsMasterScrapProducts({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.isActive,
  });
}

@immutable
class ListMasterScrapProductsData {
  final List<ListMasterScrapProductsMasterScrapProducts> masterScrapProducts;
  ListMasterScrapProductsData.fromJson(dynamic json):
  
  masterScrapProducts = (json['masterScrapProducts'] as List<dynamic>)
        .map((e) => ListMasterScrapProductsMasterScrapProducts.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterScrapProductsData otherTyped = other as ListMasterScrapProductsData;
    return masterScrapProducts == otherTyped.masterScrapProducts;
    
  }
  @override
  int get hashCode => masterScrapProducts.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterScrapProducts'] = masterScrapProducts.map((e) => e.toJson()).toList();
    return json;
  }

  ListMasterScrapProductsData({
    required this.masterScrapProducts,
  });
}

