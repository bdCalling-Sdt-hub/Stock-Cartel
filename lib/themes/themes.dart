import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';

class Themes {
  //=========================> Dart Theme <===================================
  final darkTheme = ThemeData.dark().copyWith(

      //========================> Elevated Button Theme <========================
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.maxFinite, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),

      //===========================> Appbar Theme <=========================
      appBarTheme: const AppBarTheme(
          centerTitle: false,
          color: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.white10),

      //======================> Text Filed Themes <==============================
      inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.h),
          filled: true,
          fillColor: AppColors.fieldColor,
          hintStyle: TextStyle(
              fontSize: 16.h, fontWeight: FontWeight.w400, color: Colors.white),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusDefault),
              borderSide: BorderSide(color: AppColors.borderColor, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusDefault),
              borderSide: BorderSide(color: AppColors.borderColor, width: 1))));
}
