part of 'default.dart';

class SeedShiftDayVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedShiftDayVariablesBuilder(this._dataConnect, );
  Deserializer<SeedShiftDayData> dataDeserializer = (dynamic json)  => SeedShiftDayData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedShiftDayData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedShiftDayData, void> ref() {
    
    return _dataConnect.mutation("SeedShiftDay", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedShiftDayMasterShiftInsert {
  final String id;
  SeedShiftDayMasterShiftInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedShiftDayMasterShiftInsert otherTyped = other as SeedShiftDayMasterShiftInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedShiftDayMasterShiftInsert({
    required this.id,
  });
}

@immutable
class SeedShiftDayData {
  final SeedShiftDayMasterShiftInsert masterShift_insert;
  SeedShiftDayData.fromJson(dynamic json):
  
  masterShift_insert = SeedShiftDayMasterShiftInsert.fromJson(json['masterShift_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedShiftDayData otherTyped = other as SeedShiftDayData;
    return masterShift_insert == otherTyped.masterShift_insert;
    
  }
  @override
  int get hashCode => masterShift_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterShift_insert'] = masterShift_insert.toJson();
    return json;
  }

  SeedShiftDayData({
    required this.masterShift_insert,
  });
}

