import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/views/widgets/custom_page_loading.dart';
import '../../../../controllers/privacy_policy_controller.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});

  final PrivacyPolicyController _policyController =
  Get.put(PrivacyPolicyController());

  @override
  Widget build(BuildContext context) {
    _policyController.getPrivacy();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      //===========================================> AppBar Section <=============================================
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.privacyPolicyS.tr,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body:  Obx(
          () => _policyController.isLoading.value
            ? const CustomPageLoading()
            : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            children: [
              //===========================================> Text Section <=============================================
              Obx(() => Html(
                    data:
                    _policyController.content.value,
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
