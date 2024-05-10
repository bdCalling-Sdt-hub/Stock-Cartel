import 'package:get/get.dart';
import 'package:stock_cartel/views/screens/auth/registerScreen/register_screen.dart';
import 'package:stock_cartel/views/screens/languageScreen/language_screen.dart';
import '../views/screens/auth/createAccount/create_account_screen.dart';
import '../views/screens/auth/forgotPassword/forgot_password_screen.dart';
import '../views/screens/auth/logInScreen/log_in_screen.dart';
import '../views/screens/auth/setNewPassword/set_new_password_screen.dart';
import '../views/screens/auth/verifyNumber/verify_number_screen.dart';
import '../views/screens/homeScreen/home_screen.dart';
import '../views/screens/messageScreen/chat_screen.dart';
import '../views/screens/notificationsScreen/notifications_screen.dart';
import '../views/screens/onboardingScreen/onboarding_screen.dart';
import '../views/screens/profileScreen/profile_screen.dart';
import '../views/screens/splashScreen/splash_screen.dart';
import '../views/screens/subscriptionScreen/subscription_screen.dart';

class AppRoutes{
  static const String splashScreen = "/splash_screen.dart";
  static const String logInScreen = "/log_in_screen.dart";
  static const String languageScreen = "/language_screen.dart";
  static const String onboardingScreen = "/onboarding_screen.dart";
  static const String registerScreen = "/register_screen.dart";
  static const String verifyNumberScreen = "/verify_number_screen.dart";
  static const String forgotPasswordScreen = "/forgot_password_screen.dart";
  static const String setNewPasswordScreen = "/set_new_password_screen.dart";
  static const String createAccountScreen = "/create_account_screen.dart";
  static const String subscriptionScreen = "/subscription_screen.dart";
  static const String homeScreen = "/home_screen.dart";
  static const String chatScreen = "/chat_screen.dart";
  static const String notificationScreen = "/notification_screen.dart";
  static const String profileScreen = "/profile_screen.dart";

  static List<GetPage> get routes => [
  GetPage(name: splashScreen, page: () => SplashScreen()),
  GetPage(name: logInScreen, page: () => LogInScreen()),
  GetPage(name: languageScreen , page: () => LanguageScreen()),
  GetPage(name: onboardingScreen , page: () => OnboardingScreen()),
  GetPage(name: registerScreen , page: () => RegisterScreen()),
  GetPage(name: verifyNumberScreen , page: () => VerifyNumberScreen()),
  GetPage(name: forgotPasswordScreen , page: () => ForgotPasswordScreen()),
  GetPage(name: setNewPasswordScreen , page: () => SetNewPasswordScreen()),
  GetPage(name: createAccountScreen , page: () => CreateAccountScreen()),
  GetPage(name: subscriptionScreen , page: () => SubscriptionScreen()),
  GetPage(name: homeScreen , page: () => HomeScreen()),
  GetPage(name: chatScreen , page: () => ChatScreen()),
  GetPage(name: notificationScreen , page: () => NotificationScreen()),
  GetPage(name: profileScreen , page: () => ProfileScreen()),
  ];
}