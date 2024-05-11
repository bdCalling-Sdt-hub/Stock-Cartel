import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
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
                      width: 100.w,
                      height: 100.h,
                      margin: EdgeInsets.only(right: 10.w),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2.w, color: AppColors.white),
                          shape: BoxShape.circle,
                          color: Colors.white),
                      child: Image.network(
                        "https://st3.depositphotos.com/15648834/17930/v/450/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),

                    //=================================> Profile Name <==========================
                    Expanded(
                      child: CustomText(
                        text: 'Mr Swapon',
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
