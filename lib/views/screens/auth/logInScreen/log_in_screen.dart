import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});
  final TextEditingController phoneNumberCodeCTRl = TextEditingController();
  final TextEditingController phoneNumberCTRl = TextEditingController();
  final TextEditingController passwordCTRl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.logIn.tr,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                top: 24.h,
                bottom: 24.h,
                text: AppStrings.logInToYour.tr,
                fontWeight: FontWeight.w500,
                fontsize: 18.sp,
              ),
              //====================================> Phone Number Text Field <=========================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 84.w,
                    height: 56.h,
                    child: CustomTextField(
                      contenpaddingHorizontal: 12.w,
                      contenpaddingVertical: 16.h,
                      readOnly: true,
                      controller: phoneNumberCodeCTRl,
                      hintText: '+44'.tr,
                      sufixicons: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        child: SvgPicture.asset(
                          AppIcons.downArrow,
                          width: 20.h,
                          height: 12.h,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  SizedBox(
                    width: 250.w,
                    height: 56.h,
                    child: CustomTextField(
                      keyboardType: TextInputType.phone,
                      contenpaddingHorizontal: 12.w,
                      contenpaddingVertical: 16.h,
                      controller: phoneNumberCTRl,
                      hintText: AppStrings.phoneNumber.tr,
                    ),
                  )
                ],
              ),
           //====================================> Password Text Field <=========================
              SizedBox(height: 16.h),
              CustomTextField(controller: passwordCTRl,
              contenpaddingVertical: 16.h,
                contenpaddingHorizontal: 12.w,
                hintText: AppStrings.password.tr,
                isPassword: true,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.forgotPasswordScreen);
                },
                child: CustomText(
                  top: 12.h,
                  text: AppStrings.forgotPassword.tr,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              //====================================> Log In Button  <=========================
              SizedBox(height: 367.h),
              CustomButton(title: AppStrings.logIn.tr, onpress: () {
                Get.toNamed(AppRoutes.createAccountScreen);
              }),
              SizedBox(height: 74.h)
            ],
          ),
        ),
      ),
    );
  }
}
