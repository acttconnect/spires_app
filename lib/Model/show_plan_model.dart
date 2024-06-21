import 'dart:convert';

ShowPlanModel showPlanModelFromJson(String str) =>
    ShowPlanModel.fromJson(json.decode(str));
String showPlanModelToJson(ShowPlanModel data) => json.encode(data.toJson());

class ShowPlanModel {
  ShowPlanModel({
    List<Data>? data,
    String? message,
    bool? error,
  }) {
    _data = data;
    _message = message;
    _error = error;
  }

  ShowPlanModel.fromJson(dynamic json) {
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
  ShowPlanModel copyWith({
    List<Data>? data,
    String? message,
    bool? error,
  }) =>
      ShowPlanModel(
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
    String? planName,
    String? price,
    String? planTitle,
    String? planSubTitle,
    String? duration,
    String? discount,
    List<String>? list,
    String? planCategory,
    String? discountPrice,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _planName = planName;
    _price = price;
    _planTitle = planTitle;
    _planSubTitle = planSubTitle;
    _duration = duration;
    _discount = discount;
    _list = list;
    _planCategory = planCategory;
    _discountPrice = discountPrice;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _planName = json['plan_name'];
    _price = json['price'];
    _planTitle = json['plan_title'];
    _planSubTitle = json['plan_sub_title'];
    _duration = json['duration'];
    _discount = json['discount'];
    _list = json['list'] != null ? json['list'].cast<String>() : [];
    _planCategory = json['plan_category'];
    _discountPrice = json['discount_price'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _planName;
  String? _price;
  String? _planTitle;
  String? _planSubTitle;
  String? _duration;
  String? _discount;
  List<String>? _list;
  String? _planCategory;
  String? _discountPrice;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    num? id,
    String? planName,
    String? price,
    String? planTitle,
    String? planSubTitle,
    String? duration,
    String? discount,
    List<String>? list,
    String? planCategory,
    String? discountPrice,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        planName: planName ?? _planName,
        price: price ?? _price,
        planTitle: planTitle ?? _planTitle,
        planSubTitle: planSubTitle ?? _planSubTitle,
        duration: duration ?? _duration,
        discount: discount ?? _discount,
        list: list ?? _list,
        planCategory: planCategory ?? _planCategory,
        discountPrice: discountPrice ?? _discountPrice,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get planName => _planName;
  String? get price => _price;
  String? get planTitle => _planTitle;
  String? get planSubTitle => _planSubTitle;
  String? get duration => _duration;
  String? get discount => _discount;
  List<String>? get list => _list;
  String? get planCategory => _planCategory;
  String? get discountPrice => _discountPrice;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['plan_name'] = _planName;
    map['price'] = _price;
    map['plan_title'] = _planTitle;
    map['plan_sub_title'] = _planSubTitle;
    map['duration'] = _duration;
    map['discount'] = _discount;
    map['list'] = _list;
    map['plan_category'] = _planCategory;
    map['discount_price'] = _discountPrice;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
