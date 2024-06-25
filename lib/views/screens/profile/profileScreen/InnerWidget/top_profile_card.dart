import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../services/api_constants.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_images.dart';
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
          border: Border(
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
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2.w, color: AppColors.white)),

              //=======================> Profile Image <===========================
              child: profileUrl == '' || profileUrl == null
                  ? Image.asset(
                      AppImages.person,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 100.h,
                      width: 100.w,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(width: 2.w, color: AppColors.white)),
                      child: CachedNetworkImage(
                        imageUrl: "${ApiConstants.imageBaseUrl}/$profileUrl",
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        fit: BoxFit.cover,
                      ),
                    )),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: profileName == '' ? "name" : '$profileName',
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
