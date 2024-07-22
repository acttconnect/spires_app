import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
        MyController.userPhone = data['data']['phone_number'] ?? '';
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

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final String _apiUrl = 'https://www.spiresrecruit.com/api/google-login';

   Future<UserCredential?> signInWithGoogle() async {
    try {
      // final User? currentUser = _firebaseAuth.currentUser;
      // if (currentUser != null) {
      //   print('User is already signed in: ${currentUser.displayName}');
      //   return null;
      // }
      // Initiate Google Sign-In
      print('Signing in with Google');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('Google sign-in aborted.');
        return null;
      }

      print('Google user: ${googleUser.displayName}, ${googleUser.email}, ${googleUser.photoUrl}, ${googleUser.id}, ${googleUser.serverAuthCode}');
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print('Google auth: $googleAuth');

      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        print('Google auth tokens are missing.');
        return null;
      }

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print('Google credentials: $credential');

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      final String? idToken = googleAuth.idToken;


      // Send Google sign-in data to the API
      final customUserId = await _sendGoogleSignInDataToApi(googleUser, idToken ?? '');
      if (customUserId != null) {
        // Store user data
        SharedPrefs.loginSave(email: userCredential.user!.email!, password:'');
        MyController.id = customUserId;
        MyController.userFirstName = googleUser.displayName?.split(' ').first ?? '';
        MyController.userLastName = googleUser.displayName?.split(' ').last ?? '';
        MyController.userEmail = googleUser.email;
        MyController.userPhone = '';
        MyController.veriEmail = 'verified';
        MyController.veriPhone = '';
        MyController.subscribed = '';
        Get.offAll(() => MainScreen());
      } else {
        throw Exception('Failed to get custom user ID.');
      }
      return userCredential;
    } catch (error) {
      print('Error during Google sign-in: $error');
      return null;
    }
  }


  Future<int?> _sendGoogleSignInDataToApi(GoogleSignInAccount googleUser, String idToken) async {
    final String email = googleUser.email;
    final String givenName = googleUser.displayName?.split(' ').first ?? '';
    final String familyName = googleUser.displayName?.split(' ').last ?? '';
    final String picture = googleUser.photoUrl ?? '';

    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id_token': idToken,
        'email': email,
        'given_name': givenName,
        'family_name': familyName,
        'picture': picture,
      }),
    );



    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      final data = jsonDecode(response.body);
      print('Data: $data');
      if (data['error'] == false) {
        return data['data']['id'];
      } else {
        throw Exception('Error fetching user ID from the API: ${data['message']}');
      }
    } else {
      throw Exception('Failed to send Google sign-in data to the API. Status code: ${response.statusCode}');
    }
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
