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

import '../../../helpers/prefs_helpers.dart';
import '../../../utils/app_colors.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = "";

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
            //=================================> English Tile <=============================
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedLanguage = AppStrings.english;
                });
              },
              child: CustomListTile(
                title: AppStrings.english.tr,
                prefixIcon: Radio(
                    value: AppStrings.english,
                    activeColor: AppColors.primaryColor,
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.primaryColor),
                    groupValue: selectedLanguage,
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value!;
                      });
                    }),
              ),
            ),
            //=================================> Spanish Tile <=============================
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedLanguage = AppStrings.spanish;
                });
              },
              child: CustomListTile(
                title: AppStrings.spanish.tr,
                prefixIcon: Radio(
                    value: AppStrings.spanish,
                    activeColor: AppColors.primaryColor,
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.primaryColor),
                    groupValue: selectedLanguage,
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value!;
                      });
                    }),
              ),
            ),
            const Spacer(),
            CustomButton(
              text: AppStrings.continues.tr,
              onTap: () {
                Get.toNamed(AppRoutes.onboardingScreen);
              },
            ),
            SizedBox(height: 54.h)
          ],
        ),
      ),
    );
  }
}
