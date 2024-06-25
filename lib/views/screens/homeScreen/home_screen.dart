import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/controllers/groupListController/group_list_controller.dart';
import 'package:stock_cartel/helpers/time_format.dart';
import 'package:stock_cartel/services/api_client.dart';
import 'package:stock_cartel/services/api_constants.dart';
import 'package:stock_cartel/views/widgets/custom_page_loading.dart';
import 'package:stock_cartel/views/widgets/custom_text.dart';
import '../../../models/group_list_model.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_images.dart';
import '../../widgets/bottom_menu..dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String roomId = Get.parameters['roomId'] ?? '';
  final GroupListController _groupListController = Get.put(GroupListController());

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

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
            Obx(
              () => _groupListController.isLoading.value
                  ? const Center(child: CustomPageLoading())
                  : _groupListController.groupList.isEmpty
                      ? Center(child: CustomText(text: "No data available"))
                      : Expanded(
                          child: ListView.builder(
                              itemCount: _groupListController.groupList.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                GroupListModel groupData = _groupListController.groupList[index];
                                return GestureDetector(
                                  onTap: () {
                                      Get.toNamed(AppRoutes.chatScreen, arguments:groupData.groupType=="adminOnly",parameters: {'roomId' : groupData.roomId ?? "",  'avatar' : '${ApiConstants.imageBaseUrl}${groupData.avatar!.publicFileUrl}', 'name': '${groupData.name}',});
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 8.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.w),
                                      color: const Color(0xffe6f2e6),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24.w, vertical: 12.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                //=======================================> Group Avatar <======================
                                                Container(
                                                  width: 58.w,
                                                  height: 58.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(100.w),
                                                    color: const Color(0xffe6f2e0),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(100.w),
                                                    child: Image.network(
                                                      '${ApiConstants.imageBaseUrl}${groupData.avatar!.publicFileUrl}',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 12.w),
                                                //=======================================> Title and Subtitle Column <======================
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        text: '${groupData.name}',
                                                        fontWeight: FontWeight.w500,
                                                        fontsize: 18.w,
                                                        maxline: 1,
                                                        textAlign: TextAlign.start,
                                                      ),
                                                      SizedBox(height: 10.h,),
                                                      SizedBox(
                                                        width: 100.w,
                                                        child: CustomText(
                                                          text: '${groupData.lastMessage!.message}',
                                                          fontsize: 12.w,
                                                          maxline: 2,
                                                          textAlign: TextAlign.start,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //=======================================> Time and Count Column <======================
                                         SizedBox(width: 10.w,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              CustomText(
                                                text: groupData.lastMessage?.createdAt != null
                                                    ? timeago.format(groupData.lastMessage!.createdAt!)
                                                    : '',

                                                fontsize: 12.w,
                                                color: Colors.grey,

                                              ),
                                              SizedBox(height: 10.h,),
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
                        ),
            )
          ],
        ),
      ),
    );
  }
}
