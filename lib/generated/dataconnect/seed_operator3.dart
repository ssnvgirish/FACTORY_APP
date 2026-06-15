part of 'default.dart';

class SeedOperator3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedOperator3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedOperator3Data> dataDeserializer = (dynamic json)  => SeedOperator3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedOperator3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedOperator3Data, void> ref() {
    
    return _dataConnect.mutation("SeedOperator3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedOperator3UserInsert {
  final String id;
  SeedOperator3UserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedOperator3UserInsert otherTyped = other as SeedOperator3UserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedOperator3UserInsert({
    required this.id,
  });
}

@immutable
class SeedOperator3Data {
  final SeedOperator3UserInsert user_insert;
  SeedOperator3Data.fromJson(dynamic json):
  
  user_insert = SeedOperator3UserInsert.fromJson(json['user_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedOperator3Data otherTyped = other as SeedOperator3Data;
    return user_insert == otherTyped.user_insert;
    
  }
  @override
  int get hashCode => user_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    return json;
  }

  SeedOperator3Data({
    required this.user_insert,
  });
}

