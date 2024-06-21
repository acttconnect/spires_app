import 'dart:convert';

PrefModel prefModelFromJson(String str) => PrefModel.fromJson(json.decode(str));
String prefModelToJson(PrefModel data) => json.encode(data.toJson());

class PrefModel {
  PrefModel({
    List<Data>? data,
    String? message,
    bool? error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  PrefModel.fromJson(dynamic json) {
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
  PrefModel copyWith({
    List<Data>? data,
    String? message,
    bool? error,
  }) =>
      PrefModel(
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
    String? categoryId,
    String? createdAt,
    String? updatedAt,
    Category? category,
  }) {
    _id = id;
    _userId = userId;
    _categoryId = categoryId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _category = category;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _categoryId = json['category_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }
  num? _id;
  String? _userId;
  String? _categoryId;
  String? _createdAt;
  String? _updatedAt;
  Category? _category;
  Data copyWith({
    num? id,
    String? userId,
    String? categoryId,
    String? createdAt,
    String? updatedAt,
    Category? category,
  }) =>
      Data(
        id: id ?? _id,
        userId: userId ?? _userId,
        categoryId: categoryId ?? _categoryId,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        category: category ?? _category,
      );
  num? get id => _id;
  String? get userId => _userId;
  String? get categoryId => _categoryId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Category? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['category_id'] = _categoryId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    return map;
  }
}

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    num? id,
    String? name,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
  Category copyWith({
    num? id,
    String? name,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) =>
      Category(
        id: id ?? _id,
        name: name ?? _name,
        image: image ?? _image,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get name => _name;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
