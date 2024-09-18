import 'package:flutter/material.dart';
import 'package:iyakking/models/yakking_message.dart';

class MessageBubble extends StatelessWidget {
  final YakMessage message;
  final bool belongsToCurrentUser;

  const MessageBubble(
      {Key? key, required this.message, required this.belongsToCurrentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: belongsToCurrentUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(
                color: belongsToCurrentUser ? Colors.green[50] : Colors.green,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: belongsToCurrentUser
                        ? Radius.circular(16)
                        : Radius.circular(0),
                    bottomRight: belongsToCurrentUser
                        ? Radius.circular(0)
                        : Radius.circular(16))),
            width: 230,
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 8,
            ),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: belongsToCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(message.userName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: belongsToCurrentUser
                            ? Colors.black
                            : Colors.white)),
                Text(
                  message.text,
                  overflow: TextOverflow.ellipsis,
                  textAlign:
                      belongsToCurrentUser ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                      color:
                          belongsToCurrentUser ? Colors.black : Colors.white),
                ),
              ],
            )),
      ],
    );
  }
}
