import 'dart:convert';

JobModel jobModelFromJson(String str) => JobModel.fromJson(json.decode(str));
String jobModelToJson(JobModel data) => json.encode(data.toJson());

class JobModel {
  JobModel({
    bool? error,
    List<Data>? data,
    String? message,
  }) {
    _error = error;
    _data = data;
    _message = message;
  }

  JobModel.fromJson(dynamic json) {
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
  JobModel copyWith({
    bool? error,
    List<Data>? data,
    String? message,
  }) =>
      JobModel(
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
    int? id,
    String? categoryId,
    String? jobTitle,
    String? jobType,
    String? postDate,
    String? experience,
    String? aboutJob,
    String? website,
    String? location,
    String? salary,
    String? skills,
    String? openings,
    String? probationSalary,
    String? probationDuration,
    String? lastDate,
    bool? isApplied,
    bool? isSaved,
    String? postUserId,
    String? createdAt,
    String? updatedAt,
    String? applyJobStatus,
    String? savedJobStatus,
    Admin? admin,
  }) {
    _id = id;
    _categoryId = categoryId;
    _jobTitle = jobTitle;
    _jobType = jobType;
    _postDate = postDate;
    _experience = experience;
    _aboutJob = aboutJob;
    _website = website;
    _location = location;
    _salary = salary;
    _skills = skills;
    _openings = openings;
    _probationSalary = probationSalary;
    _probationDuration = probationDuration;
    _lastDate = lastDate;
    _isApplied = isApplied;
    _isSaved = isSaved;
    _postUserId = postUserId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _applyJobStatus = applyJobStatus;
    _savedJobStatus = savedJobStatus;
    _admin = admin;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _jobTitle = json['job_title'];
    _jobType = json['job_type'];
    _postDate = json['post_date'];
    _experience = json['experience'];
    _aboutJob = json['about_job'];
    _website = json['website'];
    _location = json['location'];
    _salary = json['salary'];
    _skills = json['skills'];
    _openings = json['openings'];
    _probationSalary = json['probation_salary'];
    _probationDuration = json['probation_duration'];
    _lastDate = json['last_date'];
    _isApplied = json['is_applied'];
    _isSaved = json['is_saved'];
    _postUserId = json['post_user_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _applyJobStatus = json['apply_job_status'];
    _savedJobStatus = json['saved_job_status'];
    _admin = json['admin'] != null ? Admin.fromJson(json['admin']) : null;
  }
  int? _id;
  String? _categoryId;
  String? _jobTitle;
  String? _jobType;
  String? _postDate;
  String? _experience;
  String? _aboutJob;
  String? _website;
  String? _location;
  String? _salary;
  String? _skills;
  String? _openings;
  String? _probationSalary;
  String? _probationDuration;
  String? _lastDate;
  bool? _isApplied;
  bool? _isSaved;
  String? _postUserId;
  String? _createdAt;
  String? _updatedAt;
  String? _applyJobStatus;
  String? _savedJobStatus;
  Admin? _admin;
  Data copyWith({
    int? id,
    String? categoryId,
    String? jobTitle,
    String? jobType,
    String? postDate,
    String? experience,
    String? aboutJob,
    String? website,
    String? location,
    String? salary,
    String? skills,
    String? openings,
    String? probationSalary,
    String? probationDuration,
    String? lastDate,
    bool? isApplied,
    bool? isSaved,
    String? postUserId,
    String? createdAt,
    String? updatedAt,
    String? applyJobStatus,
    String? savedJobStatus,
    Admin? admin,
  }) =>
      Data(
        id: id ?? _id,
        categoryId: categoryId ?? _categoryId,
        jobTitle: jobTitle ?? _jobTitle,
        jobType: jobType ?? _jobType,
        postDate: postDate ?? _postDate,
        experience: experience ?? _experience,
        aboutJob: aboutJob ?? _aboutJob,
        website: website ?? _website,
        location: location ?? _location,
        salary: salary ?? _salary,
        skills: skills ?? _skills,
        openings: openings ?? _openings,
        probationSalary: probationSalary ?? _probationSalary,
        probationDuration: probationDuration ?? _probationDuration,
        lastDate: lastDate ?? _lastDate,
        isApplied: isApplied ?? _isApplied,
        isSaved: isSaved ?? _isSaved,
        postUserId: postUserId ?? _postUserId,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        applyJobStatus: applyJobStatus ?? _applyJobStatus,
        savedJobStatus: savedJobStatus ?? _savedJobStatus,
        admin: admin ?? _admin,
      );
  int? get id => _id;
  String? get categoryId => _categoryId;
  String? get jobTitle => _jobTitle;
  String? get jobType => _jobType;
  String? get postDate => _postDate;
  String? get experience => _experience;
  String? get aboutJob => _aboutJob;
  String? get website => _website;
  String? get location => _location;
  String? get salary => _salary;
  String? get skills => _skills;
  String? get openings => _openings;
  String? get probationSalary => _probationSalary;
  String? get probationDuration => _probationDuration;
  String? get lastDate => _lastDate;
  bool? get isApplied => _isApplied;
  bool? get isSaved => _isSaved;
  String? get postUserId => _postUserId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get applyJobStatus => _applyJobStatus;
  String? get savedJobStatus => _savedJobStatus;
  Admin? get admin => _admin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['job_title'] = _jobTitle;
    map['job_type'] = _jobType;
    map['post_date'] = _postDate;
    map['experience'] = _experience;
    map['about_job'] = _aboutJob;
    map['website'] = _website;
    map['location'] = _location;
    map['salary'] = _salary;
    map['skills'] = _skills;
    map['openings'] = _openings;
    map['probation_salary'] = _probationSalary;
    map['probation_duration'] = _probationDuration;
    map['last_date'] = _lastDate;
    map['is_applied'] = _isApplied;
    map['is_saved'] = _isSaved;
    map['post_user_id'] = _postUserId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['apply_job_status'] = _applyJobStatus;
    map['saved_job_status'] = _savedJobStatus;
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
    int? id,
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
    String? internshipPosted,
    String? candidateHired,
    String? isAdmin,
    int? status,
    String? jobPostNoti,
    String? jobInternNoti,
    String? latitude,
    String? longitude,
    String? createdAt,
    String? updatedAt,
    int? otp,
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
    _internshipPosted = internshipPosted;
    _candidateHired = candidateHired;
    _isAdmin = isAdmin;
    _status = status;
    _jobPostNoti = jobPostNoti;
    _jobInternNoti = jobInternNoti;
    _latitude = latitude;
    _longitude = longitude;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _otp = otp;
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
    _internshipPosted = json['internship_posted'];
    _candidateHired = json['candidate_hired'];
    _isAdmin = json['is_admin'];
    _status = json['status'];
    _jobPostNoti = json['job_post_noti'];
    _jobInternNoti = json['job_intern_noti'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _otp = json['otp'];
  }
  int? _id;
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
  String? _internshipPosted;
  String? _candidateHired;
  String? _isAdmin;
  int? _status;
  String? _jobPostNoti;
  String? _jobInternNoti;
  String? _latitude;
  String? _longitude;
  String? _createdAt;
  String? _updatedAt;
  int? _otp;
  Admin copyWith({
    int? id,
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
    String? internshipPosted,
    String? candidateHired,
    String? isAdmin,
    int? status,
    String? jobPostNoti,
    String? jobInternNoti,
    String? latitude,
    String? longitude,
    String? createdAt,
    String? updatedAt,
    int? otp,
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
        internshipPosted: internshipPosted ?? _internshipPosted,
        candidateHired: candidateHired ?? _candidateHired,
        isAdmin: isAdmin ?? _isAdmin,
        status: status ?? _status,
        jobPostNoti: jobPostNoti ?? _jobPostNoti,
        jobInternNoti: jobInternNoti ?? _jobInternNoti,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        otp: otp ?? _otp,
      );
  int? get id => _id;
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
  String? get internshipPosted => _internshipPosted;
  String? get candidateHired => _candidateHired;
  String? get isAdmin => _isAdmin;
  int? get status => _status;
  String? get jobPostNoti => _jobPostNoti;
  String? get jobInternNoti => _jobInternNoti;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get otp => _otp;

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
    map['internship_posted'] = _internshipPosted;
    map['candidate_hired'] = _candidateHired;
    map['is_admin'] = _isAdmin;
    map['status'] = _status;
    map['job_post_noti'] = _jobPostNoti;
    map['job_intern_noti'] = _jobInternNoti;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['otp'] = _otp;
    return map;
  }
}
