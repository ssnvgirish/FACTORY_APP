part of 'default.dart';

class SeedOperator2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedOperator2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedOperator2Data> dataDeserializer = (dynamic json)  => SeedOperator2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedOperator2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedOperator2Data, void> ref() {
    
    return _dataConnect.mutation("SeedOperator2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedOperator2UserInsert {
  final String id;
  SeedOperator2UserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedOperator2UserInsert otherTyped = other as SeedOperator2UserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedOperator2UserInsert({
    required this.id,
  });
}

@immutable
class SeedOperator2Data {
  final SeedOperator2UserInsert user_insert;
  SeedOperator2Data.fromJson(dynamic json):
  
  user_insert = SeedOperator2UserInsert.fromJson(json['user_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedOperator2Data otherTyped = other as SeedOperator2Data;
    return user_insert == otherTyped.user_insert;
    
  }
  @override
  int get hashCode => user_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    return json;
  }

  SeedOperator2Data({
    required this.user_insert,
  });
}

