part of 'default.dart';

class SeedOperator4VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedOperator4VariablesBuilder(this._dataConnect, );
  Deserializer<SeedOperator4Data> dataDeserializer = (dynamic json)  => SeedOperator4Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedOperator4Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedOperator4Data, void> ref() {
    
    return _dataConnect.mutation("SeedOperator4", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedOperator4UserInsert {
  final String id;
  SeedOperator4UserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedOperator4UserInsert otherTyped = other as SeedOperator4UserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedOperator4UserInsert({
    required this.id,
  });
}

@immutable
class SeedOperator4Data {
  final SeedOperator4UserInsert user_insert;
  SeedOperator4Data.fromJson(dynamic json):
  
  user_insert = SeedOperator4UserInsert.fromJson(json['user_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedOperator4Data otherTyped = other as SeedOperator4Data;
    return user_insert == otherTyped.user_insert;
    
  }
  @override
  int get hashCode => user_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    return json;
  }

  SeedOperator4Data({
    required this.user_insert,
  });
}

