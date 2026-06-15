part of 'default.dart';

class CreateScrapQualityReportVariablesBuilder {
  DateTime date;
  String machineNumber;
  String shift;
  String product;
  int qualityRating;
  Optional<String> _comments = Optional.optional(nativeFromJson, nativeToJson);
  String createdBy;

  final FirebaseDataConnect _dataConnect;  CreateScrapQualityReportVariablesBuilder comments(String? t) {
   _comments.value = t;
   return this;
  }

  CreateScrapQualityReportVariablesBuilder(this._dataConnect, {required  this.date,required  this.machineNumber,required  this.shift,required  this.product,required  this.qualityRating,required  this.createdBy,});
  Deserializer<CreateScrapQualityReportData> dataDeserializer = (dynamic json)  => CreateScrapQualityReportData.fromJson(jsonDecode(json));
  Serializer<CreateScrapQualityReportVariables> varsSerializer = (CreateScrapQualityReportVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateScrapQualityReportData, CreateScrapQualityReportVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateScrapQualityReportData, CreateScrapQualityReportVariables> ref() {
    CreateScrapQualityReportVariables vars= CreateScrapQualityReportVariables(date: date,machineNumber: machineNumber,shift: shift,product: product,qualityRating: qualityRating,comments: _comments,createdBy: createdBy,);
    return _dataConnect.mutation("CreateScrapQualityReport", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateScrapQualityReportScrapQualityReportInsert {
  final String id;
  CreateScrapQualityReportScrapQualityReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapQualityReportScrapQualityReportInsert otherTyped = other as CreateScrapQualityReportScrapQualityReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateScrapQualityReportScrapQualityReportInsert({
    required this.id,
  });
}

@immutable
class CreateScrapQualityReportData {
  final CreateScrapQualityReportScrapQualityReportInsert scrapQualityReport_insert;
  CreateScrapQualityReportData.fromJson(dynamic json):
  
  scrapQualityReport_insert = CreateScrapQualityReportScrapQualityReportInsert.fromJson(json['scrapQualityReport_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapQualityReportData otherTyped = other as CreateScrapQualityReportData;
    return scrapQualityReport_insert == otherTyped.scrapQualityReport_insert;
    
  }
  @override
  int get hashCode => scrapQualityReport_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapQualityReport_insert'] = scrapQualityReport_insert.toJson();
    return json;
  }

  CreateScrapQualityReportData({
    required this.scrapQualityReport_insert,
  });
}

@immutable
class CreateScrapQualityReportVariables {
  final DateTime date;
  final String machineNumber;
  final String shift;
  final String product;
  final int qualityRating;
  late final Optional<String>comments;
  final String createdBy;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateScrapQualityReportVariables.fromJson(Map<String, dynamic> json):
  
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  product = nativeFromJson<String>(json['product']),
  qualityRating = nativeFromJson<int>(json['qualityRating']),
  createdBy = nativeFromJson<String>(json['createdBy']) {
  
  
  
  
  
  
  
    comments = Optional.optional(nativeFromJson, nativeToJson);
    comments.value = json['comments'] == null ? null : nativeFromJson<String>(json['comments']);
  
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateScrapQualityReportVariables otherTyped = other as CreateScrapQualityReportVariables;
    return date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    product == otherTyped.product && 
    qualityRating == otherTyped.qualityRating && 
    comments == otherTyped.comments && 
    createdBy == otherTyped.createdBy;
    
  }
  @override
  int get hashCode => Object.hashAll([date.hashCode, machineNumber.hashCode, shift.hashCode, product.hashCode, qualityRating.hashCode, comments.hashCode, createdBy.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['product'] = nativeToJson<String>(product);
    json['qualityRating'] = nativeToJson<int>(qualityRating);
    if(comments.state == OptionalState.set) {
      json['comments'] = comments.toJson();
    }
    json['createdBy'] = nativeToJson<String>(createdBy);
    return json;
  }

  CreateScrapQualityReportVariables({
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.product,
    required this.qualityRating,
    required this.comments,
    required this.createdBy,
  });
}

