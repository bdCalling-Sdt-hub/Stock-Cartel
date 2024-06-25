import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stock_cartel/views/widgets/cache_network_image.dart';

import '../../../../../../models/chat_model.dart';
import '../../../../../../services/api_constants.dart';
import '../photo_gallery_view/photo_gallery_view.dart';

//TODO add text size
class ImageMessageWidget extends StatelessWidget {
  /// chat message model to get teh data
  final ChatModel message;

  ///the color of the sender container
  final Color senderColor;
  final bool isSender;

  final TextStyle? messageContainerTextStyle;

  const ImageMessageWidget({
    Key? key,
    required this.message,
    required this.senderColor,
    required this.isSender,
    this.messageContainerTextStyle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start ,
      children: [
        if(!isSender)
        CustomNetworkImage(
          imageUrl: ApiConstants.imageBaseUrl +
              message.senderId!.image!.publicFileUrl!,
          height: 38.h,
          width: 38.h,
          boxShape: BoxShape.circle,
        ),
        if(!isSender)
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment:
              !isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.w),
              decoration: BoxDecoration(
                color:message.text!.isNotEmpty? senderColor.withOpacity(0.3):Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: !isSender
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      /// navigate to to the photo gallery view, for viewing the taped image
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => PhotoGalleryView(
                            chatMessage: message,
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      /// 45% of total width
                      width: MediaQuery.of(context).size.width * 0.45,

                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child:  CustomNetworkImage(
                              imageUrl:ApiConstants.imageBaseUrl+message.file!.publicFileUrl!,
                              height: double.infinity,
                              width: double.infinity,
                            )),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: message.text!.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        message.text ?? "",
                        style: messageContainerTextStyle ??
                            const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DateFormat("h:mm a").format(message.createdAt??DateTime.now()),
                      style: TextStyle(
                        color:Colors.black.withOpacity(0.6),
                        fontSize: 12.sp,

                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if(isSender)
        SizedBox(
          width: 10.w,
        ),
        if(isSender)
        CustomNetworkImage(
          imageUrl: ApiConstants.imageBaseUrl +
              message.senderId!.image!.publicFileUrl!,
          height: 38.h,
          width: 38.h,
          boxShape: BoxShape.circle,
        ),

      ],
    );
  }
}
