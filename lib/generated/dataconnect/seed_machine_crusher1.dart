part of 'default.dart';

class SeedMachineCrusher1VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMachineCrusher1VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMachineCrusher1Data> dataDeserializer = (dynamic json)  => SeedMachineCrusher1Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMachineCrusher1Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMachineCrusher1Data, void> ref() {
    
    return _dataConnect.mutation("SeedMachineCrusher1", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMachineCrusher1MasterMachineInsert {
  final String id;
  SeedMachineCrusher1MasterMachineInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachineCrusher1MasterMachineInsert otherTyped = other as SeedMachineCrusher1MasterMachineInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMachineCrusher1MasterMachineInsert({
    required this.id,
  });
}

@immutable
class SeedMachineCrusher1Data {
  final SeedMachineCrusher1MasterMachineInsert masterMachine_insert;
  SeedMachineCrusher1Data.fromJson(dynamic json):
  
  masterMachine_insert = SeedMachineCrusher1MasterMachineInsert.fromJson(json['masterMachine_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachineCrusher1Data otherTyped = other as SeedMachineCrusher1Data;
    return masterMachine_insert == otherTyped.masterMachine_insert;
    
  }
  @override
  int get hashCode => masterMachine_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMachine_insert'] = masterMachine_insert.toJson();
    return json;
  }

  SeedMachineCrusher1Data({
    required this.masterMachine_insert,
  });
}

