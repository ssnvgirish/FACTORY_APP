part of 'default.dart';

class SeedMachineSheet3VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMachineSheet3VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMachineSheet3Data> dataDeserializer = (dynamic json)  => SeedMachineSheet3Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMachineSheet3Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMachineSheet3Data, void> ref() {
    
    return _dataConnect.mutation("SeedMachineSheet3", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMachineSheet3MasterMachineInsert {
  final String id;
  SeedMachineSheet3MasterMachineInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachineSheet3MasterMachineInsert otherTyped = other as SeedMachineSheet3MasterMachineInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMachineSheet3MasterMachineInsert({
    required this.id,
  });
}

@immutable
class SeedMachineSheet3Data {
  final SeedMachineSheet3MasterMachineInsert masterMachine_insert;
  SeedMachineSheet3Data.fromJson(dynamic json):
  
  masterMachine_insert = SeedMachineSheet3MasterMachineInsert.fromJson(json['masterMachine_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachineSheet3Data otherTyped = other as SeedMachineSheet3Data;
    return masterMachine_insert == otherTyped.masterMachine_insert;
    
  }
  @override
  int get hashCode => masterMachine_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMachine_insert'] = masterMachine_insert.toJson();
    return json;
  }

  SeedMachineSheet3Data({
    required this.masterMachine_insert,
  });
}

