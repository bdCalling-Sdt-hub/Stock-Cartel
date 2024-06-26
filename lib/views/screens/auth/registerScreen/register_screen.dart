import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/utils/app_colors.dart';
import 'package:stock_cartel/utils/app_strings.dart';
import 'package:stock_cartel/views/widgets/custom_button.dart';
import 'package:stock_cartel/views/widgets/custom_text.dart';
import 'package:stock_cartel/views/widgets/custom_text_field.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../../utils/app_icons.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.register.tr,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: AppStrings.whatsYour.tr,
                fontWeight: FontWeight.w500,
                fontsize: 18.sp,
              ),
              CustomText(
                top: 8.h,
                text: AppStrings.weWillText.tr,
                maxline: 2,
                textAlign: TextAlign.start,
                bottom: 24.h,
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
                              _authController.selectedCountryCode = countryCode.dialCode!;
                              print(_authController.selectedCountryCode);
                            });
                          },
                          initialSelection: 'BD',
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
                      controller: _authController.phoneNumberCTRl,
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
              //====================================> Verify Button  <=========================
              const Spacer(),
              CustomButton(
                  loading: _authController.registerLoading.value,
                  text: AppStrings.verifyNumber.tr,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _authController.handleRegister();
                      print('===========================> This call api <==================');
                    } else {
                      return '==================> Something wrong';
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
