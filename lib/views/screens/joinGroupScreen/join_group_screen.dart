import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/controllers/joinGroupController/join_group_controller.dart';
import 'package:stock_cartel/models/join_group_model.dart';
import 'package:stock_cartel/utils/app_colors.dart';
import 'package:stock_cartel/views/widgets/custom_text.dart';

import '../../../routes/app_routes.dart';
import '../../../services/api_constants.dart';
import '../../../utils/app_icons.dart';
import '../../widgets/custom_page_loading.dart';

class JoinGroupScreen extends StatefulWidget {
  const JoinGroupScreen({super.key});

  @override
  State<JoinGroupScreen> createState() => _JoinGroupScreenState();
}

class _JoinGroupScreenState extends State<JoinGroupScreen> {
  final JoinGroupController _joinGroupController = Get.put(JoinGroupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "All Group".tr,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Obx(
              () => _joinGroupController.isLoading.value
              ? const Center(child: CustomPageLoading())
              : _joinGroupController.joinGroupList.isEmpty
              ? Center(child: CustomText(text: "No data available"))
              : ListView.builder(
            itemCount: _joinGroupController.joinGroupList.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              Attribute groupData = _joinGroupController.joinGroupList[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.w),
                  color: const Color(0xffe6f2e6),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 58.w,
                        height: 58.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.w),
                          color: const Color(0xffe6f2e0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.w),
                          child: CachedNetworkImage(
                            imageUrl: '${ApiConstants.imageBaseUrl}${groupData.avatar!.publicFileUrl}',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      //==========================> Group Name <================================
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CustomText(
                          text: groupData.name ?? '',
                          fontWeight: FontWeight.w500,
                          fontsize: 18.w,
                          maxline: 1,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      //==========================> Join Button <===============================
                      SizedBox(
                        width: 70.w,
                        height: 30.h,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
                          ),
                          onPressed: (){},
                          child: CustomText(
                          text: 'Join'.tr,
                          color: Colors.white,
                          fontsize: 8.sp,
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
