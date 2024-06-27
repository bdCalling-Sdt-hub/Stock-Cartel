import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../controllers/profile_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/bottom_menu..dart';
import 'InnerWidget/custom_alert.dart';
import 'InnerWidget/custom_list_tile.dart';
import 'InnerWidget/top_profile_card.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool switchToProvide = false;
  final AuthController _authController = Get.put(AuthController());
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    _profileController.getProfileData();
    return Scaffold(
      bottomNavigationBar: BottomMenu(1),
      body: Obx(() {
        var profileData =
            _profileController.profileModel.value.data?.attributes;
        return SingleChildScrollView(
          child: Column(
            children: [
              //============================> TopContainer Section <======================
              TopProfileCard(
                profileName: '${profileData?.name}',
                profileUrl: profileData?.image?.publicFileUrl ?? '',
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  children: [
                    CustomListTile(
                      onTap: () {
                        Get.toNamed(AppRoutes.personalInformation);
                      },
                      title: AppStrings.personalInformation.tr,
                      prefixIcon: SvgPicture.asset(AppIcons.person,
                          color: AppColors.primaryColor),
                    ),
                    CustomListTile(
                      onTap: () {
                        Get.toNamed(AppRoutes.settingsScreen);
                      },
                      title: AppStrings.settings.tr,
                      prefixIcon: SvgPicture.asset(AppIcons.settings,
                          color: AppColors.primaryColor),
                    ),
                    CustomListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CustomAlert();
                            });
                      },
                      title: AppStrings.logOut.tr,
                      prefixIcon: SvgPicture.asset(AppIcons.logOut,
                          color: AppColors.primaryColor),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
