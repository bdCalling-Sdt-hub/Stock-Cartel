import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/bottom_menu..dart';
import 'InnerWidget/custom_list_tile.dart';
import 'InnerWidget/top_profile_card.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool switchToProvide = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(1),
      body: Column(
        children: [
          TopProfileCard(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              children: [
                CustomListTile(
                  onTap: () {
                    Get.toNamed(AppRoutes.personalInformation);
                  },
                  title: AppStrings.personalInformation,
                  prefixIcon: SvgPicture.asset(AppIcons.person,
                      color: AppColors.primaryColor),
                ),
                CustomListTile(
                  onTap: () {
                    Get.toNamed(AppRoutes.settingsScreen);
                  },
                  title: AppStrings.settings,
                  prefixIcon: SvgPicture.asset(AppIcons.settings,
                      color: AppColors.primaryColor),
                ),
                CustomListTile(
                  onTap: () {
                    // Get.toNamed(AppRoutes.settingScreen);
                  },
                  title: AppStrings.logOut,
                  prefixIcon: SvgPicture.asset(AppIcons.logOut,
                      color: AppColors.primaryColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
