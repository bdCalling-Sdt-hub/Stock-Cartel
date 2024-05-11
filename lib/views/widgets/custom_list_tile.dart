import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_colors.dart';
import 'custom_text.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final Color? borderColor;
  const CustomListTile({
    super.key,
    required this.title,
    this.prefixIcon,
    this.sufixIcon,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.fieldColor,
          border: Border.all(width: 1.w, color: borderColor ?? AppColors.primaryColor)),
      child: ListTile(
        leading: prefixIcon,
        trailing: sufixIcon,
        horizontalTitleGap: 0.w,
        dense: true,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: CustomText(
            textAlign: TextAlign.start,
            text: title,
            maxline: 2,
            fontsize: 16.sp,
            fontWeight: FontWeight.w400,
            fontName: 'Poppins',
          ),
        ),
      ),
    );
  }
}