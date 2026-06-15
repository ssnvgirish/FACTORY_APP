part of 'default.dart';

class SeedScrapOperator1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapOperator1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapOperator1Data> dataDeserializer = (dynamic json)  => SeedScrapOperator1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapOperator1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapOperator1Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapOperator1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapOperator1UserInsert {
  final String id;
  SeedScrapOperator1UserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapOperator1UserInsert otherTyped = other as SeedScrapOperator1UserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapOperator1UserInsert({
    required this.id,
  });
}

@immutable
class SeedScrapOperator1Data {
  final SeedScrapOperator1UserInsert user_insert;
  SeedScrapOperator1Data.fromJson(dynamic json):
  
  user_insert = SeedScrapOperator1UserInsert.fromJson(json['user_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapOperator1Data otherTyped = other as SeedScrapOperator1Data;
    return user_insert == otherTyped.user_insert;
    
  }
  @override
  int get hashCode => user_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    return json;
  }

  SeedScrapOperator1Data({
    required this.user_insert,
  });
}

