import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../controllers/authController/auth_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberCodeCTRl = TextEditingController();
  final TextEditingController phoneNumberCTRl = TextEditingController();
  final _authController = Get.put(AuthController());
  String _selectedCountryCode = '';
  

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
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 256.h),
                CustomText(
                  bottom: 24.h,
                  text: AppStrings.enterMobile.tr,
                  maxline: 2,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                  fontsize: 18.sp,
                ),
                //====================================> Phone Number Text Field <=========================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
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
                      child: CustomTextField(
                        keyboardType: TextInputType.phone,
                        controller: phoneNumberCTRl,
                        hintText: AppStrings.phoneNumber.tr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your phone \nnumber";
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24.h),
                //====================================> Get OTP Button  <=========================
                CustomButton(
                    text: AppStrings.getOtp.tr,
                    loading: _authController.forgotLoading.value,
                    onTap: () {
                      Get.toNamed(AppRoutes.verifyNumberScreen);
                      if (_formKey.currentState!.validate()) {
                        _authController.forgotPassword(phoneNumberCTRl.text.trim());
                      }
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
