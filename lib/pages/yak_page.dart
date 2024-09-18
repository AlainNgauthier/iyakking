// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:iyakking/components/messages.dart';
import 'package:iyakking/components/new_message.dart';
import 'package:iyakking/services/auth/auth_service.dart';

class YakPage extends StatelessWidget {
  const YakPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                'Lets yak!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white),
              ),
            ],
          ),
          toolbarHeight: 72,
          centerTitle: true,
          backgroundColor: Colors.green[600],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))),
          actions: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: DropdownButton(
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: const Color.fromARGB(255, 15, 14, 13),
                ),
                items: [
                  DropdownMenuItem(
                      value: 'logout',
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.exit_to_app,
                            ),
                            SizedBox(width: 12),
                            Text('Logout'),
                          ],
                        ),
                      ))
                ],
                onChanged: (value) {
                  if (value == 'logout') {
                    AuthService().logout();
                  }
                },
              ),
            )
          ],
        ),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        )));
  }
}
