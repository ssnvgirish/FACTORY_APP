part of 'default.dart';

class ListMasterSalaryWeightagesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMasterSalaryWeightagesVariablesBuilder(this._dataConnect, );
  Deserializer<ListMasterSalaryWeightagesData> dataDeserializer = (dynamic json)  => ListMasterSalaryWeightagesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMasterSalaryWeightagesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMasterSalaryWeightagesData, void> ref() {
    
    return _dataConnect.query("ListMasterSalaryWeightages", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMasterSalaryWeightagesMasterSalaryWeightages {
  final String id;
  final String variable;
  final String label;
  final String category;
  final double percentage;
  ListMasterSalaryWeightagesMasterSalaryWeightages.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
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

    final ListMasterSalaryWeightagesMasterSalaryWeightages otherTyped = other as ListMasterSalaryWeightagesMasterSalaryWeightages;
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
    json['id'] = nativeToJson<String>(id);
    json['variable'] = nativeToJson<String>(variable);
    json['label'] = nativeToJson<String>(label);
    json['category'] = nativeToJson<String>(category);
    json['percentage'] = nativeToJson<double>(percentage);
    return json;
  }

  ListMasterSalaryWeightagesMasterSalaryWeightages({
    required this.id,
    required this.variable,
    required this.label,
    required this.category,
    required this.percentage,
  });
}

@immutable
class ListMasterSalaryWeightagesData {
  final List<ListMasterSalaryWeightagesMasterSalaryWeightages> masterSalaryWeightages;
  ListMasterSalaryWeightagesData.fromJson(dynamic json):
  
  masterSalaryWeightages = (json['masterSalaryWeightages'] as List<dynamic>)
        .map((e) => ListMasterSalaryWeightagesMasterSalaryWeightages.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMasterSalaryWeightagesData otherTyped = other as ListMasterSalaryWeightagesData;
    return masterSalaryWeightages == otherTyped.masterSalaryWeightages;
    
  }
  @override
  int get hashCode => masterSalaryWeightages.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSalaryWeightages'] = masterSalaryWeightages.map((e) => e.toJson()).toList();
    return json;
  }

  ListMasterSalaryWeightagesData({
    required this.masterSalaryWeightages,
  });
}

