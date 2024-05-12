import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class AboutusScreen extends StatelessWidget {
  AboutusScreen({super.key});
  // final AboutUsController _aboutUsController = Get.put(AboutUsController());

  @override
  Widget build(BuildContext context) {
    //_aboutUsController.getAboutUs();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      //===========================================> AppBar Section <=============================================
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.aboutUsS,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: /*Obx(
            () => _aboutUsController.isLoading.value
            ? const CustomCircleLoader()
            : */
          SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
          child: Column(
            children: [
              //===========================================> Text Section <=============================================
              CustomText(
                text:
                    'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.',
                maxline: 20,
                textAlign: TextAlign.start,
              )
              /* Obx(
                      () => Html(
                    shrinkWrap: true,
                    data: _aboutUsController.content.value,
                  ),
                ),*/
            ],
          ),
        ),
      ),
    );
    // );
  }
}
