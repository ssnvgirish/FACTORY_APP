part of 'default.dart';

class SeedMachinePulverizer3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMachinePulverizer3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMachinePulverizer3Data> dataDeserializer = (dynamic json)  => SeedMachinePulverizer3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMachinePulverizer3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMachinePulverizer3Data, void> ref() {
    
    return _dataConnect.mutation("SeedMachinePulverizer3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMachinePulverizer3MasterMachineInsert {
  final String id;
  SeedMachinePulverizer3MasterMachineInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachinePulverizer3MasterMachineInsert otherTyped = other as SeedMachinePulverizer3MasterMachineInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMachinePulverizer3MasterMachineInsert({
    required this.id,
  });
}

@immutable
class SeedMachinePulverizer3Data {
  final SeedMachinePulverizer3MasterMachineInsert masterMachine_insert;
  SeedMachinePulverizer3Data.fromJson(dynamic json):
  
  masterMachine_insert = SeedMachinePulverizer3MasterMachineInsert.fromJson(json['masterMachine_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachinePulverizer3Data otherTyped = other as SeedMachinePulverizer3Data;
    return masterMachine_insert == otherTyped.masterMachine_insert;
    
  }
  @override
  int get hashCode => masterMachine_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMachine_insert'] = masterMachine_insert.toJson();
    return json;
  }

  SeedMachinePulverizer3Data({
    required this.masterMachine_insert,
  });
}

