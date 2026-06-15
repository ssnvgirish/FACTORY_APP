part of 'default.dart';

class ListMasterFrameWeightsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMasterFrameWeightsVariablesBuilder(this._dataConnect, );
  Deserializer<ListMasterFrameWeightsData> dataDeserializer = (dynamic json)  => ListMasterFrameWeightsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMasterFrameWeightsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMasterFrameWeightsData, void> ref() {
    
    return _dataConnect.query("ListMasterFrameWeights", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMasterFrameWeightsMasterFrameWeights {
  final String id;
  final String section;
  final String density;
  final double weightPerFoot;
  ListMasterFrameWeightsMasterFrameWeights.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  section = nativeFromJson<String>(json['section']),
  density = nativeFromJson<String>(json['density']),
  weightPerFoot = nativeFromJson<double>(json['weightPerFoot']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterFrameWeightsMasterFrameWeights otherTyped = other as ListMasterFrameWeightsMasterFrameWeights;
    return id == otherTyped.id && 
    section == otherTyped.section && 
    density == otherTyped.density && 
    weightPerFoot == otherTyped.weightPerFoot;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, section.hashCode, density.hashCode, weightPerFoot.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['section'] = nativeToJson<String>(section);
    json['density'] = nativeToJson<String>(density);
    json['weightPerFoot'] = nativeToJson<double>(weightPerFoot);
    return json;
  }

  ListMasterFrameWeightsMasterFrameWeights({
    required this.id,
    required this.section,
    required this.density,
    required this.weightPerFoot,
  });
}

@immutable
class ListMasterFrameWeightsData {
  final List<ListMasterFrameWeightsMasterFrameWeights> masterFrameWeights;
  ListMasterFrameWeightsData.fromJson(dynamic json):
  
  masterFrameWeights = (json['masterFrameWeights'] as List<dynamic>)
        .map((e) => ListMasterFrameWeightsMasterFrameWeights.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterFrameWeightsData otherTyped = other as ListMasterFrameWeightsData;
    return masterFrameWeights == otherTyped.masterFrameWeights;
    
  }
  @override
  int get hashCode => masterFrameWeights.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeights'] = masterFrameWeights.map((e) => e.toJson()).toList();
    return json;
  }

  ListMasterFrameWeightsData({
    required this.masterFrameWeights,
  });
}

