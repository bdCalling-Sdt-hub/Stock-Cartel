import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/routes/app_routes.dart';
import 'package:stock_cartel/services/socket_service.dart';
import 'package:stock_cartel/utils/app_constants.dart';
import 'package:stock_cartel/utils/messages.dart';
import 'package:stock_cartel/views/screens/splashScreen/splash_screen.dart';
import 'controllers/auth_controller.dart';
import 'controllers/localaization_controller.dart';
import 'controllers/theme_controller.dart';
import 'helpers/di.dart' as di;
import 'helpers/notification_helper.dart';
import 'themes/light_theme.dart';

final FlutterLocalNotificationsPlugin fln=FlutterLocalNotificationsPlugin();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Map<String, Map<String, String>> _languages = await di.init();
  await NotificationHelper.initLocalNotification(fln);
  Get.put(AuthController());
 SocketService.init();
  runApp(MyApp(
    languages: _languages,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languages});
  final Map<String, Map<String, String>> languages;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return ScreenUtilInit(
            designSize: const Size(390, 844),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return GetMaterialApp(
                title: AppConstants.APP_NAME,
                debugShowCheckedModeBanner: false,
                navigatorKey: Get.key,
                theme: light(),
                defaultTransition: Transition.topLevel,
                locale: localizeController.locale,
                translations: Messages(languages: languages),
                fallbackLocale: Locale(AppConstants.languages[0].languageCode,
                    AppConstants.languages[0].countryCode),
                transitionDuration: const Duration(milliseconds: 500),
                getPages: AppRoutes.routes,
                initialRoute: AppRoutes.splashScreen,
                home: const SplashScreen(),
              );
            });
      });
    });
  }
}
