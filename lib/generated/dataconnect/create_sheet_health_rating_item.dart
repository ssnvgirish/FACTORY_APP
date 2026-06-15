part of 'default.dart';

class CreateSheetHealthRatingItemVariablesBuilder {
  CreateSheetHealthRatingItemVariablesReportId reportId;
  String item;
  int rating;

  final FirebaseDataConnect _dataConnect;
  CreateSheetHealthRatingItemVariablesBuilder(this._dataConnect, {required  this.reportId,required  this.item,required  this.rating,});
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

