// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:iyakking/services/auth/auth_service.dart';
import 'package:iyakking/services/yakking/yak_service.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  NewMessageState createState() => NewMessageState();
}

class NewMessageState extends State<NewMessage> {
  String digitedMessage = '';
  final messageController = TextEditingController();

  Future<void> sendMessage() async {
    final user = AuthService().currentUser;
    if (user != null) {
      await YakService().save(digitedMessage, user);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
          controller: messageController,
          onChanged: (msg) => setState(() => digitedMessage = msg),
          decoration: InputDecoration(
            labelText: 'Your turn',
          ),
          onSubmitted: (_) {
            if (digitedMessage.trim().isNotEmpty) {
              sendMessage();
            }
          },
        )),
        IconButton(
            onPressed: digitedMessage.trim().isEmpty ? null : sendMessage,
            icon: Icon(Icons.send))
      ],
    );
  }
}
