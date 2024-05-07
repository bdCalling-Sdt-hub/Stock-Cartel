import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/utils/app_icons.dart';
import 'package:stock_cartel/utils/app_strings.dart';
import 'package:stock_cartel/views/widgets/custom_button.dart';
import 'package:stock_cartel/views/widgets/custom_list_tile.dart';
import 'package:stock_cartel/views/widgets/custom_text.dart';

import '../../../utils/app_colors.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = ""; // String to store the selected language

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
              text: AppStrings.chooseLanguage,
              fontsize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
            //=================================> English Tile <=============================
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedLanguage =
                      AppStrings.english; // Update selected language
                });
              },
              child: CustomListTile(
                title: AppStrings.english,
                prefixIcon: Radio(
                    value: AppStrings.english,
                    activeColor: AppColors.primaryColor,
                    groupValue:
                        selectedLanguage, // Use selectedLanguage as groupValue
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value!; // Update selected language
                      });
                    }),
              ),
            ),
            //=================================> Spanish Tile <=============================
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedLanguage =
                      AppStrings.spanish; // Update selected language
                });
              },
              child: CustomListTile(
                title: AppStrings.spanish,
                prefixIcon: Radio(
                    value: AppStrings.spanish,
                    activeColor: AppColors.primaryColor,
                    groupValue:
                        selectedLanguage, // Use selectedLanguage as groupValue
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value!; // Update selected language
                      });
                    }),
              ),
            ),
            const Spacer(),
            CustomButton(
              title: AppStrings.continues,
              onpress: () {},
            ),
            SizedBox(height: 54.h)
          ],
        ),
      ),
    );
  }
}
