import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/views/widgets/custom_page_loading.dart';
import '../../../../controllers/terms_conditions_controller.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class TermsConditionScreen extends StatelessWidget {
  TermsConditionScreen({super.key});
   final TermsConditionsController _termsConditionsController =
  Get.put(TermsConditionsController());
  @override
  Widget build(BuildContext context) {
     _termsConditionsController.getTermsCondition();
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
      body: Obx(
            () => _termsConditionsController.isLoading.value
            ? const CustomPageLoading()
            :SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            children: [
              //===========================================> Text Section <=============================================
              Obx(() => Html(
                shrinkWrap: true,
                    data: _termsConditionsController.content.value,
                  ),
                ),
            ],
          ),
        ),
      ),
    )
    );
  }
}
