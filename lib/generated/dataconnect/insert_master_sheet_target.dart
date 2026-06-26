part of 'default.dart';

class InsertMasterSheetTargetVariablesBuilder {
  String thickness;
  String density;
  double targetFeetPerHour;

  final FirebaseDataConnect _dataConnect;
  InsertMasterSheetTargetVariablesBuilder(
    this._dataConnect, {
    required this.thickness,
    required this.density,
    required this.targetFeetPerHour,
  });
  Deserializer<InsertMasterSheetTargetData> dataDeserializer = (dynamic json) =>
      InsertMasterSheetTargetData.fromJson(jsonDecode(json));
  Serializer<InsertMasterSheetTargetVariables> varsSerializer =
      (InsertMasterSheetTargetVariables vars) => jsonEncode(vars.toJson());
  Future<
    OperationResult<
      InsertMasterSheetTargetData,
      InsertMasterSheetTargetVariables
    >
  >
  execute() {
    return ref().execute();
  }

  MutationRef<InsertMasterSheetTargetData, InsertMasterSheetTargetVariables>
  ref() {
    InsertMasterSheetTargetVariables vars = InsertMasterSheetTargetVariables(
      thickness: thickness,
      density: density,
      targetFeetPerHour: targetFeetPerHour,
    );
    return _dataConnect.mutation(
      "InsertMasterSheetTarget",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class InsertMasterSheetTargetMasterSheetTargetInsert {
  final String id;
  InsertMasterSheetTargetMasterSheetTargetInsert.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterSheetTargetMasterSheetTargetInsert otherTyped =
        other as InsertMasterSheetTargetMasterSheetTargetInsert;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMasterSheetTargetMasterSheetTargetInsert({required this.id});
}

@immutable
class InsertMasterSheetTargetData {
  final InsertMasterSheetTargetMasterSheetTargetInsert masterSheetTarget_insert;
  InsertMasterSheetTargetData.fromJson(dynamic json)
    : masterSheetTarget_insert =
          InsertMasterSheetTargetMasterSheetTargetInsert.fromJson(
            json['masterSheetTarget_insert'],
          );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterSheetTargetData otherTyped =
        other as InsertMasterSheetTargetData;
    return masterSheetTarget_insert == otherTyped.masterSheetTarget_insert;
  }

  @override
  int get hashCode => masterSheetTarget_insert.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetTarget_insert'] = masterSheetTarget_insert.toJson();
    return json;
  }

  InsertMasterSheetTargetData({required this.masterSheetTarget_insert});
}

@immutable
class InsertMasterSheetTargetVariables {
  final String thickness;
  final String density;
  final double targetFeetPerHour;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  InsertMasterSheetTargetVariables.fromJson(Map<String, dynamic> json)
    : thickness = nativeFromJson<String>(json['thickness']),
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

    final InsertMasterSheetTargetVariables otherTyped =
        other as InsertMasterSheetTargetVariables;
    return thickness == otherTyped.thickness &&
        density == otherTyped.density &&
        targetFeetPerHour == otherTyped.targetFeetPerHour;
  }

  @override
  int get hashCode =>
      Object.hashAll([thickness.hashCode, density.hashCode, targetFeetPerHour.hashCode]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['thickness'] = nativeToJson<String>(thickness);
    json['density'] = nativeToJson<String>(density);
    json['targetFeetPerHour'] = nativeToJson<double>(targetFeetPerHour);
    return json;
  }

  InsertMasterSheetTargetVariables({
    required this.thickness,
    required this.density,
    required this.targetFeetPerHour,
  });
}
