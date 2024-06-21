import '../../Constants/exports.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final loginKey = GlobalKey<FormState>();
  final c = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => c.isLoginLoading.value
            ? loading
            : Container(
                width: double.maxFinite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Form(
                  key: loginKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Image.asset(appLogo, height: 85),
                      ),
                      Text(
                        "Welcome Back",
                        style: xLargeColorText,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 36),
                        child: Text(
                          "Good to see you again,",
                          textAlign: TextAlign.center,
                          style: normalLightText,
                        ),
                      ),
                      CustomTextField(
                        controller: emailController,
                        hintText: 'Your Email',
                        iconData: Icons.email,
                        isEmail: true,
                      ),
                      CustomTextField(
                        controller: passController,
                        hintText: 'Enter Password',
                        iconData: Icons.lock,
                        isPassword: true,
                      ),
                      const SizedBox(height: defaultPadding),
                      forgetPass(),
                      const SizedBox(height: defaultPadding * 2),
                      loginButton(),
                      const SizedBox(height: defaultPadding * 2),
                      // loginwithGoogle(),
                      // const SizedBox(height: defaultPadding * 2),
                      donthaveAccount(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Row forgetPass() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () => Get.to(() => ForgetPassword()),
          child: Text(
            "Forgot Password ?",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: normalColorText,
          ),
        ),
      ],
    );
  }

  ElevatedButton loginButton() {
    return ElevatedButton.icon(
      onPressed: () {
        final isValid = loginKey.currentState!.validate();
        if (isValid) {
          AuthUtils.getLogin(
              email: emailController.text, pass: passController.text);
        }
      },
      icon: const Icon(
        Icons.login,
        color: Colors.white,
      ),
      label: Text(
        "Login",
        style: normalWhiteText,
      ),
    );
  }

  ElevatedButton loginwithGoogle() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            googleIcon,
            width: 30,
          ),
          const SizedBox(width: 10),
          Text(
            "Sign in with Google",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: normalLightText,
          ),
        ],
      ),
    );
  }

  RichText donthaveAccount() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Don't have an account yet?  ",
            style: normalLightText,
          ),
          TextSpan(
            text: "Sign Up",
            style: const TextStyle(
              color: primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.to(() => SignUpScreen()),
          )
        ],
      ),
      textAlign: TextAlign.left,
    );
  }
}
