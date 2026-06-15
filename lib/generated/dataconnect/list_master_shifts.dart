part of 'default.dart';

class ListMasterShiftsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMasterShiftsVariablesBuilder(this._dataConnect, );
  Deserializer<ListMasterShiftsData> dataDeserializer = (dynamic json)  => ListMasterShiftsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMasterShiftsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMasterShiftsData, void> ref() {
    
    return _dataConnect.query("ListMasterShifts", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMasterShiftsMasterShifts {
  final String id;
  final String name;
  final int sortOrder;
  final bool isActive;
  ListMasterShiftsMasterShifts.fromJson(dynamic json):
  
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

    final ListMasterShiftsMasterShifts otherTyped = other as ListMasterShiftsMasterShifts;
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

  ListMasterShiftsMasterShifts({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.isActive,
  });
}

@immutable
class ListMasterShiftsData {
  final List<ListMasterShiftsMasterShifts> masterShifts;
  ListMasterShiftsData.fromJson(dynamic json):
  
  masterShifts = (json['masterShifts'] as List<dynamic>)
        .map((e) => ListMasterShiftsMasterShifts.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterShiftsData otherTyped = other as ListMasterShiftsData;
    return masterShifts == otherTyped.masterShifts;
    
  }
  @override
  int get hashCode => masterShifts.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterShifts'] = masterShifts.map((e) => e.toJson()).toList();
    return json;
  }

  ListMasterShiftsData({
    required this.masterShifts,
  });
}

