import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class SetNewPasswordScreen extends StatelessWidget {
  SetNewPasswordScreen({super.key});
  final TextEditingController setPasswordCTRl = TextEditingController();
  final TextEditingController confirmPasswordCTRl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.setNewPassword.tr,
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
                text: AppStrings.yourPasswordMust.tr,
                fontWeight: FontWeight.w500,
                fontsize: 18.sp,
                textAlign: TextAlign.start,
                maxline: 3,
              ),
              //====================================> Set A Password Text Field <=========================
              SizedBox(height: 16.h),
              CustomTextField(
                controller: setPasswordCTRl,
                contenpaddingVertical: 16.h,
                contenpaddingHorizontal: 12.w,
                hintText: AppStrings.setANewPassword.tr,
                isPassword: true,
              ),
              //====================================> Confirm Password Text Field <=========================
              SizedBox(height: 16.h),
              CustomTextField(
                controller: confirmPasswordCTRl,
                contenpaddingVertical: 16.h,
                contenpaddingHorizontal: 12.w,
                hintText: AppStrings.confirmNewPassword.tr,
                isPassword: true,
              ),
              //====================================> Reset Password Button  <=========================
              SizedBox(height: 382.h),
              CustomButton(
                  title: AppStrings.resetPassword.tr,
                  onpress: () {
                    // Get.toNamed(AppRoutes.verifyNumberScreen);
                  }),
              SizedBox(height: 74.h)
            ],
          ),
        ),
      ),
    );
  }
}
