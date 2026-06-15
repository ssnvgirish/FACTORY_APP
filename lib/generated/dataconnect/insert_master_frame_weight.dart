part of 'default.dart';

class InsertMasterFrameWeightVariablesBuilder {
  String section;
  String density;
  double weightPerFoot;

  final FirebaseDataConnect _dataConnect;
  InsertMasterFrameWeightVariablesBuilder(this._dataConnect, {required  this.section,required  this.density,required  this.weightPerFoot,});
  Deserializer<InsertMasterFrameWeightData> dataDeserializer = (dynamic json)  => InsertMasterFrameWeightData.fromJson(jsonDecode(json));
  Serializer<InsertMasterFrameWeightVariables> varsSerializer = (InsertMasterFrameWeightVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMasterFrameWeightData, InsertMasterFrameWeightVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMasterFrameWeightData, InsertMasterFrameWeightVariables> ref() {
    InsertMasterFrameWeightVariables vars= InsertMasterFrameWeightVariables(section: section,density: density,weightPerFoot: weightPerFoot,);
    return _dataConnect.mutation("InsertMasterFrameWeight", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMasterFrameWeightMasterFrameWeightInsert {
  final String id;
  InsertMasterFrameWeightMasterFrameWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterFrameWeightMasterFrameWeightInsert otherTyped = other as InsertMasterFrameWeightMasterFrameWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMasterFrameWeightMasterFrameWeightInsert({
    required this.id,
  });
}

@immutable
class InsertMasterFrameWeightData {
  final InsertMasterFrameWeightMasterFrameWeightInsert masterFrameWeight_insert;
  InsertMasterFrameWeightData.fromJson(dynamic json):
  
  masterFrameWeight_insert = InsertMasterFrameWeightMasterFrameWeightInsert.fromJson(json['masterFrameWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterFrameWeightData otherTyped = other as InsertMasterFrameWeightData;
    return masterFrameWeight_insert == otherTyped.masterFrameWeight_insert;
    
  }
  @override
  int get hashCode => masterFrameWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameWeight_insert'] = masterFrameWeight_insert.toJson();
    return json;
  }

  InsertMasterFrameWeightData({
    required this.masterFrameWeight_insert,
  });
}

@immutable
class InsertMasterFrameWeightVariables {
  final String section;
  final String density;
  final double weightPerFoot;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMasterFrameWeightVariables.fromJson(Map<String, dynamic> json):
  
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

    final InsertMasterFrameWeightVariables otherTyped = other as InsertMasterFrameWeightVariables;
    return section == otherTyped.section && 
    density == otherTyped.density && 
    weightPerFoot == otherTyped.weightPerFoot;
    
  }
  @override
  int get hashCode => Object.hashAll([section.hashCode, density.hashCode, weightPerFoot.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['section'] = nativeToJson<String>(section);
    json['density'] = nativeToJson<String>(density);
    json['weightPerFoot'] = nativeToJson<double>(weightPerFoot);
    return json;
  }

  InsertMasterFrameWeightVariables({
    required this.section,
    required this.density,
    required this.weightPerFoot,
  });
}

