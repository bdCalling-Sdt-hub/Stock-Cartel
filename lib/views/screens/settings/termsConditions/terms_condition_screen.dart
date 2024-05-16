import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class TermsConditionScreen extends StatelessWidget {
  TermsConditionScreen({super.key});
  /* final TermsConditionsController _termsConditionsController =
  Get.put(TermsConditionsController());
*/
  @override
  Widget build(BuildContext context) {
    // _termsConditionsController.getTermsCondition();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      //===========================================> AppBar Section <=============================================
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.termsConditionsS.tr,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: /*Obx(
            () => _termsConditionsController.isLoading.value
            ? const CustomCircleLoader()
            : */
          SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              //===========================================> Text Section <=============================================
              CustomText(
                text:
                    'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.'.tr,
                maxline: 20,
                textAlign: TextAlign.start,
              )
              /*Obx(
                      () => Html(
                    data: _termsConditionsController.content.value,
                  ),
                ),*/
            ],
          ),
        ),
      ),
    );
    //);
  }
}
