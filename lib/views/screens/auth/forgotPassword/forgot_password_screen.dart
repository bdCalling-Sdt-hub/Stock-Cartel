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

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final TextEditingController phoneNumberCodeCTRl = TextEditingController();
  final TextEditingController phoneNumberCTRl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.forgotPasswords.tr,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 256.h),
              CustomText(
                top: 24.h,
                bottom: 24.h,
                text: AppStrings.enterMobile.tr,
                fontWeight: FontWeight.w500,
                fontsize: 18.sp,
              ),
              //====================================> Phone Number Text Field <=========================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  SizedBox(width: 16.w),
                  SizedBox(
                    width: 250.w,
                    height: 56.h,
                    child: CustomTextField(
                      keyboardType: TextInputType.phone,
                      controller: phoneNumberCTRl,
                      hintText: AppStrings.phoneNumber.tr,
                    ),
                  )
                ],
              ),
              SizedBox(height: 24.h),
              //====================================> Get OTP Button  <=========================
              CustomButton(text: AppStrings.getOtp.tr, onTap: () {
                Get.toNamed(AppRoutes.verifyNumberScreen);
              }),
              SizedBox(height: 74.h)
            ],
          ),
        ),
      ),
    );
  }
}
