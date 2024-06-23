import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_list_tile.dart';
import '../../../widgets/custom_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.settings.tr,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          children: [
            //=================================> Change Password Section <=======================
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.changePasswordScreen);
              },
              child: CustomListTile(
                title: AppStrings.changePassword.tr,
                prefixIcon: SvgPicture.asset(
                  AppIcons.lock,
                  color: Colors.black,
                ),
                sufixIcon: SvgPicture.asset(
                  AppIcons.rightArrow,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            //=================================> Privacy Policy Section <=======================

            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.privacyPolicyScreen);
              },
              child: CustomListTile(
                title: AppStrings.privacyPolicy.tr,
                prefixIcon: SvgPicture.asset(
                  AppIcons.privacyPolicy,
                  color: Colors.black,
                ),
                sufixIcon: SvgPicture.asset(
                  AppIcons.rightArrow,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            //=================================> Terms & Conditions Section <=======================

            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.termsConditionScreen);
              },
              child: CustomListTile(
                title: AppStrings.termsConditions.tr,
                prefixIcon: SvgPicture.asset(
                  AppIcons.terms,
                  color: Colors.black,
                ),
                sufixIcon: SvgPicture.asset(
                  AppIcons.rightArrow,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            //=================================> About Us Section <=======================
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.aboutusScreen);
              },
              child: CustomListTile(
                title: AppStrings.aboutUs.tr,
                prefixIcon: SvgPicture.asset(
                  AppIcons.aboutUs,
                  color: Colors.black,
                ),
                sufixIcon: SvgPicture.asset(
                  AppIcons.rightArrow,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            //=================================> Website Section <=======================
            /* GestureDetector(
              onTap: () {
                //Get.toNamed(AppRoutes.aboutusScreen);
              },
              child: CustomListTile(
                title: AppStrings.website.tr,
                prefixIcon: SvgPicture.asset(
                  AppIcons.website,
                  color: Colors.black,
                ),
                sufixIcon: SvgPicture.asset(
                  AppIcons.rightArrow,
                  color: Colors.black,
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
