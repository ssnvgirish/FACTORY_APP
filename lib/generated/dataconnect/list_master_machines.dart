part of 'default.dart';

class ListMasterMachinesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMasterMachinesVariablesBuilder(this._dataConnect, );
  Deserializer<ListMasterMachinesData> dataDeserializer = (dynamic json)  => ListMasterMachinesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMasterMachinesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMasterMachinesData, void> ref() {
    
    return _dataConnect.query("ListMasterMachines", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMasterMachinesMasterMachines {
  final String id;
  final String name;
  final String type;
  final int sortOrder;
  final bool isActive;
  ListMasterMachinesMasterMachines.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  type = nativeFromJson<String>(json['type']),
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

    final ListMasterMachinesMasterMachines otherTyped = other as ListMasterMachinesMasterMachines;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    type == otherTyped.type && 
    sortOrder == otherTyped.sortOrder && 
    isActive == otherTyped.isActive;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, type.hashCode, sortOrder.hashCode, isActive.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['type'] = nativeToJson<String>(type);
    json['sortOrder'] = nativeToJson<int>(sortOrder);
    json['isActive'] = nativeToJson<bool>(isActive);
    return json;
  }

  ListMasterMachinesMasterMachines({
    required this.id,
    required this.name,
    required this.type,
    required this.sortOrder,
    required this.isActive,
  });
}

@immutable
class ListMasterMachinesData {
  final List<ListMasterMachinesMasterMachines> masterMachines;
  ListMasterMachinesData.fromJson(dynamic json):
  
  masterMachines = (json['masterMachines'] as List<dynamic>)
        .map((e) => ListMasterMachinesMasterMachines.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterMachinesData otherTyped = other as ListMasterMachinesData;
    return masterMachines == otherTyped.masterMachines;
    
  }
  @override
  int get hashCode => masterMachines.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMachines'] = masterMachines.map((e) => e.toJson()).toList();
    return json;
  }

  ListMasterMachinesData({
    required this.masterMachines,
  });
}

