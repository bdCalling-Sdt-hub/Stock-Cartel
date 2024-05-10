import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/routes/app_routes.dart';
import 'package:stock_cartel/utils/app_colors.dart';
import 'package:stock_cartel/utils/app_strings.dart';
import 'package:stock_cartel/views/widgets/custom_button.dart';
import 'package:stock_cartel/views/widgets/custom_text.dart';
import 'package:stock_cartel/views/widgets/custom_text_field.dart';

import '../../../../utils/app_icons.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController phoneNumberCodeCTRl = TextEditingController();
  final TextEditingController phoneNumberCTRl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.register.tr,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              top: 24.h,
              text: AppStrings.whatsYour.tr,
              fontWeight: FontWeight.w500,
              fontsize: 18.sp,
            ),
            CustomText(
              top: 8.h,
              text: AppStrings.weWillText.tr,
              bottom: 24.h,
            ),
            //====================================> Phone Number Text Field <=========================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 84.w,
                  height: 56.h,
                  child: CustomTextField(
                    onTab: (){},
                    readOnly: true,
                    controller: phoneNumberCodeCTRl,
                    contenpaddingHorizontal: 12.w,
                    contenpaddingVertical: 16.h,
                    hintText: "+44",
                    sufixicons: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: SvgPicture.asset(AppIcons.downArrow,color: Colors.grey),
                    ),
                  ),
                ),

                SizedBox(width: 16.w),
                SizedBox(
                  width: 250.w,
                  height: 56.h,
                  child: CustomTextField(
                    keyboardType: TextInputType.phone,

                    controller: phoneNumberCTRl,
                    hintText: AppStrings.phoneNumber.tr,
                  ),
                )
              ],
            ),
            //====================================> Verify Button  <=========================
            const Spacer(),
            CustomButton(text: AppStrings.verifyNumber.tr, onTap: () {
              Get.toNamed(AppRoutes.verifyNumberScreen);
            }),
            SizedBox(height: 74.h)
          ],
        ),
      ),
    );
  }
}
