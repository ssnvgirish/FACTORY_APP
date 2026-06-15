part of 'default.dart';

class SeedMachineFrame1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMachineFrame1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMachineFrame1Data> dataDeserializer = (dynamic json)  => SeedMachineFrame1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMachineFrame1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMachineFrame1Data, void> ref() {
    
    return _dataConnect.mutation("SeedMachineFrame1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMachineFrame1MasterMachineInsert {
  final String id;
  SeedMachineFrame1MasterMachineInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachineFrame1MasterMachineInsert otherTyped = other as SeedMachineFrame1MasterMachineInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMachineFrame1MasterMachineInsert({
    required this.id,
  });
}

@immutable
class SeedMachineFrame1Data {
  final SeedMachineFrame1MasterMachineInsert masterMachine_insert;
  SeedMachineFrame1Data.fromJson(dynamic json):
  
  masterMachine_insert = SeedMachineFrame1MasterMachineInsert.fromJson(json['masterMachine_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachineFrame1Data otherTyped = other as SeedMachineFrame1Data;
    return masterMachine_insert == otherTyped.masterMachine_insert;
    
  }
  @override
  int get hashCode => masterMachine_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMachine_insert'] = masterMachine_insert.toJson();
    return json;
  }

  SeedMachineFrame1Data({
    required this.masterMachine_insert,
  });
}

