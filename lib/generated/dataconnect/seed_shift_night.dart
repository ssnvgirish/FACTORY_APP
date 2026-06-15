part of 'default.dart';

class SeedShiftNightVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedShiftNightVariablesBuilder(this._dataConnect, );
  Deserializer<SeedShiftNightData> dataDeserializer = (dynamic json)  => SeedShiftNightData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedShiftNightData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedShiftNightData, void> ref() {
    
    return _dataConnect.mutation("SeedShiftNight", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedShiftNightMasterShiftInsert {
  final String id;
  SeedShiftNightMasterShiftInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedShiftNightMasterShiftInsert otherTyped = other as SeedShiftNightMasterShiftInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedShiftNightMasterShiftInsert({
    required this.id,
  });
}

@immutable
class SeedShiftNightData {
  final SeedShiftNightMasterShiftInsert masterShift_insert;
  SeedShiftNightData.fromJson(dynamic json):
  
  masterShift_insert = SeedShiftNightMasterShiftInsert.fromJson(json['masterShift_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedShiftNightData otherTyped = other as SeedShiftNightData;
    return masterShift_insert == otherTyped.masterShift_insert;
    
  }
  @override
  int get hashCode => masterShift_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterShift_insert'] = masterShift_insert.toJson();
    return json;
  }

  SeedShiftNightData({
    required this.masterShift_insert,
  });
}

