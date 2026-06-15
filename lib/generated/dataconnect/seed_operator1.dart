part of 'default.dart';

class SeedOperator1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedOperator1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedOperator1Data> dataDeserializer = (dynamic json)  => SeedOperator1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedOperator1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedOperator1Data, void> ref() {
    
    return _dataConnect.mutation("SeedOperator1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedOperator1UserInsert {
  final String id;
  SeedOperator1UserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedOperator1UserInsert otherTyped = other as SeedOperator1UserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedOperator1UserInsert({
    required this.id,
  });
}

@immutable
class SeedOperator1Data {
  final SeedOperator1UserInsert user_insert;
  SeedOperator1Data.fromJson(dynamic json):
  
  user_insert = SeedOperator1UserInsert.fromJson(json['user_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedOperator1Data otherTyped = other as SeedOperator1Data;
    return user_insert == otherTyped.user_insert;
    
  }
  @override
  int get hashCode => user_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    return json;
  }

  SeedOperator1Data({
    required this.user_insert,
  });
}

