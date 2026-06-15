part of 'default.dart';

class SeedMachineFrame2VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMachineFrame2VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMachineFrame2Data> dataDeserializer = (dynamic json)  => SeedMachineFrame2Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMachineFrame2Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMachineFrame2Data, void> ref() {
    
    return _dataConnect.mutation("SeedMachineFrame2", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMachineFrame2MasterMachineInsert {
  final String id;
  SeedMachineFrame2MasterMachineInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachineFrame2MasterMachineInsert otherTyped = other as SeedMachineFrame2MasterMachineInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMachineFrame2MasterMachineInsert({
    required this.id,
  });
}

@immutable
class SeedMachineFrame2Data {
  final SeedMachineFrame2MasterMachineInsert masterMachine_insert;
  SeedMachineFrame2Data.fromJson(dynamic json):
  
  masterMachine_insert = SeedMachineFrame2MasterMachineInsert.fromJson(json['masterMachine_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachineFrame2Data otherTyped = other as SeedMachineFrame2Data;
    return masterMachine_insert == otherTyped.masterMachine_insert;
    
  }
  @override
  int get hashCode => masterMachine_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMachine_insert'] = masterMachine_insert.toJson();
    return json;
  }

  SeedMachineFrame2Data({
    required this.masterMachine_insert,
  });
}

