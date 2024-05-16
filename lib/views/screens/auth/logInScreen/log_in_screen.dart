import 'package:country_code_picker/country_code_picker.dart';
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

class LogInScreen extends StatefulWidget {
  LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberCodeCTRl = TextEditingController();
  final TextEditingController phoneNumberCTRl = TextEditingController();
  final TextEditingController passwordCTRl = TextEditingController();
  String _selectedCountryCode = '';

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
          child: Form(
            key: _formKey,
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
                    Container(
                      height: 56.h,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.w, color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //=================================> Country Code Picker Widget <============================
                          CountryCodePicker(
                            showFlag: false,
                            showFlagDialog: true,
                            onChanged: (countryCode) {
                              setState(() {
                                _selectedCountryCode = countryCode.dialCode!;
                              });
                            },
                            initialSelection: 'BD',
                            favorite: ['+880', 'BD'],
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: SvgPicture.asset(
                              AppIcons.downArrow,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: SizedBox(
                        height: 56.h,
                        child: CustomTextField(
                          keyboardType: TextInputType.phone,
                          controller: phoneNumberCTRl,
                          hintText: AppStrings.phoneNumber.tr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your \nphone number";
                            }
                            return null;
                          },
                        ),
                      ),
                    )
                  ],
                ),
                //====================================> Password Text Field <=========================
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: passwordCTRl,
                  hintText: AppStrings.password.tr,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  },
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
                CustomButton(
                    //loading: _authcontroller.forgotLoading.value,
                    text: AppStrings.logIn.tr,
                    onTap: () {
                      Get.toNamed(AppRoutes.subscriptionScreen);
                     /* if (_formKey.currentState!.validate()) {
                        _authcontroller.handleForget();
                        // Get.toNamed(AppRoutes.verifyOtpScreen);
                      }*/
                    }),
                SizedBox(height: 74.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
