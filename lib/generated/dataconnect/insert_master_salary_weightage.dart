part of 'default.dart';

class InsertMasterSalaryWeightageVariablesBuilder {
  String variable;
  String label;
  String category;
  double percentage;

  final FirebaseDataConnect _dataConnect;
  InsertMasterSalaryWeightageVariablesBuilder(this._dataConnect, {required  this.variable,required  this.label,required  this.category,required  this.percentage,});
  Deserializer<InsertMasterSalaryWeightageData> dataDeserializer = (dynamic json)  => InsertMasterSalaryWeightageData.fromJson(jsonDecode(json));
  Serializer<InsertMasterSalaryWeightageVariables> varsSerializer = (InsertMasterSalaryWeightageVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<InsertMasterSalaryWeightageData, InsertMasterSalaryWeightageVariables>> execute() {
    return ref().execute();
  }

  MutationRef<InsertMasterSalaryWeightageData, InsertMasterSalaryWeightageVariables> ref() {
    InsertMasterSalaryWeightageVariables vars= InsertMasterSalaryWeightageVariables(variable: variable,label: label,category: category,percentage: percentage,);
    return _dataConnect.mutation("InsertMasterSalaryWeightage", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class InsertMasterSalaryWeightageMasterSalaryWeightageInsert {
  final String id;
  InsertMasterSalaryWeightageMasterSalaryWeightageInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterSalaryWeightageMasterSalaryWeightageInsert otherTyped = other as InsertMasterSalaryWeightageMasterSalaryWeightageInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  InsertMasterSalaryWeightageMasterSalaryWeightageInsert({
    required this.id,
  });
}

@immutable
class InsertMasterSalaryWeightageData {
  final InsertMasterSalaryWeightageMasterSalaryWeightageInsert masterSalaryWeightage_insert;
  InsertMasterSalaryWeightageData.fromJson(dynamic json):
  
  masterSalaryWeightage_insert = InsertMasterSalaryWeightageMasterSalaryWeightageInsert.fromJson(json['masterSalaryWeightage_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final InsertMasterSalaryWeightageData otherTyped = other as InsertMasterSalaryWeightageData;
    return masterSalaryWeightage_insert == otherTyped.masterSalaryWeightage_insert;
    
  }
  @override
  int get hashCode => masterSalaryWeightage_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSalaryWeightage_insert'] = masterSalaryWeightage_insert.toJson();
    return json;
  }

  InsertMasterSalaryWeightageData({
    required this.masterSalaryWeightage_insert,
  });
}

@immutable
class InsertMasterSalaryWeightageVariables {
  final String variable;
  final String label;
  final String category;
  final double percentage;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  InsertMasterSalaryWeightageVariables.fromJson(Map<String, dynamic> json):
  
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

    final InsertMasterSalaryWeightageVariables otherTyped = other as InsertMasterSalaryWeightageVariables;
    return variable == otherTyped.variable && 
    label == otherTyped.label && 
    category == otherTyped.category && 
    percentage == otherTyped.percentage;
    
  }
  @override
  int get hashCode => Object.hashAll([variable.hashCode, label.hashCode, category.hashCode, percentage.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['variable'] = nativeToJson<String>(variable);
    json['label'] = nativeToJson<String>(label);
    json['category'] = nativeToJson<String>(category);
    json['percentage'] = nativeToJson<double>(percentage);
    return json;
  }

  InsertMasterSalaryWeightageVariables({
    required this.variable,
    required this.label,
    required this.category,
    required this.percentage,
  });
}

