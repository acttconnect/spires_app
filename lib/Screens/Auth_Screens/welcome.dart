import 'package:spires_app/Constants/exports.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 55),
              Image.asset(appLogo, height: 90),
              Image.asset(wlcmBgImg, height: 250),
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Find Your ",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 34,
                        ),
                      ),
                      TextSpan(
                        text: "Dream Job Here!",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  "Explore all the most exciting job roles based on your interest.",
                  textAlign: TextAlign.center,
                  style: normalLightText,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Get.to(() => LoginScreen(),
                    transition: Transition.rightToLeft),
                child: Text(
                  'Login',
                  style: mediumWhiteText,
                ),
              ),
              const SizedBox(height: defaultPadding),
              ElevatedButton(
                onPressed: () => Get.to(
                  () => SignUpScreen(),
                ),
                child: Text(
                  'Register',
                  style: mediumWhiteText,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
