import 'dart:convert';

EduModel eduModelFromJson(String str) => EduModel.fromJson(json.decode(str));
String eduModelToJson(EduModel data) => json.encode(data.toJson());

class EduModel {
  EduModel({
    List<Data>? data,
    String? message,
    bool? error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  EduModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _message = json['message'];
    _error = json['error'];
  }
  List<Data>? _data;
  String? _message;
  bool? _error;
  EduModel copyWith({
    List<Data>? data,
    String? message,
    bool? error,
  }) =>
      EduModel(
        data: data ?? _data,
        message: message ?? _message,
        error: error ?? _error,
      );
  List<Data>? get data => _data;
  String? get message => _message;
  bool? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    map['error'] = _error;
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    num? id,
    String? userId,
    String? name,
    String? degree,
    String? stream,
    String? percentage,
    String? startDate,
    String? endDate,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _userId = userId;
    _name = name;
    _degree = degree;
    _stream = stream;
    _percentage = percentage;
    _startDate = startDate;
    _endDate = endDate;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _name = json['name'];
    _degree = json['degree'];
    _stream = json['stream'];
    _percentage = json['percentage'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _userId;
  String? _name;
  String? _degree;
  String? _stream;
  String? _percentage;
  String? _startDate;
  String? _endDate;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    num? id,
    String? userId,
    String? name,
    String? degree,
    String? stream,
    String? percentage,
    String? startDate,
    String? endDate,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        userId: userId ?? _userId,
        name: name ?? _name,
        degree: degree ?? _degree,
        stream: stream ?? _stream,
        percentage: percentage ?? _percentage,
        startDate: startDate ?? _startDate,
        endDate: endDate ?? _endDate,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get userId => _userId;
  String? get name => _name;
  String? get degree => _degree;
  String? get stream => _stream;
  String? get percentage => _percentage;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['name'] = _name;
    map['degree'] = _degree;
    map['stream'] = _stream;
    map['percentage'] = _percentage;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
