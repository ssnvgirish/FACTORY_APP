part of 'default.dart';

class ListMasterFrameSectionsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMasterFrameSectionsVariablesBuilder(this._dataConnect, );
  Deserializer<ListMasterFrameSectionsData> dataDeserializer = (dynamic json)  => ListMasterFrameSectionsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMasterFrameSectionsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMasterFrameSectionsData, void> ref() {
    
    return _dataConnect.query("ListMasterFrameSections", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMasterFrameSectionsMasterFrameSections {
  final String id;
  final String name;
  final int sortOrder;
  final bool isActive;
  ListMasterFrameSectionsMasterFrameSections.fromJson(dynamic json):
  
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

    final ListMasterFrameSectionsMasterFrameSections otherTyped = other as ListMasterFrameSectionsMasterFrameSections;
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

  ListMasterFrameSectionsMasterFrameSections({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.isActive,
  });
}

@immutable
class ListMasterFrameSectionsData {
  final List<ListMasterFrameSectionsMasterFrameSections> masterFrameSections;
  ListMasterFrameSectionsData.fromJson(dynamic json):
  
  masterFrameSections = (json['masterFrameSections'] as List<dynamic>)
        .map((e) => ListMasterFrameSectionsMasterFrameSections.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterFrameSectionsData otherTyped = other as ListMasterFrameSectionsData;
    return masterFrameSections == otherTyped.masterFrameSections;
    
  }
  @override
  int get hashCode => masterFrameSections.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameSections'] = masterFrameSections.map((e) => e.toJson()).toList();
    return json;
  }

  ListMasterFrameSectionsData({
    required this.masterFrameSections,
  });
}

