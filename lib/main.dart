import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/themes/themes.dart';
import 'package:stock_cartel/views/screens/languageScreen/language_screen.dart';
import 'routes/app_routes.dart';
import 'views/screens/splashScreen/splash_screen.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        title: 'Stock Cartel',
        theme: Themes().darkTheme,
        darkTheme: Themes().darkTheme,
        initialRoute: AppRoutes.languageScreen,
        getPages: AppRoutes.routes,
        home: const LanguageScreen(),
      ),
      designSize: const Size(390, 844),
    );
  }
}