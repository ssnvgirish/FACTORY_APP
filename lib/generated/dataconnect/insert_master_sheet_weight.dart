part of 'default.dart';

class InsertMasterSheetWeightVariablesBuilder {
  String thickness;
  String density;
  double weightPerSqft;

  final FirebaseDataConnect _dataConnect;
  InsertMasterSheetWeightVariablesBuilder(this._dataConnect, {required  this.thickness,required  this.density,required  this.weightPerSqft,});
  Deserializer<InsertMasterSheetWeightData> dataDeserializer = (dynamic json)  => InsertMasterSheetWeightData.fromJson(jsonDecode(json));
  Serializer<InsertMasterSheetWeightVariables> varsSerializer = (InsertMasterSheetWeightVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMasterSheetWeightData, InsertMasterSheetWeightVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMasterSheetWeightData, InsertMasterSheetWeightVariables> ref() {
    InsertMasterSheetWeightVariables vars= InsertMasterSheetWeightVariables(thickness: thickness,density: density,weightPerSqft: weightPerSqft,);
    return _dataConnect.mutation("InsertMasterSheetWeight", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMasterSheetWeightMasterSheetWeightInsert {
  final String id;
  InsertMasterSheetWeightMasterSheetWeightInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterSheetWeightMasterSheetWeightInsert otherTyped = other as InsertMasterSheetWeightMasterSheetWeightInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMasterSheetWeightMasterSheetWeightInsert({
    required this.id,
  });
}

@immutable
class InsertMasterSheetWeightData {
  final InsertMasterSheetWeightMasterSheetWeightInsert masterSheetWeight_insert;
  InsertMasterSheetWeightData.fromJson(dynamic json):
  
  masterSheetWeight_insert = InsertMasterSheetWeightMasterSheetWeightInsert.fromJson(json['masterSheetWeight_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterSheetWeightData otherTyped = other as InsertMasterSheetWeightData;
    return masterSheetWeight_insert == otherTyped.masterSheetWeight_insert;
    
  }
  @override
  int get hashCode => masterSheetWeight_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSheetWeight_insert'] = masterSheetWeight_insert.toJson();
    return json;
  }

  InsertMasterSheetWeightData({
    required this.masterSheetWeight_insert,
  });
}

@immutable
class InsertMasterSheetWeightVariables {
  final String thickness;
  final String density;
  final double weightPerSqft;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMasterSheetWeightVariables.fromJson(Map<String, dynamic> json):
  
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

    final InsertMasterSheetWeightVariables otherTyped = other as InsertMasterSheetWeightVariables;
    return thickness == otherTyped.thickness && 
    density == otherTyped.density && 
    weightPerSqft == otherTyped.weightPerSqft;
    
  }
  @override
  int get hashCode => Object.hashAll([thickness.hashCode, density.hashCode, weightPerSqft.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['thickness'] = nativeToJson<String>(thickness);
    json['density'] = nativeToJson<String>(density);
    json['weightPerSqft'] = nativeToJson<double>(weightPerSqft);
    return json;
  }

  InsertMasterSheetWeightVariables({
    required this.thickness,
    required this.density,
    required this.weightPerSqft,
  });
}

