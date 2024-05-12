import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../routes/app_routes.dart';
import '../../../widgets/custom_list_tile.dart';
import '../../../widgets/custom_text.dart';
import 'InnerWidget/top_section.dart';

class PersonalInformation extends StatelessWidget {
  PersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: CustomText(
          text: "Personal Information",
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 27.w),
        child: Column(
          children: [
            SizedBox(height: 24.h),
            //==================================> TopContainer Section <=================================
            TopSection(
              ontap: () {
                Get.toNamed(AppRoutes.editProfileScreen);
                /*var data = _profileController.profileModel.value;
                Get.toNamed(AppRoutes.editProfileScreen, parameters: {
                  "name": '${data.fullName}',
                  "email": '${data.email}',
                  "phone": '${data.phoneNumber}',
                  "dateOfBirth": '${data.dataOfBirth}',
                  "nidNo": '${data.nidNumber}',
                  "address": '${data.address}',
                  "image": '${data.image!.url}',
                });*/
              },
            ),
            SizedBox(height: 24.h),
            //==================================> CustomContainer Section <=================================

            SizedBox(height: 24.h),

            //=================================> Profile Name <==========================
            CustomListTile(
                title: 'Write your name',
                prefixIcon: _prefixIcon(AppIcons.person)),
            SizedBox(height: 16.h),

            //=================================> Profile Email <==========================
            CustomListTile(
                title: 'Write your email',
                prefixIcon: _prefixIcon(AppIcons.mail)),
            SizedBox(height: 16.h),

            //=================================> Phone Number <==========================
            CustomListTile(
                title: '(000) 000-0000',
                prefixIcon: _prefixIcon(
                  AppIcons.phone,
                )),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  _prefixIcon(String icon) {
    return SvgPicture.asset(icon, color: AppColors.primaryColor);
  }
}