import 'dart:convert';

LogoModel logoModelFromJson(String str) => LogoModel.fromJson(json.decode(str));
String logoModelToJson(LogoModel data) => json.encode(data.toJson());

class LogoModel {
  LogoModel({
    bool? error,
    List<Data>? data,
  }) {
    _error = error;
    _data = data;
  }

  LogoModel.fromJson(dynamic json) {
    _error = json['error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  List<Data>? _data;
  LogoModel copyWith({
    bool? error,
    List<Data>? data,
  }) =>
      LogoModel(
        error: error ?? _error,
        data: data ?? _data,
      );
  bool? get error => _error;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    num? id,
    String? logo,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _logo = logo;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _logo = json['logo'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _logo;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    num? id,
    String? logo,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        logo: logo ?? _logo,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get logo => _logo;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['logo'] = _logo;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
