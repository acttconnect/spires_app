import 'dart:convert';
import 'package:spires_app/Constants/exports.dart';
import 'package:spires_app/Model/category_model.dart';
import 'package:spires_app/Model/job_model.dart';
import 'package:spires_app/Model/logo_model.dart';
import 'package:spires_app/Model/review_model.dart';
import 'package:http/http.dart' as http;
import '../Model/internship_model.dart';
import '../Model/notification_model.dart';
import '../Model/pref_model.dart';
import '../Model/show_plan_model.dart';

class HomeUtils {
  static final c = Get.put(MyController());
  static final rc = Get.put(ResumeController());
  static Future<JobCategoryModel> getCategories() async {
    const url = '${apiUrl}jobCategory';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        return JobCategoryModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable to load data');
  }

  static Future<ShowPlanModel> showPlan() async {
    const url = '${apiUrl}showPlan';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        return ShowPlanModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable to load data');
  }

  static Future<void> purchasePlan(int planId) async {
    final url =
        '${apiUrl}subscriptionnew?user_id=${MyController.id}&plan_id=$planId';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        c.isSubscribed.value = true;
        Fluttertoast.showToast(msg: 'Payment successful & plan purchased');
        Get.back();
      } else {
        Fluttertoast.showToast(msg: data['message']);
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable to load data');
  }

  static Future<NotificationModel> showNotifications() async {
    final url = '${apiUrl}notify?user_id=${MyController.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        return NotificationModel.fromJson(data);
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable to load data');
  }

  static Future<JobModel> showJobByCategory(int catId) async {
    final url =
        '${apiUrl}jobsByCategory?category_id=$catId&user_id=${MyController.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return JobModel.fromJson(data);
    } else {
      Fluttertoast.showToast(
          msg:
              'Internal server error ${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable load data');
  }

  static Future<InternshipModel> getInternshipByCategory(int catId) async {
    final url =
        '${apiUrl}internshipsByCategory?user_id=${MyController.id}&category_id=$catId';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return InternshipModel.fromJson(data);
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable load data');
  }

  static Future<ReviewModel> getReviews() async {
    const url = '${apiUrl}review';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        return ReviewModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable to load data');
  }

  static Future<LogoModel> getLogo() async {
    const url = '${apiUrl}logo';
    c.profileImg.value == ""
        ? null
        : rc.pdfImg.value = await rc.downloadImage();
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        return LogoModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable to load data');
  }

  static Future<void> addToPref(int prefId) async {
    final url =
        '${apiUrl}addpreference?user_id=${MyController.id}&category_id=$prefId';
    c.isPrefLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        c.isPrefLoading.value = false;
        Fluttertoast.showToast(msg: data['message']);
      } else {
        c.isPrefLoading.value = false;
        Fluttertoast.showToast(msg: 'Already Added');
      }
    } else {
      c.isPrefLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable to load data');
  }

  static Future<void> removeFromPref(int prefId) async {
    final url =
        '${apiUrl}deletePreference?user_id=${MyController.id}&preference_id=$prefId';
    c.isPrefLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        c.isPrefLoading.value = false;
        Fluttertoast.showToast(msg: 'Removed');
      } else {
        c.isPrefLoading.value = false;
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      c.isPrefLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable to load data');
  }

  static Future<PrefModel> showPref() async {
    final url = '${apiUrl}showpreference?user_id=${MyController.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        return PrefModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable to load data');
  }
}
