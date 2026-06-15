part of 'default.dart';

class GetScrapSalaryWeightagesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetScrapSalaryWeightagesVariablesBuilder(this._dataConnect, );
  Deserializer<GetScrapSalaryWeightagesData> dataDeserializer = (dynamic json)  => GetScrapSalaryWeightagesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetScrapSalaryWeightagesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetScrapSalaryWeightagesData, void> ref() {
    
    return _dataConnect.query("GetScrapSalaryWeightages", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class GetScrapSalaryWeightagesMasterSalaryWeightages {
  final String id;
  final String variable;
  final String label;
  final String category;
  final double percentage;
  GetScrapSalaryWeightagesMasterSalaryWeightages.fromJson(dynamic json):
  
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

    final GetScrapSalaryWeightagesMasterSalaryWeightages otherTyped = other as GetScrapSalaryWeightagesMasterSalaryWeightages;
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

  GetScrapSalaryWeightagesMasterSalaryWeightages({
    required this.id,
    required this.variable,
    required this.label,
    required this.category,
    required this.percentage,
  });
}

@immutable
class GetScrapSalaryWeightagesData {
  final List<GetScrapSalaryWeightagesMasterSalaryWeightages> masterSalaryWeightages;
  GetScrapSalaryWeightagesData.fromJson(dynamic json):
  
  masterSalaryWeightages = (json['masterSalaryWeightages'] as List<dynamic>)
        .map((e) => GetScrapSalaryWeightagesMasterSalaryWeightages.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetScrapSalaryWeightagesData otherTyped = other as GetScrapSalaryWeightagesData;
    return masterSalaryWeightages == otherTyped.masterSalaryWeightages;
    
  }
  @override
  int get hashCode => masterSalaryWeightages.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterSalaryWeightages'] = masterSalaryWeightages.map((e) => e.toJson()).toList();
    return json;
  }

  GetScrapSalaryWeightagesData({
    required this.masterSalaryWeightages,
  });
}

