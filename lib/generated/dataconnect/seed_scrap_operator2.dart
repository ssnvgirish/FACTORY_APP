part of 'default.dart';

class SeedScrapOperator2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedScrapOperator2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedScrapOperator2Data> dataDeserializer = (dynamic json)  => SeedScrapOperator2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedScrapOperator2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedScrapOperator2Data, void> ref() {
    
    return _dataConnect.mutation("SeedScrapOperator2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedScrapOperator2UserInsert {
  final String id;
  SeedScrapOperator2UserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapOperator2UserInsert otherTyped = other as SeedScrapOperator2UserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedScrapOperator2UserInsert({
    required this.id,
  });
}

@immutable
class SeedScrapOperator2Data {
  final SeedScrapOperator2UserInsert user_insert;
  SeedScrapOperator2Data.fromJson(dynamic json):
  
  user_insert = SeedScrapOperator2UserInsert.fromJson(json['user_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedScrapOperator2Data otherTyped = other as SeedScrapOperator2Data;
    return user_insert == otherTyped.user_insert;
    
  }
  @override
  int get hashCode => user_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    return json;
  }

  SeedScrapOperator2Data({
    required this.user_insert,
  });
}

