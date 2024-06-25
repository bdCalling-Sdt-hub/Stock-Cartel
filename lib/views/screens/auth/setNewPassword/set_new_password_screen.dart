import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/authController/auth_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class SetNewPasswordScreen extends StatelessWidget {
  SetNewPasswordScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController setPasswordCTRl = TextEditingController();
  final TextEditingController confirmPasswordCTRl = TextEditingController();
  final _authController = Get.put(AuthController());
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
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
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
                  hintText: AppStrings.setANewPassword.tr,
                  isPassword: true,
                ),
                //====================================> Confirm Password Text Field <=========================
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: confirmPasswordCTRl,
                  hintText: AppStrings.confirmNewPassword.tr,
                  isPassword: true,
                  validator: (value){
                    bool data = AppConstants.passwordValidator.hasMatch(value);
                    if (value.isEmpty) {
                      return "Please enter confirm password";
                    } else if (!data) {
                      return "Insecure password detected.";
                    }else if(setPasswordCTRl.text !=value){
                      return "Password did not match.";
                    }
                    return null;
                  },
                ),
                //====================================> Reset Password Button  <=========================
                SizedBox(height: 382.h),
                Obx(()=> CustomButton(
                      text: AppStrings.resetPassword.tr,
                      loading: _authController.setPasswordLoading.value,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _authController.setPassword(
                              Get.arguments, confirmPasswordCTRl.text);
                        }
                      }),
                ),
                SizedBox(height: 74.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
