part of 'default.dart';

class SeedAdminUserVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedAdminUserVariablesBuilder(this._dataConnect, );
  Deserializer<SeedAdminUserData> dataDeserializer = (dynamic json)  => SeedAdminUserData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedAdminUserData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedAdminUserData, void> ref() {
    
    return _dataConnect.mutation("SeedAdminUser", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedAdminUserUserInsert {
  final String id;
  SeedAdminUserUserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedAdminUserUserInsert otherTyped = other as SeedAdminUserUserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedAdminUserUserInsert({
    required this.id,
  });
}

@immutable
class SeedAdminUserData {
  final SeedAdminUserUserInsert user_insert;
  SeedAdminUserData.fromJson(dynamic json):
  
  user_insert = SeedAdminUserUserInsert.fromJson(json['user_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedAdminUserData otherTyped = other as SeedAdminUserData;
    return user_insert == otherTyped.user_insert;
    
  }
  @override
  int get hashCode => user_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    return json;
  }

  SeedAdminUserData({
    required this.user_insert,
  });
}

