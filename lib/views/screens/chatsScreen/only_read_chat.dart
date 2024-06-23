import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../controllers/readOnlyChatController/read_only_chat_controller.dart';
import '../../../helpers/prefs_helpers.dart';
import '../../../helpers/time_format.dart';
import '../../../models/read_only_chat_screen_model.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_text.dart';

class OnlyReadChat extends StatefulWidget {
  const OnlyReadChat({super.key});

  @override
  State<OnlyReadChat> createState() => _OnlyReadChatState();
}

class _OnlyReadChatState extends State<OnlyReadChat> {
  final ReadOnlyChatController _readOnlyChatController = Get.put(ReadOnlyChatController());
  final StreamController _streamController = StreamController();
  final ScrollController _scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  String roomId = Get.parameters['roomId'] ?? "";
  List<Map<String, String>> messageList = [
    {
      "status": "receiver",
      "message": "Hi, what's up?",
    },
    {
      "status": "receiver",
      "message":
          "Last week, the share price of Kotak Mahindra Bank (NS:KTKM) took a severe hit, tanking 10.2% to INR 1,608.5.",
    },
    {
      "status": "receiver",
      "message":
          "BEIJING (Reuters) - Baidu (NASDAQ:BIDU), China's major internet search company, reached an agreement with Tesla (NASDAQ:TSLA) to grant the car company access to its mapping license for data.",
    },
    {
      "status": "receiver",
      "message":
          "Explore our expertly curated list of the top altcoins worth investing in right now! Discover profit potential, understand risks, and hone your cryptocurrency investment strategy.",
    },
    {
      "status": "receiver",
      "message": "Everything's good here, thanks!",
    },
    {
      "status": "receiver",
      "message":
      "Explore our expertly curated list of the top altcoins worth investing in right now! Discover profit potential, understand risks, and hone your cryptocurrency investment strategy.",
    },
    {
      "status": "receiver",
      "message":
      "Explore our expertly curated list of the top altcoins worth investing in right now! Discover profit potential, understand risks, and hone your cryptocurrency investment strategy.",
    },
    {
      "status": "receiver",
      "message":
      "Explore our expertly curated list of the top altcoins worth investing in right now! Discover profit potential, understand risks, and hone your cryptocurrency investment strategy.",
    },
    {
      "status": "receiver",
      "message":
      "Explore our expertly curated list of the top altcoins worth investing in right now! Discover profit potential, understand risks, and hone your cryptocurrency investment strategy.",
    },
  ];

  @override
  void initState() {
    super.initState();
    _readOnlyChatController.getMessages(roomId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  //Stack(
                   // children: [
                      Container(
                        height: 38.h,
                        width: 38.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          "${Get.parameters['avatar']}",
                          //AppImages.stock,
                          fit: BoxFit.cover,
                        ),
                      ),
                      /*Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 13.h,
                          width: 13.w,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.white, width: 1.5.r),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF34DE00),
                                Color(0xFF229400),
                              ],
                              stops: [0.0, 1.0],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      )*/
                   // ],
                 // ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "${Get.parameters['name']}",
                        fontsize: 16.h,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                      controller: _scrollController,
                      dragStartBehavior: DragStartBehavior.down,
                      itemCount: _readOnlyChatController.messageList.length,
                      itemBuilder: (context, index) {
                        Attribute message = _readOnlyChatController.messageList[index];
                        return receiverBubble(context, message);
                      });
                })
              ),
              //===============================================> Read Only SMS Section <=============================
              SizedBox(height: 10.h),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1.w, color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: CustomText(
                      text:
                          'Read Only,Sending messages are not allowed in this chat.'
                              .tr,
                      fontsize: 10.sp,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //=============================================> Receiver Bubble <=================================
  receiverBubble(BuildContext context, Attribute message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
            backGroundColor: const Color(0xffe6f2e6),
            margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.50.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Flexible(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            message.createdAt != null
                                ? TimeFormatHelper.timeFormat(message.createdAt!)
                                : '',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
