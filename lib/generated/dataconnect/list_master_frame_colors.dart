part of 'default.dart';

class ListMasterFrameColorsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMasterFrameColorsVariablesBuilder(this._dataConnect, );
  Deserializer<ListMasterFrameColorsData> dataDeserializer = (dynamic json)  => ListMasterFrameColorsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMasterFrameColorsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMasterFrameColorsData, void> ref() {
    
    return _dataConnect.query("ListMasterFrameColors", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMasterFrameColorsMasterFrameColors {
  final String id;
  final String name;
  final int sortOrder;
  final bool isActive;
  ListMasterFrameColorsMasterFrameColors.fromJson(dynamic json):
  
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

    final ListMasterFrameColorsMasterFrameColors otherTyped = other as ListMasterFrameColorsMasterFrameColors;
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

  ListMasterFrameColorsMasterFrameColors({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.isActive,
  });
}

@immutable
class ListMasterFrameColorsData {
  final List<ListMasterFrameColorsMasterFrameColors> masterFrameColors;
  ListMasterFrameColorsData.fromJson(dynamic json):
  
  masterFrameColors = (json['masterFrameColors'] as List<dynamic>)
        .map((e) => ListMasterFrameColorsMasterFrameColors.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterFrameColorsData otherTyped = other as ListMasterFrameColorsData;
    return masterFrameColors == otherTyped.masterFrameColors;
    
  }
  @override
  int get hashCode => masterFrameColors.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameColors'] = masterFrameColors.map((e) => e.toJson()).toList();
    return json;
  }

  ListMasterFrameColorsData({
    required this.masterFrameColors,
  });
}

