part of 'default.dart';

class UpdateMasterSalaryWeightageVariablesBuilder {
  UpdateMasterSalaryWeightageVariablesId id;
  String variable;
  String label;
  String category;
  double percentage;

  final FirebaseDataConnect _dataConnect;
  UpdateMasterSalaryWeightageVariablesBuilder(this._dataConnect, {required  this.id,required  this.variable,required  this.label,required  this.category,required  this.percentage,});
  Deserializer<UpdateMasterSalaryWeightageData> dataDeserializer = (dynamic json)  => UpdateMasterSalaryWeightageData.fromJson(jsonDecode(json));
  Serializer<UpdateMasterSalaryWeightageVariables> varsSerializer = (UpdateMasterSalaryWeightageVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMasterSalaryWeightageData, UpdateMasterSalaryWeightageVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateMasterSalaryWeightageData, UpdateMasterSalaryWeightageVariables> ref() {
    UpdateMasterSalaryWeightageVariables vars= UpdateMasterSalaryWeightageVariables(id: id,variable: variable,label: label,category: category,percentage: percentage,);
    return _dataConnect.mutation("UpdateMasterSalaryWeightage", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateMasterSalaryWeightageMasterSalaryWeightageUpdate {
  final String id;
  UpdateMasterSalaryWeightageMasterSalaryWeightageUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSalaryWeightageMasterSalaryWeightageUpdate otherTyped = other as UpdateMasterSalaryWeightageMasterSalaryWeightageUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterSalaryWeightageMasterSalaryWeightageUpdate({
    required this.id,
  });
}

@immutable
class UpdateMasterSalaryWeightageData {
  final UpdateMasterSalaryWeightageMasterSalaryWeightageUpdate? masterSalaryWeightage_update;
  UpdateMasterSalaryWeightageData.fromJson(dynamic json):
  
  masterSalaryWeightage_update = json['masterSalaryWeightage_update'] == null ? null : UpdateMasterSalaryWeightageMasterSalaryWeightageUpdate.fromJson(json['masterSalaryWeightage_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSalaryWeightageData otherTyped = other as UpdateMasterSalaryWeightageData;
    return masterSalaryWeightage_update == otherTyped.masterSalaryWeightage_update;
    
  }
  @override
  int get hashCode => masterSalaryWeightage_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterSalaryWeightage_update != null) {
      json['masterSalaryWeightage_update'] = masterSalaryWeightage_update!.toJson();
    }
    return json;
  }

  UpdateMasterSalaryWeightageData({
    this.masterSalaryWeightage_update,
  });
}

@immutable
class UpdateMasterSalaryWeightageVariablesId {
  final String id;
  UpdateMasterSalaryWeightageVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSalaryWeightageVariablesId otherTyped = other as UpdateMasterSalaryWeightageVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterSalaryWeightageVariablesId({
    required this.id,
  });
}

@immutable
class UpdateMasterSalaryWeightageVariables {
  final UpdateMasterSalaryWeightageVariablesId id;
  final String variable;
  final String label;
  final String category;
  final double percentage;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateMasterSalaryWeightageVariables.fromJson(Map<String, dynamic> json):
  
  id = UpdateMasterSalaryWeightageVariablesId.fromJson(json['id']),
  variable = nativeFromJson<String>(json['variable']),
  label = nativeFromJson<String>(json['label']),
  category = nativeFromJson<String>(json['category']),
  percentage = nativeFromJson<double>(json['percentage']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterSalaryWeightageVariables otherTyped = other as UpdateMasterSalaryWeightageVariables;
    return id == otherTyped.id && 
    variable == otherTyped.variable && 
    label == otherTyped.label && 
    category == otherTyped.category && 
    percentage == otherTyped.percentage;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, variable.hashCode, label.hashCode, category.hashCode, percentage.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    json['variable'] = nativeToJson<String>(variable);
    json['label'] = nativeToJson<String>(label);
    json['category'] = nativeToJson<String>(category);
    json['percentage'] = nativeToJson<double>(percentage);
    return json;
  }

  UpdateMasterSalaryWeightageVariables({
    required this.id,
    required this.variable,
    required this.label,
    required this.category,
    required this.percentage,
  });
}

