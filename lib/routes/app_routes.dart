import 'package:get/get.dart';
import 'package:stock_cartel/views/screens/auth/registerScreen/register_screen.dart';
import 'package:stock_cartel/views/screens/languageScreen/language_screen.dart';
import '../views/screens/auth/logInScreen/log_in_screen.dart';
import '../views/screens/auth/verifyNumber/verify_number_screen.dart';
import '../views/screens/onboardingScreen/onboarding_screen.dart';
import '../views/screens/splashScreen/splash_screen.dart';

class AppRoutes{
  static const String splashScreen = "/splash_screen.dart";
  static const String logInScreen = "/log_in_screen.dart";
  static const String languageScreen = "/language_screen.dart";
  static const String onboardingScreen = "/onboarding_screen.dart";
  static const String registerScreen = "/register_screen.dart";
  static const String verifyNumberScreen = "/verify_number_screen.dart";

  static List<GetPage> get routes => [
  GetPage(name: splashScreen, page: () => SplashScreen()),
  GetPage(name: logInScreen, page: () => LogInScreen()),
  GetPage(name: languageScreen , page: () => LanguageScreen()),
  GetPage(name: onboardingScreen , page: () => OnboardingScreen()),
  GetPage(name: registerScreen , page: () => RegisterScreen()),
  GetPage(name: verifyNumberScreen , page: () => VerifyNumberScreen()),
  ];
}