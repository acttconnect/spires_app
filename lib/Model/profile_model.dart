import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));
String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    String? cv,
    Message? message,
    bool? error,
  }) {
    _cv = cv;
    _message = message;
    _error = error;
  }

  ProfileModel.fromJson(dynamic json) {
    _cv = json['cv'];
    _message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
    _error = json['error'];
  }
  String? _cv;
  Message? _message;
  bool? _error;
  ProfileModel copyWith({
    String? cv,
    Message? message,
    bool? error,
  }) =>
      ProfileModel(
        cv: cv ?? _cv,
        message: message ?? _message,
        error: error ?? _error,
      );
  String? get cv => _cv;
  Message? get message => _message;
  bool? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cv'] = _cv;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    map['error'] = _error;
    return map;
  }
}

Message messageFromJson(String str) => Message.fromJson(json.decode(str));
String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    num? id,
    String? fname,
    String? lname,
    String? email,
    String? image,
    String? cv,
    String? cvUpdatedAt,
    String? phoneNumber,
    dynamic emailVerifiedAt,
    String? description,
    String? randId,
    String? isEverify,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _fname = fname;
    _lname = lname;
    _email = email;
    _image = image;
    _cv = cv;
    _cvUpdatedAt = cvUpdatedAt;
    _phoneNumber = phoneNumber;
    _emailVerifiedAt = emailVerifiedAt;
    _description = description;
    _randId = randId;
    _isEverify = isEverify;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Message.fromJson(dynamic json) {
    _id = json['id'];
    _fname = json['fname'];
    _lname = json['lname'];
    _email = json['email'];
    _image = json['image'];
    _cv = json['cv'];
    _cvUpdatedAt = json['cv_updated_at'];
    _phoneNumber = json['phone_number'];
    _emailVerifiedAt = json['email_verified_at'];
    _description = json['description'];
    _randId = json['rand_id'];
    _isEverify = json['is_everify'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _fname;
  String? _lname;
  String? _email;
  String? _image;
  String? _cv;
  String? _cvUpdatedAt;
  String? _phoneNumber;
  dynamic _emailVerifiedAt;
  String? _description;
  String? _randId;
  String? _isEverify;
  String? _createdAt;
  String? _updatedAt;
  Message copyWith({
    num? id,
    String? fname,
    String? lname,
    String? email,
    String? image,
    String? cv,
    String? cvUpdatedAt,
    String? phoneNumber,
    dynamic emailVerifiedAt,
    String? description,
    String? randId,
    String? isEverify,
    String? createdAt,
    String? updatedAt,
  }) =>
      Message(
        id: id ?? _id,
        fname: fname ?? _fname,
        lname: lname ?? _lname,
        email: email ?? _email,
        image: image ?? _image,
        cv: cv ?? _cv,
        cvUpdatedAt: cvUpdatedAt ?? _cvUpdatedAt,
        phoneNumber: phoneNumber ?? _phoneNumber,
        emailVerifiedAt: emailVerifiedAt ?? _emailVerifiedAt,
        description: description ?? _description,
        randId: randId ?? _randId,
        isEverify: isEverify ?? _isEverify,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get fname => _fname;
  String? get lname => _lname;
  String? get email => _email;
  String? get image => _image;
  String? get cv => _cv;
  String? get cvUpdatedAt => _cvUpdatedAt;
  String? get phoneNumber => _phoneNumber;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  String? get description => _description;
  String? get randId => _randId;
  String? get isEverify => _isEverify;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['fname'] = _fname;
    map['lname'] = _lname;
    map['email'] = _email;
    map['image'] = _image;
    map['cv'] = _cv;
    map['cv_updated_at'] = _cvUpdatedAt;
    map['phone_number'] = _phoneNumber;
    map['email_verified_at'] = _emailVerifiedAt;
    map['description'] = _description;
    map['rand_id'] = _randId;
    map['is_everify'] = _isEverify;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
