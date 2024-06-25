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
import 'package:stock_cartel/helpers/prefs_helpers.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../controllers/chatScreenController/chat_screen_controller.dart';
import '../../../controllers/groupListController/group_list_controller.dart';
import '../../../helpers/time_format.dart';
import '../../../models/chat_model.dart';
import '../../../models/chat_screen_model.dart';
import '../../../services/api_constants.dart';
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
  final GroupListController _groupListController =
      Get.put(GroupListController());
  final ChatController _chatController = Get.put(ChatController());
  TextEditingController messageController = TextEditingController();
  Uint8List? _image;
  File? selectedImage;
  String roomId = Get.parameters['roomId'] ?? "";

  // @override
  // void initState() {
  //   super.initState();
  //   _chatScreenController.getMessages(roomId);
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  //   });
  // }

  @override
  void initState() {
    // _chatController.getUserId();
    // _chatController.readMessage(chatId);
    // _chatController.listenMessage(Get.arguments);
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

    //  _chatController.receivedListen(userData.id!);

    super.initState();
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
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                          return const SizedBox();
                        },
                        itemBuilder: (context, ChatModel message) {
                          return MessageWidget(
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
                      if (_image != null)
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
                                        image: MemoryImage(_image!),
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
                                              _image = null;
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
             Get.arguments?  Center(
               child: Container(
                 decoration: BoxDecoration(
                     border:
                     Border.all(width: 1.w, color: AppColors.primaryColor),
                     borderRadius: BorderRadius.circular(5.r)),
                 child: Padding(
                   padding: EdgeInsets.all(8.0.w),
                   child: CustomText(
                     text:
                     'Read Only, Sending messages are not allowed in this chat.'
                         .tr,
                     fontsize: 10.sp,
                     textAlign: TextAlign.center,
                   ),
                 ),
               ),
             ):Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: messageController,
                        hintText: "Type something…",
                        sufixicons: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 16.w),
                          child: GestureDetector(
                              onTap: () {
                                openGallery();
                              },
                              child: SvgPicture.asset(AppIcons.photo)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal:16.w,vertical:16.w),
                            child: SvgPicture.asset(AppIcons.sendIcon),
                          )),
                    )
                  ],
                ),
              ),


              GestureDetector(
                onTap: () {

                  Map<String, dynamic> newMessage = {
                    "name": PrefsHelper.myName,
                    "status": "sender",
                    "message": messageController.text,
                    "image": PrefsHelper.myImage,
                  };

                  Attribute item = Attribute.fromJson(newMessage);
                  if (messageController.text.isNotEmpty) {
                    SenderId sender = SenderId(
                      id: PrefsHelper.clientId,
                      name: PrefsHelper.myName,
                      //image: PrefsHelper.myImage,
                    );
                    Attribute newMessage = Attribute(
                      senderId: sender,
                      text: messageController.text,
                      createdAt: DateTime.now(),
                    );
                    _chatScreenController.messageList.add(newMessage);
                    messageController.clear();
                    setState(() {
                      _image = null;
                    });
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                    });
                  }
                },
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: SvgPicture.asset(AppIcons.sendIcon),
                    )),
              )


            ],
          ),
        ),
      ),
      // bottomSheet: Container(
      //   height: MediaQuery.of(context).size.height * 0.1,
      //   width: MediaQuery.of(context).size.width,
      //   child: Padding(
      //     padding: EdgeInsets.symmetric(horizontal: 20.w),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         SizedBox(
      //           width: 295.w,
      //           child: CustomTextField(
      //             controller: messageController,
      //             hintText: "Type something…",
      //             sufixicons: Padding(
      //               padding:
      //                   EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      //               child: GestureDetector(
      //                   onTap: () {
      //                     openGallery();
      //                   },
      //                   child: SvgPicture.asset(AppIcons.photo)),
      //             ),
      //           ),
      //         ),
      //         GestureDetector(
      //           onTap: () {
      //
      //           },
      //           child: Container(
      //               decoration: BoxDecoration(
      //                   border: Border.all(color: AppColors.primaryColor),
      //                   borderRadius: BorderRadius.circular(8.r)),
      //               child: Padding(
      //                 padding: const EdgeInsets.all(11.0),
      //                 child: SvgPicture.asset(AppIcons.sendIcon),
      //               )),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  receiverBubble(BuildContext context, Attribute message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 38.h,
          width: 38.w,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.network(
            '${ApiConstants.imageBaseUrl}${message.senderId?.image?.publicFileUrl ?? ""}',
            // Modify according to your image source
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 8.w),
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
                    message.senderId?.name?.split(" ")[0] ?? '',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    message.text ?? '',
                    style: TextStyle(
                      color: const Color(0xFF333333),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Flexible(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            message.createdAt != null
                                ? timeago.format(message.createdAt!)
                                : '',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 12.sp,
                            ),
                            textAlign: TextAlign.end,
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

  senderBubble(BuildContext context, Attribute message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
            backGroundColor: const Color(0xffE1FEC6),
            margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.50.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.senderId?.name ?? "",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    message.text ?? '',
                    style: TextStyle(
                      color: const Color(0xFF333333),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Flexible(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            message.createdAt != null
                                ? timeago.format(message.createdAt!)
                                : '',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12.sp,
                            ),
                            textAlign: TextAlign.end,
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

  Future<void> openGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final imageBytes = await image.readAsBytes();
        setState(() {
          _image = imageBytes;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
