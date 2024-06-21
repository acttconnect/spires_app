import 'package:flutter/cupertino.dart';
import 'package:spires_app/Constants/exports.dart';
import 'package:spires_app/Screens/Bottom_nav_tabs/Drawer/programs_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: myTheme(),
      title: appName,
      debugShowCheckedModeBanner: false,
      home: autoLoginSystem(),
      // home: const ProgramsScreen(),
    );
  }

  FutureBuilder<bool> autoLoginSystem() {
    return FutureBuilder(
      future: SharedPrefs.autoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.data == true) {
            return const SplashScreen();
          } else {
            return const WelcomeScreen();
          }
        }
      },
    );
  }

  ThemeData myTheme() {
    return ThemeData(
      primarySwatch: mycolor,
      visualDensity: VisualDensity.standard,
      scaffoldBackgroundColor: bgColor,
      primaryColor: primaryColor,
      appBarTheme: const AppBarTheme(
        elevation: 1,
        centerTitle: true,
        backgroundColor: whiteColor,
        foregroundColor: blackColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          elevation: 0,
          shape: const StadiumBorder(),
          maximumSize: const Size(double.infinity, 45),
          minimumSize: const Size(double.infinity, 45),
        ),
      ),
      checkboxTheme: const CheckboxThemeData(
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      inputDecorationTheme: InputDecorationTheme(
          iconColor: primaryColor,
          fillColor: whiteColor,
          filled: true,
          hintStyle: smallLightText,
          prefixIconColor: primaryColor,
          contentPadding: const EdgeInsets.all(defaultPadding),
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(color: primaryColor),
          )),
    );
  }
}
