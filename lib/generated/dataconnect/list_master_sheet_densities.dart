part of 'default.dart';

class ListMasterSheetDensitiesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMasterSheetDensitiesVariablesBuilder(this._dataConnect, );
  Deserializer<ListMasterSheetDensitiesData> dataDeserializer = (dynamic json)  => ListMasterSheetDensitiesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMasterSheetDensitiesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMasterSheetDensitiesData, void> ref() {
    
    return _dataConnect.query("ListMasterSheetDensities", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMasterSheetDensitiesMasterSheetDensities {
  final String id;
  final String value;
  final int sortOrder;
  final bool isActive;
  ListMasterSheetDensitiesMasterSheetDensities.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  value = nativeFromJson<String>(json['value']),
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

    final ListMasterSheetDensitiesMasterSheetDensities otherTyped = other as ListMasterSheetDensitiesMasterSheetDensities;
    return id == otherTyped.id && 
    value == otherTyped.value && 
    sortOrder == otherTyped.sortOrder && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, value.hashCode, sortOrder.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['value'] = nativeToJson<String>(value);
    json['sortOrder'] = nativeToJson<int>(sortOrder);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  ListMasterSheetDensitiesMasterSheetDensities({
    required this.id,
    required this.value,
    required this.sortOrder,
    required this.isActive,
  });
}

@immutable
class ListMasterSheetDensitiesData {
  final List<ListMasterSheetDensitiesMasterSheetDensities> masterSheetDensities;
  ListMasterSheetDensitiesData.fromJson(dynamic json):
  
  masterSheetDensities = (json['masterSheetDensities'] as List<dynamic>)
        .map((e) => ListMasterSheetDensitiesMasterSheetDensities.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterSheetDensitiesData otherTyped = other as ListMasterSheetDensitiesData;
    return masterSheetDensities == otherTyped.masterSheetDensities;
    
  }
  @override
  int get hashCode => masterSheetDensities.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetDensities'] = masterSheetDensities.map((e) => e.toJson()).toList();
    return json;
  }

  ListMasterSheetDensitiesData({
    required this.masterSheetDensities,
  });
}

