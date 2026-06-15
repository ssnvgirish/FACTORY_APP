part of 'default.dart';

class UpdateMasterFrameWeightVariablesBuilder {
  UpdateMasterFrameWeightVariablesId id;
  String section;
  String density;
  double weightPerFoot;

  final FirebaseDataConnect _dataConnect;
  UpdateMasterFrameWeightVariablesBuilder(this._dataConnect, {required  this.id,required  this.section,required  this.density,required  this.weightPerFoot,});
  Deserializer<UpdateMasterFrameWeightData> dataDeserializer = (dynamic json)  => UpdateMasterFrameWeightData.fromJson(jsonDecode(json));
  Serializer<UpdateMasterFrameWeightVariables> varsSerializer = (UpdateMasterFrameWeightVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMasterFrameWeightData, UpdateMasterFrameWeightVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateMasterFrameWeightData, UpdateMasterFrameWeightVariables> ref() {
    UpdateMasterFrameWeightVariables vars= UpdateMasterFrameWeightVariables(id: id,section: section,density: density,weightPerFoot: weightPerFoot,);
    return _dataConnect.mutation("UpdateMasterFrameWeight", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateMasterFrameWeightMasterFrameWeightUpdate {
  final String id;
  UpdateMasterFrameWeightMasterFrameWeightUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterFrameWeightMasterFrameWeightUpdate otherTyped = other as UpdateMasterFrameWeightMasterFrameWeightUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterFrameWeightMasterFrameWeightUpdate({
    required this.id,
  });
}

@immutable
class UpdateMasterFrameWeightData {
  final UpdateMasterFrameWeightMasterFrameWeightUpdate? masterFrameWeight_update;
  UpdateMasterFrameWeightData.fromJson(dynamic json):
  
  masterFrameWeight_update = json['masterFrameWeight_update'] == null ? null : UpdateMasterFrameWeightMasterFrameWeightUpdate.fromJson(json['masterFrameWeight_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterFrameWeightData otherTyped = other as UpdateMasterFrameWeightData;
    return masterFrameWeight_update == otherTyped.masterFrameWeight_update;
    
  }
  @override
  int get hashCode => masterFrameWeight_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterFrameWeight_update != null) {
      json['masterFrameWeight_update'] = masterFrameWeight_update!.toJson();
    }
    return json;
  }

  UpdateMasterFrameWeightData({
    this.masterFrameWeight_update,
  });
}

@immutable
class UpdateMasterFrameWeightVariablesId {
  final String id;
  UpdateMasterFrameWeightVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterFrameWeightVariablesId otherTyped = other as UpdateMasterFrameWeightVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterFrameWeightVariablesId({
    required this.id,
  });
}

@immutable
class UpdateMasterFrameWeightVariables {
  final UpdateMasterFrameWeightVariablesId id;
  final String section;
  final String density;
  final double weightPerFoot;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateMasterFrameWeightVariables.fromJson(Map<String, dynamic> json):
  
  id = UpdateMasterFrameWeightVariablesId.fromJson(json['id']),
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

    final UpdateMasterFrameWeightVariables otherTyped = other as UpdateMasterFrameWeightVariables;
    return id == otherTyped.id && 
    section == otherTyped.section && 
    density == otherTyped.density && 
    weightPerFoot == otherTyped.weightPerFoot;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, section.hashCode, density.hashCode, weightPerFoot.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    json['section'] = nativeToJson<String>(section);
    json['density'] = nativeToJson<String>(density);
    json['weightPerFoot'] = nativeToJson<double>(weightPerFoot);
    return json;
  }

  UpdateMasterFrameWeightVariables({
    required this.id,
    required this.section,
    required this.density,
    required this.weightPerFoot,
  });
}

