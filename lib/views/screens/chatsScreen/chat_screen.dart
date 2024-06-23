import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_cartel/helpers/prefs_helpers.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../controllers/chatScreenController/chat_screen_controller.dart';
import '../../../controllers/groupListController/group_list_controller.dart';
import '../../../helpers/time_format.dart';
import '../../../models/chat_screen_model.dart';
import '../../../services/api_constants.dart';
import '../../../utils/app_icons.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GroupListController _groupListController =
      Get.put(GroupListController());
  final ChatScreenController _chatScreenController =
      Get.put(ChatScreenController());
  final StreamController _streamController = StreamController();
  final ScrollController _scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  Uint8List? _image;
  File? selectedImage;
  String roomId = Get.parameters['roomId'] ?? "";

  @override
  void initState() {
    super.initState();
    _chatScreenController.getMessages(roomId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
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
                  //Stack(
                    //children: [
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
                    //],
                  //),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: '${Get.parameters['name']}',
                        fontsize: 16.h,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      // CustomText(
                      //   top: 4.h,
                      //   text: "Online",
                      //   fontsize: 12.h,
                      //   fontWeight: FontWeight.w400,
                      // )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: Stack(
                  children: [
                    Obx(() {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          controller: _scrollController,
                          dragStartBehavior: DragStartBehavior.down,
                          itemCount: _chatScreenController.messageList.length,
                          itemBuilder: (context, index) {
                            Attribute message = _chatScreenController.messageList[index];
                            print(message);
                            return message.senderId?.id == PrefsHelper.clientId
                                ? senderBubble(context, message)
                                : receiverBubble(context, message);
                          });
                    }),
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
                                        child:
                                            const Icon(Icons.cancel_outlined))),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 295.w,
                child: CustomTextField(
                  controller: messageController,
                  hintText: "Type something…",
                  sufixicons: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    child: GestureDetector(
                        onTap: () {
                          openGallery();
                        },
                        child: SvgPicture.asset(AppIcons.photo)),
                  ),
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
                      image: PrefsHelper.myImage,
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
