part of 'default.dart';

class InsertMasterFrameTargetVariablesBuilder {
  String section;
  double targetKgPerHour;

  final FirebaseDataConnect _dataConnect;
  InsertMasterFrameTargetVariablesBuilder(this._dataConnect, {required  this.section,required  this.targetKgPerHour,});
  Deserializer<InsertMasterFrameTargetData> dataDeserializer = (dynamic json)  => InsertMasterFrameTargetData.fromJson(jsonDecode(json));
  Serializer<InsertMasterFrameTargetVariables> varsSerializer = (InsertMasterFrameTargetVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMasterFrameTargetData, InsertMasterFrameTargetVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMasterFrameTargetData, InsertMasterFrameTargetVariables> ref() {
    InsertMasterFrameTargetVariables vars= InsertMasterFrameTargetVariables(section: section,targetKgPerHour: targetKgPerHour,);
    return _dataConnect.mutation("InsertMasterFrameTarget", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMasterFrameTargetMasterFrameTargetInsert {
  final String id;
  InsertMasterFrameTargetMasterFrameTargetInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterFrameTargetMasterFrameTargetInsert otherTyped = other as InsertMasterFrameTargetMasterFrameTargetInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMasterFrameTargetMasterFrameTargetInsert({
    required this.id,
  });
}

@immutable
class InsertMasterFrameTargetData {
  final InsertMasterFrameTargetMasterFrameTargetInsert masterFrameTarget_insert;
  InsertMasterFrameTargetData.fromJson(dynamic json):
  
  masterFrameTarget_insert = InsertMasterFrameTargetMasterFrameTargetInsert.fromJson(json['masterFrameTarget_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterFrameTargetData otherTyped = other as InsertMasterFrameTargetData;
    return masterFrameTarget_insert == otherTyped.masterFrameTarget_insert;
    
  }
  @override
  int get hashCode => masterFrameTarget_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterFrameTarget_insert'] = masterFrameTarget_insert.toJson();
    return json;
  }

  InsertMasterFrameTargetData({
    required this.masterFrameTarget_insert,
  });
}

@immutable
class InsertMasterFrameTargetVariables {
  final String section;
  final double targetKgPerHour;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMasterFrameTargetVariables.fromJson(Map<String, dynamic> json):
  
  section = nativeFromJson<String>(json['section']),
  targetKgPerHour = nativeFromJson<double>(json['targetKgPerHour']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterFrameTargetVariables otherTyped = other as InsertMasterFrameTargetVariables;
    return section == otherTyped.section && 
    targetKgPerHour == otherTyped.targetKgPerHour;
    
  }
  @override
  int get hashCode => Object.hashAll([section.hashCode, targetKgPerHour.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['section'] = nativeToJson<String>(section);
    json['targetKgPerHour'] = nativeToJson<double>(targetKgPerHour);
    return json;
  }

  InsertMasterFrameTargetVariables({
    required this.section,
    required this.targetKgPerHour,
  });
}

