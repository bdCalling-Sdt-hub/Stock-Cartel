import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stock_cartel/controllers/profileController/profile_controller.dart';
import 'package:stock_cartel/helpers/prefs_helpers.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../controllers/chatScreenController/chat_screen_controller.dart';
import '../../../controllers/groupListController/group_list_controller.dart';
import '../../../helpers/time_format.dart';
import '../../../models/chat_model.dart';
import '../../../models/chat_screen_model.dart';
import '../../../services/api_constants.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_icons.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'components/message/message_widget.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GroupListController _groupListController = Get.put(GroupListController());
  final ChatController _chatController = Get.put(ChatController());
  final ProfileController _profileController = Get.put(ProfileController());
  TextEditingController messageController = TextEditingController();
  String _imagePath = "";
  File? selectedImage;
  String roomId = Get.parameters['roomId'] ?? "";

  @override
  void initState() {
    getUserId();
    _chatController.listenMessage(roomId);
    _chatController.scrollController =
        ScrollController(initialScrollOffset: 0.0);

    _chatController.scrollController =
        ScrollController(initialScrollOffset: 0.0);
    _chatController.fastLoad(roomId);
    _chatController.scrollController.addListener(() {
      if (_chatController.scrollController.position.pixels <=
          _chatController.scrollController.position.minScrollExtent) {
        print("====> scroll Top");

        // _chatController.loadMore(Get.arguments);
        // _controller.loadMore(userData.id);
      } else if (_chatController.scrollController.position.pixels ==
          _chatController.scrollController.position.maxScrollExtent) {
        print("====> scroll bottom");
        _chatController.loadMore(roomId);
      }
    });

    super.initState();
  }

  var userId = "";

  getUserId() async {
    userId = await PrefsHelper.getString(AppConstants.id);
  }

  @override
  void dispose() {
    _chatController.offSocket(roomId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(roomId);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    height: 38.h,
                    width: 38.w,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      "${Get.parameters['avatar']}",
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(width: 8.w),
                  Expanded(
                    child: CustomText(
                      text: '${Get.parameters['name']}',
                      textAlign: TextAlign.start,
                      fontsize: 16.h,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Obx(
                () => Expanded(
                  child: Stack(
                    children: [
                      GroupedListView<ChatModel, DateTime>(
                        elements: _chatController.chatList.value,
                        controller: _chatController.scrollController,
                        // padding: EdgeInsets.symmetric(horizontal: 10.w),
                        order: GroupedListOrder.DESC,
                        itemComparator: (item1, item2) =>
                            item1.createdAt!.compareTo(item2.createdAt!),
                        groupBy: (ChatModel message) => DateTime(
                            message.createdAt!.year,
                            message.createdAt!.month,
                            message.createdAt!.day),
                        reverse: true,
                        shrinkWrap: true,
                        //physics: const AlwaysScrollableScrollPhysics(),
                        groupSeparatorBuilder: (DateTime date) {
                          final now = DateTime.now();
                          final today = DateTime(now.year, now.month, now.day);
                          return Center(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0, 3),
                                          spreadRadius: 0,
                                          blurRadius: 2,
                                          color: Colors.black.withOpacity(0.15))
                                    ]),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 3.h),
                                margin: EdgeInsets.symmetric(
                                  vertical: 10.h,
                                ),
                                child: today == date
                                    ? const Text("Today")
                                    : Text(
                                        DateFormat('MMMM dd, yyyy')
                                            .format(date),
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.black,
                                        ),
                                      )),
                          );
                        },
                        itemBuilder: (context, ChatModel message) {
                          return MessageWidget(
                            isSender: message.senderId!.id == userId,
                            message: message,
                            senderColor: AppColors.primaryColor,
                            inActiveAudioSliderColor: AppColors.primaryColor,
                            activeAudioSliderColor: AppColors.primaryColor,
                          );
                        },
                      ),
                      Positioned(
                          top: 20,
                          left: Get.width / 2.5,
                          child:
                              Obx(() => _chatController.isLoadMoreRunning.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.grey,
                                      ),
                                    )
                                  : const SizedBox())),
                      if (_imagePath.isNotEmpty)
                        Positioned(
                          bottom: 0.h,
                          left: 0.w,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 120.h,
                                    width: 120.w,
                                    margin: EdgeInsets.only(bottom: 10.h),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(_imagePath),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                  Positioned(
                                      top: 0.h,
                                      right: 0.w,
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _imagePath = "";
                                            });
                                          },
                                          child: const Icon(
                                              Icons.cancel_outlined))),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Get.arguments
                  ? Center(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.w, color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: CustomText(
                            text:
                                'Read Only, Sending messages are not allowed in this chat.'
                                    .tr,
                            maxline: 2,
                            fontsize: 10.sp,
                            textAlign: TextAlign.center,

                          ),
                        ),
                      ),
                    )
                  : _profileController.profileModel.value.data!.attributes!.isBlocked?Center(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.w, color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(5.r)),
                      child: Padding(
                        padding: EdgeInsets.all(8.0.w),
                        child: CustomText(
                          text:
                          'Admin has blocked you. Please contact with admin.'.tr,
                          fontsize: 10.sp,
                          maxline: 2,
                          textAlign: TextAlign.center,

                        ),
                      ),
                    ),
                  )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: messageController,
                              hintText: "Type something…",
                             /* sufixicons: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 16.w),
                                child: GestureDetector(
                                    onTap: () {
                                      openGallery();
                                    },
                                    child: SvgPicture.asset(AppIcons.photo)),
                              ),*/
                            ),
                          ),
                          SizedBox(width: 10.w),
                          GestureDetector(
                            onTap: () {
                              if (_imagePath.isEmpty) {
                                if (messageController.text.isNotEmpty) {
                                  _chatController.sendMessage(
                                      messageController.text,
                                      chatId: roomId);
                                  messageController.clear();
                                }
                              } else {
                                _chatController.sendFile(messageController.text,
                                    chatId: roomId,
                                    userId: userId,
                                    image: _imagePath);
                                messageController.clear();
                                setState(() {
                                  _imagePath = "";
                                });
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.primaryColor),
                                    borderRadius: BorderRadius.circular(8.r)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 16.w),
                                  child: SvgPicture.asset(AppIcons.sendIcon),
                                )),
                          )
                        ],
                      ),
                    ),

            ],
          ),
        ),
      ),
    );
  }
/*
  Future<void> openGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final imagePath = await image.path;
        setState(() {
          _imagePath = imagePath;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }*/
}
