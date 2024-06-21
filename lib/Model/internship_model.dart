import 'dart:convert';

InternshipModel internshipModelFromJson(String str) =>
    InternshipModel.fromJson(json.decode(str));
String internshipModelToJson(InternshipModel data) =>
    json.encode(data.toJson());

class InternshipModel {
  InternshipModel({
    bool? error,
    List<Data>? data,
    String? message,
  }) {
    _error = error;
    _data = data;
    _message = message;
  }

  InternshipModel.fromJson(dynamic json) {
    _error = json['error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _message = json['message'];
  }
  bool? _error;
  List<Data>? _data;
  String? _message;
  InternshipModel copyWith({
    bool? error,
    List<Data>? data,
    String? message,
  }) =>
      InternshipModel(
        error: error ?? _error,
        data: data ?? _data,
        message: message ?? _message,
      );
  bool? get error => _error;
  List<Data>? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    num? id,
    String? internshipTitle,
    String? internshipType,
    String? startFrom,
    String? openings,
    String? duration,
    String? stipend,
    String? lastDate,
    String? skill,
    String? aboutInternship,
    String? whoCanApply,
    String? perks,
    String? information,
    String? website,
    String? location,
    bool? isApplied,
    bool? isSaved,
    String? createdAt,
    String? updatedAt,
    Admin? admin,
  }) {
    _id = id;
    _internshipTitle = internshipTitle;
    _internshipType = internshipType;
    _startFrom = startFrom;
    _openings = openings;
    _duration = duration;
    _stipend = stipend;
    _lastDate = lastDate;
    _skill = skill;
    _aboutInternship = aboutInternship;
    _whoCanApply = whoCanApply;
    _perks = perks;
    _information = information;
    _website = website;
    _location = location;
    _isApplied = isApplied;
    _isSaved = isSaved;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _admin = admin;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _internshipTitle = json['internship_title'];
    _internshipType = json['internship_type'];
    _startFrom = json['start_from'];
    _openings = json['openings'];
    _duration = json['duration'];
    _stipend = json['stipend'];
    _lastDate = json['last_date'];
    _skill = json['skill'];
    _aboutInternship = json['about_internship'];
    _whoCanApply = json['who_can_apply'];
    _perks = json['perks'];
    _information = json['information'];
    _website = json['website'];
    _location = json['location'];
    _isApplied = json['is_applied'];
    _isSaved = json['is_saved'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _admin = json['admin'] != null ? Admin.fromJson(json['admin']) : null;
  }
  num? _id;
  String? _internshipTitle;
  String? _internshipType;
  String? _startFrom;
  String? _openings;
  String? _duration;
  String? _stipend;
  String? _lastDate;
  String? _skill;
  String? _aboutInternship;
  String? _whoCanApply;
  String? _perks;
  String? _information;
  String? _website;
  String? _location;
  bool? _isApplied;
  bool? _isSaved;
  String? _createdAt;
  String? _updatedAt;
  Admin? _admin;
  Data copyWith({
    num? id,
    String? internshipTitle,
    String? internshipType,
    String? startFrom,
    String? openings,
    String? duration,
    String? stipend,
    String? lastDate,
    String? skill,
    String? aboutInternship,
    String? whoCanApply,
    String? perks,
    String? information,
    String? website,
    String? location,
    bool? isApplied,
    bool? isSaved,
    String? createdAt,
    String? updatedAt,
    Admin? admin,
  }) =>
      Data(
        id: id ?? _id,
        internshipTitle: internshipTitle ?? _internshipTitle,
        internshipType: internshipType ?? _internshipType,
        startFrom: startFrom ?? _startFrom,
        openings: openings ?? _openings,
        duration: duration ?? _duration,
        stipend: stipend ?? _stipend,
        lastDate: lastDate ?? _lastDate,
        skill: skill ?? _skill,
        aboutInternship: aboutInternship ?? _aboutInternship,
        whoCanApply: whoCanApply ?? _whoCanApply,
        perks: perks ?? _perks,
        information: information ?? _information,
        website: website ?? _website,
        location: location ?? _location,
        isApplied: isApplied ?? _isApplied,
        isSaved: isSaved ?? _isSaved,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        admin: admin ?? _admin,
      );
  num? get id => _id;
  String? get internshipTitle => _internshipTitle;
  String? get internshipType => _internshipType;
  String? get startFrom => _startFrom;
  String? get openings => _openings;
  String? get duration => _duration;
  String? get stipend => _stipend;
  String? get lastDate => _lastDate;
  String? get skill => _skill;
  String? get aboutInternship => _aboutInternship;
  String? get whoCanApply => _whoCanApply;
  String? get perks => _perks;
  String? get information => _information;
  String? get website => _website;
  String? get location => _location;
  bool? get isApplied => _isApplied;
  bool? get isSaved => _isSaved;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Admin? get admin => _admin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['internship_title'] = _internshipTitle;
    map['internship_type'] = _internshipType;
    map['start_from'] = _startFrom;
    map['openings'] = _openings;
    map['duration'] = _duration;
    map['stipend'] = _stipend;
    map['last_date'] = _lastDate;
    map['skill'] = _skill;
    map['about_internship'] = _aboutInternship;
    map['who_can_apply'] = _whoCanApply;
    map['perks'] = _perks;
    map['information'] = _information;
    map['website'] = _website;
    map['location'] = _location;
    map['is_applied'] = _isApplied;
    map['is_saved'] = _isSaved;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_admin != null) {
      map['admin'] = _admin?.toJson();
    }
    return map;
  }
}

Admin adminFromJson(String str) => Admin.fromJson(json.decode(str));
String adminToJson(Admin data) => json.encode(data.toJson());

class Admin {
  Admin({
    num? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? website,
    String? logo,
    String? phone,
    String? industry,
    String? address,
    String? employee,
    String? description,
    String? password,
    String? date,
    String? roleId,
    String? jobPosted,
    String? candidateHired,
    String? isAdmin,
    num? status,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _username = username;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _website = website;
    _logo = logo;
    _phone = phone;
    _industry = industry;
    _address = address;
    _employee = employee;
    _description = description;
    _password = password;
    _date = date;
    _roleId = roleId;
    _jobPosted = jobPosted;
    _candidateHired = candidateHired;
    _isAdmin = isAdmin;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Admin.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _email = json['email'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _website = json['website'];
    _logo = json['logo'];
    _phone = json['phone'];
    _industry = json['industry'];
    _address = json['address'];
    _employee = json['employee'];
    _description = json['description'];
    _password = json['password'];
    _date = json['date'];
    _roleId = json['role_id'];
    _jobPosted = json['job_posted'];
    _candidateHired = json['candidate_hired'];
    _isAdmin = json['is_admin'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _username;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _website;
  String? _logo;
  String? _phone;
  String? _industry;
  String? _address;
  String? _employee;
  String? _description;
  String? _password;
  String? _date;
  String? _roleId;
  String? _jobPosted;
  String? _candidateHired;
  String? _isAdmin;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  Admin copyWith({
    num? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? website,
    String? logo,
    String? phone,
    String? industry,
    String? address,
    String? employee,
    String? description,
    String? password,
    String? date,
    String? roleId,
    String? jobPosted,
    String? candidateHired,
    String? isAdmin,
    num? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      Admin(
        id: id ?? _id,
        username: username ?? _username,
        email: email ?? _email,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        website: website ?? _website,
        logo: logo ?? _logo,
        phone: phone ?? _phone,
        industry: industry ?? _industry,
        address: address ?? _address,
        employee: employee ?? _employee,
        description: description ?? _description,
        password: password ?? _password,
        date: date ?? _date,
        roleId: roleId ?? _roleId,
        jobPosted: jobPosted ?? _jobPosted,
        candidateHired: candidateHired ?? _candidateHired,
        isAdmin: isAdmin ?? _isAdmin,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get username => _username;
  String? get email => _email;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get website => _website;
  String? get logo => _logo;
  String? get phone => _phone;
  String? get industry => _industry;
  String? get address => _address;
  String? get employee => _employee;
  String? get description => _description;
  String? get password => _password;
  String? get date => _date;
  String? get roleId => _roleId;
  String? get jobPosted => _jobPosted;
  String? get candidateHired => _candidateHired;
  String? get isAdmin => _isAdmin;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['email'] = _email;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['website'] = _website;
    map['logo'] = _logo;
    map['phone'] = _phone;
    map['industry'] = _industry;
    map['address'] = _address;
    map['employee'] = _employee;
    map['description'] = _description;
    map['password'] = _password;
    map['date'] = _date;
    map['role_id'] = _roleId;
    map['job_posted'] = _jobPosted;
    map['candidate_hired'] = _candidateHired;
    map['is_admin'] = _isAdmin;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
