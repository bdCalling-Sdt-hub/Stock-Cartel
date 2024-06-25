import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../controllers/profileController/profile_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../widgets/custom_list_tile.dart';
import '../../../widgets/custom_text.dart';
import 'InnerWidget/top_section.dart';

class PersonalInformation extends StatelessWidget {
  PersonalInformation({super.key});

  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    _profileController.getProfileData();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: CustomText(
          text: "Personal Information".tr,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        var profileData =
            _profileController.profileModel.value.data?.attributes;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            children: [
              //==================================> TopContainer Section <=================================
              TopSection(
                image: profileData?.image?.publicFileUrl ?? '',
                name: '${profileData?.name}',
                ontap: () {
                  Get.toNamed(AppRoutes.editProfileScreen);
                },
              ),
              SizedBox(height: 24.h),
              //=================================> Profile Name <==========================
              CustomListTile(
                  title: '${profileData?.name}',
                  prefixIcon: _prefixIcon(AppIcons.person)),
              SizedBox(height: 16.h),
              //=================================> Phone Number <========================
              CustomListTile(
                  title: '${profileData?.phone}',
                  prefixIcon: _prefixIcon(
                    AppIcons.phone,
                  )),
              SizedBox(height: 16.h),
            ],
          ),
        );
      }),
    );
  }

  _prefixIcon(String icon) {
    return SvgPicture.asset(icon, color: AppColors.primaryColor);
  }
}
