part of 'default.dart';

class SeedMachineCrusher2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMachineCrusher2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMachineCrusher2Data> dataDeserializer = (dynamic json)  => SeedMachineCrusher2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMachineCrusher2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMachineCrusher2Data, void> ref() {
    
    return _dataConnect.mutation("SeedMachineCrusher2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMachineCrusher2MasterMachineInsert {
  final String id;
  SeedMachineCrusher2MasterMachineInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachineCrusher2MasterMachineInsert otherTyped = other as SeedMachineCrusher2MasterMachineInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMachineCrusher2MasterMachineInsert({
    required this.id,
  });
}

@immutable
class SeedMachineCrusher2Data {
  final SeedMachineCrusher2MasterMachineInsert masterMachine_insert;
  SeedMachineCrusher2Data.fromJson(dynamic json):
  
  masterMachine_insert = SeedMachineCrusher2MasterMachineInsert.fromJson(json['masterMachine_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachineCrusher2Data otherTyped = other as SeedMachineCrusher2Data;
    return masterMachine_insert == otherTyped.masterMachine_insert;
    
  }
  @override
  int get hashCode => masterMachine_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMachine_insert'] = masterMachine_insert.toJson();
    return json;
  }

  SeedMachineCrusher2Data({
    required this.masterMachine_insert,
  });
}

