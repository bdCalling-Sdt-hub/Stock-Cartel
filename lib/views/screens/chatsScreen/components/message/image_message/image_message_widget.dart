import 'dart:io';


import 'package:flutter/material.dart';
import 'package:stock_cartel/views/widgets/cache_network_image.dart';

import '../../../../../../models/chat_model.dart';
import '../photo_gallery_view/photo_gallery_view.dart';

//TODO add text size
class ImageMessageWidget extends StatelessWidget {
  /// chat message model to get teh data
  final ChatMessage message;

  ///the color of the sender container
  final Color senderColor;

  final TextStyle? messageContainerTextStyle;

  const ImageMessageWidget({
    Key? key,
    required this.message,
    required this.senderColor,
    this.messageContainerTextStyle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var isSender=message.sender!.id=="1";
    return Column(
      crossAxisAlignment:
      isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: senderColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: isSender
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
                      child:const CustomNetworkImage(imageUrl: '', height:double.infinity, width: double.infinity,)
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: message.text!.isNotEmpty,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 8,
                    top: 8,
                    right: isSender ? 8 : 0,
                    left: isSender ? 0 : 8,
                  ),
                  child: Text(
                    message.text??"",
                    style: messageContainerTextStyle ?? const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
