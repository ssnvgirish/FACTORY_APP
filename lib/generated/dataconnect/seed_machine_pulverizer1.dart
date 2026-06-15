part of 'default.dart';

class SeedMachinePulverizer1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMachinePulverizer1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMachinePulverizer1Data> dataDeserializer = (dynamic json)  => SeedMachinePulverizer1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMachinePulverizer1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMachinePulverizer1Data, void> ref() {
    
    return _dataConnect.mutation("SeedMachinePulverizer1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMachinePulverizer1MasterMachineInsert {
  final String id;
  SeedMachinePulverizer1MasterMachineInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachinePulverizer1MasterMachineInsert otherTyped = other as SeedMachinePulverizer1MasterMachineInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMachinePulverizer1MasterMachineInsert({
    required this.id,
  });
}

@immutable
class SeedMachinePulverizer1Data {
  final SeedMachinePulverizer1MasterMachineInsert masterMachine_insert;
  SeedMachinePulverizer1Data.fromJson(dynamic json):
  
  masterMachine_insert = SeedMachinePulverizer1MasterMachineInsert.fromJson(json['masterMachine_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachinePulverizer1Data otherTyped = other as SeedMachinePulverizer1Data;
    return masterMachine_insert == otherTyped.masterMachine_insert;
    
  }
  @override
  int get hashCode => masterMachine_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMachine_insert'] = masterMachine_insert.toJson();
    return json;
  }

  SeedMachinePulverizer1Data({
    required this.masterMachine_insert,
  });
}

