part of 'default.dart';

class UpdateMasterFrameTargetVariablesBuilder {
  UpdateMasterFrameTargetVariablesId id;
  String section;
  String density;
  double targetKgPerHour;

  final FirebaseDataConnect _dataConnect;
  UpdateMasterFrameTargetVariablesBuilder(
    this._dataConnect, {
    required this.id,
    required this.section,
    required this.density,
    required this.targetKgPerHour,
  });
  Deserializer<UpdateMasterFrameTargetData> dataDeserializer = (dynamic json) =>
      UpdateMasterFrameTargetData.fromJson(jsonDecode(json));
  Serializer<UpdateMasterFrameTargetVariables> varsSerializer =
      (UpdateMasterFrameTargetVariables vars) => jsonEncode(vars.toJson());
  Future<
    OperationResult<
      UpdateMasterFrameTargetData,
      UpdateMasterFrameTargetVariables
    >
  >
  execute() {
    return ref().execute();
  }

  MutationRef<UpdateMasterFrameTargetData, UpdateMasterFrameTargetVariables>
  ref() {
    UpdateMasterFrameTargetVariables vars = UpdateMasterFrameTargetVariables(
      id: id,
      section: section,
      density: density,
      targetKgPerHour: targetKgPerHour,
    );
    return _dataConnect.mutation(
      "UpdateMasterFrameTarget",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class UpdateMasterFrameTargetMasterFrameTargetUpdate {
  final String id;
  UpdateMasterFrameTargetMasterFrameTargetUpdate.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterFrameTargetMasterFrameTargetUpdate otherTyped =
        other as UpdateMasterFrameTargetMasterFrameTargetUpdate;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterFrameTargetMasterFrameTargetUpdate({required this.id});
}

@immutable
class UpdateMasterFrameTargetData {
  final UpdateMasterFrameTargetMasterFrameTargetUpdate?
  masterFrameTarget_update;
  UpdateMasterFrameTargetData.fromJson(dynamic json)
    : masterFrameTarget_update = json['masterFrameTarget_update'] == null
          ? null
          : UpdateMasterFrameTargetMasterFrameTargetUpdate.fromJson(
              json['masterFrameTarget_update'],
            );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterFrameTargetData otherTyped =
        other as UpdateMasterFrameTargetData;
    return masterFrameTarget_update == otherTyped.masterFrameTarget_update;
  }

  @override
  int get hashCode => masterFrameTarget_update.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterFrameTarget_update != null) {
      json['masterFrameTarget_update'] = masterFrameTarget_update!.toJson();
    }
    return json;
  }

  UpdateMasterFrameTargetData({this.masterFrameTarget_update});
}

@immutable
class UpdateMasterFrameTargetVariablesId {
  final String id;
  UpdateMasterFrameTargetVariablesId.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterFrameTargetVariablesId otherTyped =
        other as UpdateMasterFrameTargetVariablesId;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterFrameTargetVariablesId({required this.id});
}

@immutable
class UpdateMasterFrameTargetVariables {
  final UpdateMasterFrameTargetVariablesId id;
  final String section;
  final String density;
  final double targetKgPerHour;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  UpdateMasterFrameTargetVariables.fromJson(Map<String, dynamic> json)
    : id = UpdateMasterFrameTargetVariablesId.fromJson(json['id']),
      section = nativeFromJson<String>(json['section']),
      density = nativeFromJson<String>(json['density']),
      targetKgPerHour = nativeFromJson<double>(json['targetKgPerHour']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterFrameTargetVariables otherTyped =
        other as UpdateMasterFrameTargetVariables;
    return id == otherTyped.id &&
        section == otherTyped.section &&
        density == otherTyped.density &&
        targetKgPerHour == otherTyped.targetKgPerHour;
  }

  @override
  int get hashCode =>
      Object.hashAll([id.hashCode, section.hashCode, density.hashCode, targetKgPerHour.hashCode]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    json['section'] = nativeToJson<String>(section);
    json['density'] = nativeToJson<String>(density);
    json['targetKgPerHour'] = nativeToJson<double>(targetKgPerHour);
    return json;
  }

  UpdateMasterFrameTargetVariables({
    required this.id,
    required this.section,
    required this.density,
    required this.targetKgPerHour,
  });
}
