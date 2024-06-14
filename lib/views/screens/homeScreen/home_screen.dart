import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/controllers/groupListController/group_list_controller.dart';
import 'package:stock_cartel/views/widgets/custom_text.dart';
import '../../../models/group_list_model.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_images.dart';
import '../../widgets/bottom_menu..dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GroupListController _groupListController = Get.put(GroupListController());

  List chatList = [
    {
      "title": "Stock",
      "subTitle": "Stock rate increased 30%",
      "image": AppImages.stock
    },
    {
      "title": "Cryptocurrency",
      "subTitle": "Lorem Ipsum dummy....",
      "image": AppImages.crypto
    },
    {
      "title": "Community",
      "subTitle": "Lorem Ipsum dummy....",
      "image": AppImages.community
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(0),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //====================================> Logo With Notification <==========================
            SizedBox(height: 62.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  AppImages.appLogo,
                  width: 86.w,
                  height: 48.h,
                ),
                GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.notificationScreen);
                    },
                    child: SvgPicture.asset(AppIcons.notifications,
                        width: 36.w, height: 36.h))
              ],
            ),
            SizedBox(height: 22.h),
            //====================================> Chat List Section <===============================
            Expanded(
              child: ListView.builder(
                  itemCount: _groupListController.groupList.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    GroupListModel groupData = _groupListController.groupList[index];
                    return GestureDetector(
                      onTap: () {
                        if (index == 0 || index == 1) {
                          Get.toNamed(AppRoutes.onlyReadChat);
                        } else {
                          Get.toNamed(AppRoutes.chatScreen);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.h),
                        width: 350.w,
                        height: 75.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.w),
                          color: Color(0xffe6f2e6),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 12.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    child: Image.network('${groupData.avatar!.publicFileUrl}'),
                                  ),
                                  SizedBox(width: 12.w),
                                  //=======================================> Title and Subtitle Column <======================
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text:  '${groupData.name}',
                                        fontWeight: FontWeight.w500,
                                        fontsize: 18.w,
                                      ),
                                      CustomText(
                                        text: '${groupData.lastMessage!.message}',
                                        fontsize: 12.w,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              //=======================================> Time and Count Column <======================
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: '${groupData.createdAt}',
                                    fontsize: 12.w,
                                    color: Colors.grey,
                                  ),
                                  SvgPicture.asset(
                                    AppIcons.counter,
                                    width: 24.w,
                                    height: 24.h,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
