import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spires_app/Constants/exports.dart';
import 'package:spires_app/Model/internship_model.dart';
import 'package:spires_app/Widgets/custom_dialog.dart';

class InternshipUtils {
  static final c = Get.put(MyController());

  static Future<InternshipModel> allInternship() async {
    final url = '${apiUrl}internship?user_id=${MyController.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      c.allInternship.value = data['data'].length;
      return InternshipModel.fromJson(data);
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable load data');
  }

  static Future<InternshipModel> showInternship() async {
    final url = '${apiUrl}internshipCategory?user_id=${MyController.id}';
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

  static Future<void> applyForInternship({required int internId}) async {
    final url =
        '${apiUrl}internship-apply?user_id=${MyController.id}&internship_id=$internId';
    c.isInternshipLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        c.isInternshipLoading.value = false;
        c.isInternshipApplied.value = true;
        Fluttertoast.showToast(msg: 'Applied');
      } else {
        c.isInternshipLoading.value = false;
        customDialog(title: 'Attention', middleText: data['message']);
        Fluttertoast.showToast(msg: data['message']);
      }
    } else {
      c.isInternshipLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<void> saveInternship({required int internID}) async {
    final url =
        '${apiUrl}saveInternship?user_id=${MyController.id}&internship_id=$internID';
    c.isInternshipLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        c.isInternshipLoading.value = false;
        c.isInternshipSaved.value = true;
        Fluttertoast.showToast(msg: 'Saved');
      } else {
        c.isInternshipLoading.value = false;
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      c.isInternshipLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<void> unSaveInternship({required int internId}) async {
    c.isInternshipLoading.value = true;
    final url =
        '${apiUrl}unsaveInternship?user_id=${MyController.id}&internship_id=$internId';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        c.isInternshipLoading.value = false;
        c.isInternshipSaved.value = false;
        Fluttertoast.showToast(msg: 'Removed');
      } else {
        c.isInternshipLoading.value = false;
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      c.isInternshipLoading.value = false;
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<InternshipModel> showSavedInternship() async {
    final url = '${apiUrl}getSavedInternship?user_id=${MyController.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        return InternshipModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } else {
      Fluttertoast.showToast(
          msg: ' ${response.statusCode} ${response.reasonPhrase}');
    }
    throw Exception('Unable load data');
  }

  static Future<InternshipModel> showAppliedInternship() async {
    final url = '${apiUrl}getApplyInternship?user_id=${MyController.id}';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        return InternshipModel.fromJson(data);
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
