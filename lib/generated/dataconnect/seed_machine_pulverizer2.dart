part of 'default.dart';

class SeedMachinePulverizer2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMachinePulverizer2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMachinePulverizer2Data> dataDeserializer = (dynamic json)  => SeedMachinePulverizer2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMachinePulverizer2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMachinePulverizer2Data, void> ref() {
    
    return _dataConnect.mutation("SeedMachinePulverizer2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMachinePulverizer2MasterMachineInsert {
  final String id;
  SeedMachinePulverizer2MasterMachineInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachinePulverizer2MasterMachineInsert otherTyped = other as SeedMachinePulverizer2MasterMachineInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMachinePulverizer2MasterMachineInsert({
    required this.id,
  });
}

@immutable
class SeedMachinePulverizer2Data {
  final SeedMachinePulverizer2MasterMachineInsert masterMachine_insert;
  SeedMachinePulverizer2Data.fromJson(dynamic json):
  
  masterMachine_insert = SeedMachinePulverizer2MasterMachineInsert.fromJson(json['masterMachine_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachinePulverizer2Data otherTyped = other as SeedMachinePulverizer2Data;
    return masterMachine_insert == otherTyped.masterMachine_insert;
    
  }
  @override
  int get hashCode => masterMachine_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMachine_insert'] = masterMachine_insert.toJson();
    return json;
  }

  SeedMachinePulverizer2Data({
    required this.masterMachine_insert,
  });
}

