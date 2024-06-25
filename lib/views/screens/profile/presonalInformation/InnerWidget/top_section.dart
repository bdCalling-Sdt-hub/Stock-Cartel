import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../services/api_constants.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_images.dart';
import '../../../../widgets/custom_text.dart';

class TopSection extends StatelessWidget {
  final String? name;
  final String? image;
  final VoidCallback? ontap;

  TopSection({this.name, this.image, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //=================================> Profile image <==========================
                    Container(
                      clipBehavior: Clip.antiAlias,
                      width: 80.w,
                      height: 80.h,
                      margin: EdgeInsets.only(right: 10.w),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2.w, color: AppColors.white),
                          shape: BoxShape.circle,
                          color: Colors.white),
                      child: image == '' || image == null
                          ? Image.asset(
                        AppImages.person,
                        fit: BoxFit.cover,
                      )
                          :  Container(
                        height: 80.h,
                        width: 80.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                            Border.all(width: 2.w, color: AppColors.white)),
                        child: CachedNetworkImage(
                          imageUrl: "${ApiConstants.imageBaseUrl}/$image",
                          fit: BoxFit.cover,
                        ),
                      )),

                    //=================================> Profile Name <==========================
                    Expanded(
                      child: CustomText(
                        text: name == null ? "name" : '$name',
                        textAlign: TextAlign.start,
                        fontsize: 24.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10.h,
          right: 0.w,
          child: IconButton(
              onPressed: ontap,
              icon: SvgPicture.asset(
                AppIcons.edit,
                color: AppColors.white,
              )),
        )
      ],
    );
  }
}
