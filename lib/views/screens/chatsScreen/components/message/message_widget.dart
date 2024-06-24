import 'package:flutter/material.dart';
import 'package:stock_cartel/utils/app_dimensions.dart';
import 'package:stock_cartel/views/screens/chatsScreen/components/message/text_message/text_message_widget.dart';

import '../../../../../helpers/prefs_helpers.dart';
import '../../../../../models/chat_model.dart';
import '../../../../../utils/app_constants.dart';
import 'date_time_widget.dart';
import 'image_message/image_message_widget.dart';

/// widget used to determine the right message type
/// //TODO add color support for reciver
class MessageWidget extends StatefulWidget {
  final Color senderColor;
  final Color inActiveAudioSliderColor;
  final bool isSender ;
  final Color activeAudioSliderColor;
  final TextStyle? messageContainerTextStyle;
  final TextStyle? sendDateTextStyle;

  const MessageWidget({
    Key? key,
    required this.message,
    required this.senderColor,
    required this.inActiveAudioSliderColor,
    required this.activeAudioSliderColor,
    required this.isSender,
    this.messageContainerTextStyle,
    this.sendDateTextStyle,
  }) : super(key: key);

  final ChatModel message;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {




  @override
  Widget build(BuildContext context){

    return messageContent(widget.message, widget.isSender);
    // return Padding(
    //   padding: const EdgeInsets.only(top: AppDimensions.paddingSizeDefault),
    //   child: Align(
    //     alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    //     /// check message type and render the right widget
    //     child:  messageContent(widget.message,isSender)
    //   ),
    // );
  }

   messageContent(ChatModel message,bool isSender) {

    /// check message type and render the right widget
    if (message.messageType == null) {
      /// render text message
      return TextMessageWidget(
        message: message,
        senderColor: widget.senderColor,
        isSender:isSender ,
      );
    } else {
      return message.messageType == "image"
          ? ImageMessageWidget(
              message: message,
              isSender: isSender,
              senderColor: widget.senderColor,
              messageContainerTextStyle: widget.messageContainerTextStyle,
            )
          : message.messageType == "audio"
              ? Container()
              : TextMessageWidget(
                  isSender: isSender,
                  message: message,
                  senderColor: widget.senderColor,
                );
    }
  }
}
