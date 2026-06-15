part of 'default.dart';

class SeedMachineShredderVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMachineShredderVariablesBuilder(this._dataConnect, );
  Deserializer<SeedMachineShredderData> dataDeserializer = (dynamic json)  => SeedMachineShredderData.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMachineShredderData, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMachineShredderData, void> ref() {
    
    return _dataConnect.mutation("SeedMachineShredder", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMachineShredderMasterMachineInsert {
  final String id;
  SeedMachineShredderMasterMachineInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachineShredderMasterMachineInsert otherTyped = other as SeedMachineShredderMasterMachineInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMachineShredderMasterMachineInsert({
    required this.id,
  });
}

@immutable
class SeedMachineShredderData {
  final SeedMachineShredderMasterMachineInsert masterMachine_insert;
  SeedMachineShredderData.fromJson(dynamic json):
  
  masterMachine_insert = SeedMachineShredderMasterMachineInsert.fromJson(json['masterMachine_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachineShredderData otherTyped = other as SeedMachineShredderData;
    return masterMachine_insert == otherTyped.masterMachine_insert;
    
  }
  @override
  int get hashCode => masterMachine_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMachine_insert'] = masterMachine_insert.toJson();
    return json;
  }

  SeedMachineShredderData({
    required this.masterMachine_insert,
  });
}

