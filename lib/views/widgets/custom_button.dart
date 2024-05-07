import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_cartel/views/widgets/custom_text.dart';


class CustomButton extends StatelessWidget {
  final VoidCallback onpress;
  final String title;
  final Color? color;
  final Color? titlecolor;
  final double? height;
  final double? width;
  final double? fontSize;
  final bool loading;

  CustomButton({
    super.key,
    required this.title,
    required this.onpress,
    this.color,
    this.height,
    this.width,
    this.fontSize,
    this.titlecolor,
    this.loading=false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:loading?(){} :onpress,
      child: Container(
        width:width?? 345.w,
        height: height ?? 52.h,
        padding: const EdgeInsets.all(10),
        decoration: color == null
            ? ShapeDecoration(
          gradient: const LinearGradient(colors: [
            Color(0xFFFA1131),
            Color(0xFFB20C23),
          ]),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r)),
        )
            : ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            loading?  SizedBox(
              height: 20.h,
              width: 20.h,
              child: const CircularProgressIndicator(color: Colors.white,),
            ):
            CustomText(
              text: title,
              fontsize: fontSize ?? 20.h,
              color: titlecolor ?? Colors.white,
              fontName: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}