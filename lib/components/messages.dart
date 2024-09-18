import 'package:flutter/material.dart';
import 'package:iyakking/components/message_bubble.dart';
import 'package:iyakking/models/yakking_message.dart';
import 'package:iyakking/services/auth/auth_service.dart';
import 'package:iyakking/services/yakking/yak_service.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;

    return StreamBuilder<List<YakMessage>>(
        stream: YakService().messagesStream(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('How about yakking?'));
          } else {
            final msgs = snapshot.data!;
            return ListView.builder(
              reverse: true,
              itemCount: msgs.length,
              itemBuilder: (ctx, i) => MessageBubble(
                  key: ValueKey(msgs[i].id),
                  message: msgs[i],
                  belongsToCurrentUser: currentUser?.id == msgs[i].userId),
            );
          }
        });
  }
}
