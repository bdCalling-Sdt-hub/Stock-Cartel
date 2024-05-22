import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/routes/app_routes.dart';
import 'package:stock_cartel/utils/app_icons.dart';
import 'package:stock_cartel/utils/app_strings.dart';
import 'package:stock_cartel/views/widgets/custom_button.dart';
import 'package:stock_cartel/views/widgets/custom_list_tile.dart';
import 'package:stock_cartel/views/widgets/custom_text.dart';

import '../../../controllers/localaization_controller.dart';
import '../../../helpers/prefs_helpers.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/style.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  LocalizationController localizationController =
      Get.find<LocalizationController>();
  /*var data = [
    {'name': 'English'},
    {'name': 'Spanish'},
  ];*/
  var selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 118.h),
            CustomText(
              text: AppStrings.chooseLanguage.tr,
              fontsize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
            ListView.builder(
                itemCount: AppConstants.languages.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  var data = AppConstants.languages[index];
                  return GestureDetector(
                    onTap: () {
                      localizationController.setLanguage(Locale(
                        AppConstants.languages[index].languageCode,
                        AppConstants.languages[index].countryCode,
                      ));
                      localizationController.setSelectIndex(index);
                      setState(() {
                        selectedOption = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.fieldColor,
                          border: Border.all(
                              width: 1.w, color: AppColors.primaryColor)),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
                        leading: Radio<int>(
                          value: index,
                          groupValue: selectedOption,
                          activeColor: Get.theme.primaryColor,
                          fillColor:
                              MaterialStateProperty.all(Get.theme.primaryColor),
                          splashRadius: 25.r,
                          onChanged: (_) {
                            localizationController.setLanguage(Locale(
                              AppConstants.languages[index].languageCode,
                              AppConstants.languages[index].countryCode,
                            ));
                            localizationController.setSelectIndex(index);
                            setState(() {
                              selectedOption = index;
                            });
                          },
                        ),
                        title: Text(
                          data.languageName.tr,
                          style: AppStyles.customSize(
                              size: 16, color: Colors.black),
                        ),
                      ),
                    ),
                  );
                }),
            const Spacer(),
            CustomButton(
              text: AppStrings.continues.tr,
              onTap: () {
                if (selectedOption != null) {
                  Get.toNamed(AppRoutes.onboardingScreen);
                } else {
                  return Get.snackbar('Error', 'Please select a language');
                }
              },
            ),
            SizedBox(height: 54.h)
          ],
        ),
      ),
    );
  }
}
