import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spires_app/Constants/exports.dart';
import '../Model/edu_model.dart';
import '../Model/exp_model.dart';
import '../Model/profile_model.dart';

class ProfileUtils {
  static final c = Get.put(MyController());
  static final rc = Get.put(ResumeController());

  static Future<void> addEducation(
      {required String collegeName,
      required String degree,
      required String startDate,
      required String endDate,
      required String stream,
      required String percent}) async {
    final url =
        '${apiUrl}education?user_id=${MyController.id}&name=$collegeName&degree=$degree&stream=$stream&start_date=$startDate&end_date=$endDate&percentage=$percent';
    c.isEduLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        Get.back();
        Fluttertoast.showToast(msg: 'Data saved');
        c.isEduLoading.value = false;
      } else {
        Get.back();
        Fluttertoast.showToast(msg: 'Something went wrong');
        c.isEduLoading.value = false;
      }
    } else {
      Get.back();
      c.isEduLoading.value = false;
      Fluttertoast.showToast(
          msg:
              'Internal server error ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<EduModel> showEducation() async {
    final url = '${apiUrl}showEducation?user_id=${MyController.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        data['data'].length == 0
            ? c.eduPoints.value = 0.00
            : c.eduPoints.value = 10.00;
        c.getProgressValue();
        List<EduDetailModel> allData = (data['data'] as List)
            .map((e) => EduDetailModel(
                collegName: e['name'],
                degree: e['degree'],
                stream: e['stream'],
                startDate: e['percentage'],
                endDate: e['start_date'],
                percent: e['end_date']))
            .toList();
        rc.allEduList.value = allData;
        return EduModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg:
              'Internal server error ${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable load data');
  }

  static Future<void> editEducation(
      {required String collegeName,
      required String degree,
      required String startDate,
      required String endDate,
      required String stream,
      required String percent,
      required int eduId}) async {
    final url =
        '${apiUrl}updateEducation?user_id=${MyController.id}&name=$collegeName&degree=$degree&stream=$stream&start_date=$startDate&end_date=$endDate&percentage=$percent&education_id=$eduId';
    c.isEduLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        Get.back();
        Fluttertoast.showToast(msg: 'Data updated');
        c.isEduLoading.value = false;
      } else {
        Get.back();
        Fluttertoast.showToast(msg: 'Something went wrong');
        c.isEduLoading.value = false;
      }
    } else {
      Get.back();
      c.isEduLoading.value = false;
      Fluttertoast.showToast(
          msg:
              'Internal server error ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<void> deleteEducation({required int eduId}) async {
    Get.back();
    final url =
        '${apiUrl}deleteEducation?user_id=${MyController.id}&education_id=$eduId';
    c.isEduLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        Get.back();
        Fluttertoast.showToast(msg: 'Data deleted');
        c.isEduLoading.value = false;
      } else {
        Get.back();
        Fluttertoast.showToast(msg: 'Something went wrong');
        c.isEduLoading.value = false;
      }
    } else {
      Get.back();
      c.isEduLoading.value = false;
      Fluttertoast.showToast(
          msg:
              'Internal server error ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<void> addExperience(
      {required String designation,
      required String organisation,
      required String location,
      required String start,
      required String end,
      required String desc,
      required bool isWFH}) async {
    final url =
        '${apiUrl}work?user_id=${MyController.id}&designation=$designation&organization=$organisation&location=$location&start_date=$start&end_date=$end&description=$desc&is_work_home=$isWFH';
    c.isExpLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        Get.back();
        Fluttertoast.showToast(msg: 'Data saved');
        c.isExpLoading.value = false;
      } else {
        Get.back();
        Fluttertoast.showToast(msg: 'Something went wrong');
        c.isExpLoading.value = false;
      }
    } else {
      Get.back();
      c.isExpLoading.value = false;
      Fluttertoast.showToast(
          msg:
              'Internal server error ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<ExpModel> showExperience() async {
    final url = '${apiUrl}showExperience?user_id=${MyController.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        data['data'].length == 0
            ? c.expPoints.value = 0.00
            : c.expPoints.value = 10.00;
        c.getProgressValue();
        List<WorkExpModel> allData = (data['data'] as List)
            .map((e) => WorkExpModel(
                  designation: e['designation'],
                  organization: e['organization'],
                  location: e['location'],
                  startDate: e['start_date'],
                  endDate: e['end_date'],
                  desc: e['description'],
                ))
            .toList();
        rc.allExpList.value = allData;
        return ExpModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg:
              'Internal server error ${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Ubable load data');
  }

  static Future<void> editExperience(
      {required String designation,
      required String organisation,
      required String location,
      required String start,
      required String end,
      required String desc,
      required bool isWFH,
      required int expId}) async {
    final url =
        '${apiUrl}updateExperience?user_id=${MyController.id}&designation=$designation&organization=$organisation&location=$location&start_date=$start&end_date=$end&description=$desc&is_work_home=$isWFH&experience_id=$expId';
    c.isExpLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        Get.back();
        Fluttertoast.showToast(msg: 'Data updated');
        c.isExpLoading.value = false;
      } else {
        Get.back();
        Fluttertoast.showToast(msg: 'Something went wrong');
        c.isExpLoading.value = false;
      }
    } else {
      Get.back();
      c.isExpLoading.value = false;
      Fluttertoast.showToast(
          msg:
              'Internal server error ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<void> deleteExperience({required int expId}) async {
    final url =
        '${apiUrl}deleteExperience?user_id=${MyController.id}&experience_id=$expId';
    c.isExpLoading.value = true;
    final response = await http.post(Uri.parse(url));
    Get.back();
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        Fluttertoast.showToast(msg: 'Data deleted');
        c.isExpLoading.value = false;
      } else {
        Get.back();
        Fluttertoast.showToast(msg: 'Something went wrong');
        c.isExpLoading.value = false;
      }
    } else {
      Get.back();
      c.isExpLoading.value = false;
      Fluttertoast.showToast(
          msg:
              'Internal server error ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<void> addAboutMe({required String aboutMe}) async {
    final url =
        '${apiUrl}aboutme?user_id=${MyController.id}&description=$aboutMe';
    c.isAboutLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        Get.back();
        Fluttertoast.showToast(msg: 'Data saved');
        c.isAboutLoading.value = false;
      } else {
        Get.back();
        Fluttertoast.showToast(msg: 'Something went wrong');
        c.isAboutLoading.value = false;
      }
    } else {
      Get.back();
      c.isAboutLoading.value = false;
      Fluttertoast.showToast(
          msg:
              'Internal server error ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<void> editAboutMe({required String aboutMe}) async {
    final url =
        '${apiUrl}editAboutUs?user_id=${MyController.id}&description=$aboutMe';
    c.isAboutLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        Get.back();
        Fluttertoast.showToast(msg: 'Data saved');
        c.isAboutLoading.value = false;
      } else {
        Get.back();
        Fluttertoast.showToast(msg: 'Something went wrong');
        c.isAboutLoading.value = false;
      }
    } else {
      Get.back();
      c.isAboutLoading.value = false;
      Fluttertoast.showToast(
          msg:
              'Internal server error ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<void> uploadCV(String resume) async {
    final url = '${apiUrl}updateProfile?user_id=${MyController.id}';
    c.isCVLoading.value = true;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('cv', resume));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);
      if (data['error'] == false) {
        Get.back();
        c.isCVLoading.value = false;
        Fluttertoast.showToast(msg: 'CV Uploaded');
      } else {
        Get.back();
        c.isCVLoading.value = false;
        Fluttertoast.showToast(msg: data['message']);
      }
    } else {
      Get.back();
      c.isCVLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.reasonPhrase} ${response.statusCode}');
    }
  }

  static Future<ProfileModel> showProfile() async {
    final url = '${apiUrl}showCV?user_id=${MyController.id}';
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        c.aboutMe.value = data['message']['description'] ?? "";
        c.profileImg.value = data['message']['image'] ?? "";
        data['message']['cv'] == null
            ? c.resumePoints.value = 0.00
            : c.resumePoints.value = 15.00;
        data['message']['description'] == null ||
                data['message']['description'] == ''
            ? c.aboutMePoints.value = 0.00
            : c.aboutMePoints.value = 10.00;
        data['message']['image'] == null || data['message']['image'] == ''
            ? c.imgPoints.value = 0.00
            : c.imgPoints.value = 15.00;
        c.getProgressValue();
        return ProfileModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg:
              'Internal server error ${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable to load data');
  }

  static Future<void> deleteCV() async {
    final url = '${apiUrl}deleteCV?user_id=${MyController.id}';
    c.isCVLoading.value = true;
    final response = await http.delete(Uri.parse(url));
    Get.back();
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        Fluttertoast.showToast(msg: 'CV deleted');
        c.isCVLoading.value = false;
      } else {
        Get.back();
        Fluttertoast.showToast(msg: 'Something went wrong');
        c.isCVLoading.value = false;
      }
    } else {
      Get.back();
      c.isCVLoading.value = false;
      Fluttertoast.showToast(
          msg:
              'Internal server error ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<void> updateDP({required String imagePath}) async {
    final url = '${apiUrl}updateImage?user_id=${MyController.id}';
    c.isDpLoading.value = true;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);
      if (data['error'] == false) {
        Fluttertoast.showToast(msg: 'Profile picture updated successfully');
        ProfileUtils.showProfile();
        c.isDpLoading.value = false;
      } else {
        c.isDpLoading.value = false;
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      c.isDpLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.reasonPhrase} ${response.statusCode}');
    }
  }

  // static Future<void> getOtp(String phone) async {
  //   final url = '${apiUrl}sendotp?phone_number=$phone';
  //   c.isotpLoading.value = true;
  //   final response = await http.post(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     if (data['error'] == false) {
  //       c.otp.value = data['otp'].toString();
  //       Get.to(() => MobileVerify());
  //       Fluttertoast.showToast(msg: 'OTP sent');
  //       c.isotpLoading.value = false;
  //     } else {
  //       Fluttertoast.showToast(msg: 'Something went wrong');
  //       c.isotpLoading.value = false;
  //     }
  //   } else {
  //     c.isotpLoading.value = false;
  //   }
  // }

  static Future<void> getOtp(String phone) async {
    final url = '${apiUrl}sendotp?phone_number=$phone';
    c.isotpLoading.value = true;
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          c.otp.value = data['otp'].toString();
          Get.to(() => MobileVerify());
          Fluttertoast.showToast(msg: 'OTP sent');
        } else {
          Fluttertoast.showToast(msg: 'Something went wrong');
        }
      } else {
        Fluttertoast.showToast(msg: 'Failed to send OTP');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'An error occurred');
    } finally {
      c.isotpLoading.value = false;
    }
  }


  static Future<void> getEmailVerification() async {
    final url = '${apiUrl}SendVerificationMail?user_id=${MyController.id}';
    print(MyController.id);
    c.isemailLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      print(response.body);
      final data = jsonDecode(response.body);
      print(data);
      if (data['error'] == false) {
        Get.defaultDialog(
            radius: defaultRadius,
            title: 'Email Verification',
            middleText:
                'Check your mail and click on the Link which has been sent to ${MyController.userEmail} to verify your email',
            confirm: myButton(
                onPressed: () => Get.back(),
                label: 'OK',
                color: primaryColor,
                style: normalWhiteText));
        c.isemailLoading.value = false;
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
        c.isemailLoading.value = false;
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
      c.isemailLoading.value = false;
    }
  }

  static Future<void> getPhoneVerification() async {
    final url = '${apiUrl}verifyOtp?user_id=${MyController.id}';
    c.isotpLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        MyController.veriPhone = '1';
        c.isPhoneVerified.value = true;
        c.phonePoints.value = 15.00;
        c.getProgressValue();
        Get.back();
        Get.defaultDialog(
            radius: defaultRadius,
            title: 'Congratulations!!!',
            middleText:
                'Your phone number ${MyController.userPhone} verified Successfully',
            confirm: myButton(
                onPressed: () => Get.back(),
                label: 'OK',
                color: primaryColor,
                style: normalWhiteText));
        c.isotpLoading.value = false;
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
        c.isotpLoading.value = false;
      }
    } else {
      c.isotpLoading.value = false;
    }
  }
}
