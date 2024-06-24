import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_cartel/helpers/prefs_helpers.dart';
import 'package:stock_cartel/services/api_constants.dart';
import 'package:stock_cartel/utils/app_dimensions.dart';
import 'package:stock_cartel/views/widgets/cache_network_image.dart';

import '../../../../../../models/chat_model.dart';
import '../../../../../../utils/app_colors.dart';
import '../date_time_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

/// this widget is used to render a text message container

class TextMessageWidget extends StatelessWidget {
  final ChatModel message;
  final Color senderColor;
  final bool isSender;

  const TextMessageWidget({
    super.key,
    required this.message,
    required this.senderColor,
    required this.isSender
  });

  @override
  Widget build(BuildContext context) {
    return isSender? senderBubble(context, message):receiverBubble(context, message);

    // return Row(
    //   crossAxisAlignment:  isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    //   children: [
    //     if(!isSender)
    //       CustomNetworkImage(imageUrl:ApiConstants.imageBaseUrl+message.senderId!.image!.publicFileUrl!, height:40.r, width: 40.r,boxShape: BoxShape.circle,),
    //     if(!isSender)
    //     const SizedBox(width: 10,),
    //     Column(
    //       crossAxisAlignment:  isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    //       children: [
    //         ConstrainedBox(
    //           constraints: BoxConstraints(
    //               maxWidth: MediaQuery.of(context).size.width / 2, minWidth: 50),
    //           child: Container(
    //             padding: const EdgeInsets.symmetric(
    //               horizontal: AppDimensions.paddingSizeDefault * 0.75,
    //               vertical: AppDimensions.paddingSizeDefault / 2,
    //             ),
    //             decoration: BoxDecoration(
    //               color: senderColor.withOpacity(isSender ? 1 : 0.1),
    //               borderRadius: BorderRadius.only(
    //                   topRight: Radius.circular(20.r),
    //                   bottomLeft: Radius.circular(20.r),
    //                   bottomRight: Radius.circular(20.r)),
    //             ),
    //             child: Text(
    //               "$isSender" ?? "",
    //               textDirection: TextDirection.rtl,
    //               style: TextStyle(
    //                 color: isSender ? Colors.white : Colors.black,
    //               ),
    //             ),
    //           ),
    //         ),
    //         DateTimeWidget(
    //           message: message,
    //           sendDateTextStyle: TextStyle(fontSize: 12.sp,),
    //         )
    //       ],
    //     ),
    //
    //     if(isSender)
    //       CustomNetworkImage(imageUrl:ApiConstants.imageBaseUrl+message.senderId!.image!.publicFileUrl!, height:40.r, width: 40.r,boxShape: BoxShape.circle,),
    //     if(isSender)
    //       const SizedBox(width: 10,),
    //   ],
    // );
  }
  receiverBubble(BuildContext context, ChatModel message) {
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
            backGroundColor: const Color(0xFFE7F2E6),
            margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
            alignment: Alignment.centerLeft,
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

  senderBubble(BuildContext context, ChatModel message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
            backGroundColor: const Color(0xff0A8100),
            margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
            alignment: Alignment.centerRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.50.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    message.text ?? '',
                    style: TextStyle(
                      color: Colors.white,
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
                              color:Colors.white.withOpacity(0.6),
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
        SizedBox(width: 10.w,),
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
      ],
    );
  }
}
