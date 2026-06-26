part of 'default.dart';

class CreateSheetMaintenanceEntryVariablesBuilder {
  CreateSheetMaintenanceEntryVariablesReportId reportId;
  String maintenanceItem;
  Timestamp startTime;
  Timestamp endTime;
  String personDoingMaintenance;
  String description;
  double durationHours;

  final FirebaseDataConnect _dataConnect;
  CreateSheetMaintenanceEntryVariablesBuilder(this._dataConnect, {required  this.reportId,required  this.maintenanceItem,required  this.startTime,required  this.endTime,required  this.personDoingMaintenance,required  this.description,required  this.durationHours,});
  Deserializer<CreateSheetMaintenanceEntryData> dataDeserializer = (dynamic json)  => CreateSheetMaintenanceEntryData.fromJson(jsonDecode(json));
  Serializer<CreateSheetMaintenanceEntryVariables> varsSerializer = (CreateSheetMaintenanceEntryVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateSheetMaintenanceEntryData, CreateSheetMaintenanceEntryVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateSheetMaintenanceEntryData, CreateSheetMaintenanceEntryVariables> ref() {
    CreateSheetMaintenanceEntryVariables vars= CreateSheetMaintenanceEntryVariables(reportId: reportId,maintenanceItem: maintenanceItem,startTime: startTime,endTime: endTime,personDoingMaintenance: personDoingMaintenance,description: description,durationHours: durationHours,);
    return _dataConnect.mutation("CreateSheetMaintenanceEntry", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateSheetMaintenanceEntrySheetMaintenanceEntryInsert {
  final String id;
  CreateSheetMaintenanceEntrySheetMaintenanceEntryInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetMaintenanceEntrySheetMaintenanceEntryInsert otherTyped = other as CreateSheetMaintenanceEntrySheetMaintenanceEntryInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetMaintenanceEntrySheetMaintenanceEntryInsert({
    required this.id,
  });
}

@immutable
class CreateSheetMaintenanceEntryData {
  final CreateSheetMaintenanceEntrySheetMaintenanceEntryInsert sheetMaintenanceEntry_insert;
  CreateSheetMaintenanceEntryData.fromJson(dynamic json):
  
  sheetMaintenanceEntry_insert = CreateSheetMaintenanceEntrySheetMaintenanceEntryInsert.fromJson(json['sheetMaintenanceEntry_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetMaintenanceEntryData otherTyped = other as CreateSheetMaintenanceEntryData;
    return sheetMaintenanceEntry_insert == otherTyped.sheetMaintenanceEntry_insert;
    
  }
  @override
  int get hashCode => sheetMaintenanceEntry_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetMaintenanceEntry_insert'] = sheetMaintenanceEntry_insert.toJson();
    return json;
  }

  CreateSheetMaintenanceEntryData({
    required this.sheetMaintenanceEntry_insert,
  });
}

@immutable
class CreateSheetMaintenanceEntryVariablesReportId {
  final String id;
  CreateSheetMaintenanceEntryVariablesReportId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetMaintenanceEntryVariablesReportId otherTyped = other as CreateSheetMaintenanceEntryVariablesReportId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetMaintenanceEntryVariablesReportId({
    required this.id,
  });
}

@immutable
class CreateSheetMaintenanceEntryVariables {
  final CreateSheetMaintenanceEntryVariablesReportId reportId;
  final String maintenanceItem;
  final Timestamp startTime;
  final Timestamp endTime;
  final String personDoingMaintenance;
  final String description;
  final double durationHours;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateSheetMaintenanceEntryVariables.fromJson(Map<String, dynamic> json):
  
  reportId = CreateSheetMaintenanceEntryVariablesReportId.fromJson(json['reportId']),
  maintenanceItem = nativeFromJson<String>(json['maintenanceItem']),
  startTime = Timestamp.fromJson(json['startTime']),
  endTime = Timestamp.fromJson(json['endTime']),
  personDoingMaintenance = nativeFromJson<String>(json['personDoingMaintenance']),
  description = nativeFromJson<String>(json['description']),
  durationHours = nativeFromJson<double>(json['durationHours']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetMaintenanceEntryVariables otherTyped = other as CreateSheetMaintenanceEntryVariables;
    return reportId == otherTyped.reportId && 
    maintenanceItem == otherTyped.maintenanceItem && 
    startTime == otherTyped.startTime && 
    endTime == otherTyped.endTime && 
    personDoingMaintenance == otherTyped.personDoingMaintenance && 
    description == otherTyped.description && 
    durationHours == otherTyped.durationHours;
    
  }
  @override
  int get hashCode => Object.hashAll([reportId.hashCode, maintenanceItem.hashCode, startTime.hashCode, endTime.hashCode, personDoingMaintenance.hashCode, description.hashCode, durationHours.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['reportId'] = reportId.toJson();
    json['maintenanceItem'] = nativeToJson<String>(maintenanceItem);
    json['startTime'] = startTime.toJson();
    json['endTime'] = endTime.toJson();
    json['personDoingMaintenance'] = nativeToJson<String>(personDoingMaintenance);
    json['description'] = nativeToJson<String>(description);
    json['durationHours'] = nativeToJson<double>(durationHours);
    return json;
  }

  CreateSheetMaintenanceEntryVariables({
    required this.reportId,
    required this.maintenanceItem,
    required this.startTime,
    required this.endTime,
    required this.personDoingMaintenance,
    required this.description,
    required this.durationHours,
  });
}

  Deserializer<CreateSheetHealthRatingItemData> dataDeserializer = (dynamic json)  => CreateSheetHealthRatingItemData.fromJson(jsonDecode(json));
  Serializer<CreateSheetHealthRatingItemVariables> varsSerializer = (CreateSheetHealthRatingItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateSheetHealthRatingItemData, CreateSheetHealthRatingItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateSheetHealthRatingItemData, CreateSheetHealthRatingItemVariables> ref() {
    CreateSheetHealthRatingItemVariables vars= CreateSheetHealthRatingItemVariables(reportId: reportId,item: item,rating: rating,);
    return _dataConnect.mutation("CreateSheetHealthRatingItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateSheetHealthRatingItemSheetHealthRatingItemInsert {
  final String id;
  CreateSheetHealthRatingItemSheetHealthRatingItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetHealthRatingItemSheetHealthRatingItemInsert otherTyped = other as CreateSheetHealthRatingItemSheetHealthRatingItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetHealthRatingItemSheetHealthRatingItemInsert({
    required this.id,
  });
}

@immutable
class CreateSheetHealthRatingItemData {
  final CreateSheetHealthRatingItemSheetHealthRatingItemInsert sheetHealthRatingItem_insert;
  CreateSheetHealthRatingItemData.fromJson(dynamic json):
  
  sheetHealthRatingItem_insert = CreateSheetHealthRatingItemSheetHealthRatingItemInsert.fromJson(json['sheetHealthRatingItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetHealthRatingItemData otherTyped = other as CreateSheetHealthRatingItemData;
    return sheetHealthRatingItem_insert == otherTyped.sheetHealthRatingItem_insert;
    
  }
  @override
  int get hashCode => sheetHealthRatingItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['sheetHealthRatingItem_insert'] = sheetHealthRatingItem_insert.toJson();
    return json;
  }

  CreateSheetHealthRatingItemData({
    required this.sheetHealthRatingItem_insert,
  });
}

@immutable
class CreateSheetHealthRatingItemVariablesReportId {
  final String id;
  CreateSheetHealthRatingItemVariablesReportId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetHealthRatingItemVariablesReportId otherTyped = other as CreateSheetHealthRatingItemVariablesReportId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateSheetHealthRatingItemVariablesReportId({
    required this.id,
  });
}

@immutable
class CreateSheetHealthRatingItemVariables {
  final CreateSheetHealthRatingItemVariablesReportId reportId;
  final String item;
  final int rating;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateSheetHealthRatingItemVariables.fromJson(Map<String, dynamic> json):
  
  reportId = CreateSheetHealthRatingItemVariablesReportId.fromJson(json['reportId']),
  item = nativeFromJson<String>(json['item']),
  rating = nativeFromJson<int>(json['rating']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateSheetHealthRatingItemVariables otherTyped = other as CreateSheetHealthRatingItemVariables;
    return reportId == otherTyped.reportId && 
    item == otherTyped.item && 
    rating == otherTyped.rating;
    
  }
  @override
  int get hashCode => Object.hashAll([reportId.hashCode, item.hashCode, rating.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['reportId'] = reportId.toJson();
    json['item'] = nativeToJson<String>(item);
    json['rating'] = nativeToJson<int>(rating);
    return json;
  }

  CreateSheetHealthRatingItemVariables({
    required this.reportId,
    required this.item,
    required this.rating,
  });
}

