import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_cartel/utils/app_colors.dart';
import 'package:stock_cartel/views/widgets/custom_button.dart';
import 'package:stock_cartel/views/widgets/custom_text.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            //==========================> Background Image <=========================
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(AppImages.onboardingBg),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.srcOver,
                ),
              )),
            ),
            //=========================> App Logo Section <=====================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 138.h),
                  Center(
                    child: Image.asset(
                      AppImages.appLogo,
                      width: 164.w,
                      height: 96.h,
                    ),
                  ),
                  //========================> Welcome Section <===================
                  const Spacer(),
                  CustomText(
                    text: AppStrings.welcomeToStock,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontsize: 20.sp,
                  ),
                  SizedBox(height: 24.h),
                  CustomButton(onpress: () {}, title: AppStrings.register),
                  SizedBox(height: 16.h),
                  CustomButton(
                    onpress: () {},
                    title: AppStrings.logIn,
                    color: Colors.white,
                    titlecolor: AppColors.primaryColor,
                  ),
                  SizedBox(height: 54.h),
                ],
              ),
            ),
          ],
        ));
  }
}
