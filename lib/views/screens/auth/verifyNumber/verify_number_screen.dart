import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/utils/app_colors.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import 'InnerWidget/pin_code_text_field.dart';

class VerifyNumberScreen extends StatelessWidget {
  const VerifyNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.verifyNumber.tr,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 157.h),
              CustomText(
                text: AppStrings.verifyNumber.tr,
                fontWeight: FontWeight.w500,
                fontsize: 20.sp,
                bottom: 12.h,
              ),
              CustomText(
                text: AppStrings.weHaveSent.tr,
                maxline: 4,
                bottom: 16.h,
              ),
              //==============================> Pin Code Text Field <=====================
              CustomPinCodeTextField(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //===============================> Didn't get the Code Text <=========================
                  CustomText(
                    text: AppStrings.didntGet.tr,
                  ),
                  //===============================> Resent Text <=========================
                  InkWell(
                    onTap: () {},
                    child: CustomText(
                      text: AppStrings.resend.tr,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),

              //===============================> Verify Button  <=========================
              SizedBox(height: 203.h),
              CustomButton(title: AppStrings.verifyNumber, onpress: () {}),
              SizedBox(height: 74.h)
            ],
          ),
        ),
      ),
    );
  }
}
