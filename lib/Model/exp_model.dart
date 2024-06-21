import 'dart:convert';

ExpModel expModelFromJson(String str) => ExpModel.fromJson(json.decode(str));
String expModelToJson(ExpModel data) => json.encode(data.toJson());

class ExpModel {
  ExpModel({
    List<Data>? data,
    String? message,
    bool? error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  ExpModel.fromJson(dynamic json) {
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
  ExpModel copyWith({
    List<Data>? data,
    String? message,
    bool? error,
  }) =>
      ExpModel(
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
    String? designation,
    String? organization,
    String? location,
    String? startDate,
    String? endDate,
    String? description,
    String? isWorkHome,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _userId = userId;
    _designation = designation;
    _organization = organization;
    _location = location;
    _startDate = startDate;
    _endDate = endDate;
    _description = description;
    _isWorkHome = isWorkHome;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _designation = json['designation'];
    _organization = json['organization'];
    _location = json['location'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _description = json['description'];
    _isWorkHome = json['is_work_home'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _userId;
  String? _designation;
  String? _organization;
  String? _location;
  String? _startDate;
  String? _endDate;
  String? _description;
  String? _isWorkHome;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    num? id,
    String? userId,
    String? designation,
    String? organization,
    String? location,
    String? startDate,
    String? endDate,
    String? description,
    String? isWorkHome,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        userId: userId ?? _userId,
        designation: designation ?? _designation,
        organization: organization ?? _organization,
        location: location ?? _location,
        startDate: startDate ?? _startDate,
        endDate: endDate ?? _endDate,
        description: description ?? _description,
        isWorkHome: isWorkHome ?? _isWorkHome,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get userId => _userId;
  String? get designation => _designation;
  String? get organization => _organization;
  String? get location => _location;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get description => _description;
  String? get isWorkHome => _isWorkHome;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['designation'] = _designation;
    map['organization'] = _organization;
    map['location'] = _location;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['description'] = _description;
    map['is_work_home'] = _isWorkHome;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
