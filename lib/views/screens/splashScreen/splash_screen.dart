import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stock_cartel/controllers/create_account_controller.dart';
import 'package:stock_cartel/utils/app_images.dart';
import '../../../helpers/prefs_helpers.dart';
import '../../../routes/app_routes.dart';
import 'dart:math' as math;

import '../../../utils/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;
  final CreateAccountController _createAccountController = Get.put(CreateAccountController());
  _route() {
    Timer(const Duration(seconds: 1), () async {
      var onBoard = await PrefsHelper.getBool(AppConstants.isOnboard);
      var isLogged = await PrefsHelper.getBool(AppConstants.isLogged);
      var subscription = await PrefsHelper.getString(AppConstants.subscription);
      var subscriptionDateAviale = await PrefsHelper.getBool(AppConstants.isFutureDate);
      if (onBoard == true) {
        if (isLogged == true ) {
         // if(subscriptionDateAviale){
            Get.offNamed(AppRoutes.homeScreen);
            print("=================================================================>  $subscription and $subscriptionDateAviale");
        //  }
        //   else{
        //     Get.offAllNamed(AppRoutes.subscriptionScreen);
        //   }
        } else {
          Get.offAllNamed(AppRoutes.languageScreen);
        }
      } else {
        Get.offAllNamed(AppRoutes.onboardingScreen);
      }
    });
  }
  @override
  void initState() {
    super.initState();
    StreamSubscription;
    getConnectivity();
    _route();
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
          //Get.offAllNamed(AppRoutes.languageScreen);
          _route();
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
