import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/views/widgets/custom_page_loading.dart';
import 'package:timeago/timeago.dart' as TimeAgo;
import '../../../controllers/notifiaction_controller.dart';
import '../../../models/notification_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/custom_text.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController _notificationController =
      Get.put(NotificationController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addScrollListener();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _notificationController.loadMore();
        print("load more true");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //================================> App bar section <=======================
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.notifications.tr,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
        ),
      ),

      //================================> Body section <=======================
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Column(
          children: [
            //================================> Notification section <=======================
            Expanded(
              child: Obx(
                () => _notificationController.notificationLoading.value
                    ? const CustomPageLoading()
                    : _notificationController.notificationsList.isEmpty
                        ? Center(
                            child: CustomText(
                            text: "No notifications yet",
                          ))
                        : RefreshIndicator(
                            onRefresh: () async {
                              //_notificationController.notificationsList.refresh();
                              _notificationController.page.value = 1;
                              _notificationController.notificationsList.clear();
                              await _notificationController.getNotifications();
                            },
                            child: ListView.builder(
                              controller: _scrollController,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: _notificationController
                                      .notificationsList.length +
                                  1,
                              itemBuilder: (context, index) {
                                if (index < _notificationController.notificationsList.length) {
                                  Attribute notifications = _notificationController.notificationsList[index];
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 16.h,
                                    ),
                                    child: _Notification('${notifications.message}', notifications.createdAt!),
                                  );
                                } else if (index >=
                                    _notificationController.totalResult) {
                                  return null;
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _Notification(String title, DateTime time) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(
          color: Color(0xffE7F2E6), borderRadius: BorderRadius.circular(4.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 10.h,
                width: 10.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.primaryColor),
              ),
              Container(
                margin: EdgeInsets.only(left: 8.w, right: 7.w),
                padding: EdgeInsets.all(7.r),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffffffff)),
                child: SvgPicture.asset(
                  AppIcons.notification,
                  color: AppColors.primaryColor,
                ),
              )
            ],
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontsize: 14.h,
                  color: Colors.black,
                  maxline: 5,
                  textAlign: TextAlign.start,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    top: 2.h,
                    text: TimeAgo.format(time),
                    fontsize: 8.h,
                    fontWeight: FontWeight.w400,
                    color: const Color(
                      0xFF8C8C8C,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
