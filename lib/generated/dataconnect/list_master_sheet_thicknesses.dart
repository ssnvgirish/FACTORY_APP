part of 'default.dart';

class ListMasterSheetThicknessesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMasterSheetThicknessesVariablesBuilder(this._dataConnect, );
  Deserializer<ListMasterSheetThicknessesData> dataDeserializer = (dynamic json)  => ListMasterSheetThicknessesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMasterSheetThicknessesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMasterSheetThicknessesData, void> ref() {
    
    return _dataConnect.query("ListMasterSheetThicknesses", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMasterSheetThicknessesMasterSheetThicknesses {
  final String id;
  final String value;
  final int sortOrder;
  final bool isActive;
  ListMasterSheetThicknessesMasterSheetThicknesses.fromJson(dynamic json):
  
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

    final ListMasterSheetThicknessesMasterSheetThicknesses otherTyped = other as ListMasterSheetThicknessesMasterSheetThicknesses;
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

  ListMasterSheetThicknessesMasterSheetThicknesses({
    required this.id,
    required this.value,
    required this.sortOrder,
    required this.isActive,
  });
}

@immutable
class ListMasterSheetThicknessesData {
  final List<ListMasterSheetThicknessesMasterSheetThicknesses> masterSheetThicknesses;
  ListMasterSheetThicknessesData.fromJson(dynamic json):
  
  masterSheetThicknesses = (json['masterSheetThicknesses'] as List<dynamic>)
        .map((e) => ListMasterSheetThicknessesMasterSheetThicknesses.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterSheetThicknessesData otherTyped = other as ListMasterSheetThicknessesData;
    return masterSheetThicknesses == otherTyped.masterSheetThicknesses;
    
  }
  @override
  int get hashCode => masterSheetThicknesses.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetThicknesses'] = masterSheetThicknesses.map((e) => e.toJson()).toList();
    return json;
  }

  ListMasterSheetThicknessesData({
    required this.masterSheetThicknesses,
  });
}

