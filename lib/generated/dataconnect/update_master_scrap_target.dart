part of 'default.dart';

class UpdateMasterScrapTargetVariablesBuilder {
  UpdateMasterScrapTargetVariablesId id;
  String product;
  double targetKgPerHour;

  final FirebaseDataConnect _dataConnect;
  UpdateMasterScrapTargetVariablesBuilder(this._dataConnect, {required  this.id,required  this.product,required  this.targetKgPerHour,});
  Deserializer<UpdateMasterScrapTargetData> dataDeserializer = (dynamic json)  => UpdateMasterScrapTargetData.fromJson(jsonDecode(json));
  Serializer<UpdateMasterScrapTargetVariables> varsSerializer = (UpdateMasterScrapTargetVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMasterScrapTargetData, UpdateMasterScrapTargetVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateMasterScrapTargetData, UpdateMasterScrapTargetVariables> ref() {
    UpdateMasterScrapTargetVariables vars= UpdateMasterScrapTargetVariables(id: id,product: product,targetKgPerHour: targetKgPerHour,);
    return _dataConnect.mutation("UpdateMasterScrapTarget", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateMasterScrapTargetMasterScrapTargetUpdate {
  final String id;
  UpdateMasterScrapTargetMasterScrapTargetUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterScrapTargetMasterScrapTargetUpdate otherTyped = other as UpdateMasterScrapTargetMasterScrapTargetUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterScrapTargetMasterScrapTargetUpdate({
    required this.id,
  });
}

@immutable
class UpdateMasterScrapTargetData {
  final UpdateMasterScrapTargetMasterScrapTargetUpdate? masterScrapTarget_update;
  UpdateMasterScrapTargetData.fromJson(dynamic json):
  
  masterScrapTarget_update = json['masterScrapTarget_update'] == null ? null : UpdateMasterScrapTargetMasterScrapTargetUpdate.fromJson(json['masterScrapTarget_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterScrapTargetData otherTyped = other as UpdateMasterScrapTargetData;
    return masterScrapTarget_update == otherTyped.masterScrapTarget_update;
    
  }
  @override
  int get hashCode => masterScrapTarget_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (masterScrapTarget_update != null) {
      json['masterScrapTarget_update'] = masterScrapTarget_update!.toJson();
    }
    return json;
  }

  UpdateMasterScrapTargetData({
    this.masterScrapTarget_update,
  });
}

@immutable
class UpdateMasterScrapTargetVariablesId {
  final String id;
  UpdateMasterScrapTargetVariablesId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterScrapTargetVariablesId otherTyped = other as UpdateMasterScrapTargetVariablesId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateMasterScrapTargetVariablesId({
    required this.id,
  });
}

@immutable
class UpdateMasterScrapTargetVariables {
  final UpdateMasterScrapTargetVariablesId id;
  final String product;
  final double targetKgPerHour;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateMasterScrapTargetVariables.fromJson(Map<String, dynamic> json):
  
  id = UpdateMasterScrapTargetVariablesId.fromJson(json['id']),
  product = nativeFromJson<String>(json['product']),
  targetKgPerHour = nativeFromJson<double>(json['targetKgPerHour']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMasterScrapTargetVariables otherTyped = other as UpdateMasterScrapTargetVariables;
    return id == otherTyped.id && 
    product == otherTyped.product && 
    targetKgPerHour == otherTyped.targetKgPerHour;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, product.hashCode, targetKgPerHour.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id.toJson();
    json['product'] = nativeToJson<String>(product);
    json['targetKgPerHour'] = nativeToJson<double>(targetKgPerHour);
    return json;
  }

  UpdateMasterScrapTargetVariables({
    required this.id,
    required this.product,
    required this.targetKgPerHour,
  });
}

