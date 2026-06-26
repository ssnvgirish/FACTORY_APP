part of 'default.dart';

class UpdateMasterSheetTargetVariablesBuilder {
  UpdateMasterSheetTargetVariablesId id;
  String thickness;
  String density;
  double targetFeetPerHour;

  final FirebaseDataConnect _dataConnect;
  UpdateMasterSheetTargetVariablesBuilder(
    this._dataConnect, {
    required this.id,
    required this.thickness,
    required this.density,
    required this.targetFeetPerHour,
  });
  Deserializer<UpdateMasterSheetTargetData> dataDeserializer = (dynamic json) =>
      UpdateMasterSheetTargetData.fromJson(jsonDecode(json));
  Serializer<UpdateMasterSheetTargetVariables> varsSerializer =
      (UpdateMasterSheetTargetVariables vars) => jsonEncode(vars.toJson());
  Future<
    OperationResult<
      UpdateMasterSheetTargetData,
      UpdateMasterSheetTargetVariables
    >
  >
  execute() {
    return ref().execute();
  }

  MutationRef<UpdateMasterSheetTargetData, UpdateMasterSheetTargetVariables>
  ref() {
    UpdateMasterSheetTargetVariables vars = UpdateMasterSheetTargetVariables(
      id: id,
      thickness: thickness,
      density: density,
      targetFeetPerHour: targetFeetPerHour,
    );
    return _dataConnect.mutation(
      "UpdateMasterSheetTarget",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class UpdateMasterSheetTargetMasterSheetTargetUpdate {
  final String id;
  UpdateMasterSheetTargetMasterSheetTargetUpdate.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSheetTargetMasterSheetTargetUpdate otherTyped =
        other as UpdateMasterSheetTargetMasterSheetTargetUpdate;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterSheetTargetMasterSheetTargetUpdate({required this.id});
}

@immutable
class UpdateMasterSheetTargetData {
  final UpdateMasterSheetTargetMasterSheetTargetUpdate?
  masterSheetTarget_update;
  UpdateMasterSheetTargetData.fromJson(dynamic json)
    : masterSheetTarget_update = json['masterSheetTarget_update'] == null
          ? null
          : UpdateMasterSheetTargetMasterSheetTargetUpdate.fromJson(
              json['masterSheetTarget_update'],
            );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSheetTargetData otherTyped =
        other as UpdateMasterSheetTargetData;
    return masterSheetTarget_update == otherTyped.masterSheetTarget_update;
  }

  @override
  int get hashCode => masterSheetTarget_update.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterSheetTarget_update != null) {
      json['masterSheetTarget_update'] = masterSheetTarget_update!.toJson();
    }
    return json;
  }

  UpdateMasterSheetTargetData({this.masterSheetTarget_update});
}

@immutable
class UpdateMasterSheetTargetVariablesId {
  final String id;
  UpdateMasterSheetTargetVariablesId.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSheetTargetVariablesId otherTyped =
        other as UpdateMasterSheetTargetVariablesId;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterSheetTargetVariablesId({required this.id});
}

@immutable
class UpdateMasterSheetTargetVariables {
  final UpdateMasterSheetTargetVariablesId id;
  final String thickness;
  final String density;
  final double targetFeetPerHour;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  UpdateMasterSheetTargetVariables.fromJson(Map<String, dynamic> json)
    : id = UpdateMasterSheetTargetVariablesId.fromJson(json['id']),
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

    final UpdateMasterSheetTargetVariables otherTyped =
        other as UpdateMasterSheetTargetVariables;
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
    json['id'] = id.toJson();
    json['thickness'] = nativeToJson<String>(thickness);
    json['density'] = nativeToJson<String>(density);
    json['targetFeetPerHour'] = nativeToJson<double>(targetFeetPerHour);
    return json;
  }

  UpdateMasterSheetTargetVariables({
    required this.id,
    required this.thickness,
    required this.density,
    required this.targetFeetPerHour,
  });
}
