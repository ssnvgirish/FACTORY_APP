part of 'default.dart';

class UpdateMasterSheetWeightVariablesBuilder {
  UpdateMasterSheetWeightVariablesId id;
  String thickness;
  String density;
  double weightPerSqft;

  final FirebaseDataConnect _dataConnect;
  UpdateMasterSheetWeightVariablesBuilder(this._dataConnect, {required  this.id,required  this.thickness,required  this.density,required  this.weightPerSqft,});
  Deserializer<UpdateMasterSheetWeightData> dataDeserializer = (dynamic json)  => UpdateMasterSheetWeightData.fromJson(jsonDecode(json));
  Serializer<UpdateMasterSheetWeightVariables> varsSerializer = (UpdateMasterSheetWeightVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMasterSheetWeightData, UpdateMasterSheetWeightVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateMasterSheetWeightData, UpdateMasterSheetWeightVariables> ref() {
    UpdateMasterSheetWeightVariables vars= UpdateMasterSheetWeightVariables(id: id,thickness: thickness,density: density,weightPerSqft: weightPerSqft,);
    return _dataConnect.mutation("UpdateMasterSheetWeight", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateMasterSheetWeightMasterSheetWeightUpdate {
  final String id;
  UpdateMasterSheetWeightMasterSheetWeightUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSheetWeightMasterSheetWeightUpdate otherTyped = other as UpdateMasterSheetWeightMasterSheetWeightUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterSheetWeightMasterSheetWeightUpdate({
    required this.id,
  });
}

@immutable
class UpdateMasterSheetWeightData {
  final UpdateMasterSheetWeightMasterSheetWeightUpdate? masterSheetWeight_update;
  UpdateMasterSheetWeightData.fromJson(dynamic json):
  
  masterSheetWeight_update = json['masterSheetWeight_update'] == null ? null : UpdateMasterSheetWeightMasterSheetWeightUpdate.fromJson(json['masterSheetWeight_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSheetWeightData otherTyped = other as UpdateMasterSheetWeightData;
    return masterSheetWeight_update == otherTyped.masterSheetWeight_update;
    
  }
  @override
  int get hashCode => masterSheetWeight_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterSheetWeight_update != null) {
      json['masterSheetWeight_update'] = masterSheetWeight_update!.toJson();
    }
    return json;
  }

  UpdateMasterSheetWeightData({
    this.masterSheetWeight_update,
  });
}

@immutable
class UpdateMasterSheetWeightVariablesId {
  final String id;
  UpdateMasterSheetWeightVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSheetWeightVariablesId otherTyped = other as UpdateMasterSheetWeightVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterSheetWeightVariablesId({
    required this.id,
  });
}

@immutable
class UpdateMasterSheetWeightVariables {
  final UpdateMasterSheetWeightVariablesId id;
  final String thickness;
  final String density;
  final double weightPerSqft;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateMasterSheetWeightVariables.fromJson(Map<String, dynamic> json):
  
  id = UpdateMasterSheetWeightVariablesId.fromJson(json['id']),
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

    final UpdateMasterSheetWeightVariables otherTyped = other as UpdateMasterSheetWeightVariables;
    return id == otherTyped.id && 
    thickness == otherTyped.thickness && 
    density == otherTyped.density && 
    weightPerSqft == otherTyped.weightPerSqft;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, thickness.hashCode, density.hashCode, weightPerSqft.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    json['thickness'] = nativeToJson<String>(thickness);
    json['density'] = nativeToJson<String>(density);
    json['weightPerSqft'] = nativeToJson<double>(weightPerSqft);
    return json;
  }

  UpdateMasterSheetWeightVariables({
    required this.id,
    required this.thickness,
    required this.density,
    required this.weightPerSqft,
  });
}

