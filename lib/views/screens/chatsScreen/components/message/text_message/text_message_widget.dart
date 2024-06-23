
import 'package:flutter/material.dart';
import 'package:stock_cartel/utils/app_dimensions.dart';

import '../../../../../../models/chat_model.dart';

/// this widget is used to render a text message container

class TextMessageWidget extends StatelessWidget {
  final ChatModel message;
  final Color senderColor;

  const TextMessageWidget({
    super.key,
    required this.message,
    required this.senderColor,
  });

  @override
  Widget build(BuildContext context) {
    var isSender=message.senderId!.id=="1";
    return Column(
      crossAxisAlignment:
      isSender? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 2, minWidth: 50),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingSizeDefault * 0.75,
              vertical: AppDimensions.paddingSizeDefault / 2,
            ),
            decoration: BoxDecoration(
              color: senderColor.withOpacity(isSender ? 1 : 0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              message.text??"",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: isSender
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}