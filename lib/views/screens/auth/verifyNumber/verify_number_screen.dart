import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/routes/app_routes.dart';
import 'package:stock_cartel/utils/app_colors.dart';
import '../../../../controllers/authController/auth_controller.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import 'InnerWidget/pin_code_text_field.dart';

class VerifyNumberScreen extends StatefulWidget {
  const VerifyNumberScreen({super.key});

  @override
  State<VerifyNumberScreen> createState() => _VerifyNumberScreenState();
}

class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
  var prameters = Get.parameters;
  final _authCtrl = Get.put(AuthController());

  @override
  void dispose() {
    _authCtrl.otpCtrl.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    print(
        "=================${prameters["phone"]} and ${prameters["screenType"]}");
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
              CustomPinCodeTextField(otpCTE: _authCtrl.otpCtrl),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //===============================> Didn't get the Code Text <=========================
                  CustomText(
                    text: AppStrings.didntGet.tr,
                  ),
                  //===============================> Resent Text <=========================
                  InkWell(
                    onTap: () {
                      _authCtrl.resendOtp('${prameters['phone']}');
                      _authCtrl.otpCtrl.clear();
                    },
                    child: CustomText(
                      text: AppStrings.resend.tr,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),

              //===============================> Verify Button  <=========================
              SizedBox(height: 203.h),
              CustomButton(
                  loading: _authCtrl.verifyLoading.value,
                  text: AppStrings.verifyNumber.tr,
                  onTap: () {
                    if (_authCtrl.otpCtrl.text.length > 5) {
                      Get.toNamed(AppRoutes.createAccountScreen);
                      _authCtrl.handleOtpVery(
                          phone: "${prameters['phone']}",
                          otp: _authCtrl.otpCtrl.text,
                          type: "${prameters['screenType']}");
                    }
                  }),
              SizedBox(height: 74.h)
            ],
          ),
        ),
      ),
    );
  }
}
