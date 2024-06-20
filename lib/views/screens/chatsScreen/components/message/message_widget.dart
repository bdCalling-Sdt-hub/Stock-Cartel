import 'package:flutter/material.dart';
import 'package:stock_cartel/utils/app_dimensions.dart';
import 'package:stock_cartel/views/screens/chatsScreen/components/message/text_message/text_message_widget.dart';

import '../../../../../models/chat_model.dart';
import 'date_time_widget.dart';
import 'image_message/image_message_widget.dart';

/// widget used to determine the right message type
/// //TODO add color support for reciver
class MessageWidget extends StatelessWidget {
  final Color senderColor;
  final Color inActiveAudioSliderColor;
  final Color activeAudioSliderColor;
  final TextStyle? messageContainerTextStyle;
  final TextStyle? sendDateTextStyle;

  const MessageWidget({
    Key? key,
    required this.message,
    required this.senderColor,
    required this.inActiveAudioSliderColor,
    required this.activeAudioSliderColor,
    this.messageContainerTextStyle,
    this.sendDateTextStyle,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    var isSender = message.sender!.id == "1";
    return Padding(
      padding: const EdgeInsets.only(top: AppDimensions.paddingSizeDefault),
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,

        /// check message type and render the right widget
        child: Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            messageContent(message),
            const SizedBox(
              height: 3,
            ),
            DateTimeWidget(
              message: message,
              sendDateTextStyle: sendDateTextStyle,
            )
          ],
        ),
      ),
    );
  }

  Widget messageContent(ChatMessage message) {
    /// check message type and render the right widget
    if (message.chatMedia == null) {
      /// render text message
      return TextMessageWidget(
        message: message,
        senderColor: senderColor,
      );
    } else {
      return message.chatMedia!.mediaType == "image"
          ? ImageMessageWidget(
              message: message,
              senderColor: senderColor,
              messageContainerTextStyle: messageContainerTextStyle,
            )
          : message.chatMedia!.mediaType == "audio"
              ? Container()
              : TextMessageWidget(
                  message: message,
                  senderColor: senderColor,
                );
    }
  }
}
