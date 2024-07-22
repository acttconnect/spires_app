import 'package:firebase_auth/firebase_auth.dart';
import 'package:spires_app/Constants/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isSelected = false;
  final c = Get.put(MyController());

  Future<void> navToWelcome() async {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        final isLoggedIn = FirebaseAuth.instance.currentUser!=null;
        if(isLoggedIn){
          AuthUtils().signInWithGoogle();
        }else{
          AuthUtils.getLogin(email: c.authEmail.value, pass: c.authPass.value);
        }
      },
    );
    Future.delayed(const Duration(milliseconds: 200),
        () => setState(() => isSelected = true));
  }

  @override
  void initState() {
    navToWelcome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Lottie.asset(splashLottie, height: size.height, fit: BoxFit.cover),
          GestureDetector(
            onTap: () => setState(() => isSelected = !isSelected),
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(seconds: 2),
                height: isSelected ? 220 : 50,
                width: isSelected ? 220 : 50,
                curve: Curves.elasticOut,
                child: Image.asset(appLogo),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
