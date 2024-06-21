import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spires_app/Constants/exports.dart';
import 'package:spires_app/Model/job_model.dart';
import 'package:spires_app/Model/nearby_job_model.dart';
import 'package:spires_app/Widgets/custom_dialog.dart';

class JobsUtils {
  static final c = Get.put(MyController());

  static Future<JobModel> allJobs() async {
    final url =
        '${apiUrl}job?user_id=${MyController.id}&latitude=0.0&longitude=0.0&radius=0';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      c.allJob.value = data['data'].length;
      return JobModel.fromJson(data);
    } else {
      Fluttertoast.showToast(
          msg:
              'Internal server error ${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable load data');
  }

  static Future<NearbyJobModel> nearbyJobs(
      double lat, double long, int radius) async {
    final url =
        '${apiUrl}nearby-jobs?latitude=$lat&longitude=$long&radius=$radius&user_id=${MyController.id}';
    
    c.isNearbyLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      c.isNearbyLoading.value = false;
      final data = jsonDecode(response.body);
      
      return NearbyJobModel.fromJson(data);
    } else {
      c.isNearbyLoading.value = false;
      Fluttertoast.showToast(
          msg:
              'Internal server error ${response.statusCode} ${response.reasonPhrase}');
    }

    throw Exception('Unable load data');
  }

  static Future<JobModel> showJobs() async {
    final url = '${apiUrl}userjob?user_id=${MyController.id}';
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

  static Future<void> applyForJob({required int jobId}) async {
    c.isJobLoading.value = true;
    final url = '${apiUrl}job-apply?user_id=${MyController.id}&job_id=$jobId';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        c.isJobLoading.value = false;
        c.isJobApplied.value = true;
        Fluttertoast.showToast(msg: 'Applied');
      } else {
        c.isJobLoading.value = false;
        customDialog(title: 'Attention', middleText: data['message']);
        Fluttertoast.showToast(msg: data['message']);
      }
    } else {
      c.isJobLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<void> saveJob({required int jobId}) async {
    final url = '${apiUrl}saveJob?user_id=${MyController.id}&job_id=$jobId';
    c.isJobLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        c.isJobLoading.value = false;
        c.isJobSaved.value = true;
        Fluttertoast.showToast(msg: 'Saved');
      } else {
        c.isJobLoading.value = false;
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      c.isJobLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<void> unSaveJob({required int jobId}) async {
    final url = '${apiUrl}unsaveJob?user_id=${MyController.id}&job_id=$jobId';
    c.isJobLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        c.isJobLoading.value = false;
        c.isJobSaved.value = false;
        Fluttertoast.showToast(msg: 'Removed');
      } else {
        c.isJobLoading.value = false;
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      c.isJobLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<JobModel> showSavedJobs() async {
    final url = '${apiUrl}getSavedJobs?user_id=${MyController.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        return JobModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: ' ${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable load data');
  }

  static Future<JobModel> showAppliedJob() async {
    final url = '${apiUrl}getApplyJobs?user_id=${MyController.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        return JobModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: ' ${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable load data');
  }
}
