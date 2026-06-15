part of 'default.dart';

class ListMasterFrameDensitiesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMasterFrameDensitiesVariablesBuilder(this._dataConnect, );
  Deserializer<ListMasterFrameDensitiesData> dataDeserializer = (dynamic json)  => ListMasterFrameDensitiesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMasterFrameDensitiesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMasterFrameDensitiesData, void> ref() {
    
    return _dataConnect.query("ListMasterFrameDensities", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMasterFrameDensitiesMasterFrameDensities {
  final String id;
  final String value;
  final int sortOrder;
  final bool isActive;
  ListMasterFrameDensitiesMasterFrameDensities.fromJson(dynamic json):
  
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

    final ListMasterFrameDensitiesMasterFrameDensities otherTyped = other as ListMasterFrameDensitiesMasterFrameDensities;
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

  ListMasterFrameDensitiesMasterFrameDensities({
    required this.id,
    required this.value,
    required this.sortOrder,
    required this.isActive,
  });
}

@immutable
class ListMasterFrameDensitiesData {
  final List<ListMasterFrameDensitiesMasterFrameDensities> masterFrameDensities;
  ListMasterFrameDensitiesData.fromJson(dynamic json):
  
  masterFrameDensities = (json['masterFrameDensities'] as List<dynamic>)
        .map((e) => ListMasterFrameDensitiesMasterFrameDensities.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterFrameDensitiesData otherTyped = other as ListMasterFrameDensitiesData;
    return masterFrameDensities == otherTyped.masterFrameDensities;
    
  }
  @override
  int get hashCode => masterFrameDensities.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameDensities'] = masterFrameDensities.map((e) => e.toJson()).toList();
    return json;
  }

  ListMasterFrameDensitiesData({
    required this.masterFrameDensities,
  });
}

