import 'dart:convert';

SkillModel skillModelFromJson(String str) =>
    SkillModel.fromJson(json.decode(str));
String skillModelToJson(SkillModel data) => json.encode(data.toJson());

class SkillModel {
  SkillModel({
    List<Data>? data,
    String? message,
    bool? error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  SkillModel.fromJson(dynamic json) {
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
  SkillModel copyWith({
    List<Data>? data,
    String? message,
    bool? error,
  }) =>
      SkillModel(
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
    String? skill,
    String? skillLevel,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _userId = userId;
    _skill = skill;
    _skillLevel = skillLevel;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _skill = json['skill'];
    _skillLevel = json['skill_level'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _userId;
  String? _skill;
  String? _skillLevel;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    num? id,
    String? userId,
    String? skill,
    String? skillLevel,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        userId: userId ?? _userId,
        skill: skill ?? _skill,
        skillLevel: skillLevel ?? _skillLevel,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get userId => _userId;
  String? get skill => _skill;
  String? get skillLevel => _skillLevel;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['skill'] = _skill;
    map['skill_level'] = _skillLevel;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
