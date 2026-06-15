part of 'default.dart';

class ListScrapQualityReportsVariablesBuilder {
  Optional<String> _machineNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _startDate = Optional.optional(nativeFromJson, nativeToJson);
  Optional<DateTime> _endDate = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;
  ListScrapQualityReportsVariablesBuilder machineNumber(String? t) {
   _machineNumber.value = t;
   return this;
  }
  ListScrapQualityReportsVariablesBuilder startDate(DateTime? t) {
   _startDate.value = t;
   return this;
  }
  ListScrapQualityReportsVariablesBuilder endDate(DateTime? t) {
   _endDate.value = t;
   return this;
  }

  ListScrapQualityReportsVariablesBuilder(this._dataConnect, );
  Deserializer<ListScrapQualityReportsData> dataDeserializer = (dynamic json)  => ListScrapQualityReportsData.fromJson(jsonDecode(json));
  Serializer<ListScrapQualityReportsVariables> varsSerializer = (ListScrapQualityReportsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListScrapQualityReportsData, ListScrapQualityReportsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<ListScrapQualityReportsData, ListScrapQualityReportsVariables> ref() {
    ListScrapQualityReportsVariables vars= ListScrapQualityReportsVariables(machineNumber: _machineNumber,startDate: _startDate,endDate: _endDate,);
    return _dataConnect.query("ListScrapQualityReports", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ListScrapQualityReportsScrapQualityReports {
  final String id;
  final DateTime date;
  final String machineNumber;
  final String shift;
  final String product;
  final int qualityRating;
  final String? comments;
  final String createdBy;
  final Timestamp? timestamp;
  ListScrapQualityReportsScrapQualityReports.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = nativeFromJson<DateTime>(json['date']),
  machineNumber = nativeFromJson<String>(json['machineNumber']),
  shift = nativeFromJson<String>(json['shift']),
  product = nativeFromJson<String>(json['product']),
  qualityRating = nativeFromJson<int>(json['qualityRating']),
  comments = json['comments'] == null ? null : nativeFromJson<String>(json['comments']),
  createdBy = nativeFromJson<String>(json['createdBy']),
  timestamp = json['timestamp'] == null ? null : Timestamp.fromJson(json['timestamp']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListScrapQualityReportsScrapQualityReports otherTyped = other as ListScrapQualityReportsScrapQualityReports;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    machineNumber == otherTyped.machineNumber && 
    shift == otherTyped.shift && 
    product == otherTyped.product && 
    qualityRating == otherTyped.qualityRating && 
    comments == otherTyped.comments && 
    createdBy == otherTyped.createdBy && 
    timestamp == otherTyped.timestamp;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, machineNumber.hashCode, shift.hashCode, product.hashCode, qualityRating.hashCode, comments.hashCode, createdBy.hashCode, timestamp.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['date'] = nativeToJson<DateTime>(date);
    json['machineNumber'] = nativeToJson<String>(machineNumber);
    json['shift'] = nativeToJson<String>(shift);
    json['product'] = nativeToJson<String>(product);
    json['qualityRating'] = nativeToJson<int>(qualityRating);
    if (comments != null) {
      json['comments'] = nativeToJson<String?>(comments);
    }
    json['createdBy'] = nativeToJson<String>(createdBy);
    if (timestamp != null) {
      json['timestamp'] = timestamp!.toJson();
    }
    return json;
  }

  ListScrapQualityReportsScrapQualityReports({
    required this.id,
    required this.date,
    required this.machineNumber,
    required this.shift,
    required this.product,
    required this.qualityRating,
    this.comments,
    required this.createdBy,
    this.timestamp,
  });
}

@immutable
class ListScrapQualityReportsData {
  final List<ListScrapQualityReportsScrapQualityReports> scrapQualityReports;
  ListScrapQualityReportsData.fromJson(dynamic json):
  
  scrapQualityReports = (json['scrapQualityReports'] as List<dynamic>)
        .map((e) => ListScrapQualityReportsScrapQualityReports.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListScrapQualityReportsData otherTyped = other as ListScrapQualityReportsData;
    return scrapQualityReports == otherTyped.scrapQualityReports;
    
  }
  @override
  int get hashCode => scrapQualityReports.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['scrapQualityReports'] = scrapQualityReports.map((e) => e.toJson()).toList();
    return json;
  }

  ListScrapQualityReportsData({
    required this.scrapQualityReports,
  });
}

@immutable
class ListScrapQualityReportsVariables {
  late final Optional<String>machineNumber;
  late final Optional<DateTime>startDate;
  late final Optional<DateTime>endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ListScrapQualityReportsVariables.fromJson(Map<String, dynamic> json) {
  
  
    machineNumber = Optional.optional(nativeFromJson, nativeToJson);
    machineNumber.value = json['machineNumber'] == null ? null : nativeFromJson<String>(json['machineNumber']);
  
  
    startDate = Optional.optional(nativeFromJson, nativeToJson);
    startDate.value = json['startDate'] == null ? null : nativeFromJson<DateTime>(json['startDate']);
  
  
    endDate = Optional.optional(nativeFromJson, nativeToJson);
    endDate.value = json['endDate'] == null ? null : nativeFromJson<DateTime>(json['endDate']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListScrapQualityReportsVariables otherTyped = other as ListScrapQualityReportsVariables;
    return machineNumber == otherTyped.machineNumber && 
    startDate == otherTyped.startDate && 
    endDate == otherTyped.endDate;
    
  }
  @override
  int get hashCode => Object.hashAll([machineNumber.hashCode, startDate.hashCode, endDate.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(machineNumber.state == OptionalState.set) {
      json['machineNumber'] = machineNumber.toJson();
    }
    if(startDate.state == OptionalState.set) {
      json['startDate'] = startDate.toJson();
    }
    if(endDate.state == OptionalState.set) {
      json['endDate'] = endDate.toJson();
    }
    return json;
  }

  ListScrapQualityReportsVariables({
    required this.machineNumber,
    required this.startDate,
    required this.endDate,
  });
}

