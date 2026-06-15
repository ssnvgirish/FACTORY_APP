part of 'default.dart';

class SeedMachineCrusher3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMachineCrusher3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMachineCrusher3Data> dataDeserializer = (dynamic json)  => SeedMachineCrusher3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMachineCrusher3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMachineCrusher3Data, void> ref() {
    
    return _dataConnect.mutation("SeedMachineCrusher3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMachineCrusher3MasterMachineInsert {
  final String id;
  SeedMachineCrusher3MasterMachineInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachineCrusher3MasterMachineInsert otherTyped = other as SeedMachineCrusher3MasterMachineInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMachineCrusher3MasterMachineInsert({
    required this.id,
  });
}

@immutable
class SeedMachineCrusher3Data {
  final SeedMachineCrusher3MasterMachineInsert masterMachine_insert;
  SeedMachineCrusher3Data.fromJson(dynamic json):
  
  masterMachine_insert = SeedMachineCrusher3MasterMachineInsert.fromJson(json['masterMachine_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachineCrusher3Data otherTyped = other as SeedMachineCrusher3Data;
    return masterMachine_insert == otherTyped.masterMachine_insert;
    
  }
  @override
  int get hashCode => masterMachine_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMachine_insert'] = masterMachine_insert.toJson();
    return json;
  }

  SeedMachineCrusher3Data({
    required this.masterMachine_insert,
  });
}

