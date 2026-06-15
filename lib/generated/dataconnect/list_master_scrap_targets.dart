part of 'default.dart';

class ListMasterScrapTargetsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMasterScrapTargetsVariablesBuilder(this._dataConnect, );
  Deserializer<ListMasterScrapTargetsData> dataDeserializer = (dynamic json)  => ListMasterScrapTargetsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMasterScrapTargetsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMasterScrapTargetsData, void> ref() {
    
    return _dataConnect.query("ListMasterScrapTargets", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMasterScrapTargetsMasterScrapTargets {
  final String id;
  final String product;
  final double targetKgPerHour;
  ListMasterScrapTargetsMasterScrapTargets.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  product = nativeFromJson<String>(json['product']),
  targetKgPerHour = nativeFromJson<double>(json['targetKgPerHour']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterScrapTargetsMasterScrapTargets otherTyped = other as ListMasterScrapTargetsMasterScrapTargets;
    return id == otherTyped.id && 
    product == otherTyped.product && 
    targetKgPerHour == otherTyped.targetKgPerHour;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, product.hashCode, targetKgPerHour.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['product'] = nativeToJson<String>(product);
    json['targetKgPerHour'] = nativeToJson<double>(targetKgPerHour);
    return json;
  }

  ListMasterScrapTargetsMasterScrapTargets({
    required this.id,
    required this.product,
    required this.targetKgPerHour,
  });
}

@immutable
class ListMasterScrapTargetsData {
  final List<ListMasterScrapTargetsMasterScrapTargets> masterScrapTargets;
  ListMasterScrapTargetsData.fromJson(dynamic json):
  
  masterScrapTargets = (json['masterScrapTargets'] as List<dynamic>)
        .map((e) => ListMasterScrapTargetsMasterScrapTargets.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterScrapTargetsData otherTyped = other as ListMasterScrapTargetsData;
    return masterScrapTargets == otherTyped.masterScrapTargets;
    
  }
  @override
  int get hashCode => masterScrapTargets.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterScrapTargets'] = masterScrapTargets.map((e) => e.toJson()).toList();
    return json;
  }

  ListMasterScrapTargetsData({
    required this.masterScrapTargets,
  });
}

