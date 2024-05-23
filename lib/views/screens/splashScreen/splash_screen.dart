import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stock_cartel/utils/app_images.dart';
import '../../../routes/app_routes.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();
    StreamSubscription;
    getConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Center(
          child: Image.asset(
            AppImages.appLogo,
            width: 350.w,
            height: 202.h,
          ),
        ),
      ),
    );
  }

  //===================> Internet connection checker <==========================
  StreamSubscription? streamSubscription;
  bool isConnection = false;
  //========================> Is internet connection check <====================
  void getConnectivity() {
    streamSubscription =
        Connectivity().onConnectivityChanged.listen((event) async {
      isConnection = await InternetConnectionChecker().hasConnection;

      //==================> if internet is available <======================
      if (isConnection) {
        print("------------------Internet available");
        Timer(const Duration(seconds: 4), () async {
          Get.offAllNamed(AppRoutes.languageScreen);
        });
      }

      //=============================> No internet <========================
      else {
        Fluttertoast.showToast(msg: "Please connect your internet");
        print("----------------------No internet");
        return null;
      }
    });
  }
}
