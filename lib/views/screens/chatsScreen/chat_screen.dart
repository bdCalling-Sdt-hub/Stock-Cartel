import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../utils/app_icons.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final StreamController _streamController = StreamController();
  final ScrollController _scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  Uint8List? _image;
  File? selectedIMage;

  List<Map<String, String>> messageList = [
    {
      "name": "Alice",
      "status": "sender",
      "message": "Hey there!",
      "image": AppImages.stock
    },
    {
      "name": "Bob",
      "status": "receiver",
      "message": "Hi, what's up?",
      "image": AppImages.stock
    },
    {
      "name": "Charlie",
      "status": "sender",
      "message": "Just checking in.",
      "image": AppImages.stock
    },
    {
      "name": "David",
      "status": "receiver",
      "message": "Everything's good here, thanks!",
      "image": AppImages.stock
    },
    {
      "name": "Eve",
      "status": "sender",
      "message": "Cool.",
      "image": AppImages.stock
    },
    {
      "name": "Frank",
      "status": "receiver",
      "message": "Did you see the latest update?",
      "image": AppImages.stock
    },
    {
      "name": "Alice",
      "status": "sender",
      "message": "Hey there!",
      "image": AppImages.stock
    },
    {
      "name": "Bob",
      "status": "receiver",
      "message": "Hi, what's up?",
      "image": AppImages.stock
    },
    {
      "name": "Charlie",
      "status": "sender",
      "message": "Just checking in.",
      "image": AppImages.stock
    },
    {
      "name": "David",
      "status": "receiver",
      "message": "Everything's good here, thanks!",
      "image": AppImages.stock
    },
    {
      "name": "Eve",
      "status": "sender",
      "message": "Cool.",
      "image": AppImages.stock
    },
    {
      "name": "Frank",
      "status": "receiver",
      "message": "Did you see the latest update?",
      "image": AppImages.stock
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      // If you want a smooth scroll animation instead of jumping directly, use animateTo:
      // _scrollController.animateTo(
      //   _scrollController.position.maxScrollExtent,
      //   duration: Duration(milliseconds: 300),
      //   curve: Curves.easeOut,
      // );
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
                  Stack(
                    children: [
                      Container(
                        height: 38.h,
                        width: 38.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          AppImages.stock,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
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
                      )
                    ],
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Stock" ?? "${Get.parameters['userName']}",
                        fontsize: 16.h,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      CustomText(
                        top: 4.h,
                        text: "Hello, are you here?",
                        fontsize: 12.h,
                        fontWeight: FontWeight.w400,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: Stack(
                  children: [
                    StreamBuilder(
                      stream: _streamController.stream,
                      builder: (context, snapshot) {
                        if (true) {
                          return ListView.builder(
                              controller: _scrollController,
                              dragStartBehavior: DragStartBehavior.down,
                              itemCount: messageList.length,
                              itemBuilder: (context, index) {
                                var message = messageList[index];
                                return message['status'] == "sender"
                                    ? senderBubble(context, message)
                                    : receiverBubble(context, message);

                              });
                        } else {
                          return const CustomLoading();
                        }
                      },
                    ),
                    //========================================> Show Select Image <============================
                    Positioned(
                        bottom: 0.h,
                        left: 0.w,
                        child: Column(
                      children: [
                        if (_image != null)
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
                                  //border: Border.all(color: AppColors.primaryColor),
                                ),
                              ),
                              //========================================> Cancel Icon <============================
                              Positioned(
                                  top: 0.h,
                                  left: 0.w,
                                  child: GestureDetector(
                                      onTap: (){
                                        Get.back();
                                      },
                                      child: const Icon(Icons.cancel_outlined)))
                            ],
                          ),
                      ],
                    ))
                  ],
                ),
              ),
              //===============================================> Write Sms Section <=============================
              SizedBox(height: 65.h),
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
              GestureDetector(
                onTap: () {
                  Map<String, String> newMessage = {
                    "name": "John",
                    "status": "sender",
                    "message": messageController.text,
                    "image": AppImages.stock,
                  };
                  if (messageController.text.isNotEmpty) {
                    messageList.add(newMessage);
                    _streamController.sink.add(messageList);
                    print(messageList);
                    messageController.clear();
                    _image = null; // Clear the selected image after sending
                  }
                  setState(() {});
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

  //=============================================> Receiver Bubble <=================================
  receiverBubble(BuildContext context, Map<String, String> message) {
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
          child: Image.asset(
            message['image']!,
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
                maxWidth: MediaQuery.of(context).size.width * 0.57.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message['message'] ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          'time',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.end,
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

  //=============================================> Sender Bubble <========================================
  senderBubble(BuildContext context, Map<String, String> message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(
              type: BubbleType.sendBubble,
            ),
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
            backGroundColor: AppColors.primaryColor,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message['message'] ?? "",
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'time',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          height: 38.h,
          width: 38.w,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            message['image']!,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  //==================================> Gallery <===============================
  Future openGallery() async {
    final pickImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedIMage = File(pickImage!.path);
      _image = File(pickImage.path).readAsBytesSync();
    });
  }
/*Future _pickImageFromGallery() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    // Get.back();
  }*/
}
