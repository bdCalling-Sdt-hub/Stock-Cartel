
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_cartel/utils/app_dimensions.dart';

import '../../../../../models/chat_model.dart';

class DateTimeWidget extends StatelessWidget {
  final TextStyle? sendDateTextStyle;
  const DateTimeWidget({
    Key? key,
    required this.message,
    this.sendDateTextStyle,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        // top: 2,
        left: AppDimensions.paddingSizeDefault / 2,
        right: AppDimensions.paddingSizeDefault / 2,
      ),
      child: Text(
        DateFormat("h:mm:ss a").format(message.createAt??DateTime.now()),
        style: sendDateTextStyle ?? const TextStyle(fontSize: 12),
      ),
    );
  }
}