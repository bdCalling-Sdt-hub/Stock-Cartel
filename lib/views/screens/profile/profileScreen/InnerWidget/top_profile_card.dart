import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../widgets/custom_text.dart';


class TopProfileCard extends StatelessWidget {
  final String? profileName;
  final String? profileUrl;
  final double? height;
  final String? badge;


  const TopProfileCard(
      {super.key, this.profileName, this.profileUrl, this.height, this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 328.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          border:  Border(
              bottom: BorderSide(color: AppColors.primaryColor, width: 1.80)),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.r),
            bottomRight: Radius.circular(24.r),
          )),
      child: Column(
        children: [
          CustomText(
            text: AppStrings.profile.tr,
            fontsize: 18.h,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            bottom: 44.h,
            top: 65.h,
          ),
          Container(
            height: 100.h,
            width: 100.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2.w, color: AppColors.white)),

            //=======================> Profile Image <===========================
            child: profileUrl == null
                ? const CircleAvatar(
              backgroundImage: NetworkImage('https://st3.depositphotos.com/15648834/17930/v/450/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-settingsScreen.jpg'),
              //AssetImage(AppImages.person),
            )
                : const CircleAvatar(
              backgroundImage:
              NetworkImage("https://st3.depositphotos.com/15648834/17930/v/450/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-settingsScreen.jpg"),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Mr. Swapon" ?? "",
                  fontsize: 20.h,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  // top: 5.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}