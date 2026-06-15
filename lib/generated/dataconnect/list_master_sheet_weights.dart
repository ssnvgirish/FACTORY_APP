part of 'default.dart';

class ListMasterSheetWeightsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMasterSheetWeightsVariablesBuilder(this._dataConnect, );
  Deserializer<ListMasterSheetWeightsData> dataDeserializer = (dynamic json)  => ListMasterSheetWeightsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMasterSheetWeightsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMasterSheetWeightsData, void> ref() {
    
    return _dataConnect.query("ListMasterSheetWeights", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMasterSheetWeightsMasterSheetWeights {
  final String id;
  final String thickness;
  final String density;
  final double weightPerSqft;
  ListMasterSheetWeightsMasterSheetWeights.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  thickness = nativeFromJson<String>(json['thickness']),
  density = nativeFromJson<String>(json['density']),
  weightPerSqft = nativeFromJson<double>(json['weightPerSqft']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterSheetWeightsMasterSheetWeights otherTyped = other as ListMasterSheetWeightsMasterSheetWeights;
    return id == otherTyped.id && 
    thickness == otherTyped.thickness && 
    density == otherTyped.density && 
    weightPerSqft == otherTyped.weightPerSqft;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, thickness.hashCode, density.hashCode, weightPerSqft.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['thickness'] = nativeToJson<String>(thickness);
    json['density'] = nativeToJson<String>(density);
    json['weightPerSqft'] = nativeToJson<double>(weightPerSqft);
    return json;
  }

  ListMasterSheetWeightsMasterSheetWeights({
    required this.id,
    required this.thickness,
    required this.density,
    required this.weightPerSqft,
  });
}

@immutable
class ListMasterSheetWeightsData {
  final List<ListMasterSheetWeightsMasterSheetWeights> masterSheetWeights;
  ListMasterSheetWeightsData.fromJson(dynamic json):
  
  masterSheetWeights = (json['masterSheetWeights'] as List<dynamic>)
        .map((e) => ListMasterSheetWeightsMasterSheetWeights.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterSheetWeightsData otherTyped = other as ListMasterSheetWeightsData;
    return masterSheetWeights == otherTyped.masterSheetWeights;
    
  }
  @override
  int get hashCode => masterSheetWeights.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetWeights'] = masterSheetWeights.map((e) => e.toJson()).toList();
    return json;
  }

  ListMasterSheetWeightsData({
    required this.masterSheetWeights,
  });
}

