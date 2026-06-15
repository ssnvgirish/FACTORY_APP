part of 'default.dart';

class ListMasterFrameTargetsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMasterFrameTargetsVariablesBuilder(this._dataConnect, );
  Deserializer<ListMasterFrameTargetsData> dataDeserializer = (dynamic json)  => ListMasterFrameTargetsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMasterFrameTargetsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMasterFrameTargetsData, void> ref() {
    
    return _dataConnect.query("ListMasterFrameTargets", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMasterFrameTargetsMasterFrameTargets {
  final String id;
  final String section;
  final double targetKgPerHour;
  ListMasterFrameTargetsMasterFrameTargets.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  section = nativeFromJson<String>(json['section']),
  targetKgPerHour = nativeFromJson<double>(json['targetKgPerHour']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterFrameTargetsMasterFrameTargets otherTyped = other as ListMasterFrameTargetsMasterFrameTargets;
    return id == otherTyped.id && 
    section == otherTyped.section && 
    targetKgPerHour == otherTyped.targetKgPerHour;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, section.hashCode, targetKgPerHour.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['section'] = nativeToJson<String>(section);
    json['targetKgPerHour'] = nativeToJson<double>(targetKgPerHour);
    return json;
  }

  ListMasterFrameTargetsMasterFrameTargets({
    required this.id,
    required this.section,
    required this.targetKgPerHour,
  });
}

@immutable
class ListMasterFrameTargetsData {
  final List<ListMasterFrameTargetsMasterFrameTargets> masterFrameTargets;
  ListMasterFrameTargetsData.fromJson(dynamic json):
  
  masterFrameTargets = (json['masterFrameTargets'] as List<dynamic>)
        .map((e) => ListMasterFrameTargetsMasterFrameTargets.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterFrameTargetsData otherTyped = other as ListMasterFrameTargetsData;
    return masterFrameTargets == otherTyped.masterFrameTargets;
    
  }
  @override
  int get hashCode => masterFrameTargets.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameTargets'] = masterFrameTargets.map((e) => e.toJson()).toList();
    return json;
  }

  ListMasterFrameTargetsData({
    required this.masterFrameTargets,
  });
}

