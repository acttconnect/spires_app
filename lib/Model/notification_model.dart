import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));
String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    bool? error,
    List<Data>? data,
    num? notiiicationCount,
    String? message,
  }) {
    _error = error;
    _data = data;
    _notiiicationCount = notiiicationCount;
    _message = message;
  }

  NotificationModel.fromJson(dynamic json) {
    _error = json['error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _notiiicationCount = json['Notiiication Count'];
    _message = json['message'];
  }
  bool? _error;
  List<Data>? _data;
  num? _notiiicationCount;
  String? _message;
  NotificationModel copyWith({
    bool? error,
    List<Data>? data,
    num? notiiicationCount,
    String? message,
  }) =>
      NotificationModel(
        error: error ?? _error,
        data: data ?? _data,
        notiiicationCount: notiiicationCount ?? _notiiicationCount,
        message: message ?? _message,
      );
  bool? get error => _error;
  List<Data>? get data => _data;
  num? get notiiicationCount => _notiiicationCount;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['Notiiication Count'] = _notiiicationCount;
    map['message'] = _message;
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? userId,
    String? type,
    String? message,
    String? date,
    String? createdAt,
    String? time,
  }) {
    _userId = userId;
    _type = type;
    _message = message;
    _date = date;
    _createdAt = createdAt;
    _time = time;
  }

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _type = json['type'];
    _message = json['message'];
    _date = json['date'];
    _createdAt = json['created_at'];
    _time = json['time'];
  }
  String? _userId;
  String? _type;
  String? _message;
  String? _date;
  String? _createdAt;
  String? _time;
  Data copyWith({
    String? userId,
    String? type,
    String? message,
    String? date,
    String? createdAt,
    String? time,
  }) =>
      Data(
        userId: userId ?? _userId,
        type: type ?? _type,
        message: message ?? _message,
        date: date ?? _date,
        createdAt: createdAt ?? _createdAt,
        time: time ?? _time,
      );
  String? get userId => _userId;
  String? get type => _type;
  String? get message => _message;
  String? get date => _date;
  String? get createdAt => _createdAt;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['type'] = _type;
    map['message'] = _message;
    map['date'] = _date;
    map['created_at'] = _createdAt;
    map['time'] = _time;
    return map;
  }
}
