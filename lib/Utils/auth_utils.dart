import 'dart:convert';
import 'package:spires_app/Constants/exports.dart';
import 'package:http/http.dart' as http;

import '../Screens/Main_Screens/main_screen.dart';

class AuthUtils {
  static final c = Get.put(MyController());
  static final rc = Get.put(ResumeController());
  static Future<void> getRegistered(
      {required String fname,
      required String lname,
      required String email,
      required String pass,
      required String phone}) async {
    final url =
        '${apiUrl}employee-signup?fname=$fname&lname=$lname&email=$email&password=$pass&phone_number=$phone';
    c.isRegLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        SharedPrefs.loginSave(email: email, password: pass);
        Fluttertoast.showToast(msg: 'Registration Successful');
        MyController.id = data['data']['id'];
        MyController.userFirstName = data['data']['fname'];
        MyController.userLastName = data['data']['lname'];
        MyController.userEmail = data['data']['email'];
        MyController.userPhone = data['data']['phone_number'];
        MyController.veriPhone = '';
        MyController.veriEmail = '';
        MyController.subscribed = '';
        Get.offAll(() => MainScreen());
        c.isRegLoading.value = false;
      } else {
        Fluttertoast.showToast(msg: data['message']);
        c.isRegLoading.value = false;
      }
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode} ${response.reasonPhrase}');
      c.isRegLoading.value = false;
    }
  }

  static Future<void> getLogin(
      {required String email, required String pass}) async {
    final url = '${apiUrl}employee-login?email=$email&password=$pass';
    c.isLoginLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        SharedPrefs.loginSave(email: email, password: pass);
        MyController.id = data['data']['id'];
        MyController.userFirstName = data['data']['fname'];
        MyController.userLastName = data['data']['lname'];
        MyController.userEmail = data['data']['email'];
        MyController.userPhone = data['data']['phone_number'];
        c.profileImg.value = data['data']['image'] ?? "";
        MyController.veriEmail = data['data']['is_everify'];
        MyController.veriPhone = data['data']['is_phone_verified'];
        MyController.subscribed = data['data']['sub_status'];
        Get.offAll(() => MainScreen());
        Fluttertoast.showToast(msg: 'Login Successful');
        Future.delayed(const Duration(seconds: 2), () {
          c.isLoginLoading.value = false;
        });
      } else {
        Fluttertoast.showToast(msg: data['message']);
        c.isLoginLoading.value = false;
      }
    } else {
      Fluttertoast.showToast(
          msg: ' ${response.statusCode} ${response.reasonPhrase}');
      c.isLoginLoading.value = false;
    }
  }

  static Future<void> updatePass({required String newPass}) async {
    final url =
        '${apiUrl}updatePassword?phone_number=${MyController.userPhone}&password=$newPass';
    c.isLoginLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        Get.back();
        SharedPrefs.loginSave(email: MyController.userEmail, password: newPass);
        Fluttertoast.showToast(msg: 'Password updated');
        c.isLoginLoading.value = false;
      } else {
        Fluttertoast.showToast(msg: 'Invalid Credentials');
        c.isLoginLoading.value = false;
      }
    } else {
      Fluttertoast.showToast(msg: 'Internal server error');
      c.isLoginLoading.value = false;
    }
  }

  static Future<void> forgetPass({required String email}) async {
    final url = '${apiUrl}forget-password?email=$email';
    c.isLoginLoading.value = true;
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        Get.back();
        Get.defaultDialog(
          title: 'Email Sent',
          middleText: 'An Email with a link has been sent to $email',
          confirm: OutlinedButton(
            onPressed: () => Get.back(),
            child: Text('OK', style: normalColorText),
          ),
        );
        c.isLoginLoading.value = false;
      } else {
        Fluttertoast.showToast(msg: 'Email id is not registered with us.');
        c.isLoginLoading.value = false;
      }
    } else {
      Fluttertoast.showToast(msg: 'Internal server error');
      c.isLoginLoading.value = false;
    }
  }
}
