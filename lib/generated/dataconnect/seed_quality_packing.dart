part of 'default.dart';

class SeedQualityPackingVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedQualityPackingVariablesBuilder(this._dataConnect, );
  Deserializer<SeedQualityPackingData> dataDeserializer = (dynamic json)  => SeedQualityPackingData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedQualityPackingData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedQualityPackingData, void> ref() {
    
    return _dataConnect.mutation("SeedQualityPacking", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedQualityPackingUserInsert {
  final String id;
  SeedQualityPackingUserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedQualityPackingUserInsert otherTyped = other as SeedQualityPackingUserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedQualityPackingUserInsert({
    required this.id,
  });
}

@immutable
class SeedQualityPackingData {
  final SeedQualityPackingUserInsert user_insert;
  SeedQualityPackingData.fromJson(dynamic json):
  
  user_insert = SeedQualityPackingUserInsert.fromJson(json['user_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedQualityPackingData otherTyped = other as SeedQualityPackingData;
    return user_insert == otherTyped.user_insert;
    
  }
  @override
  int get hashCode => user_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    return json;
  }

  SeedQualityPackingData({
    required this.user_insert,
  });
}

