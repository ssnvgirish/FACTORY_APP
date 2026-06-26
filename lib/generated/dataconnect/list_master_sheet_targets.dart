part of 'default.dart';

class ListMasterSheetTargetsVariablesBuilder {
  final FirebaseDataConnect _dataConnect;
  ListMasterSheetTargetsVariablesBuilder(this._dataConnect);
  Deserializer<ListMasterSheetTargetsData> dataDeserializer = (dynamic json) =>
      ListMasterSheetTargetsData.fromJson(jsonDecode(json));

  Future<QueryResult<ListMasterSheetTargetsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMasterSheetTargetsData, void> ref() {
    return _dataConnect.query(
      "ListMasterSheetTargets",
      dataDeserializer,
      emptySerializer,
      null,
    );
  }
}

@immutable
class ListMasterSheetTargetsMasterSheetTargets {
  final String id;
  final String thickness;
  final String density;
  final double targetFeetPerHour;
  ListMasterSheetTargetsMasterSheetTargets.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']),
      thickness = nativeFromJson<String>(json['thickness']),
      density = nativeFromJson<String>(json['density']),
      targetFeetPerHour = nativeFromJson<double>(json['targetFeetPerHour']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterSheetTargetsMasterSheetTargets otherTyped =
        other as ListMasterSheetTargetsMasterSheetTargets;
    return id == otherTyped.id &&
        thickness == otherTyped.thickness &&
        density == otherTyped.density &&
        targetFeetPerHour == otherTyped.targetFeetPerHour;
  }

  @override
  int get hashCode => Object.hashAll([
    id.hashCode,
    thickness.hashCode,
    density.hashCode,
    targetFeetPerHour.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['thickness'] = nativeToJson<String>(thickness);
    json['density'] = nativeToJson<String>(density);
    json['targetFeetPerHour'] = nativeToJson<double>(targetFeetPerHour);
    return json;
  }

  ListMasterSheetTargetsMasterSheetTargets({
    required this.id,
    required this.thickness,
    required this.density,
    required this.targetFeetPerHour,
  });
}

@immutable
class ListMasterSheetTargetsData {
  final List<ListMasterSheetTargetsMasterSheetTargets> masterSheetTargets;
  ListMasterSheetTargetsData.fromJson(dynamic json)
    : masterSheetTargets = (json['masterSheetTargets'] as List<dynamic>)
          .map((e) => ListMasterSheetTargetsMasterSheetTargets.fromJson(e))
          .toList();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterSheetTargetsData otherTyped =
        other as ListMasterSheetTargetsData;
    return masterSheetTargets == otherTyped.masterSheetTargets;
  }

  @override
  int get hashCode => masterSheetTargets.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetTargets'] = masterSheetTargets
        .map((e) => e.toJson())
        .toList();
    return json;
  }

  ListMasterSheetTargetsData({required this.masterSheetTargets});
}
