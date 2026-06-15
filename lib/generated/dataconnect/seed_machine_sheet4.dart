part of 'default.dart';

class SeedMachineSheet4VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMachineSheet4VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMachineSheet4Data> dataDeserializer = (dynamic json)  => SeedMachineSheet4Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMachineSheet4Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMachineSheet4Data, void> ref() {
    
    return _dataConnect.mutation("SeedMachineSheet4", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMachineSheet4MasterMachineInsert {
  final String id;
  SeedMachineSheet4MasterMachineInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachineSheet4MasterMachineInsert otherTyped = other as SeedMachineSheet4MasterMachineInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMachineSheet4MasterMachineInsert({
    required this.id,
  });
}

@immutable
class SeedMachineSheet4Data {
  final SeedMachineSheet4MasterMachineInsert masterMachine_insert;
  SeedMachineSheet4Data.fromJson(dynamic json):
  
  masterMachine_insert = SeedMachineSheet4MasterMachineInsert.fromJson(json['masterMachine_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachineSheet4Data otherTyped = other as SeedMachineSheet4Data;
    return masterMachine_insert == otherTyped.masterMachine_insert;
    
  }
  @override
  int get hashCode => masterMachine_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMachine_insert'] = masterMachine_insert.toJson();
    return json;
  }

  SeedMachineSheet4Data({
    required this.masterMachine_insert,
  });
}

