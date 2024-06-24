import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/views/widgets/custom_page_loading.dart';
import '../../../../controllers/aboutUsController/about_us_controller.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class AboutusScreen extends StatelessWidget {
  AboutusScreen({super.key});
  final AboutUsController _aboutUsController = Get.put(AboutUsController());

  @override
  Widget build(BuildContext context) {
    _aboutUsController.getAboutUs();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      //===========================================> AppBar Section <=============================================
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.aboutUsS.tr,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => _aboutUsController.isLoading.value
            ? const CustomPageLoading()
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 12.h),
                  child: Column(
                    children: [
                      //======================> Text Section <===================
                      Obx(
                        () => Html(
                          shrinkWrap: true,
                          data: _aboutUsController.content.value,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
