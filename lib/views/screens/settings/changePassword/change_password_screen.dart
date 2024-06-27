import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/controllers/auth_controller.dart';
import '../../../../controllers/change_password_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordCtrl = TextEditingController();
  final TextEditingController newPasswordCtrl = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final ChangePasswordController _changePassCtrl = Get.put(
      ChangePasswordController());
  final AuthController _authController = Get.put(AuthController());

  bool isObscuresOld = true;
  bool isObscure = true;
  bool isObscures = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.changePasswords.tr,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //===============================> Old Password Text-field <===============================
                    CustomTextField(
                      contenpaddingHorizontal: 16.w,
                      contenpaddingVertical: 14.h,
                      isObscureText: isObscuresOld,
                      controller: oldPasswordCtrl,
                      isPassword: true,
                      prifixicon: _customIcons(AppIcons.lock),
                      hintText: AppStrings.oldPassword.tr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter old password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    //===============================> Set New Password Text-field <===============================
                    CustomTextField(
                      contenpaddingHorizontal: 16.w,
                      contenpaddingVertical: 14.h,
                      isObscureText: isObscures,
                      controller: newPasswordCtrl,
                      prifixicon: _customIcons(AppIcons.lock),
                      isPassword: true,
                      hintText: AppStrings.setNewPassword.tr,
                      /*validator: (value) {
                        if (value == null) {
                          return "Please set new password";
                        } else if (value.length < 8 ||
                            !_validatePassword(value)) {
                          return "Password: 8 characters min, letters & digits \nrequired";
                        }
                        return null;
                      },*/
                    ),
                    SizedBox(height: 16.h),
                    //===============================> Confirm Password Text-field <===============================
                    CustomTextField(
                      contenpaddingHorizontal: 16.w,
                      contenpaddingVertical: 14.h,
                      isObscureText: isObscure,
                      controller: confirmPassController,
                      prifixicon: _customIcons(AppIcons.lock),
                      isPassword: true,
                      hintText: AppStrings.confirmNewPassword.tr,
                      validator: (value) {
                        bool data = AppConstants.passwordValidator.hasMatch(
                            value);
                        if (value.isEmpty) {
                          return "Please re-enter password";
                        } else if (data) {
                          return "Insecure password detected.";
                        } else if (newPasswordCtrl.text != value) {
                          return "Password did not match.";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.forgotPasswordScreen,
                            parameters: {
                              "phone": _authController.phoneNumberCTRl.text
                            });
                      },
                      child: CustomText(
                        text: AppStrings.forgotPassword.tr,
                        fontWeight: FontWeight.w600,
                        fontsize: 16.h,
                        fontName: 'Lato',
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 367.h),
                    //===============================> Change Password Button <===============================
                    Obx(() => CustomButton(
                          text: AppStrings.changePasswords.tr,
                          loading: _changePassCtrl.changeLoading.value,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _changePassCtrl.handleChangePassword(
                                  oldPasswordCtrl.text,
                                  confirmPassController.text);
                            }
                          })
                    ),
                    SizedBox(height: 74.h),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //===============================> Custom Icons Method <===============================
  _customIcons(String icon,) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.w),
      child: SvgPicture.asset(
        icon,
        color: AppColors.primaryColor,
        height: 24.h,
        width: 24.w,
      ),
    );
  }

  bool _validatePassword(String value) {
    RegExp regex = RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z]).{6,}$');
    return regex.hasMatch(value);
  }
}
