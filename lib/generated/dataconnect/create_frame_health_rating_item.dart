part of 'default.dart';

class CreateFrameHealthRatingItemVariablesBuilder {
  CreateFrameHealthRatingItemVariablesReportId reportId;
  String item;
  int rating;

  final FirebaseDataConnect _dataConnect;
  CreateFrameHealthRatingItemVariablesBuilder(this._dataConnect, {required  this.reportId,required  this.item,required  this.rating,});
  Deserializer<CreateFrameHealthRatingItemData> dataDeserializer = (dynamic json)  => CreateFrameHealthRatingItemData.fromJson(jsonDecode(json));
  Serializer<CreateFrameHealthRatingItemVariables> varsSerializer = (CreateFrameHealthRatingItemVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateFrameHealthRatingItemData, CreateFrameHealthRatingItemVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateFrameHealthRatingItemData, CreateFrameHealthRatingItemVariables> ref() {
    CreateFrameHealthRatingItemVariables vars= CreateFrameHealthRatingItemVariables(reportId: reportId,item: item,rating: rating,);
    return _dataConnect.mutation("CreateFrameHealthRatingItem", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateFrameHealthRatingItemFrameHealthRatingItemInsert {
  final String id;
  CreateFrameHealthRatingItemFrameHealthRatingItemInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameHealthRatingItemFrameHealthRatingItemInsert otherTyped = other as CreateFrameHealthRatingItemFrameHealthRatingItemInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateFrameHealthRatingItemFrameHealthRatingItemInsert({
    required this.id,
  });
}

@immutable
class CreateFrameHealthRatingItemData {
  final CreateFrameHealthRatingItemFrameHealthRatingItemInsert frameHealthRatingItem_insert;
  CreateFrameHealthRatingItemData.fromJson(dynamic json):
  
  frameHealthRatingItem_insert = CreateFrameHealthRatingItemFrameHealthRatingItemInsert.fromJson(json['frameHealthRatingItem_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameHealthRatingItemData otherTyped = other as CreateFrameHealthRatingItemData;
    return frameHealthRatingItem_insert == otherTyped.frameHealthRatingItem_insert;
    
  }
  @override
  int get hashCode => frameHealthRatingItem_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['frameHealthRatingItem_insert'] = frameHealthRatingItem_insert.toJson();
    return json;
  }

  CreateFrameHealthRatingItemData({
    required this.frameHealthRatingItem_insert,
  });
}

@immutable
class CreateFrameHealthRatingItemVariablesReportId {
  final String id;
  CreateFrameHealthRatingItemVariablesReportId.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateFrameHealthRatingItemVariablesReportId otherTyped = other as CreateFrameHealthRatingItemVariablesReportId;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateFrameHealthRatingItemVariablesReportId({
    required this.id,
  });
}

@immutable
class CreateFrameHealthRatingItemVariables {
  final CreateFrameHealthRatingItemVariablesReportId reportId;
  final String item;
  final int rating;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateFrameHealthRatingItemVariables.fromJson(Map<String, dynamic> json):
  
  reportId = CreateFrameHealthRatingItemVariablesReportId.fromJson(json['reportId']),
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

    final CreateFrameHealthRatingItemVariables otherTyped = other as CreateFrameHealthRatingItemVariables;
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

  CreateFrameHealthRatingItemVariables({
    required this.reportId,
    required this.item,
    required this.rating,
  });
}

