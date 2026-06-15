part of 'default.dart';

class SeedMachineSheet5VariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  SeedMachineSheet5VariablesBuilder(this._dataConnect, );
  Deserializer<SeedMachineSheet5Data> dataDeserializer = (dynamic json)  => SeedMachineSheet5Data.fromJson(jsonDecode(json));
  
  Future<OperationResult<SeedMachineSheet5Data, void>> execute() {
    return ref().execute();
  }

  MutationRef<SeedMachineSheet5Data, void> ref() {
    
    return _dataConnect.mutation("SeedMachineSheet5", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class SeedMachineSheet5MasterMachineInsert {
  final String id;
  SeedMachineSheet5MasterMachineInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachineSheet5MasterMachineInsert otherTyped = other as SeedMachineSheet5MasterMachineInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  SeedMachineSheet5MasterMachineInsert({
    required this.id,
  });
}

@immutable
class SeedMachineSheet5Data {
  final SeedMachineSheet5MasterMachineInsert masterMachine_insert;
  SeedMachineSheet5Data.fromJson(dynamic json):
  
  masterMachine_insert = SeedMachineSheet5MasterMachineInsert.fromJson(json['masterMachine_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final SeedMachineSheet5Data otherTyped = other as SeedMachineSheet5Data;
    return masterMachine_insert == otherTyped.masterMachine_insert;
    
  }
  @override
  int get hashCode => masterMachine_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['masterMachine_insert'] = masterMachine_insert.toJson();
    return json;
  }

  SeedMachineSheet5Data({
    required this.masterMachine_insert,
  });
}

