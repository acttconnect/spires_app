import '../Constants/exports.dart';

class SharedPrefs {
  static final c = Get.put(MyController());
  static Future<void> loginSave(
      {required String email, required String password}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', email);
    preferences.setString('pass', password);
  }

  static Future<bool> autoLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('email')) {
      String mail = preferences.getString('email')!;
      String password = preferences.getString('pass')!;
      c.authEmail.value = mail;
      c.authPass.value = password;
      return true;
    }
    return false;
  }

  static Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    c.selectedIndex.value = 0;
    c.isSubscribed.value = false;
    c.isEmailVerified.value = false;
    c.isPhoneVerified.value = false;
    Get.offAll(() => LoginScreen(), transition: Transition.leftToRightWithFade);
  }
}
