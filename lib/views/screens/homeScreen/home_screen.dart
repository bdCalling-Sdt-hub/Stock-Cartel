import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stock_cartel/controllers/group_list_controller.dart';
import 'package:stock_cartel/controllers/profile_controller.dart';
import 'package:stock_cartel/helpers/time_format.dart';
import 'package:stock_cartel/services/api_client.dart';
import 'package:stock_cartel/services/api_constants.dart';
import 'package:stock_cartel/services/socket_service.dart';
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
  final ProfileController _profileController = Get.put(ProfileController());
  @override
  void initState() {
    // TODO: implement initState
    listenCount();
    super.initState();
  }

  listenCount(){
    SocketService.socket.on("groups/updated", (data){
      _groupListController.getGroupList();
      debugPrint("update group list : $data");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(0),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
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
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.joinGroupScreen);},
                        child: SvgPicture.asset(AppIcons.groupIcon,color: AppColors.primaryColor,
                            width: 28.w, height: 28.h)),
                    SizedBox(width: 18.w),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.notificationScreen);},
                        child: SvgPicture.asset(AppIcons.notification, color: AppColors.primaryColor ,
                            width: 28.w, height: 28.h))
                  ],
                ),
              ],
            ),
            SizedBox(height: 22.h),
            //====================================> Chat List Section <===============================
            Obx(
              () => _groupListController.isLoading.value
                  ? Expanded(child: const Center(child: CustomPageLoading()))
                  : _groupListController.groupList.isEmpty
                      ? Expanded(child: Center(child: CustomText(text: "No data found!")))
                      : Expanded(
                          child: RefreshIndicator(
                            onRefresh: ()async{
                              _groupListController.getGroupList();
                              },
                            child: ListView.builder(
                                itemCount: _groupListController.groupList.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  GroupListModel groupData = _groupListController.groupList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      _profileController.getProfileData();
                                        Get.toNamed(AppRoutes.chatScreen, arguments:groupData.groupType == "adminOnly",parameters: {'roomId' : groupData.roomId ?? "",  'avatar' : '${ApiConstants.imageBaseUrl}${groupData.avatar!.publicFileUrl}', 'name': '${groupData.name}',});
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
                                                      child: CachedNetworkImage(
                                                        imageUrl: '${ApiConstants.imageBaseUrl}${groupData.avatar!.publicFileUrl}',
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
                                                        CustomText(
                                                          text: '${groupData.lastMessage!.message}',
                                                          fontsize: 12.w,
                                                          maxline: 1,
                                                          textAlign: TextAlign.start,
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
                                                      ? TimeFormatHelper.timeFormat(groupData.lastMessage!.createdAt!)
                                                      : '',
                                                  fontsize: 12.w,
                                                  color: Colors.grey,

                                                ),
                                                SizedBox(height: 10.h,),
                                                //==========================> Unread Count <========================
                                                groupData.unreadCount !=0 ?
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.primaryColor,
                                                    shape: BoxShape.circle
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                                    child: CustomText(
                                                      text: "${groupData.unreadCount}",
                                                      fontsize: 10.w,
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                )
                                                :  const SizedBox(),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
            )
          ],
        ),
      ),
    );
  }
}
