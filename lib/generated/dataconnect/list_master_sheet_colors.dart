part of 'default.dart';

class ListMasterSheetColorsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMasterSheetColorsVariablesBuilder(this._dataConnect, );
  Deserializer<ListMasterSheetColorsData> dataDeserializer = (dynamic json)  => ListMasterSheetColorsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMasterSheetColorsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMasterSheetColorsData, void> ref() {
    
    return _dataConnect.query("ListMasterSheetColors", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMasterSheetColorsMasterSheetColors {
  final String id;
  final String name;
  final int sortOrder;
  final bool isActive;
  ListMasterSheetColorsMasterSheetColors.fromJson(dynamic json):
  
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

    final ListMasterSheetColorsMasterSheetColors otherTyped = other as ListMasterSheetColorsMasterSheetColors;
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

  ListMasterSheetColorsMasterSheetColors({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.isActive,
  });
}

@immutable
class ListMasterSheetColorsData {
  final List<ListMasterSheetColorsMasterSheetColors> masterSheetColors;
  ListMasterSheetColorsData.fromJson(dynamic json):
  
  masterSheetColors = (json['masterSheetColors'] as List<dynamic>)
        .map((e) => ListMasterSheetColorsMasterSheetColors.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterSheetColorsData otherTyped = other as ListMasterSheetColorsData;
    return masterSheetColors == otherTyped.masterSheetColors;
    
  }
  @override
  int get hashCode => masterSheetColors.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetColors'] = masterSheetColors.map((e) => e.toJson()).toList();
    return json;
  }

  ListMasterSheetColorsData({
    required this.masterSheetColors,
  });
}

