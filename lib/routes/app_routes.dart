import 'package:get/get.dart';
import '../views/screens/auth/sign_in/sign_in_screen.dart';
import '../views/screens/splashScreen/splash_screen.dart';

class AppRoutes{
  static const String splashScreen = "/splash_screen.dart";
  static const String signInScreen = "/sign_in_screen.dart";

  static List<GetPage> get routes => [
  GetPage(name: splashScreen, page: () => SplashScreen()),
  GetPage(name: signInScreen, page: () => SignInScreen()),
  ];
}